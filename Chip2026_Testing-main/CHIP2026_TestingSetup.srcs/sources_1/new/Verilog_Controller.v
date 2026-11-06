`timescale 1ns / 1ps

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
    input        CLK_A_C,
    input        CLK_B_C,
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
    output [3:0] SAMPLE_EDGE_TIME,

    // Renamed to avoid AXI inference issues
    input  [31:0] scan_mode_setting_in,
    input  [2:0]  dig_out,

    ////////////////////////////////////////////////////////
    // DMA / Stream Signals
    ////////////////////////////////////////////////////////
    input         clk,
    // MM2S
    input         in_tvalid,
    input         in_tlast,
    input  [31:0] in_tdata,
    output        in_tready,
    // S2MM
    input         out_tready,
    output        out_tvalid,
    output        out_tlast,
    output [31:0] out_tdata,

    ////////////////////////////////////////////////////////
    // Scan Data Flags
    ////////////////////////////////////////////////////////
    output [3:0] SCAN_DONE_FLAGS
);

    // --------------------------------------------------------------------
    // Dig-out scan signal aliases
    // --------------------------------------------------------------------
    wire SCN_OUT = dig_out[0];
    wire [1:0] DEBUG_SC_OUT;
    assign DEBUG_SC_OUT[0] = dig_out[1];
    assign DEBUG_SC_OUT[1] = dig_out[2];

    // --------------------------------------------------------------------
    // Scan control / mode bits
    // --------------------------------------------------------------------
    wire VERILOG_C_SCN     = scan_mode_setting_in[0];
    wire [2:0] SCN_ID      = scan_mode_setting_in[3:1];
    wire RECV_SCN_IN_DATA  = scan_mode_setting_in[4];
    wire SEND_SCN_OUT_DATA = scan_mode_setting_in[5];
    wire SCAN_IN_EN        = scan_mode_setting_in[7];
    wire SCAN_OUT_EN       = scan_mode_setting_in[8];
    wire TEST_DMA          = scan_mode_setting_in[9];
    wire [7:0] N_CYCLES    = scan_mode_setting_in[17:10];
    wire TOPS_EN           = scan_mode_setting_in[18];
    wire TOPS_STOP         = scan_mode_setting_in[19];
    wire WRITE_SRAM_EN     = scan_mode_setting_in[20];
    wire FAST_IMC_EN       = scan_mode_setting_in[21];
    wire SEND_IMC_DATA     = scan_mode_setting_in[22];
    wire IMC_Mode          = scan_mode_setting_in[23];
    wire Ext_IMC_EN        = scan_mode_setting_in[24];
    wire stepIMC_EN        = scan_mode_setting_in[25];
    wire [5:0] active_cols = scan_mode_setting_in[31:26];

    // --------------------------------------------------------------------
    // DMA / AXI-Stream internal buses
    // --------------------------------------------------------------------
    wire m_axis_tvalid_scan, m_axis_tlast_scan, m_axis_tready_scan;
    wire [31:0] m_axis_tdata_scan;

    wire m_axis_tvalid_imc, m_axis_tlast_imc, m_axis_tready_imc;
    wire [31:0] m_axis_tdata_imc;

    assign out_tvalid = (SEND_SCN_OUT_DATA == 1'b1) ? m_axis_tvalid_scan : m_axis_tvalid_imc;
    assign out_tlast  = (SEND_SCN_OUT_DATA == 1'b1) ? m_axis_tlast_scan  : m_axis_tlast_imc;
    assign out_tdata  = (SEND_SCN_OUT_DATA == 1'b1) ? m_axis_tdata_scan  : m_axis_tdata_imc;

    assign m_axis_tready_scan = (SEND_SCN_OUT_DATA == 1'b1) ? out_tready : 1'b0;
    assign m_axis_tready_imc  = (SEND_IMC_DATA == 1'b1) ? out_tready : 1'b0;

    // --------------------------------------------------------------------
    // DMA buffer definitions
    // --------------------------------------------------------------------
    wire [32*48-1:0] SCAN_IN_BUFF;
    wire [32*48-1:0] SCAN_OUT_BUFF;
    wire [32*48-1:0] DMA_SEND_BUFF;
    assign DMA_SEND_BUFF = (TEST_DMA) ? SCAN_IN_BUFF : SCAN_OUT_BUFF;

    wire [7:0] SCAN_LEN_WORD;
    wire [10:0] SCAN_LEN_BITS;

    assign SCAN_LEN_WORD = (SCN_ID == 6) ? 8'd7 :
                          (SCN_ID == 5) ? 8'd7 :
                          (SCN_ID == 4) ? 8'd48 :
                          (SCN_ID == 3) ? 8'd15 :
                          (SCN_ID == 2) ? 8'd36 :
                          (SCN_ID == 1) ? 8'd36 :
                                          8'd36;

    assign SCAN_LEN_BITS = (SCN_ID == 6) ? 11'd200 :
                           (SCN_ID == 5) ? 11'd200 :
                           (SCN_ID == 4) ? 11'd1536 :
                           (SCN_ID == 3) ? 11'd475 :
                           (SCN_ID == 2) ? 11'd1152 :
                           (SCN_ID == 1) ? 11'd1152 :
                                           11'd1152;

    // --------------------------------------------------------------------
    // DMA Receive: scan_in_data
    // --------------------------------------------------------------------
    dma_recv_data u_recv (
        .clk(clk),
        .EN(RECV_SCN_IN_DATA),
        .s_axis_tvalid(in_tvalid),
        .s_axis_tlast(in_tlast),
        .s_axis_tdata(in_tdata),
        .s_axis_tready(in_tready),
        .buffer_flat(SCAN_IN_BUFF)
    );
    defparam u_recv.BUFF_SIZE = 32*48;
    defparam u_recv.MAX_ITER_BITS = 8;

    // --------------------------------------------------------------------
    // DMA Send: scan_out_data
    // --------------------------------------------------------------------
    dma_send_data u_send_scn (
        .clk(clk),
        .EN(SEND_SCN_OUT_DATA),
        .send_len(SCAN_LEN_WORD),
        .buffer_flat(DMA_SEND_BUFF),
        .m_axis_tvalid(m_axis_tvalid_scan),
        .m_axis_tlast(m_axis_tlast_scan),
        .m_axis_tdata(m_axis_tdata_scan),
        .m_axis_tready(m_axis_tready_scan)
    );
    defparam u_send_scn.BUFF_SIZE = 32*48;
    defparam u_send_scn.MAX_ITER_BITS = 8;

    // --------------------------------------------------------------------
    // DMA Send: IMC output
    // --------------------------------------------------------------------
    wire [479:0] IMC_OUT_BUFF_final;
    wire [479:0] IMC_OUT_BUFF;

    assign IMC_OUT_BUFF_final = {3'b000, DEBUG_SC_OUT[1], DEBUG_SC_OUT[0], IMC_OUT_BUFF[474:0]};

    wire [7:0] IMC_OUT_LEN_WORD = 8'd15;

    dma_send_data u_send_imc (
        .clk(clk),
        .EN(SEND_IMC_DATA),
        .send_len(IMC_OUT_LEN_WORD),
        .buffer_flat(IMC_OUT_BUFF_final),
        .m_axis_tvalid(m_axis_tvalid_imc),
        .m_axis_tlast(m_axis_tlast_imc),
        .m_axis_tdata(m_axis_tdata_imc),
        .m_axis_tready(m_axis_tready_imc)
    );
    defparam u_send_imc.BUFF_SIZE = 480;
    defparam u_send_imc.MAX_ITER_BITS = 8;

    // --------------------------------------------------------------------
    // FAST SCAN MODULES
    // --------------------------------------------------------------------
    wire CLK_A_VER, CLK_B_VER;
    wire CLK_A_SCNIN, CLK_B_SCNIN;
    wire CLK_A_SCNOUT, CLK_B_SCNOUT;
    wire SCAN_IN_VER, SCAN_IN_DONE, SCAN_OUT_DONE;

    assign CLK_A_VER = (SCAN_IN_EN) ? CLK_A_SCNIN : CLK_A_SCNOUT;
    assign CLK_B_VER = (SCAN_IN_EN) ? CLK_B_SCNIN : CLK_B_SCNOUT;

    scan_in_verilog u_scn_in(
        .EN(SCAN_IN_EN),
        .CLK(clk),
        .scan_in_buff(SCAN_IN_BUFF),
        .scan_len_bits(SCAN_LEN_BITS),
        .SCAN_IN(SCAN_IN_VER),
        .CLK_A(CLK_A_SCNIN),
        .CLK_B(CLK_B_SCNIN),
        .SCAN_DONE(SCAN_IN_DONE)
    );

    scan_out_verilog u_scn_out(
        .EN(SCAN_OUT_EN),
        .CLK(clk),
        .SCAN_OUT(SCN_OUT),
        .scan_len_bits(SCAN_LEN_BITS),
        .CLK_A(CLK_A_SCNOUT),
        .CLK_B(CLK_B_SCNOUT),
        .SCAN_DONE(SCAN_OUT_DONE),
        .SCAN_OUT_BUFF(SCAN_OUT_BUFF)
    );

    // --------------------------------------------------------------------
    // TOPS block
    // --------------------------------------------------------------------
    wire DFF_RST_TOPS, COMPUTE_EN_TOPS, CONTROL_EN_TOPS, imc_done_scan_out;

    TOPS_BLOCK u_tops_block(
        .CLK(clk),
        .EN(TOPS_EN),
        .stop(TOPS_STOP),
        .DFF_RST(DFF_RST_TOPS),
        .COMPUTE_EN(COMPUTE_EN_TOPS),
        .CONTROL_EN(CONTROL_EN_TOPS),
        .imc_done_scan_out(imc_done_scan_out)
    );

    // --------------------------------------------------------------------
    // WRITE_SRAM block
    // --------------------------------------------------------------------
    wire WRITE_SRAM_DONE, WEN_SRAM, WLEN_SRAM;

    Write_SRAM_WL u_write_sram(
        .CLK(clk),
        .EN(WRITE_SRAM_EN),
        .done(WRITE_SRAM_DONE),
        .WEN(WEN_SRAM),
        .WL_EN(WLEN_SRAM)
    );

    // --------------------------------------------------------------------
    // IMC scan-out / external wrapper
    // --------------------------------------------------------------------
    wire SCAN_IN_IMC, IN_EN_IMC, CLK_A_IMC, CLK_B_IMC, DFF_RST_IMC;
    wire [2:0] SCAN_SEL_IMC;
    wire COMPUTE_EN_IMC, MUX_SEL_IMC, CLK_CAPTURE_IMC;

    wire IMC_SCNOUT_DONE;
    wire FAST_IMC_DONE;
    wire EXT_IMC_DONE_final, EXT_IMC_DONE;

    assign FAST_IMC_DONE = (Ext_IMC_EN) ? EXT_IMC_DONE :
                           ((FAST_IMC_EN) ? IMC_SCNOUT_DONE : imc_done_scan_out);

    IMC_ScanOut u1_imc_scnout (
        .CLK(clk),
        .EN(FAST_IMC_EN),
        .IMC_MODE(IMC_Mode),
        .SCAN_OUT(SCN_OUT),
        .IMC_DONE(imc_done_scan_out),
        .SCAN_IN(SCAN_IN_IMC),
        .IN_EN(IN_EN_IMC),
        .CLK_A(CLK_A_IMC),
        .CLK_B(CLK_B_IMC),
        .DFF_RST(DFF_RST_IMC),
        .SCAN_SEL(SCAN_SEL_IMC),
        .DONE(IMC_SCNOUT_DONE),
        .OUT(IMC_OUT_BUFF),
        .COMPUTE_EN(COMPUTE_EN_IMC),
        .MUX_SEL(MUX_SEL_IMC),
        .CLK_CAPTURE(CLK_CAPTURE_IMC)
    );

    IMC_Wrapper standalone_IMC_EXT (
        .CLK(clk),
        .EN(Ext_IMC_EN),
        .cyc_one(1'b1),
        .COMPUTE_EN(COMPUTE_EN0),
        .MUX_SEL(MUX_SEL0),
        .CLK_CAPTURE(CLK_CAPTURE0),
        .DONE(EXT_IMC_DONE_final),
        .IMC_DONE(EXT_IMC_DONE)
    );

    wire COMPUTE_EN0, MUX_SEL0, CLK_CAPTURE0;

    assign capturestart = capturestart_C;
    assign div_ratio    = div_ratio_C;
    assign SAMPLE_EDGE_TIME = SAMPLE_EDGE_TIME_C;

    // --------------------------------------------------------------------
    // Final controller output flags
    // --------------------------------------------------------------------
    assign SCAN_DONE_FLAGS = {FAST_IMC_DONE, WRITE_SRAM_DONE, SCAN_OUT_DONE, SCAN_IN_DONE};

    // --------------------------------------------------------------------
    // Read & Write Signal Mapping
    // --------------------------------------------------------------------
    assign WL_EN = (WRITE_SRAM_EN) ? WLEN_SRAM : WL_EN_C;
    assign SA_EN = SA_EN_C;
    assign BL_PCHG = BL_PCHG_C;
    assign CLK_SA = CLK_SA_C;
    assign WRITE_EN = (WRITE_SRAM_EN == 1'b1) ? WEN_SRAM : WEN_C;
    assign READ_EN  = READ_EN_C;
    assign CS_B     = CS_B_C;

    // --------------------------------------------------------------------
    // Scan Chain Signals
    // --------------------------------------------------------------------
    assign SCN_SEL = (FAST_IMC_EN == 1'b1) ? SCAN_SEL_IMC :
                     (VERILOG_C_SCN == 1'b1) ? SCN_ID :
                                               SCN_SEL_C;

    assign CLKA = (FAST_IMC_EN == 1'b1) ? CLK_A_IMC :
                  (VERILOG_C_SCN == 1'b1) ? CLK_A_VER :
                                            CLK_A_C;

    assign CLKB = (FAST_IMC_EN == 1'b1) ? CLK_B_IMC :
                  (VERILOG_C_SCN == 1'b1) ? CLK_B_VER :
                                            CLK_B_C;

    assign IN_EN = (FAST_IMC_EN == 1'b1) ? IN_EN_IMC : IN_EN_C;
    assign SCN_IN = (FAST_IMC_EN == 1'b1) ? SCAN_IN_IMC :
                    (VERILOG_C_SCN == 1'b1) ? SCAN_IN_VER :
                                              SCN_IN_C;

    // --------------------------------------------------------------------
    // Compute Signals
    // --------------------------------------------------------------------
    assign COMPUTE_EN = (TOPS_EN) ? COMPUTE_EN_TOPS :
                       ((Ext_IMC_EN) ? COMPUTE_EN0 :
                       ((IMC_Mode == 1'b1) ? COMPUTE_EN_IMC : COMPUTE_EN_C));

    assign MUX_OUT_PAD = (TOPS_EN) ? 1'b0 :
                         ((Ext_IMC_EN) ? MUX_SEL0 :
                         ((IMC_Mode == 1'b1) ? MUX_SEL_IMC : MUX_OUT_PAD_C));

    assign CLK_OUT_PAD = (Ext_IMC_EN) ? CLK_CAPTURE0 :
                         ((IMC_Mode == 1'b1) ? CLK_CAPTURE_IMC : CLK_OUT_PAD_C);

    assign DFF_RST = (TOPS_EN) ? DFF_RST_TOPS :
                     ((~IMC_Mode && FAST_IMC_EN) ? DFF_RST_IMC : DFF_RST_C);

    assign CONTROL_EN = (TOPS_EN) ? CONTROL_EN_TOPS : CONTROL_EN_C;
    assign osc_EN     = osc_EN_C;

endmodule
