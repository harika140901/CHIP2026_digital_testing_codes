#include "utils.h"
#include "state_machine.h"
#include <math.h>
#include <unistd.h>
#include <malloc.h>

void print_heap_info() {
    struct mallinfo mi = mallinfo();

    printf("Total space: %d\n", mi.arena);
    printf("Free space : %d\n", mi.fordblks);
    printf("Used space : %d\n", mi.uordblks);
}

float bytes_to_float(u8* bytes) {
    float value;
    memcpy(&value, bytes, sizeof(float));
    return value;
}

u8 process_fn_data(u8* data){
    //Clear any previous write data buffer before starting new function
    set_write_data_to_default();
    GLOBAL_FN_TCP_DATA.fn_data_mode = 1;
    GLOBAL_FN_TCP_DATA.fn_name = data[0];
    GLOBAL_FN_TCP_DATA.Data_Size = ((u32)data[4] << 24) | ((u32)data[3] << 16) | ((u32)data[2] << 8) | (u32)data[1];
    GLOBAL_FN_TCP_DATA.Data_Ptr = (u8*)calloc(GLOBAL_FN_TCP_DATA.Data_Size,sizeof(u8));
    GLOBAL_FN_TCP_DATA.Data_Recved_Size = 0;

    DEBUG_PRINT("%d %d\n",GLOBAL_FN_TCP_DATA.fn_name,GLOBAL_FN_TCP_DATA.Data_Size);

    u8 reply = SUCCESS_REPLY;
    transfer_data(&reply,1);
    return 0;
}

//Use this function to send data for more than MAX_SEND_BUFF
err_t transfer_data(u8* data, u32 len){
    err_t err;
    GLOBAL_WRITE_TCP_DATA.Data_Size_To_Send = len;
    GLOBAL_WRITE_TCP_DATA.Data_Ptr = data;
    err = push_data(NULL,GLOBAL_WRITE_TCP_DATA.pcb,0);
    return err;
}

//Call this after function is done
u8 set_fn_data_to_default(){
    free(GLOBAL_FN_TCP_DATA.Data_Ptr);
    GLOBAL_FN_TCP_DATA.Data_Ptr = NULL;
    GLOBAL_FN_TCP_DATA.Data_Size = 0;
    GLOBAL_FN_TCP_DATA.Data_Recved_Size = 0;
    GLOBAL_FN_TCP_DATA.fn_ready_flag = 0;
    return 0;
}

u8 set_write_data_to_default(){
    GLOBAL_WRITE_TCP_DATA.Data_Size_To_Send = 0;
    GLOBAL_WRITE_TCP_DATA.Send_Data_Flag = 0;
    return 0;
}

//Initialize AXI buses
u8 initialise_AXI(){
    u8 status;
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_INPUT_BUS_0, XPAR_AXI_GPIO_0_DEVICE_ID);
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_INPUT_BUS_1, XPAR_AXI_GPIO_1_DEVICE_ID);
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_OUTPUT_BUS, XPAR_DIG_AXI_OUT_BUS_DEVICE_ID);
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_DEBUG_OUTPUT_BUS_0, XPAR_DIG_DEBUG_AXI_OUT_BUS_0_DEVICE_ID);
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_DEBUG_OUTPUT_BUS_1, XPAR_DIG_DEBUG_AXI_OUT_BUS_1_DEVICE_ID);
    status = XGpio_Initialize(&GLOBAL_SM_DATA.AXI_SCAN_MODE_SETTINGS_BUS, XPAR_SCAN_MODE_SETTINGS_AXI_BUS_DEVICE_ID);

    XAxiDma_Config *CfgPtr = XAxiDma_LookupConfig(XPAR_AXI_DMA_0_DEVICE_ID);
    status = XAxiDma_CfgInitialize(&GLOBAL_SM_DATA.AxiDma, CfgPtr);
    if (status != XST_SUCCESS) {
        printf("DMA initialization failed with %d\n",status);
        return 1;
    }

    XAxiDma_IntrDisable(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
    XAxiDma_IntrDisable(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    return status;
}

u8 initialise_FPGA(){
    u8 default_values[DIG_IN_SIG_LEN] = {0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1};
    u16 scan_len[10] = {900,900,90,90,1164,270,270,105,1152,1152};
    memcpy(GLOBAL_SM_DATA.default_signal_values, default_values, sizeof(default_values));
    memcpy(GLOBAL_SM_DATA.signal_values, default_values, sizeof(default_values));
    memcpy(GLOBAL_SM_DATA.scan_len, scan_len, sizeof(scan_len));
    memset(GLOBAL_SM_DATA.dma_scanout_buffer,0,sizeof(GLOBAL_SM_DATA.dma_scanout_buffer));
    memset(GLOBAL_SM_DATA.dma_imcout_buffer,0,sizeof(GLOBAL_SM_DATA.dma_imcout_buffer));
    memset(GLOBAL_SM_DATA.sram_write_buffer,0,sizeof(GLOBAL_SM_DATA.sram_write_buffer));

    u8 mode_default_values[32] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    memcpy(GLOBAL_SM_DATA.mode_default_signal_values, mode_default_values, sizeof(mode_default_values));
    memcpy(GLOBAL_SM_DATA.mode_signal_values, mode_default_values, sizeof(mode_default_values));

    u16 calib_wl[12] = {288,289,290,291,292,293,870,871,872,873,874,875};
    memcpy(GLOBAL_SM_DATA.calib_wl, calib_wl, sizeof(calib_wl));

    initialise_AXI();

    set_ChipIO_to_Default();
    set_ModeIO_to_Default();

    GLOBAL_FN_TCP_DATA.fn_data_mode = 0;
    GLOBAL_FN_TCP_DATA.fn_ready_flag  = 0;
    GLOBAL_WRITE_TCP_DATA.Send_Data_Flag = 0;
    printf("TCP Receive set in FN Mode\n");
    sleep(1);

    return 0;
}

u32 get_AXI_Bits(u8 AXI_ID){
    u32 readData;
    switch(AXI_ID){
    case 0:
        readData = (u32)XGpio_DiscreteRead(&GLOBAL_SM_DATA.AXI_OUTPUT_BUS,1);
        break;
    case 1:
        readData = (u32)XGpio_DiscreteRead(&GLOBAL_SM_DATA.AXI_DEBUG_OUTPUT_BUS_0,1);
        break;
    case 2:
        readData = (u32)XGpio_DiscreteRead(&GLOBAL_SM_DATA.AXI_DEBUG_OUTPUT_BUS_1,1);
        break;
    default:
        break;
    }
    return readData;
}

u8 get_scan_out_bit(){
    u8 bit;
    bit = (get_AXI_Bits(0) & (u8)1);
    return bit;
}

u8 set_AXI_Bits(u8* signals, u8 signal_len, u8* signal_values ){
    u8 signal;
    u8 value;
    for(u32 i = 0; i < signal_len; i++){
        signal = signals[i];
        value = signal_values[i];
        GLOBAL_SM_DATA.signal_values[signal] = value;
    }

    u32 data1 = 0, data2 = 0;
    for (int i = 0; i < 32; i++) {
        data1 |= ((u32)(GLOBAL_SM_DATA.signal_values[i] & 1)) << i;
    }
    for (int i = 0; i < 2; i++) {
        data2 |= ((u32)(GLOBAL_SM_DATA.signal_values[i+32] & 1)) << i;
    }
    XGpio_DiscreteWrite(&GLOBAL_SM_DATA.AXI_INPUT_BUS_0,1,data1);
    XGpio_DiscreteWrite(&GLOBAL_SM_DATA.AXI_INPUT_BUS_1,1,data2);
    return 0;
}

u8 set_MODE_AXI_Bits(u8* signals, u8 signal_len, u8* signal_values ){
    u8 signal;
    u8 value;
    for(u32 i = 0; i < signal_len; i++){
        signal = signals[i];
        value = signal_values[i];
        GLOBAL_SM_DATA.mode_signal_values[signal] = value;
    }

    u32 data = 0;
    for (int i = 0; i < 32; i++) {
        data |= ((u32)(GLOBAL_SM_DATA.mode_signal_values[i] & 1)) << i;
    }
    XGpio_DiscreteWrite(&GLOBAL_SM_DATA.AXI_SCAN_MODE_SETTINGS_BUS,1,data);
    return 0;
}

u8 set_ChipIO_to_Default(){
    u8 signals[DIG_IN_SIG_LEN];
    for(u8 i = 0; i < DIG_IN_SIG_LEN; i++){
        signals[i] = i;
    }
    set_AXI_Bits(signals,DIG_IN_SIG_LEN,GLOBAL_SM_DATA.default_signal_values);
    return 0;
}

u8 set_ModeIO_to_Default(){
    u8 signals[32];
    for(u8 i = 0; i < 32; i++){
        signals[i] = i;
    }
    set_MODE_AXI_Bits(signals,32,GLOBAL_SM_DATA.mode_default_signal_values);
    return 0;
}

u8 set_ScanID(u8 scan_id){
    u8 signal_array[4]= {SCN_SEL_0, SCN_SEL_1, SCN_SEL_2, SCN_SEL_3};
    u8 value_array[4] = {0,0,0,0};

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in set_ScanID: %u\n", (unsigned int)scan_id);
        return 1;
    }

    switch(scan_id){
    case TDC_OUT_SC_LM:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    case TDC_OUT_SC_RM:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=1; break;
    case CL_EN_SC_LM:
        value_array[3]=0; value_array[2]=0; value_array[1]=1; value_array[0]=0; break;
    case CL_EN_SC_RM:
        value_array[3]=0; value_array[2]=0; value_array[1]=1; value_array[0]=1; break;
    case WL_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=0; value_array[0]=0; break;
    case SA_OUT_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=0; value_array[0]=1; break;
    case WRITE_DATA_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=1; value_array[0]=0; break;
    case CONTROL_LOGIC_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=1; value_array[0]=1; break;
    case XIN_SC_QUADV:
        value_array[3]=1; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    case XIN_SC_UNITV:
        value_array[3]=1; value_array[2]=0; value_array[1]=0; value_array[0]=1; break;
    default:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    }

    return set_AXI_Bits(signal_array,4,value_array);
}

u8 set_ScanID_Verilog(u8 scan_id){
    u8 signal_array[4]= {SCAN_SEL_0_V,SCAN_SEL_1_V,SCAN_SEL_2_V, SCAN_SEL_3_V};
    u8 value_array[4] = {0,0,0,0};

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in set_ScanID_Verilog: %u\n", (unsigned int)scan_id);
        return 1;
    }

    switch(scan_id){
    case TDC_OUT_SC_LM:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    case TDC_OUT_SC_RM:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=1; break;
    case CL_EN_SC_LM:
        value_array[3]=0; value_array[2]=0; value_array[1]=1; value_array[0]=0; break;
    case CL_EN_SC_RM:
        value_array[3]=0; value_array[2]=0; value_array[1]=1; value_array[0]=1; break;
    case WL_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=0; value_array[0]=0; break;
    case SA_OUT_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=0; value_array[0]=1; break;
    case WRITE_DATA_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=1; value_array[0]=0; break;
    case CONTROL_LOGIC_SC:
        value_array[3]=0; value_array[2]=1; value_array[1]=1; value_array[0]=1; break;
    case XIN_SC_QUADV:
        value_array[3]=1; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    case XIN_SC_UNITV:
        value_array[3]=1; value_array[2]=0; value_array[1]=0; value_array[0]=1; break;
    default:
        value_array[3]=0; value_array[2]=0; value_array[1]=0; value_array[0]=0; break;
    }

    return set_MODE_AXI_Bits(signal_array,4,value_array);
}

u8 c_scan_in(u8* scan_data, u8 scan_id,u16 scan_len){
    printf("Started C Scan_In Routine\n");
    set_ScanID(scan_id);
    u32 byte_length = floor((scan_len + 31) / 32)*4;
    u32 bits_set = 0;
    u8 breakOuter = 0;

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in c_scan_in: %u\n", (unsigned int)scan_id);
        return 1;
    }

    if (scan_len == 0 || scan_len > GLOBAL_SM_DATA.scan_len[scan_id]) {
        printf("WARNING: scan_len clipped to actual value for scan_id %u\n", (unsigned int)scan_id);
        scan_len = GLOBAL_SM_DATA.scan_len[scan_id];
    }

    for (u32 i = 0; i < byte_length; ++i) {
        for (int bit = 0; bit <= 7; bit++) {
            u8 scan_in_bit = (scan_data[i] >> bit) & 1;
            {
                u8 signals[3] = {SCN_IN,CLK_A,CLK_B};
                u8 values[3] = {scan_in_bit,1,0};
                set_AXI_Bits(signals,3,values);
            } {
                u8 signals[1] = {CLK_A};
                u8 values[1] = {0};
                set_AXI_Bits(signals,1,values);
            } {
                u8 signals[1] = {CLK_B};
                u8 values[1] = {1};
                set_AXI_Bits(signals,1,values);
            } {
                u8 signals[1] = {CLK_B};
                u8 values[1] = {0};
                set_AXI_Bits(signals,1,values);
            }
            bits_set += 1;
            if(bits_set == scan_len){
                breakOuter = 1;
                break;
            }
        }
        if (breakOuter) break;
    }
    set_ScanID(0);
    return 0;
}

u32 c_scan_out(u8 scan_id, u16 scan_len){
    printf("Started C Scan_Out Routine\n");
    set_ScanID(scan_id);

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in c_scan_out: %u\n", (unsigned int)scan_id);
        return 0;
    }

    if (scan_len == 0 || scan_len > GLOBAL_SM_DATA.scan_len[scan_id]) {
        printf("WARNING: scan_len clipped to actual value for scan_id %u\n", (unsigned int)scan_id);
        scan_len = GLOBAL_SM_DATA.scan_len[scan_id];
    }

    u32 num_bytes = floor((scan_len + 31) / 32)*4;
    for (u32 i = 0; i < scan_len; ++i) {
        u32 byte_index = i / 8;
        u32 bit_index = i % 8;

        {
            u8 signals[2] = {CLK_A,CLK_B};
            u8 values[2] = {0,1};
            set_AXI_Bits(signals,2,values);
        }

        u32 bit = get_scan_out_bit();

        {
            u8 signals[1] = {CLK_B};
            u8 values[1] = {0};
            set_AXI_Bits(signals,1,values);
        } {
            u8 signals[1] = {CLK_A};
            u8 values[1] = {1};
            set_AXI_Bits(signals,1,values);
        } {
            u8 signals[1] = {CLK_A};
            u8 values[1] = {0};
            set_AXI_Bits(signals,1,values);
        }

        GLOBAL_SM_DATA.dma_scanout_buffer[byte_index] &= ~(1 << (bit_index));
        GLOBAL_SM_DATA.dma_scanout_buffer[byte_index] |= (bit << (bit_index));
    }
    set_ScanID(0);
    return num_bytes;
}

// DMA test helper
u8 dma_send_recv_test(u8 scan_id,u16 scan_len){
    u8 status;
    set_ScanID_Verilog(scan_id);

    u32 num_bytes = scan_dma_len_bytes(scan_len);
    printf("scan_id = %u, scan_len = %u, num_bytes = %lu\n", scan_id, scan_len, num_bytes);

    {
        u8 signals[2] = {SCAN_IN_RECV_V,Test_DMA_V};
        u8 values[2] = {1,1};
        set_MODE_AXI_Bits(signals,2,values);
    }

    memset(GLOBAL_SM_DATA.dma_scan_in_buffer, 0, sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer));
    memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer, GLOBAL_FN_TCP_DATA.Data_Ptr + 3, num_bytes);
    Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);

    status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,(UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes, XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        printf("MM2S transfer failed with %d\n",status);
        return -1;
    }

    while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)){
    }

    {
        u8 signals[1] = {SCAN_IN_RECV_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    }

    {
        u8 signals[1] = {SCAN_IN_SEND_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes);
    status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma, (UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes, XAXIDMA_DEVICE_TO_DMA);
    if (status != XST_SUCCESS) {
        printf("S2MM transfer failed\n");
        return -1;
    }

    while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DEVICE_TO_DMA));
    printf("Received SCAN_Out Data from Verilog Controller\n");

    {
        u8 signals[2] = {SCAN_IN_SEND_V,Test_DMA_V};
        u8 values[2] = {0,0};
        set_MODE_AXI_Bits(signals,2,values);
    }

    set_ModeIO_to_Default();
    return status;
}

// Fast scan in
u8 verilog_scan_in(u8* scan_data, u8 scan_id, u16 scan_len){
    u8 status;

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id: %u\n", (unsigned int)scan_id);
        return XST_FAILURE;
    }

    if (scan_len == 0 || scan_len > GLOBAL_SM_DATA.scan_len[scan_id]) {
        printf("WARNING: requested scan_len %u exceeds actual scan_len for scan_id %u; clipping it.\n",
               (unsigned int)scan_len, (unsigned int)scan_id);
        scan_len = GLOBAL_SM_DATA.scan_len[scan_id];
    }

    u32 num_bytes = scan_dma_len_bytes(scan_len);
    if (num_bytes > sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer)) {
        printf("ERROR: scan_in DMA size exceeds buffer: %u > %zu\n", (unsigned int)num_bytes, sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer));
        return XST_FAILURE;
    }

    memset(GLOBAL_SM_DATA.dma_scan_in_buffer, 0, sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer));
    memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer, scan_data, num_bytes);
    Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);

    set_ScanID_Verilog(scan_id);

    {
        u8 signals[1] = {SCAN_IN_RECV_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,
                                   (UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer,
                                   num_bytes,
                                   XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        printf("MM2S transfer failed with %d\n",status);
        return status;
    }

    while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)) {
    }

    {
        u8 signals[1] = {SCAN_IN_RECV_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    }

    {
        u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
        u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
        set_MODE_AXI_Bits(signals,10,values);
    }

    {
        u8 signals[1] = {SCAN_IN_EN_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    while (!(get_AXI_Bits(0) & (u8)4)) {
    }

    {
        u8 signals[1] = {SCAN_IN_EN_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    }

    set_ModeIO_to_Default();
    return status;
}

u8 CL_EN_partial_scn(u8* scan_data, u8 scan_id, u16 scan_len){
    u8 status;
    set_ScanID_Verilog(scan_id);

    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in CL_EN_partial_scn: %u\n", (unsigned int)scan_id);
        return XST_FAILURE;
    }

    if (scan_len == 0 || scan_len > GLOBAL_SM_DATA.scan_len[scan_id]) {
        printf("WARNING: partial scan_len clipped\n");
        scan_len = GLOBAL_SM_DATA.scan_len[scan_id];
    }

    u32 num_bytes = scan_dma_len_bytes(scan_len);
    if (num_bytes > sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer)) {
        printf("ERROR: partial scan_in DMA size exceeds buffer: %u > %zu\n", (unsigned int)num_bytes, sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer));
        return XST_FAILURE;
    }

    {
        u8 signals[1] = {SCAN_IN_RECV_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    memset(GLOBAL_SM_DATA.dma_scan_in_buffer,0,sizeof(GLOBAL_SM_DATA.dma_scan_in_buffer));
    memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer,scan_data,num_bytes);
    Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);

    status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,(UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes, XAXIDMA_DMA_TO_DEVICE);
    if (status != XST_SUCCESS) {
        printf("MM2S transfer failed with %d\n",status);
        return -1;
    }

    while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)) {}

    {
        u8 signals[1] = {SCAN_IN_RECV_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    } {
        u8 signals[7] = {stepIMC_EN, SCAN_LEN_V_0, SCAN_LEN_V_1, SCAN_LEN_V_2, SCAN_LEN_V_3, SCAN_LEN_V_4, SCAN_LEN_V_5};
        u8 values[7] = {1, scan_len & 0x01, (scan_len>>1) & 0x01, (scan_len>>2) & 0x01, (scan_len>>3) & 0x01, (scan_len>>4) & 0x01, (scan_len>>5) & 0x01};
        set_MODE_AXI_Bits(signals,7,values);
    }

    {
        u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
        u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
        set_MODE_AXI_Bits(signals,10,values);
    }

    {
        u8 signals[1] = {SCAN_IN_EN_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    while (!(get_AXI_Bits(0) & (u8)4)) {
    }

    {
        u8 signals[1] = {SCAN_IN_EN_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    }

    set_ModeIO_to_Default();
    return status;
}

// This is fast scan out
u32 verilog_scan_out(u8 scan_id,u16 scan_len){
    u8 status;
    if (!is_valid_scan_id(scan_id)) {
        printf("ERROR: invalid scan_id in verilog_scan_out: %u\n", (unsigned int)scan_id);
        return 0;
    }

    if (scan_len == 0 || scan_len > GLOBAL_SM_DATA.scan_len[scan_id]) {
        printf("WARNING: requested scan_len %u exceeds actual scan_len for scan_id %u; clipping it.\n",
               (unsigned int)scan_len, (unsigned int)scan_id);
        scan_len = GLOBAL_SM_DATA.scan_len[scan_id];
    }

    u32 num_bytes = scan_dma_len_bytes(scan_len);
    if (num_bytes > sizeof(GLOBAL_SM_DATA.dma_scanout_buffer)) {
        printf("ERROR: scan_out DMA size exceeds buffer: %u > %zu\n", (unsigned int)num_bytes, sizeof(GLOBAL_SM_DATA.dma_scanout_buffer));
        return 0;
    }

    memset(GLOBAL_SM_DATA.dma_scanout_buffer, 0, sizeof(GLOBAL_SM_DATA.dma_scanout_buffer));
    Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes);

    set_ScanID_Verilog(scan_id);

    {
        u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
        u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
        set_MODE_AXI_Bits(signals,10,values);
    }

    {
        u8 signals[1] = {SCAN_OUT_EN_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    while (!(get_AXI_Bits(0) & (u8)8)) {
    }

    {
        u8 signals[1] = {SCAN_OUT_EN_V};
        u8 values[1] = {0};
        set_MODE_AXI_Bits(signals,1,values);
    }

    {
        u8 signals[1] = {SCAN_IN_SEND_V};
        u8 values[1] = {1};
        set_MODE_AXI_Bits(signals,1,values);
    }

    Xil_DCacheInvalidateRange((UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes);
    status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma, (UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes, XAXIDMA_DEVICE_TO_DMA);
    if (status != XST_SUCCESS) {
        printf("S2MM transfer failed\n");
        return 0;
    }

    while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DEVICE_TO_DMA)) {
    }

    {
        u8 signals[2] = {SCAN_IN_SEND_V,VERILOG_C_SCAN};
        u8 values[2] = {0,0};
        set_MODE_AXI_Bits(signals,2,values);
    }

    set_ModeIO_to_Default();
    return num_bytes;
}
