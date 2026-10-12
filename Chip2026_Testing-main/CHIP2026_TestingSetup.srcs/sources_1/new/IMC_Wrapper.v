`timescale 1ns / 1ps

module IMC_Wrapper (
    input  wire CLK,
    input  wire EN,
    input wire cyc_one,
    input  wire TOPS_en,
    output reg COMPUTE_EN,
    output reg MUX_SEL,
    output reg CLK_CAPTURE,

    output reg IMC_DONE
);

    reg [3:0] FSM_state;
    localparam IDLE              = 4'd0;
    localparam COMPUTE_EN_ON     = 4'd1;
    localparam MUX_SEL_LOW       = 4'd2;
    localparam MUX_SEL_HI        = 4'd3;
    localparam COMPUTE_EN_OFF    = 4'd4;
    localparam CLK_CAPTURE_LOW   = 4'd5;
    localparam CLK_CAPTURE_HI    = 4'd6;
    localparam DONE              = 4'd7;

    always @(posedge CLK) begin
        if (!EN) begin
            if (cyc_one) begin
                FSM_state   <= IDLE;
                MUX_SEL      <= 0;
                COMPUTE_EN     <= 0;
                CLK_CAPTURE   <= 0;
                IMC_DONE  <= 0;
            end
            else
                FSM_state   <= MUX_SEL_HI;
            
        end
        else begin  
            case (FSM_state)
                IDLE: begin
                    FSM_state <= COMPUTE_EN_ON;
                    COMPUTE_EN <= 1;
                end

                COMPUTE_EN_ON: begin
                    CLK_CAPTURE   <= 1;
                    FSM_state <= CLK_CAPTURE_HI;
                end

                CLK_CAPTURE_HI: begin
                    CLK_CAPTURE   <= 0;
                    FSM_state <= CLK_CAPTURE_LOW;
                    IMC_DONE <= 1;
                    COMPUTE_EN <= 0;
                end

                CLK_CAPTURE_LOW: begin
                    if (!MUX_SEL) begin
                        MUX_SEL <= 1;
                        FSM_state <= MUX_SEL_HI;
                    end
                    else begin
                        FSM_STATE <= COMPUTE_EN_OFF;
                        MUX_SEL <= 0;
                    end
                end

                MUX_SEL_HI: begin
                    COMPUTE_EN   <= 1;
                    FSM_state <= COMPUTE_EN_ON;
                end

                COMPUTE_EN_OFF: begin
                    COMPUTE_EN <= 0;
                end

                VTC_TDC_ON: begin
                    VTC_EN    <= 1;
                    TDC_EN    <= 1;
                    case(delay_cnt)
                        2'b01: begin
                            FSM_state <= TDC_EN_OFF;
                            delay_cnt <= 0;
                        end
                        default: begin
                            // Do nothing
                        end
                    endcase
                    
                    
                end

                TDC_EN_OFF: begin
                    TDC_EN    <= 0;
                    FSM_state <= TDC_COMPUTE_ON;
                    delay_cnt <= 0;
                end

                TDC_COMPUTE_ON: begin
                    VTC_EN      <= 0;
                    TDC_COMPUTE <= 1;
                    FSM_state   <= COMPUTE_VDAC_OFF;
                    delay_cnt <= 0;
                end

                COMPUTE_VDAC_OFF: begin
                    TDC_COMPUTE <= 0;
                    VDAC_CTRL   <= 0;
                    FSM_state   <= CHARGE_OFF;
                    delay_cnt <= 0;
                end

                CHARGE_OFF: begin
                    CHG_EN    <= 0;
                    FSM_state <= CAP_RESET_OFF;
                    delay_cnt <= 0;
                end

                CAP_RESET_OFF: begin
                    if(TOPS_en) begin // in TOPS_en mode, keep running IMC in a loop
                        RST_CAP <= 0;
                        FSM_state <= IDLE;
                        delay_cnt <= 0;
                    end
                    else begin
                        RST_CAP   <= 0;
                        FSM_state <= DONE;
                        delay_cnt <= 0;
                    end
                    
                end

                DONE: begin
                    IMC_DONE <= 1;
                    delay_cnt <= 0;
                end

                default: begin
                    FSM_state <= IDLE;
                    CHG_EN <= 0; RST_CAP <= 0; VDAC_CTRL <= 0;
                    TDC_EN <= 0; TDC_COMPUTE <= 0; TDC_RST <= 0;
                    VTC_EN <= 0; IMC_DONE <= 0;
                    delay_cnt <= 0;
                end
            endcase
        end
    end

endmodule