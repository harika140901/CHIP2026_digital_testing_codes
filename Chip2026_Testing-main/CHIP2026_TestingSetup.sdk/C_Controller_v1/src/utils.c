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
	GLOBAL_FN_TCP_DATA.fn_data_mode = 1; //Put TCP Receive in data mode.
	GLOBAL_FN_TCP_DATA.fn_name = data[0];
	GLOBAL_FN_TCP_DATA.Data_Size = ((u32)data[4] << 24) | ((u32)data[3] << 16) | ((u32)data[2] << 8) | (u32)data[1];
	GLOBAL_FN_TCP_DATA.Data_Ptr = (u8*)calloc(GLOBAL_FN_TCP_DATA.Data_Size,sizeof(u8)); //Each function shall take the responsibility to free
	GLOBAL_FN_TCP_DATA.Data_Recved_Size = 0;

	DEBUG_PRINT("%d %d\n",GLOBAL_FN_TCP_DATA.fn_name,GLOBAL_FN_TCP_DATA.Data_Size);
	//send reply to client saying all ok. ask for data.
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
	//Check memory stats here.
	//print_heap_info();
	free(GLOBAL_FN_TCP_DATA.Data_Ptr);
	GLOBAL_FN_TCP_DATA.Data_Size = 0;
	GLOBAL_FN_TCP_DATA.Data_Recved_Size = 0;
	GLOBAL_FN_TCP_DATA.fn_ready_flag = 0;
	//Check memory stats here.
	//print_heap_info();
	return 0;
}

//This needs to be called before next function comes
u8 set_write_data_to_default(){
	/*
	if((GLOBAL_FN_TCP_DATA.fn_name == linear) | (GLOBAL_FN_TCP_DATA.fn_name == convolution) ){
		if(GLOBAL_WRITE_TCP_DATA.Data_Ptr != NULL){
			free(GLOBAL_WRITE_TCP_DATA.Data_Ptr);
			GLOBAL_WRITE_TCP_DATA.Data_Ptr = NULL;
		}
	}*/
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

	// Disable interrupts (polling mode)
	XAxiDma_IntrDisable(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
	XAxiDma_IntrDisable(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
//	for(int i = 0; i < 10; i++) { // FOR DEBUG
//		printf("GLOBAL_SM_DATA.scan_len[%d]: %u\n", i, (unsigned int)GLOBAL_SM_DATA.scan_len[i]);
//	}
	return status;
}

//Startup Code
u8 initialise_FPGA(){
	//Assign Default values to the Digital Signals
	//This  shall be done from python as set default function before calling anything else.
	u8 default_values[DIG_IN_SIG_LEN] = {0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1}; //Edit here to change default values

	// Actual scan-chain lengths:
	// scan_id 1 -> input scan chain 2   = 1152
	// scan_id 2 -> input scan chain 1   = 1152
	// scan_id 3 -> output scan chain    = 475
	// scan_id 4 -> WL scan chain        = 1536
	// scan_id 5 -> read                 = 200
	// scan_id 6 -> write                = 200
	u16 scan_len[10] = {0, 1152, 1152, 475, 1536, 200, 200, 0, 0, 0};

	memcpy(GLOBAL_SM_DATA.default_signal_values, default_values, sizeof(default_values));
	memcpy(GLOBAL_SM_DATA.signal_values, default_values, sizeof(default_values)); //This is just initialise. It will be modified everytime set_ChipIO() is called
	memcpy(GLOBAL_SM_DATA.scan_len, scan_len, sizeof(scan_len));
	memset(GLOBAL_SM_DATA.dma_scanout_buffer,0,sizeof(GLOBAL_SM_DATA.dma_scanout_buffer));
	memset(GLOBAL_SM_DATA.dma_imcout_buffer,0,sizeof(GLOBAL_SM_DATA.dma_imcout_buffer));
	memset(GLOBAL_SM_DATA.sram_write_buffer,0,sizeof(GLOBAL_SM_DATA.sram_write_buffer));
	u8 mode_default_values[32] = {0};
	memcpy(GLOBAL_SM_DATA.mode_default_signal_values, mode_default_values, sizeof(mode_default_values));
	memcpy(GLOBAL_SM_DATA.mode_signal_values, mode_default_values, sizeof(mode_default_values));

	//Initialize calibration word-lines index
	u16 calib_wl[12] = {288, 289, 290, 291, 292, 293, 870, 871, 872, 873, 874, 875};

	memcpy(GLOBAL_SM_DATA.calib_wl, calib_wl, sizeof(calib_wl));
	//Initialize AXI Buses
	initialise_AXI();
	//Set Chip IO to default. This can be done from python by calling set_ChipIO() with default values as and when needed
	set_ChipIO_to_Default();
	//Set Mode IO to default.
	set_ModeIO_to_Default();
	//Add AXI_MODE_CONTROL defaults here as well
	GLOBAL_FN_TCP_DATA.fn_data_mode = 0;
	GLOBAL_FN_TCP_DATA.fn_ready_flag  = 0; //this flag will be made high in receive callback
	GLOBAL_WRITE_TCP_DATA.Send_Data_Flag = 0;
	printf("TCP Receive set in FN Mode\n");
	sleep(1); //Let the IOs.

	return 0;
}

//Read the AXI data
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

//Get Scan Out Bit from AXI
u8 get_scan_out_bit(){
	u8 bit;
	bit = (get_AXI_Bits(0) & (u8)1); //{0000...,IMC_DONE,SCN_OUT} & with 1
	return bit;
}

//Write data on AXI
u8 set_AXI_Bits(u8* signals, u8 signal_len, u8* signal_values ){
	//update the global signal values.
	u8 signal;
	u8 value;
	for(u32 i = 0; i < signal_len; i++){
		signal = signals[i];
		value = signal_values[i];
		GLOBAL_SM_DATA.signal_values[signal] = value; //this being global is important as it should conserve other signals.
	}
	//now set the AXI data accordingly. (Only Input Bus)
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

//Write data on AXI
u8 set_MODE_AXI_Bits(u8* signals, u8 signal_len, u8* signal_values ){
	//update the global signal values.
	u8 signal;
	u8 value;
	for(u32 i = 0; i < signal_len; i++){
		signal = signals[i];
		value = signal_values[i];
		GLOBAL_SM_DATA.mode_signal_values[signal] = value; //this being global is important as it should conserve other signals.
	}
	//now set the AXI data accordingly. (Only Input Bus)
	u32 data = 0;
	for (int i = 0; i < 32; i++) {
	    data |= ((u32)(GLOBAL_SM_DATA.mode_signal_values[i] & 1)) << i;
	}
	XGpio_DiscreteWrite(&GLOBAL_SM_DATA.AXI_SCAN_MODE_SETTINGS_BUS,1,data);
	return 0;
}

//Set ChipIO to default after fpga wakes up.
u8 set_ChipIO_to_Default(){
	u8 signals[DIG_IN_SIG_LEN];
	for(u8 i = 0; i < DIG_IN_SIG_LEN; i++){
		signals[i] = i;
	}
	set_AXI_Bits(signals,DIG_IN_SIG_LEN,GLOBAL_SM_DATA.default_signal_values);
//	printf("IO set to Default\n");
	return 0;
}

//Set ModeIO to default after fpga wakes up.
u8 set_ModeIO_to_Default(){
	u8 signals[32];
	for(u8 i = 0; i < 32; i++){
		signals[i] = i;
	}
	set_MODE_AXI_Bits(signals,32,GLOBAL_SM_DATA.mode_default_signal_values);
//	printf("Mode IO set to Default\n");
	return 0;
}

u8 set_ScanID(u8 scan_id){
	u8 signal_array[4]= {SCN_SEL_0, SCN_SEL_1, SCN_SEL_2, SCN_SEL_3};
	u8 value_array[4] = {0, 0 ,0, 0};

	// 3-bit SCN_SEL mapping:
	// 1 -> 001, 2 -> 010, 3 -> 011, 4 -> 100, 5 -> 101, 6 -> 110
	// This matches the user's scan-select mapping (msb->lsb mapping handled by bit positions).
	u8 select = scan_id & 0x07;

	value_array[0] = (select >> 0) & 1;
	value_array[1] = (select >> 1) & 1;
	value_array[2] = (select >> 2) & 1;
	value_array[3] = 0;

	u8 ret = set_AXI_Bits(signal_array,4,value_array);
	return ret;
}

//Set Scan ID for Fast Scan IN
u8 set_ScanID_Verilog(u8 scan_id){
	u8 signal_array[4]= {SCAN_SEL_0_V,SCAN_SEL_1_V,SCAN_SEL_2_V, SCAN_SEL_3_V};
	u8 value_array[4] = {0, 0 ,0, 0};

	u8 select = scan_id & 0x07;

	value_array[0] = (select >> 0) & 1;
	value_array[1] = (select >> 1) & 1;
	value_array[2] = (select >> 2) & 1;
	value_array[3] = 0;

	u8 ret = set_MODE_AXI_Bits(signal_array,4,value_array);
	//DEBUG_PRINT("Scan ID Verilog SET\n");
	return ret;
}

//C function to scan in data into given scan chain with given len. Note it may be requirement not to scan all data.
u8 c_scan_in(u8* scan_data, u8 scan_id,u16 scan_len){
	printf("Started C Scan_In Routine\n");
	set_ScanID(scan_id);
	u32 byte_length = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere
	u32 bits_set = 0;
	u8 breakOuter = 0;
	for (u32 i = 0; i < byte_length; ++i) {
		for (int bit = 0; bit <= 7; bit++) {
			u8 scan_in_bit= (scan_data[i] >> bit) & 1;
			//DEBUG_PRINT("%d Scan IN = %d\n",bits_set+1,scan_in_bit);
			{
				//Set SCN_IN = scan_in_bit and CLK_A = 1, CLK_B = 0
				u8 signals[3] = {SCN_IN,CLK_A,CLK_B};
				u8 values[3] = {scan_in_bit,1,0};
				set_AXI_Bits(signals,3,values);
				//usleep(200000); //100ms sleep. This needs to be parameter
			} {
				//Turn off CLK_A keep scan in bit and CLK_B = 0
				u8 signals[1] = {CLK_A};
				u8 values[1] = {0};
				set_AXI_Bits(signals,1,values);
				//usleep(200000);
			} {
				//Turn on CLK_B
				u8 signals[1] = {CLK_B};
				u8 values[1] = {1};
				set_AXI_Bits(signals,1,values);
				//usleep(200000);
			} {
				//Turn off CLK_B
				u8 signals[1] = {CLK_B};
				u8 values[1] = {0};
				set_AXI_Bits(signals,1,values);
				//usleep(200000);
			}
			bits_set+=1;
			if(bits_set==scan_len){
				breakOuter = 1;
				break;
			}
		}
		if (breakOuter) break; // breaks outer loop
	}
	set_ScanID(0);
	return 0;
}

//Scan out function for C. It is callers responsibility to ensure SCN_IN, IN_EN and the toggle related disbales are set before calling this. Eg, Control_EN = 0 before calling scan out to avoid toggle.
u32 c_scan_out(u8 scan_id, u16 scan_len){
	printf("Started C Scan_Out Routine\n");
	//Select the scan chain that needs to be scanned out
	set_ScanID(scan_id);
	//Total bytes required
	u32 num_bytes = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere
	for (u32 i = 0; i < scan_len; ++i) {
		u32 byte_index = i / 8;
		u32 bit_index = i % 8;

		{
			//Set CLK_B = 1
			u8 signals[2] = {CLK_A,CLK_B};
			u8 values[2] = {0,1};
			set_AXI_Bits(signals,2,values);
			//usleep(200000); //100ms sleep. This needs to be parameter
		}
	    //Read Scan Out Data
		u32 bit = get_scan_out_bit();
//		printf("scan_out = %lu\n", bit);
		{
			//Set CLK_B = 0
			u8 signals[1] = {CLK_B};
			u8 values[1] = {0};
			set_AXI_Bits(signals,1,values);
			//usleep(200000); //100ms sleep. This needs to be parameter
		} {
			//Set CLK_A = 1
			u8 signals[1] = {CLK_A};
			u8 values[1] = {1};
			set_AXI_Bits(signals,1,values);
			//usleep(200000); //100ms sleep. This needs to be parameter
		} {
			//Set CLK_A = 0
			u8 signals[1] = {CLK_A};
			u8 values[1] = {0};
			set_AXI_Bits(signals,1,values);
			//usleep(200000); //100ms sleep. This needs to be parameter
		}
	    // Clear the bit location first (just to be safe)
		GLOBAL_SM_DATA.dma_scanout_buffer[byte_index] &= ~(1 <<(bit_index));

		// Set the bit if needed
		GLOBAL_SM_DATA.dma_scanout_buffer[byte_index] |= (bit <<(bit_index));
	}
	set_ScanID(0);
	return num_bytes;
}

//Debug function
int verify_data(u8 *tx, u8 *rx, int size) {
    for (int i = 0; i < size; i++) {
        printf("byte %d:\n", i);
        printf("  Sent     : ");
        for (int b = 0; b < 8; b++) {
            printf("%d", (tx[i] >> b) & 1);
        }
        printf("\n");

        printf("  Received : ");
        for (int b = 0; b < 8; b++) {
            printf("%d", (rx[i] >> b) & 1);
        }
        printf("\n");

        if (tx[i] != rx[i]) {
            printf("  Mismatch Detected!\n");
            return -1;
        } else {
            printf("  Match OK.\n");
        }
    }
    return 0;
}

u8 dma_send_recv_test(u8 scan_id,u16 scan_len){
	u8 status;
	//Send Scan_ID to verilog Controller. It should know how much to scan in.
	set_ScanID_Verilog(scan_id);
	//Total bytes required
	u32 num_bytes = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere
//	printf("Num Bytes: %lu\n", num_bytes);
	printf("scan_id = %u, scan_len = %u, num_bytes = %lu\n", scan_id, scan_len, num_bytes);
	//EN Recv_Data of verilog controller also set test mode to receive same thing back
	{
		u8 signals[2] = {SCAN_IN_RECV_V,Test_DMA_V};
		u8 values[2] = {1,1};
		set_MODE_AXI_Bits(signals,2,values);
	}
	//Send the data-> copy it from your FN array into aligned buffer. This is not required in C code.
	memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer,GLOBAL_FN_TCP_DATA.Data_Ptr+3,num_bytes);
	Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);
	status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,(UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes, XAXIDMA_DMA_TO_DEVICE);
	if (status != XST_SUCCESS) {
		printf("MM2S transfer failed with %d\n",status);
		return -1;
	}
	// Wait for MM2S completion
	while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)){
		// Do nothing
	}
	//EN low Recv_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_RECV_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	}
	printf("Transfered SCAN_IN Data to Verilog Controller\n");

	//Call Scan IN Verilog Enable Here. And wait for it to complete.

	//Debug whether data has been received by calling receive function
	//EN Send_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_SEND_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	// Start S2MM: Receive data back from FPGA
	Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes);
	status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma, (UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes, XAXIDMA_DEVICE_TO_DMA);
	if (status != XST_SUCCESS) {
		printf("S2MM transfer failed\n");
		return -1;
	}
	// Wait for S2MM completion
	while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DEVICE_TO_DMA));
	printf("Received SCAN_Out Data from Verilog Controller\n");
	//EN low Send_Data of verilog controller also turn of test mode
	{
		u8 signals[2] = {SCAN_IN_SEND_V,Test_DMA_V};
		u8 values[2] = {0,0};
		set_MODE_AXI_Bits(signals,2,values);
	}
	// Verify the result
	if (verify_data(GLOBAL_SM_DATA.dma_scan_in_buffer,GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes) == 0) {
		printf("Transfer successful! Data matches.\n");
	} else {
		printf("Transfer failed. Data mismatch.\n");
	}
	set_ModeIO_to_Default();
	return status;
}

//This is fast scan in function
/*
// DMA packing:
// scan_data:   [0] [1] [2] [3] | [4] [5] [6] [7] | ...
// buffer_flat: [7:0][15:8]...[31:24] | [39:32]...[63:56] | ...
// Scan order:  buffer_flat[0] --> buffer_flat[1] --> ... --> buffer_flat[scan_len_bits-1]
//              (starts from LSB of scan_data[0])
*/
u8 verilog_scan_in(u8* scan_data, u8 scan_id, u16 scan_len){
	u8 status;
	//Send Scan_ID to verilog Controller. It should know how much to scan in.
	set_ScanID_Verilog(scan_id);
	//Total bytes required
	u32 num_bytes = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere
	//EN Recv_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_RECV_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//Send the data-> copy it from your FN array into aligned buffer. This is not required in C code.
	memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer,scan_data,num_bytes);
	Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);
	status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,(UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes, XAXIDMA_DMA_TO_DEVICE);
	if (status != XST_SUCCESS) {
		DEBUG_PRINT("MM2S transfer failed with %d\n",status);
		return -1;
	}
	// Wait for MM2S completion
	while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)) {
		// Do nothing
	}
	//EN low Recv_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_RECV_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//DEBUG_PRINT("Transfered SCAN_IN Data to Verilog Controller\n");

	//Call Scan IN Verilog Enable Here. And wait for it to complete.
	//set verilog scan = 1 and NCLK = 255
	{
		u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
		u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
		set_MODE_AXI_Bits(signals,10,values);
	}
	//Enable SCAN_IN
//	printf("Started Verilog Scan_In\n");
	{
		u8 signals[1] = {SCAN_IN_EN_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//Wait for SCAN_IN_DONE to go high
	while(!(get_AXI_Bits(0) & (u8)4)) {
		// do nothing
	}
	//Disable SCAN_IN
	{
		u8 signals[1] = {SCAN_IN_EN_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//printf("Verilog SCAN_IN Done\n");
	set_ModeIO_to_Default();
	return status;
}

u8 CL_EN_partial_scn(u8* scan_data, u8 scan_id, u16 scan_len){
	u8 status;
	//Send Scan_ID to verilog Controller. It should know how much to scan in.
	set_ScanID_Verilog(scan_id);
	//Total bytes required
	u32 num_bytes = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere
	//EN Recv_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_RECV_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//Send the data-> copy it from your FN array into aligned buffer. This is not required in C code.
	memcpy(GLOBAL_SM_DATA.dma_scan_in_buffer,scan_data,num_bytes);
	Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes);
	status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma,(UINTPTR)GLOBAL_SM_DATA.dma_scan_in_buffer, num_bytes, XAXIDMA_DMA_TO_DEVICE);
	if (status != XST_SUCCESS) {
		printf("MM2S transfer failed with %d\n",status);
		return -1;
	}
	// Wait for MM2S completion
	while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DMA_TO_DEVICE)) {
		// Do nothing
	}
	//EN low Recv_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_RECV_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	} { // set stepIMC_EN as high, and pass the length for partial scan in
		u8 signals[7] = {stepIMC_EN, SCAN_LEN_V_0, SCAN_LEN_V_1, SCAN_LEN_V_2, SCAN_LEN_V_3, SCAN_LEN_V_4, SCAN_LEN_V_5};
		u8 values[7] = {1, scan_len & 0x01, (scan_len>>1) & 0x01, (scan_len>>2) & 0x01, (scan_len>>3) & 0x01, (scan_len>>4) & 0x01, (scan_len>>5) & 0x01};
		set_MODE_AXI_Bits(signals,7,values);
	}
	//printf("Transfered SCAN_IN Data to Verilog Controller\n");

	//Call Scan IN Verilog Enable Here. And wait for it to complete.
	//set verilog scan = 1 and NCLK = 255
	{
		u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
		u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
		set_MODE_AXI_Bits(signals,10,values);
	}
	//Enable SCAN_IN
//	printf("Started Verilog Scan_In\n");
	{
		u8 signals[1] = {SCAN_IN_EN_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//Wait for SCAN_IN_DONE to go high
	while(!(get_AXI_Bits(0) & (u8)4)) {
		// do nothing
	}
	//Disable SCAN_IN
	{
		u8 signals[1] = {SCAN_IN_EN_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	}
	//printf("Verilog SCAN_IN Done\n");
	set_ModeIO_to_Default(); // resets the mode signals to default
	return status;
}

//This is fast scan out fn
u32 verilog_scan_out(u8 scan_id,u16 scan_len){
	u8 status;
	//Send Scan_ID to verilog Controller. It should know how much to scan in.
	set_ScanID_Verilog(scan_id);
	//Total bytes required
	u32 num_bytes = floor((scan_len + 31) / 32)*4; //AXI DMA needs 4 byte packet each. So maintain 4 byte padding everywhere

	//Call Scan out Verilog Enable Here. And wait for it to complete.
	//set verilog scan = 1 and NCLK = 255
	{
		u8 signals[10] = {VERILOG_C_SCAN,NCLK_0_V,NCLK_1_V,NCLK_2_V,NCLK_3_V,NCLK_4_V,NCLK_5_V,NCLK_6_V,NCLK_7_V,Test_DMA_V};
		u8 values[10] = {1,1,0,0,0,0,0,0,0,0};
		set_MODE_AXI_Bits(signals,10,values);
	}
	//Enable SCAN_OUT
	{
		u8 signals[1] = {SCAN_OUT_EN_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
//	printf("Started Verilog Scan_Out\n");
	//Wait for SCAN_OUT_DONE to go high
	while(!(get_AXI_Bits(0) & (u8)8)) {
		// do nothing
	}
	//Disable SCAN_OUT
	{
		u8 signals[1] = {SCAN_OUT_EN_V};
		u8 values[1] = {0};
		set_MODE_AXI_Bits(signals,1,values);
	}
//	printf("Verilog_Scan_Out Done\n");
	//DEBUG_PRINT("Verilog SCAN_OUT Done\n");

	//calling receive function
	//EN Send_Data of verilog controller
	{
		u8 signals[1] = {SCAN_IN_SEND_V};
		u8 values[1] = {1};
		set_MODE_AXI_Bits(signals,1,values);
	}
	// Start S2MM: Receive data back from FPGA
	Xil_DCacheFlushRange((UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes);
	status = XAxiDma_SimpleTransfer(&GLOBAL_SM_DATA.AxiDma, (UINTPTR)GLOBAL_SM_DATA.dma_scanout_buffer, num_bytes, XAXIDMA_DEVICE_TO_DMA);
	if (status != XST_SUCCESS) {
		printf("S2MM transfer failed\n");
		return -1;
	}
	// Wait for S2MM completion

	while (XAxiDma_Busy(&GLOBAL_SM_DATA.AxiDma, XAXIDMA_DEVICE_TO_DMA)) {
		// do nothing
	}
	//DEBUG_PRINT("Received SCAN_Out Data from Verilog Controller\n");
	//EN low Send_Data of verilog controller
	{
		u8 signals[2] = {SCAN_IN_SEND_V,VERILOG_C_SCAN};
		u8 values[2] = {0,0};
		set_MODE_AXI_Bits(signals,2,values);
	}
	set_ModeIO_to_Default();
	return num_bytes;
}

//Flush WL Scan Chain.And insert one 1.This needs to be done before Write.
u8 flush_wl_sc(){
	u8 flush_array[192] = {0};
	flush_array[189] = 8; // insert at the beginning of the scan chain (adjusted to 192-byte buffer)
	verilog_scan_in(flush_array,WL_SC,GLOBAL_SM_DATA.scan_len[WL_SC]);
	{
		u8 signals[2] = {SCN_IN}; //Important to keep scanin at 0
		u8 values[2] = {0};
		set_AXI_Bits(signals,1,values);
	}
	return 0;
}

u8 write_SRAM_WL(u16 wl, u8* write_data){
	//Write data into write scan chain => 270bits => 36 bytes (DMA exchange happens in 4byte-words)
	verilog_scan_in(write_data,WRITE_DATA_SC,GLOBAL_SM_DATA.scan_len[WRITE_DATA_SC]);
	//Do Write EN
	{
		u8 signals[1] = {WRITE_EN};
		u8 values[1] = {1};
		set_AXI_Bits(signals,1,values);
	}
	//Do WL_EN
	{
		u8 signals[1] = {WL_EN};
		u8 values[1] = {1};
		set_AXI_Bits(signals,1,values);
	}
	//turn off WL_EN
	{
		u8 signals[1] = {WL_EN};
		u8 values[1] = {0};
		set_AXI_Bits(signals,1,values);
	}
	//turn off WRITE_EN
	{
		u8 signals[1] = {WRITE_EN};
		u8 values[1] = {0};
		set_AXI_Bits(signals,1,values);
	}
	return 0;
}

