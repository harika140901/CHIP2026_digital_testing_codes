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
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module IMC_ScanOut(
    input  wire             CLK,
    input  wire             EN,          // enable/start
    input  wire             SCAN_OUT,    // input from chip
    input  wire             IMC_DONE,    // IMC_DONE from chip
    input  wire             IMC_MODE,    // 0: Internal Mode; 1: External Mode
    output reg              SCAN_IN,
    output reg              IN_EN,

    // compute control signals
    // Will be triggered with Ext-PL control logic
    output wire COMPUTE_EN,
    output wire MUX_SEL,
    output wire CLK_CAPTURE,

    output wire             CLK_A,
    output wire             CLK_B,
    output reg              DFF_RST,
    output reg [2:0]        SCAN_SEL,    // 3-bit selection per protocol
    output reg              DONE,
    output wire [479:0]     OUT          // 19*25 + 5bits for padding

    );

    ////////////// CONSTANTS //////////////
    localparam N_bits    = 475;
    // Scan chain lengths from the 2026 test protocol:
    // 1 = input scan chain 2 = 1152
    // 2 = input scan chain 1 = 1152
    // 3 = output scan chain  = 475
    // 4 = WL scan chain      = 1536
    // 5 = read               = 200
    // 6 = write              = 200

    reg [3:0] FSM_state;
    reg [474:0] out_buf;
    reg [2:0] scan_sel_reg;              // Current scan selection (1-6)
    reg [10:0] active_scan_len;          // Length based on scan_sel_reg
    reg [7:0] delay_cnt;
    reg [3:0] scan_idx;

    assign OUT = {5'b0, out_buf};

    ////////////// State Encodings //////////////
    localparam ST_IDLE                   = 4'd0;
    localparam ST_IMC_START              = 4'd1;
    localparam ST_IMC_WAIT               = 4'd2;
    localparam ST_IN_EN_ON               = 4'd3;
    localparam ST_CLK_A_HI               = 4'd4;
    localparam ST_CLK_A_LO               = 4'd5;
    localparam ST_IN_EN_OFF              = 4'd6;
    localparam ST_SCAN_OUT               = 4'd7;
    localparam ST_NEXT                   = 4'd7;
    localparam ST_DONE                   = 4'd8;

    ////////////// External IMC Module //////////////
    wire Ext_IMC_DONE, Ext_IMC_DONE_final, Ext_IMC_EN;
    assign Ext_IMC_EN = IMC_MODE &&
                    ((FSM_state == ST_IMC_START) ||
                     (FSM_state == ST_IMC_WAIT));

    IMC_Wrapper external_imc_controller (
        .EN(Ext_IMC_EN),
        .CLK(CLK),
        .cyc_one(1'b1),
        .COMPUTE_EN(COMPUTE_EN),
        .MUX_SEL(MUX_SEL),
        .CLK_CAPTURE(CLK_CAPTURE),
        .DONE(Ext_IMC_DONE_final),
        .IMC_DONE(Ext_IMC_DONE)
    );

    wire IMC_DONE_SEL;
    assign IMC_DONE_SEL = (IMC_MODE) ? Ext_IMC_DONE_final : IMC_DONE;

    ////////////// SCAN_OUT_MODULE //////////////
    wire submodule_scan_done, CLK_A_scnout;
    wire [32*48-1:0] scanned_bits;

    scan_out_verilog u_imc_scanout (
        .EN(FSM_state == ST_SCAN_OUT),
        .CLK(CLK),
        .SCAN_OUT(SCAN_OUT),
        .scan_len_bits(N_bits),
        .CLK_A(CLK_A_scnout),
        .CLK_B(CLK_B),
        .SCAN_DONE(submodule_scan_done),
        .SCAN_OUT_BUFF(scanned_bits)
    );

    reg CLK_A_load;
    assign CLK_A = CLK_A_scnout | CLK_A_load;

    ////////////// SCAN_SELECT OUTPUT //////////////
    // Direct mapping: SCAN_SEL[2:0] = scan_sel_reg[2:0]
    // Valid values: 001, 010, 011, 100, 101, 110
    always @(*) begin
        SCAN_SEL = scan_sel_reg;
    end

    ////////////// FSM LOGIC //////////////
    always @(posedge CLK) begin
        if (!EN) begin
            FSM_state <= ST_IDLE;
            IN_EN <= 0;
            CLK_A_load <= 0;
            DFF_RST <= 0;
            DONE <= 0;

            scan_sel_reg <= 3'd3;           // Start with mode 1 (input scan chain 1)           
            SCAN_IN <= 0;
        end else begin
            case (FSM_state)
                ST_IDLE: begin
                    FSM_state <= ST_IMC_START;
                end

                ST_IMC_START: begin
                    if (!IMC_MODE) begin    //internal mode
                        DFF_RST <= 1;
                    end
                    FSM_state <= ST_IMC_WAIT;
                end

                ST_IMC_WAIT: begin
                    if (IMC_DONE_SEL) begin
                        FSM_state <= ST_IN_EN_ON;
                    end
                end

                ST_IN_EN_ON: begin
                    IN_EN <= 1;       //parallel load
                    SCAN_IN <= 0;
                    FSM_state <= ST_CLK_A_HI;
    
                end

                ST_CLK_A_HI: begin
                    CLK_A_load <= 1;
                    FSM_state <= ST_CLK_A_LO;
                end

                ST_CLK_A_LO: begin
                    CLK_A_load <= 0;
                    FSM_state <= ST_IN_EN_OFF;
                end

                ST_IN_EN_OFF: begin
                    IN_EN <= 0;
                    FSM_state <= ST_SCAN_OUT;
                    end
                end

                ST_SCAN_OUT: begin
                    if (submodule_scan_done) begin
                        out_buf <= scanned_bits;
                        FSM_state <= ST_NEXT;
                    end
                end

                ST_NEXT: begin
                    DFF_RST <= 0;
                    FSM_state <= ST_DONE;
                    end

                ST_DONE: begin
                    DONE <= 1;
                    IN_EN <= 0;
                    CLK_A_load <= 0;
                    DFF_RST <= 0;
                end

                default: FSM_state <= ST_IDLE;
            endcase
        end
    end
endmodule
