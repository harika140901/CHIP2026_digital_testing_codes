`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 16:56:00
// Design Name: 
// Module Name: IMC_ScanOut_ext
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

module IMC_ScanOut_ext(
    input  wire             CLK,
    input  wire             EN,          // enable/start
    input  wire             SCAN_OUT,    // input from chip

    // for external mode, the IMC_DONE comes from the external IMC_Wrapper
    output reg              SCAN_IN,
    output reg              IN_EN,
    output wire             CLK_A,
    output wire             CLK_B,

    // compute control signals
    output wire CHG_EN,

    output reg [2:0]        SCAN_SEL,    // mode selection: 1..6
    output reg              ALL_DONE,
    output wire [479:0]    OUT     //padded with 5 more bits
    );

    // Scan chain lengths from the 2026 test protocol:
    // 1 = input scan chain 1 = 1152
    // 2 = input scan chain 2 = 1152
    // 3 = output scan chain  = 475
    // 4 = WL scan chain      = 1536
    // 5 = read               = 200
    // 6 = write              = 200
    localparam N_bits    = 475; 

    reg [3:0] FSM_state;
    reg [474:0] out_buf;
    reg compute_cyc_one;
    assign OUT = {5'b0, out_buf};

    // state encoding
    localparam ST_IDLE                   = 4'd0;
    localparam ST_IMC_START_AND_WAIT     = 4'd1; 
    localparam ST_IN_EN_ON               = 4'd3;
    localparam ST_CLK_A_HI               = 4'd4;
    localparam ST_CLK_A_LO               = 4'd5;
    localparam ST_IN_EN_OFF              = 4'd6;
    localparam ST_SCAN_OUT               = 4'd7;
    localparam ST_NEXT                   = 4'd8;
    localparam ST_DONE                   = 4'd9;

    // external IMC module
    wire IMC_DONE, MUX_SEL, DONE;

    IMC_Wrapper external_imc_controller (
        .EN(FSM_state == ST_IMC_START_AND_WAIT),
        .CLK(CLK),
        .cyc_one(compute_cyc_one),
        .IMC_DONE(IMC_DONE),
        .DONE(DONE),
        .MUX_SEL(MUX_SEL),

    );

    // scan capture submodule
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

    always @(posedge CLK) begin
        if (!EN) begin
            FSM_state <= ST_IDLE;
            IN_EN <= 0;
            CLK_A_load <= 0;
            ALL_DONE <= 0;
            SCAN_SEL <= 3'd3;          
            SCAN_IN <= 0;
            compute_cyc_one <= 1;
        end
        else begin

            case (FSM_state)
                ST_IDLE: begin
                    FSM_state <= ST_IMC_START_AND_WAIT;
                end

                ST_IMC_START_AND_WAIT: begin
                    if (IMC_DONE) begin
                        FSM_state <= ST_IN_EN_ON;
                    end
                end

                ST_IN_EN_ON: begin
                    IN_EN <= 1;
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

                ST_SCAN_OUT: begin
                    if (submodule_scan_done) begin
                        out_buf <= scanned_bits[N_bits - 1 :0];
                        FSM_state <= ST_NEXT;
                        compute_cyc_one <= 0;
                    end
                end

                ST_NEXT: begin
                    if (!MUX_SEL and !DONE) 
                        FSM_state <= ST_IMC_START_AND_WAIT;
                    else
                        FSM_state <= ST_DONE;
                    end

                ST_DONE: begin
                    ALL_DONE <= 1;
                    IN_EN <= 0;
                    CLK_A_load <= 0;
                end

                default: FSM_state <= ST_IDLE;
            endcase
        end
    end
endmodule
