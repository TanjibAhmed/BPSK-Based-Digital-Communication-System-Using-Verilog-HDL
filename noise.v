// LFSR Noise Generator
module lfsr_noise (
    input clk,
    input rst,
    output reg noise_bit
);

reg [7:0] lfsr;

always @(posedge clk) begin
    if (rst)
        lfsr <= 8'b10101100;
    else
        lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]};
end

always @(posedge clk) begin
    noise_bit <= lfsr[7] & lfsr[3];
end

endmodule