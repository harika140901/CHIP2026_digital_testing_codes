//------------------------------------------------------------------------------
// TOPS_BLOCK
//------------------------------------------------------------------------------
// Generates a periodic DFF_RST pulse:
//   - HIGH for N_CYCLES clock cycles
//   - LOW for 1 clock cycle
// Repeats while EN is asserted.
// If stop = 1, DFF_RST is held HIGH.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// TOPS_BLOCK
//------------------------------------------------------------------------------
// Stop logic:
//   - If stop = 1, disable CONTROL_EN and stop computation on the next edge.
//
// Cycle counter:
//   - Counts normal operating clock cycles.
//   - Generates imc_done_scan_out for one clock cycle every 5 cycles.
//   - Counter resets when EN = 0.
//------------------------------------------------------------------------------

module TOPS_BLOCK (
    input  wire CLK,
    input  wire EN,
    input  wire stop,

    output reg  DFF_RST,
    output reg  COMPUTE_EN,
    output reg  CONTROL_EN,
    output reg  imc_done_scan_out
);

    reg stop_pending = 0;
    reg [2:0] cycle_count = 0;

    always @(posedge CLK) begin
        if (!EN) begin
            DFF_RST           <= 0;
            COMPUTE_EN        <= 0;
            CONTROL_EN        <= 1;
            stop_pending      <= 0;
        end
        else if (stop_pending) begin
            // Second clock edge after stop was detected
            COMPUTE_EN        <= 0;
            stop_pending      <= 0;
        end
        else if (stop) begin
            // First clock edge: disable control
            CONTROL_EN        <= 0;
            stop_pending      <= 1;
        end
        else begin
            // Normal operation
            COMPUTE_EN <= 1;
            DFF_RST    <= 1;

        end
    end


    always @(posedge CLK) begin
        if (!EN) begin
            cycle_count       <= 0;
            imc_done_scan_out <= 0;
        end
        else if (cycle_count == 3'd4) begin
                cycle_count       <= 0;
                imc_done_scan_out <= 1;
            end
        else begin
                cycle_count       <= cycle_count + 1'b1;
                imc_done_scan_out <= 0;
            end
    end
endmodule
