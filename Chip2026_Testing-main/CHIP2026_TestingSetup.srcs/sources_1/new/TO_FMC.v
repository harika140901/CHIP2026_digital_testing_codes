`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2026 11:17:02
// Design Name: .
// Module Name: TO_FMC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TO_FMC(

    input [3:0] capturestart,
    input  [3:0] div_ratio,
    input  [3:0] SAMPLE_EDGE_TIME,
    input  [2:0] SCN_SEL,
    input  [1:0] CS_B,

    
    input       CLKA,
    input       CLKB,
    input       IN_EN,
    input       SCN_IN,

    input       COMPUTE_EN,
    input       DFF_RST,
    input       MUX_OUT_PAD,
    input       CONTROL_EN,
    input       CLK_OUT_PAD,
    input       CLK_SA_B,
    input       WEN,
    input       READ_EN,
    input       SA_EN,
    input       BL_PCHG,
    input       osc_EN,
    input       WL_EN,

    output FMC_L21,
    output FMC_L22,
    output FMC_R19,
    output FMC_T19,
    output FMC_K19,
    output FMC_K20,
    output FMC_D20,
    output FMC_C20,
    output FMC_E21,
    output FMC_D21,
    output FMC_N19,
    output FMC_N20,
    output FMC_J18,
    output FMC_K18,
    output FMC_R20,
    output FMC_R21,
    output FMC_L17,
    output FMC_M17,
    output FMC_B19,
    output FMC_B20,
    output FMC_E15,
    output FMC_D15,
    output FMC_F18,
    output FMC_E18,
    output FMC_M19,
    output FMC_M20,
    output FMC_N22,
    output FMC_P22,
    output FMC_J21,
    output FMC_J22,
    output FMC_G20,
    output FMC_G21,
    output FMC_G19,
    output FMC_F19,
    output FMC_D22,
    output FMC_C22,
    output FMC_B22,
    output FMC_C17, 
    output FMC_C18, 

    input FMC_B16,
    input FMC_B17,
    input FMC_B21,
    
    output[2:0] DIG_AXI_OUT_0,
    output[31:0] DIG_DEBUG_AXI_OUT_0,
    output DIG_DEBUG_AXI_OUT_1
    );
    
    //Update FMC INPUT PINS
    assign DIG_AXI_OUT_0 = {FMC_B16,FMC_B17,FMC_B21}; //DEBUG_SC_OUT<1:0>,SCN_OUT
    
    //Update FMC OUTPUT PINS
    assign FMC_L21 = COMPUTE_EN;
    assign FMC_L22 = capturestart[0];
    assign FMC_R19 = capturestart[1];
    assign FMC_T19 = capturestart[2];
    assign FMC_K19 = capturestart[3];
    assign FMC_K20 = div_ratio[0];
    
    assign FMC_D20 = div_ratio[1];
    assign FMC_C20 = DFF_RST;
    assign FMC_E21 = MUX_OUT_PAD;
    assign FMC_D21 = CONTROL_EN;
    assign FMC_N19 = div_ratio[2];
    assign FMC_N20 = div_ratio[3];
    assign FMC_J18 = SAMPLE_EDGE_TIME[0];
    assign FMC_K18 = SAMPLE_EDGE_TIME[1];
    
    assign FMC_R20 = SAMPLE_EDGE_TIME[2];
    assign FMC_R21 = SAMPLE_EDGE_TIME[3];
    assign FMC_L17 = CLK_OUT_PAD;
    assign FMC_M17 = CLK_SA_B;
    
    assign FMC_B19 = WEN;
    assign FMC_B20 = READ_EN;
    assign FMC_M19 = SCN_SEL[0];
    assign FMC_M20 = SCN_SEL[1];
    assign FMC_N22 = SCN_SEL[2];
    assign FMC_P22 = CS_B[1];
    assign FMC_J21 = CS_B[0];
    assign FMC_J22 = SA_EN;

    assign FMC_G21 = BL_PCHG;
    assign FMC_G19 = SCN_IN;
    assign FMC_F19 = IN_EN;
    assign FMC_D22 = CLKA;
    assign FMC_C22 = CLKB;
    assign FMC_C17 = osc_EN;
    assign FMC_C18 = WL_EN;
    

    //Update DEBUG AXI PINS 
    assign DIG_DEBUG_AXI_OUT_0[0]  = capturestart[0];
    assign DIG_DEBUG_AXI_OUT_0[1]  = capturestart[1];
    assign DIG_DEBUG_AXI_OUT_0[2]  = capturestart[2];
    assign DIG_DEBUG_AXI_OUT_0[3]  = capturestart[3];
    assign DIG_DEBUG_AXI_OUT_0[4]  = div_ratio[0];
    assign DIG_DEBUG_AXI_OUT_0[5]  = div_ratio[1];
    assign DIG_DEBUG_AXI_OUT_0[6]  = div_ratio[2];
    assign DIG_DEBUG_AXI_OUT_0[7]  = div_ratio[3];
    assign DIG_DEBUG_AXI_OUT_0[8]  = SAMPLE_EDGE_TIME[0];
    assign DIG_DEBUG_AXI_OUT_0[9]  = SAMPLE_EDGE_TIME[1];
    assign DIG_DEBUG_AXI_OUT_0[10] = SAMPLE_EDGE_TIME[2];
    assign DIG_DEBUG_AXI_OUT_0[11] = SAMPLE_EDGE_TIME[3];
    assign DIG_DEBUG_AXI_OUT_0[12] = SCN_SEL[0];
    assign DIG_DEBUG_AXI_OUT_0[13] = SCN_SEL[1];
    assign DIG_DEBUG_AXI_OUT_0[14] = SCN_SEL[2];
    assign DIG_DEBUG_AXI_OUT_0[15] = CS_B[0];
    assign DIG_DEBUG_AXI_OUT_0[16] = CS_B[1];
    assign DIG_DEBUG_AXI_OUT_0[17] = CLKA;
    assign DIG_DEBUG_AXI_OUT_0[18] = CLKB;
    assign DIG_DEBUG_AXI_OUT_0[19] = IN_EN;
    assign DIG_DEBUG_AXI_OUT_0[20] = SCN_IN;
    assign DIG_DEBUG_AXI_OUT_0[21] = COMPUTE_EN;
    assign DIG_DEBUG_AXI_OUT_0[22] = DFF_RST;
    assign DIG_DEBUG_AXI_OUT_0[23] = MUX_OUT_PAD;
    assign DIG_DEBUG_AXI_OUT_0[24] = CONTROL_EN;
    assign DIG_DEBUG_AXI_OUT_0[25] = CLK_OUT_PAD;
    assign DIG_DEBUG_AXI_OUT_0[26] = CLK_SA_B;
    assign DIG_DEBUG_AXI_OUT_0[27] = WEN;
    assign DIG_DEBUG_AXI_OUT_0[28] = READ_EN;
    assign DIG_DEBUG_AXI_OUT_0[29] = SA_EN;
    assign DIG_DEBUG_AXI_OUT_0[30] = BL_PCHG;
    assign DIG_DEBUG_AXI_OUT_0[31] = osc_EN;
    assign DIG_DEBUG_AXI_OUT_1 = WL_EN;  // FIXED: scalar assignment (was incorrectly indexed as [0])
      
endmodule
