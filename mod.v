// BPSK Modulator
module bpsk_modulator (
    input clk,
    input rst,
    input bit_in,
    output reg signed [7:0] mod_out
);

always @(posedge clk) begin
    if (rst)
        mod_out <= 0;
    else if (bit_in)
        mod_out <= 8'sd1; // 8 signed decimenl 1
    else
        mod_out <= -8'sd1;
end

endmodule