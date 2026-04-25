// BPSK Demodulator
module bpsk_demodulator (
    input clk,
    input rst,
    input signed [7:0] rx_signal,
    output reg bit_out
);

always @(posedge clk) begin
    if (rst)
        bit_out <= 0;
    else if (rx_signal > 0)
        bit_out <= 1;
    else
        bit_out <= 0;
end

endmodule