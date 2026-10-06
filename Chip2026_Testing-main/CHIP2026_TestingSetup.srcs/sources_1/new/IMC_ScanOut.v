`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 16:56:00
// Design Name: 
// Module Name: IMC_ScanOut
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Refactored to support 6 scan chains with per-chain lengths:
//   1 = input scan chain 2 (1152 bits)
//   2 = input scan chain 1 (1152 bits)
//   3 = output scan chain (475 bits)
//   4 = WL scan chain (1536 bits)
//   5 = read (50 bits)
//   6 = write (50 bits)
// 
// Dependencies: IMC_Wrapper, scan_out_verilog
// 
// Revision:
// Revision 0.02 - Updated for per-chain length support
// 
//////////////////////////////////////////////////////////////////////////////////

module IMC_ScanOut(
    input  wire             CLK,
    input  wire             EN,          // enable/start
    input  wire [2:0]       SCN_SEL,     // 3-bit scan chain select (001-110)
    input  wire             SCAN_OUT,    // input from chip
    input  wire             IMC_DONE,    // IMC_DONE from chip
    input  wire             IMC_MODE,    // 0: Internal Mode; 1: External Mode
    output reg              SCAN_IN,
    output reg              IN_EN,
    
    // compute control signals
    // Will be triggered with Ext-PL control logic
    output wire CHG_EN,
    output wire RST_CAP,
    output wire VDAC_CTRL,
    output wire TDC_EN,
    output wire TDC_COMPUTE,
    output wire TDC_RST,
    output wire VTC_EN,
    
    output wire             CLK_A,
    output wire             CLK_B,
    output reg              BANK_SEL,    // 1-bit bank select
    output reg [3:0]        BANK_EN,
    output reg              DFF_RST,
    output reg              DONE,
    output wire [3615:0]    OUT         // output buffer (max 1536 bits + padding)
    );
    
    ////////////// SCAN CHAIN DEFINITIONS //////////////
    localparam CHAIN_IN2   = 3'd1;   // input scan chain 2
    localparam CHAIN_IN1   = 3'd2;   // input scan chain 1
    localparam CHAIN_OUT   = 3'd3;   // output scan chain
    localparam CHAIN_WL    = 3'd4;   // WL scan chain
    localparam CHAIN_READ  = 3'd5;   // read
    localparam CHAIN_WRITE = 3'd6;   // write
    
    localparam Ncycles   = 1;
    
    ////////////// SCAN LENGTH DECODER //////////////
    wire [10:0] scan_len_bits;
    always @(*) begin
        case (SCN_SEL)
            CHAIN_IN2:   scan_len_bits = 11'd1152;
            CHAIN_IN1:   scan_len_bits = 11'd1152;
            CHAIN_OUT:   scan_len_bits = 11'd475;
            CHAIN_WL:    scan_len_bits = 11'd1536;
            CHAIN_READ:  scan_len_bits = 11'd50;
            CHAIN_WRITE: scan_len_bits = 11'd50;
            default:     scan_len_bits = 11'd0;
        endcase
    end
    
    ////////////// OUTPUT BUFFER //////////////
    reg [1535:0] out_buf;
    assign OUT = {2080'b0, out_buf};  // pad to 3616 bits
    
    ////////////// State Encodings //////////////
    localparam ST_IDLE          = 4'd0;
    localparam ST_IMC_START     = 4'd1;
    localparam ST_IMC_WAIT      = 4'd2;
    localparam ST_IN_EN_ON      = 4'd3;
    localparam ST_CLK_A_HI      = 4'd4;
    localparam ST_CLK_A_LO      = 4'd5;
    localparam ST_IN_EN_OFF     = 4'd6;
    localparam ST_SCAN_OUT      = 4'd7;
    localparam ST_DONE          = 4'd8;
    
    reg [3:0] FSM_state;
    
    ////////////// External IMC Module //////////////
    wire Ext_IMC_DONE, Ext_IMC_EN;
    assign Ext_IMC_EN = IMC_MODE &&
                    ((FSM_state == ST_IMC_START) ||
                     (FSM_state == ST_IMC_WAIT));
    
    IMC_Wrapper external_imc_controller (
        .EN(Ext_IMC_EN),
        .TOPS_en(1'b0),
        .CLK(CLK), .CHG_EN(CHG_EN), .RST_CAP(RST_CAP),
        .VDAC_CTRL(VDAC_CTRL), .TDC_EN(TDC_EN), .TDC_RST(TDC_RST),
        .TDC_COMPUTE(TDC_COMPUTE), .VTC_EN(VTC_EN),
        .IMC_DONE(Ext_IMC_DONE)
    );
    wire IMC_DONE_SEL;
    assign IMC_DONE_SEL = (IMC_MODE) ? Ext_IMC_DONE : IMC_DONE;
    
    ////////////// SCAN_OUT_MODULE //////////////
    wire submodule_scan_done, CLK_A_scnout;
    wire [1535:0] scanned_bits;
    
    scan_out_verilog u_imc_scanout (
        .EN(FSM_state == ST_SCAN_OUT),
        .CLK(CLK),
        .N_CYCLES(Ncycles),
        .SCAN_OUT(SCAN_OUT),
        .scan_len_bits(scan_len_bits),
        .CLK_A(CLK_A_scnout),
        .CLK_B(CLK_B),
        .SCAN_DONE(submodule_scan_done),
        .SCAN_OUT_BUFF(scanned_bits)
    );
    
    reg CLK_A_load;
    assign CLK_A = CLK_A_scnout | CLK_A_load;
    
    reg [7:0] delay_cnt;
    
    ////////////// FSM LOGIC //////////////
    always @(posedge CLK) begin
        if(!EN) begin
            FSM_state <= ST_IDLE;
            IN_EN <= 0; CLK_A_load <= 0;
            BANK_SEL <= 0; BANK_EN <= 4'b0000; 
            DFF_RST <= 0; DONE <= 0;
            delay_cnt <= 0;
            SCAN_IN <= 0;
            out_buf <= 1536'b0;
        end
        else begin
            delay_cnt <= delay_cnt + 1;
            case(FSM_state)
                ST_IDLE: begin
                    FSM_state <= ST_IMC_START;
                end
                
                ST_IMC_START: begin
                    if(!IMC_MODE) begin
                        DFF_RST <= 1;
                    end
                    delay_cnt <= 0;
                    FSM_state <= ST_IMC_WAIT;
                end
                
                ST_IMC_WAIT: begin
                    if(IMC_DONE_SEL) begin
                        FSM_state <= ST_IN_EN_ON;
                    end
                end
                
                ST_IN_EN_ON: begin
                    IN_EN <= 1;
                    SCAN_IN <= 0;
                    delay_cnt <= 0;
                    if (delay_cnt == Ncycles) begin
                        FSM_state <= ST_CLK_A_HI;
                    end
                end
                
                ST_CLK_A_HI: begin
                    CLK_A_load <= 1;
                    if (delay_cnt == Ncycles) begin
                        delay_cnt <= 0;
                        FSM_state <= ST_CLK_A_LO;
                    end
                end
                
                ST_CLK_A_LO: begin
                    CLK_A_load <= 0;
                    if (delay_cnt == Ncycles) begin
                        delay_cnt <= 0;
                        FSM_state <= ST_IN_EN_OFF;
                    end
                end
                
                ST_IN_EN_OFF: begin
                    IN_EN <= 0;
                    if (delay_cnt == Ncycles) begin
                        delay_cnt <= 0;
                        FSM_state <= ST_SCAN_OUT;
                    end
                end
                
                ST_SCAN_OUT: begin
                    if(submodule_scan_done) begin
                        out_buf <= scanned_bits;
                        DFF_RST <= 0;
                        FSM_state <= ST_DONE;
                    end
                end
                
                ST_DONE: begin
                    DONE <= 1; 
                    IN_EN <= 0;
                    CLK_A_load <= 0; 
                    BANK_SEL <= 0;
                    BANK_EN <= 4'b0000; 
                    DFF_RST <= 0;
                    delay_cnt <= 0;
                end
                
                default: FSM_state <= ST_IDLE;
            endcase
        end
    end
endmodule
