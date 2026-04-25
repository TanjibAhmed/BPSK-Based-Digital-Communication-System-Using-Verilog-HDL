// BER Counter
module ber_counter (
    input clk,
    input rst,
    input tx_bit,
    input rx_bit,
    output reg [31:0] total_bits,
    output reg [31:0] error_bits
);

always @(posedge clk) begin
    if (rst) begin
        total_bits <= 0;
        error_bits <= 0;
    end else begin
        total_bits <= total_bits + 1;
        if (tx_bit != rx_bit)
            error_bits <= error_bits + 1;
    end
end

endmodule