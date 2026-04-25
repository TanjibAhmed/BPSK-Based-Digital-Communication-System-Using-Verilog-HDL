// MAIN BODY //
module bpsk_system #(
    parameter NOISE_ENABLE = 1
)(
    input clk,
    input rst,
    output tx_bit,
    output rx_bit,
    output [31:0] total_bits,
    output [31:0] error_bits
);

wire bit_data;
wire signed [7:0] mod_sig;
wire noise;
wire signed [7:0] noisy_sig;

// TX side
bit_generator bg (
    .clk(clk),
    .rst(rst),
    .bit_out(bit_data)
);

bpsk_modulator mod (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_data),
    .mod_out(mod_sig)
);

// Noise
lfsr_noise noise_gen (
    .clk(clk),
    .rst(rst),
    .noise_bit(noise)
);

// Channel
channel #(
    .NOISE_ENABLE(NOISE_ENABLE)
) ch (
    .clk(clk),
    .rst(rst),
    .signal_in(mod_sig),
    .noise_bit(noise),
    .signal_out(noisy_sig)
);

// Demodulator
bpsk_demodulator demod (
    .clk(clk),
    .rst(rst),
    .rx_signal(noisy_sig),
    .bit_out(rx_bit)
);

//RX Alignment
reg rx_bit_d;

always @(posedge clk)
    rx_bit_d <= rx_bit;

// BER Counter
ber_counter ber (
    .clk(clk),
    .rst(rst),
    .tx_bit(bit_data),
    .rx_bit(rx_bit_d),
    .total_bits(total_bits),
    .error_bits(error_bits)
);

assign tx_bit = bit_data;

endmodule