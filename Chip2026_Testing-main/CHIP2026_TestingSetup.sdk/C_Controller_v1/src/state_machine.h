#ifndef SRC_STATE_MACHINE_H_
#define SRC_STATE_MACHINE_H_

// custom header files
#include "utils.h"
#include "echo.h"

#include "xgpio.h"
#include "xaxidma.h"
#include "xparameters.h"

/********** Signal Index for Dig AXI IN Bus 0 **********/
#define BANK_EN_0  	0
#define BANK_EN_1  	1
#define BANK_EN_2  	2
#define BANK_EN_3  	3
#define WL_EN		4
#define SA_EN		5
#define BL_PCHG		6
#define CLK_SA		7
#define WRITE_EN	8
#define CS_0		9
#define CS_1		10
#define SCN_SEL_0	11
#define SCN_SEL_1	12
#define SCN_SEL_2	13
#define SCN_SEL_3	14
#define InputEN_DAC 15
#define CALIB_EN	16
#define BANK_SEL	17
#define CHG_EN		18
#define RST_CAP		19
#define VDAC_CTRL	20
#define VTC_EN		21
#define TDC_EN		22
#define TDC_RST		23
#define TDC_COMPUTE 24
#define DFF_RST		25
#define CTRL_EN		26
#define CLK_A		27
#define CLK_B		28
#define IN_EN		29
#define SCN_IN		30
#define CTRL_VB		31

/********** Signal Index for Dig AXI IN Bus 1 **********/
#define CTRL_VBP	32
#define CTRL_VBN	33

/********** Signal Index for Output AXI Bus **********/
#define SCN_OUT 0
#define IMC_DONE 1

// Define Scan Chains
#define TDC_OUT_SC_LM       0
#define TDC_OUT_SC_RM       1
#define CL_EN_SC_LM         2
#define CL_EN_SC_RM         3
#define WL_SC               4
#define SA_OUT_SC           5
#define WRITE_DATA_SC       6
#define CONTROL_LOGIC_SC    7
#define XIN_SC_QUADV        8
#define XIN_SC_UNITV        9

#define MAX_SCAN_LEN 1164
#define NUM_WL 1164

// Scan chain validation + DMA length helpers
static inline int is_valid_scan_id(u8 scan_id) {
    return (scan_id <= XIN_SC_UNITV);
}

static inline u16 get_scan_len_for_id(u8 scan_id) {
    if (!is_valid_scan_id(scan_id)) {
        return 0;
    }
    // this is valid for the controller-side default table
    // if you later want a different table, set this here
    return 1152;
}

static inline u32 scan_dma_len_bytes(u16 scan_len) {
    return (((u32)scan_len + 31u) / 32u) * 4u;
}

//Define signal index for MODE_SETIING_AXI
#define VERILOG_C_SCAN 	0
#define SCAN_SEL_0_V 	1
#define SCAN_SEL_1_V 	2
#define SCAN_SEL_2_V 	3
#define SCAN_SEL_3_V 	4
#define SCAN_IN_RECV_V 	5
#define SCAN_IN_SEND_V 	6
#define SCAN_IN_EN_V 	7
#define SCAN_OUT_EN_V 	8
#define Test_DMA_V 		9
#define NCLK_0_V 		10
#define NCLK_1_V 		11
#define NCLK_2_V 		12
#define NCLK_3_V 		13
#define NCLK_4_V 		14
#define NCLK_5_V 		15
#define NCLK_6_V 		16
#define NCLK_7_V 		17
#define TOPS_EN_V 		18
#define TOPS_STOP_V 	19
#define WRITE_SRAM_EN_V 20
#define FAST_IMC_EN_V 	21
#define SEND_IMC_DATA_V 22
#define IMC_Mode 		23
#define Ext_IMC_EN		24
#define stepIMC_EN		25
#define SCAN_LEN_V_0	26
#define SCAN_LEN_V_1	27
#define SCAN_LEN_V_2	28
#define SCAN_LEN_V_3	29
#define SCAN_LEN_V_4	30
#define SCAN_LEN_V_5	31

//Create a structure to store the state machine data.
struct SM_DATA{
    u8 signal_values[DIG_IN_SIG_LEN];
    u8 default_signal_values[DIG_IN_SIG_LEN];

    u8 mode_signal_values[32];
    u8 mode_default_signal_values[32];

    u8 dma_scanout_buffer[148] __attribute__((aligned(32)));
    u8 dma_scan_in_buffer[148] __attribute__((aligned(32)));
    u8 dma_imcout_buffer[452] __attribute__((aligned(32)));

    int imc_out_mac[360];
    u8 sram_read_buffer [36*1164];
    u8 sram_write_buffer[36*1152];
    u16 calib_wl[12];
    u16 scan_len[10];

    XGpio AXI_INPUT_BUS_0;
    XGpio AXI_INPUT_BUS_1;
    XGpio AXI_OUTPUT_BUS;
    XGpio AXI_DEBUG_OUTPUT_BUS_0;
    XGpio AXI_DEBUG_OUTPUT_BUS_1;
    XGpio AXI_SCAN_MODE_SETTINGS_BUS;
    XAxiDma AxiDma;

    float Correction_Data[2][4][90];
};

extern struct SM_DATA GLOBAL_SM_DATA;

err_t process_fn();
#endif /* SRC_STATE_MACHINE_H_ */
