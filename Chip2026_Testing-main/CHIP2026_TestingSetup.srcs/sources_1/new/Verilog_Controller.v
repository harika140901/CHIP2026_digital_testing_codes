module Verilog_Controller(

    ////////////////////////////////////////////////////////
    // Read-Write Signals
    input        WL_EN_C,
    input        SA_EN_C,
    input        BL_PCHG_C,
    input        CLK_SA_C,
    input        READ_EN_C,
    input        WEN_C,
    input  [1:0] CS_B_C,

    // Scan-Chain Signals
    input  [2:0]  SCN_SEL_C,
    input        CLKA_C,
    input        CLKB_C,
    input        IN_EN_C,
    input        SCN_IN_C,

    // Other Signals
    input        COMPUTE_EN_C,
    input        DFF_RST_C,
    input        MUX_OUT_PAD_C,
    input        CONTROL_EN_C,
    input        CLK_OUT_PAD_C,
    input        osc_EN_C,

    // control signals
    input        [3:0] caturestart_C,
    input        [3:0] div_ratio_C,
    input        [3:0] SAMPLE_EDGE_TIME_C,

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

    output        [3:0] caturestart,
    output        [3:0] div_ratio,
    output        [3:0] SAMPLE_EDGE_TIME,

    ////////////////////////////////////////////////////////
    // Chip-level testing / word-line map compatibility notes:
    // The project notebook notes indicate a WL (word-line), scan-channel, and
    // read/write planning view for a 1536-WL style array. The legacy names used
    // here are kept intentionally for compatibility with the existing RTL and
    // interface map. The following mode/control inputs are configured externally
    // and should remain part of the module interface.
    ////////////////////////////////////////////////////////
    input  [31:0] scan_mode_setting_in,
    input  [2:0]  dig_out,

    ////////////////////////////////////////////////////////
    // DMA / Stream Signals
    ////////////////////////////////////////////////////////

    input         clk,
    // Memory mapped to stream MM2S
    input         in_tvalid,
    input         in_tlast,
    input  [31:0] in_tdata,
    output        in_tready,
    // Stream to Memory mapped S2MM
    input         out_tready,
    output        out_tvalid,
    output        out_tlast,
    output [31:0] out_tdata,

    ////////////////////////////////////////////////////////
    // Scan Data Flags
    ////////////////////////////////////////////////////////

    output [3:0] SCAN_DONE_FLAGS
);
