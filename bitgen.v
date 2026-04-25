// Bit Generator
module bit_generator (
    input clk,
    input rst,
    output reg bit_out
);

always @(posedge clk) begin
    if (rst)
        bit_out <= 0;
    else
        bit_out <= ~bit_out;  // generates 010101..
end

endmodule
