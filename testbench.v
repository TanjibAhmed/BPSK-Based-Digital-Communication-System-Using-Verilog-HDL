`timescale 1ns/1ps // time unit/ time precision (smallest time step it can represent)

module tb_bpsk_system;

reg clk;
reg rst;

wire tx_bit;
wire rx_bit;
wire [31:0] total_bits;
wire [31:0] error_bits;

bpsk_system #(
    .NOISE_ENABLE(1)
) uut (
    .clk(clk),
    .rst(rst),
    .tx_bit(tx_bit),
    .rx_bit(rx_bit),
    .total_bits(total_bits),
    .error_bits(error_bits)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");        // creates waveform file
    $dumpvars(0, tb_bpsk_system);  // dump everything inside testbench
end

initial begin
    clk = 0;
    rst = 1;

    #20 rst = 0;

    #1000000;  // run simulation

    $display("---------------------------");
    $display("Total Bits = %d", total_bits);
    $display("Error Bits = %d", error_bits);
    $display("BER = %f", error_bits * 1.0 / total_bits);
    $display("---------------------------");

    $finish;
end

endmodule