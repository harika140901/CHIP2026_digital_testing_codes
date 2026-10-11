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
    output reg [2:0]        SCAN_SEL,    // 3-bit selection per protocol
    output reg              DONE,
    output wire [6159:0]    OUT          // 4 banks x 1536 bits + 16-bit pad
    );

    ////////////// CONSTANTS //////////////
    localparam Ncycles = 1;

    // Scan chain lengths from the 2026 test protocol:
    // 1 = input scan chain 2 = 1152
    // 2 = input scan chain 1 = 1152
    // 3 = output scan chain  = 475
    // 4 = WL scan chain      = 1536
    // 5 = read               = 200
    // 6 = write              = 200
    function automatic [10:0] scan_len_for_sel;
        input [2:0] sel;
        begin
            case (sel)
                3'd1: scan_len_for_sel = 11'd1152;  // input scan chain 2
                3'd2: scan_len_for_sel = 11'd1152;  // input scan chain 1
                3'd3: scan_len_for_sel = 11'd475;   // output scan chain
                3'd4: scan_len_for_sel = 11'd1536;  // WL scan chain
                3'd5: scan_len_for_sel = 11'd200;   // read
                3'd6: scan_len_for_sel = 11'd200;   // write
                default: scan_len_for_sel = 11'd0;
            endcase
        end
    endfunction

    reg [3:0] FSM_state;
    reg [1535:0] out_buf[3:0];
    reg [2:0] scan_sel_reg;              // Current scan selection (1-6)
    reg [10:0] active_scan_len;          // Length based on scan_sel_reg
    reg [7:0] delay_cnt;
    reg scan_id_cnt;                     // Legacy: bank id counter (0 or 1)
    reg [3:0] scan_idx;
    reg bank_cnt;                        // Bank counter (0 or 1)

    assign OUT = {16'b0, out_buf[3], out_buf[2], out_buf[1], out_buf[0]};

    ////////////// State Encodings //////////////
    localparam ST_IDLE          = 4'd0;
    localparam ST_SET_SCNID     = 4'd1;
    localparam ST_SET_BANK      = 4'd2;
    localparam ST_BANK_EN       = 4'd3;
    localparam ST_IMC_START     = 4'd4;
    localparam ST_IMC_WAIT      = 4'd5;
    localparam ST_IN_EN_ON      = 4'd6;
    localparam ST_CLK_A_HI      = 4'd7;
    localparam ST_CLK_A_LO      = 4'd8;
    localparam ST_IN_EN_OFF     = 4'd9;
    localparam ST_SCAN_OUT      = 4'd10;
    localparam ST_NEXT          = 4'd11;
    localparam ST_DONE          = 4'd12;

    ////////////// External IMC Module //////////////
    wire Ext_IMC_DONE, Ext_IMC_EN;
    assign Ext_IMC_EN = IMC_MODE &&
                        ((FSM_state == ST_IMC_START) ||
                         (FSM_state == ST_IMC_WAIT));

    IMC_Wrapper external_imc_controller (
        .EN(Ext_IMC_EN),
        .TOPS_en(1'b0),
        .CLK(CLK),
        .CHG_EN(CHG_EN),
        .RST_CAP(RST_CAP),
        .VDAC_CTRL(VDAC_CTRL),
        .TDC_EN(TDC_EN),
        .TDC_RST(TDC_RST),
        .TDC_COMPUTE(TDC_COMPUTE),
        .VTC_EN(VTC_EN),
        .IMC_DONE(Ext_IMC_DONE)
    );

    wire IMC_DONE_SEL;
    assign IMC_DONE_SEL = (IMC_MODE) ? Ext_IMC_DONE : IMC_DONE;

    ////////////// SCAN_OUT_MODULE //////////////
    wire submodule_scan_done, CLK_A_scnout;
    wire [32*48-1:0] scanned_bits;

    scan_out_verilog u_imc_scanout (
        .EN(FSM_state == ST_SCAN_OUT),
        .CLK(CLK),
        .N_CYCLES(Ncycles),
        .SCAN_OUT(SCAN_OUT),
        .scan_len_bits(active_scan_len),
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
            BANK_SEL <= 0;
            BANK_EN <= 4'b0000;
            DFF_RST <= 0;
            DONE <= 0;

            delay_cnt <= 0;
            bank_cnt <= 0;
            scan_id_cnt <= 0;
            scan_idx <= 0;
            scan_sel_reg <= 3'd1;           // Start with mode 1 (input scan chain 2)
            active_scan_len <= 11'd1152;    // Default length for mode 1
            SCAN_IN <= 0;
        end else begin
            delay_cnt <= delay_cnt + 1;
            case (FSM_state)
                ST_IDLE: begin
                    FSM_state <= ST_SET_SCNID;
                end

                ST_SET_SCNID: begin
                    // Load the scan length based on current scan_sel_reg
                    active_scan_len <= scan_len_for_sel(scan_sel_reg);
                    FSM_state <= ST_SET_BANK;
                end

                ST_SET_BANK: begin
                    BANK_SEL <= bank_cnt;
                    delay_cnt <= 0;
                    FSM_state <= ST_BANK_EN;
                end

                ST_BANK_EN: begin
                    case ({scan_id_cnt, bank_cnt})
                        2'b00: BANK_EN <= 4'b0001;
                        2'b01: BANK_EN <= 4'b0010;
                        2'b10: BANK_EN <= 4'b0100;
                        2'b11: BANK_EN <= 4'b1000;
                        default: BANK_EN <= 4'b0000;
                    endcase

                    if (delay_cnt == Ncycles) begin
                        FSM_state <= ST_IMC_START;
                        delay_cnt <= 0;
                    end
                end

                ST_IMC_START: begin
                    if (!IMC_MODE) begin
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
                    IN_EN <= 1;
                    SCAN_IN <= 0;
                    if (delay_cnt == Ncycles) begin
                        delay_cnt <= 0;
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
                    if (submodule_scan_done) begin
                        out_buf[scan_idx] <= scanned_bits;
                        scan_idx <= scan_idx + 1;
                        FSM_state <= ST_NEXT;
                    end
                end

                ST_NEXT: begin
                    DFF_RST <= 0;
                    if (bank_cnt == 0) begin
                        bank_cnt <= bank_cnt + 1;
                        FSM_state <= ST_SET_BANK;
                    end else begin
                        bank_cnt <= 0;
                        if (scan_id_cnt == 0) begin
                            scan_id_cnt <= 1;
                            FSM_state <= ST_SET_SCNID;
                        end else begin
                            // Finished scanning both banks; move to done
                            // Reset for next run
                            scan_sel_reg <= 3'd1;   // Reset to mode 1
                            scan_id_cnt <= 0;
                            scan_idx <= 0;
                            FSM_state <= ST_DONE;
                        end
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
