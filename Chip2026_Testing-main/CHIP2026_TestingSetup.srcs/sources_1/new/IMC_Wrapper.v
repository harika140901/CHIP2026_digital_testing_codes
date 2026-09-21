`timescale 1ns / 1ps

module IMC_Wrapper (
    input  wire CLK,
    input  wire EN,
    input  wire TOPS_en,
    output reg CHG_EN,
    output reg RST_CAP,
    output reg VDAC_CTRL,
    output reg TDC_EN,
    output reg TDC_COMPUTE,
    output reg TDC_RST,
    output reg VTC_EN,

    output reg IMC_DONE
);

    reg [3:0] FSM_state;
    reg [1:0] delay_cnt;
    localparam IDLE              = 4'd0;
    localparam TDC_RESET_ON      = 4'd1;
    localparam TDC_RESET_OFF     = 4'd2;
    localparam VDAC_ON           = 4'd3;
    localparam CAP_RESET_ON      = 4'd4;
    localparam CHARGE_ON         = 4'd5;
    localparam VTC_TDC_ON        = 4'd6;
    localparam TDC_EN_OFF        = 4'd7;
    localparam TDC_COMPUTE_ON    = 4'd8;
    localparam COMPUTE_VDAC_OFF  = 4'd9;
    localparam CHARGE_OFF        = 4'd10;
    localparam CAP_RESET_OFF     = 4'd11;
    localparam DONE              = 4'd12;

    always @(posedge CLK) begin
        if (!EN) begin
            FSM_state   <= IDLE;
            CHG_EN      <= 0;
            RST_CAP     <= 0;
            VDAC_CTRL   <= 0;
            TDC_EN      <= 0;
            TDC_COMPUTE <= 0;
            TDC_RST     <= 0;
            VTC_EN      <= 0;
            IMC_DONE    <= 0;
            delay_cnt   <= 0;
        end
        else begin
            delay_cnt <= (delay_cnt + 1);   
            case (FSM_state)
                IDLE: begin
                    FSM_state <= TDC_RESET_ON;
                    delay_cnt <= 0;
                    IMC_DONE  <= 0;
                end

                TDC_RESET_ON: begin
                    TDC_RST   <= 1;
                    FSM_state <= TDC_RESET_OFF;
                    delay_cnt <= 0;
                end

                TDC_RESET_OFF: begin
                    TDC_RST   <= 0;
                    FSM_state <= VDAC_ON;
                    delay_cnt <= 0;
                end

                VDAC_ON: begin
                    VDAC_CTRL <= 1;
                    FSM_state <= CAP_RESET_ON;
                    delay_cnt <= 0;
                end

                CAP_RESET_ON: begin
                    RST_CAP   <= 1;
                    FSM_state <= CHARGE_ON;
                    delay_cnt <= 0;
                end

                CHARGE_ON: begin
                    CHG_EN    <= 1;
                    FSM_state <= VTC_TDC_ON;
                    delay_cnt <= 0;
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