`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2026 23:14:53
// Design Name: 
// Module Name: Unbundle_AXI_Bus
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

module Unbundle_AXI_Bus(
    // AXI Bus input
    input  [31:0] DIG_AXI_IN_0,
    input         DIG_AXI_IN_1,

    ////////////////////////////////////////////////////////
    // R/W signals
    ////////////////////////////////////////////////////////
    output        WL_EN_C,
    output        SA_EN_C,
    output        BL_PCHG_C,
    output        CLK_SA_C,
    output        WEN_C,
    output        READ_EN_C,
    output [1:0]  CS_B_C,

    ////////////////////////////////////////////////////////
    // Scan Chain Signals
    ////////////////////////////////////////////////////////
    output [2:0]  SCN_SEL_C,
    output        CLKA_C,
    output        CLKB_C,
    output        IN_EN_C,
    output        SCN_IN_C,

    ////////////////////////////////////////////////////////
    // Other Signals
    ////////////////////////////////////////////////////////
    output        COMPUTE_EN_C,
    output        DFF_RST_C,
    output        MUX_OUT_PAD_C,
    output        CONTROL_EN_C,
    output        CLK_OUT_PAD_C,
    output        osc_EN_C,

    ////////////////////////////////////////////////////////
    // Control Signals
    ////////////////////////////////////////////////////////
    output [3:0]  capturestart_C,
    output [3:0]  div_ratio_C,
    output [3:0]  SAMPLE_EDGE_TIME_C,
    output        CLK_SA_B_C
);

    ////////////////////////////////////////////////////////
    // Direct bit mapping from AXI bus to legacy controller bus
    ////////////////////////////////////////////////////////
    assign capturestart_C[0] = DIG_AXI_IN_0[0];
    assign capturestart_C[1] = DIG_AXI_IN_0[1];
    assign capturestart_C[2] = DIG_AXI_IN_0[2];
    assign capturestart_C[3] = DIG_AXI_IN_0[3];

    assign div_ratio_C[0]    = DIG_AXI_IN_0[4];
    assign div_ratio_C[1]    = DIG_AXI_IN_0[5];
    assign div_ratio_C[2]    = DIG_AXI_IN_0[6];
    assign div_ratio_C[3]    = DIG_AXI_IN_0[7];

    assign SAMPLE_EDGE_TIME_C[0] = DIG_AXI_IN_0[8];
    assign SAMPLE_EDGE_TIME_C[1] = DIG_AXI_IN_0[9];
    assign SAMPLE_EDGE_TIME_C[2] = DIG_AXI_IN_0[10];
    assign SAMPLE_EDGE_TIME_C[3] = DIG_AXI_IN_0[11];

    assign SCN_SEL_C[0] = DIG_AXI_IN_0[12];
    assign SCN_SEL_C[1] = DIG_AXI_IN_0[13];
    assign SCN_SEL_C[2] = DIG_AXI_IN_0[14];

    assign CS_B_C[0]    = DIG_AXI_IN_0[15];
    assign CS_B_C[1]    = DIG_AXI_IN_0[16];
    assign CLKA_C       = DIG_AXI_IN_0[17];
    assign CLKB_C       = DIG_AXI_IN_0[18];
    assign IN_EN_C      = DIG_AXI_IN_0[19];
    assign SCN_IN_C     = DIG_AXI_IN_0[20];
    assign COMPUTE_EN_C = DIG_AXI_IN_0[21];
    assign DFF_RST_C    = DIG_AXI_IN_0[22];
    assign MUX_OUT_PAD_C = DIG_AXI_IN_0[23];
    assign CONTROL_EN_C = DIG_AXI_IN_0[24];
    assign CLK_OUT_PAD_C = DIG_AXI_IN_0[25];
    assign CLK_SA_B_C   = DIG_AXI_IN_0[26];

    assign WEN_C       = DIG_AXI_IN_0[27];
    assign READ_EN_C   = DIG_AXI_IN_0[28];
    assign SA_EN_C     = DIG_AXI_IN_0[29];
    assign BL_PCHG_C   = DIG_AXI_IN_0[30];
    assign osc_EN_C    = DIG_AXI_IN_0[31];

    assign WL_EN_C     = DIG_AXI_IN_1;

endmodule
