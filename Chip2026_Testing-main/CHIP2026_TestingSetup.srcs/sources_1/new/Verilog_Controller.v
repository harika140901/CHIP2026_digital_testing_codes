`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2026 23:13:12
// Design Name: 
// Module Name: Verilog_Controller
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

module Verilog_Controller(
    ////////////////////////////////////////////////////////
    // Read-Write Signals
    ////////////////////////////////////////////////////////
    input        WL_EN_C,
    input        SA_EN_C,
    input        BL_PCHG_C,
    input        CLK_SA_C,
    input        READ_EN_C,
    input        WEN_C,
    input  [1:0] CS_B_C,

    ////////////////////////////////////////////////////////
    // Scan-Chain Signals
    ////////////////////////////////////////////////////////
    input  [2:0] SCN_SEL_C,
    input        CLKA_C,
    input        CLKB_C,
    input        IN_EN_C,
    input        SCN_IN_C,

    ////////////////////////////////////////////////////////
    // Other Signals
    ////////////////////////////////////////////////////////
    input        COMPUTE_EN_C,
    input        DFF_RST_C,
    input        MUX_OUT_PAD_C,
    input        CONTROL_EN_C,
    input        CLK_OUT_PAD_C,
    input        osc_EN_C,

    ////////////////////////////////////////////////////////
    // Control Signals
    ////////////////////////////////////////////////////////
    input  [3:0] capturestart_C,
    input  [3:0] div_ratio_C,
    input  [3:0] SAMPLE_EDGE_TIME_C,

    ////////////////////////////////////////////////////////
    // R/W signals
    ////////////////////////////////////////////////////////
    output        WL_EN,
    output        SA_EN,
    output        BL_PCHG,
    output        CLK_SA,
    output        WEN,
    output        READ_EN,
    output [1:0]  CS_B,

    ////////////////////////////////////////////////////////
    // Scan Chain Signals
    ////////////////////////////////////////////////////////
    output [2:0]  SCN_SEL,
    output        CLKA,
    output        CLKB,
    output        IN_EN,
    output        SCN_IN,

    ////////////////////////////////////////////////////////
    // Other Signals
    ////////////////////////////////////////////////////////
    output        COMPUTE_EN,
    output        DFF_RST,
    output        MUX_OUT_PAD,
    output        CONTROL_EN,
    output        CLK_OUT_PAD,
    output        osc_EN,

    ////////////////////////////////////////////////////////
    // Control Signals
    ////////////////////////////////////////////////////////
    output [3:0] capturestart,
    output [3:0] div_ratio,
    output [3:0] SAMPLE_EDGE_TIME
);

    assign WL_EN        = WL_EN_C;
    assign SA_EN        = SA_EN_C;
    assign BL_PCHG      = BL_PCHG_C;
    assign CLK_SA      = CLK_SA_C;
    assign WEN         = WEN_C;
    assign READ_EN     = READ_EN_C;
    assign CS_B        = CS_B_C;

    assign SCN_SEL     = SCN_SEL_C;
    assign CLKA        = CLKA_C;
    assign CLKB        = CLKB_C;
    assign IN_EN       = IN_EN_C;
    assign SCN_IN      = SCN_IN_C;

    assign COMPUTE_EN  = COMPUTE_EN_C;
    assign DFF_RST     = DFF_RST_C;
    assign MUX_OUT_PAD = MUX_OUT_PAD_C;
    assign CONTROL_EN  = CONTROL_EN_C;
    assign CLK_OUT_PAD = CLK_OUT_PAD_C;
    assign osc_EN      = osc_EN_C;

    assign capturestart = capturestart_C;
    assign div_ratio    = div_ratio_C;
    assign SAMPLE_EDGE_TIME = SAMPLE_EDGE_TIME_C;

endmodule
