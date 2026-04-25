// Channel Module
module channel #(
    parameter NOISE_ENABLE = 1 // noise control; put 0 to have a noize free channel
)(
    input clk,
    input rst,
    input signed [7:0] signal_in,
    input noise_bit,
    output reg signed [7:0] signal_out
);

always @(posedge clk) begin
    if (rst)
        signal_out <= 0;
    else if (NOISE_ENABLE && noise_bit)
        signal_out <= ~signal_in- (signal_in >>> 2);//>>> 2: means right shift by 2. its actually 25 percent of the main signal and it is substracted, thus have 75 percent signal
    else
        signal_out <= signal_in;
end

endmodule