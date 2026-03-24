`timescale 1ns / 1ps
module register_file(
        input clk,
        input[2:0] addr_A,
        input[2:0] addr_B,
        input[2:0] write_reg,
        input enable,
        input[15:0] write_data,
        output[15:0] data_A,
        output[15:0] data_B
    );
    wire[7:0] decoder_out;
    Decoder_3_to_8 decoder(
        .in(write_reg),
        .enable(enable), 
        .out(decoder_out)
    );

    wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
    DFF_16bits_register reg0(.clk(clk), .enable(decoder_out[0]), .D(write_data), .Q(r0));
    DFF_16bits_register reg1(.clk(clk), .enable(decoder_out[1]), .D(write_data), .Q(r1));
    DFF_16bits_register reg2(.clk(clk), .enable(decoder_out[2]), .D(write_data), .Q(r2));
    DFF_16bits_register reg3(.clk(clk), .enable(decoder_out[3]), .D(write_data), .Q(r3));
    DFF_16bits_register reg4(.clk(clk), .enable(decoder_out[4]), .D(write_data), .Q(r4));
    DFF_16bits_register reg5(.clk(clk), .enable(decoder_out[5]), .D(write_data), .Q(r5));
    DFF_16bits_register reg6(.clk(clk), .enable(decoder_out[6]), .D(write_data), .Q(r6));
    DFF_16bits_register reg7(.clk(clk), .enable(decoder_out[7]), .D(write_data), .Q(r7));

    multiplexer_16bits_8_to_1 mul_A(.d0(r0), .d1(r1), .d2(r2), .d3(r3), .d4(r4),
                                    .d5(r5), .d6(r6), .d7(r7), .sel(addr_A), .out(data_A));
    multiplexer_16bits_8_to_1 mul_B(.d0(r0), .d1(r1), .d2(r2), .d3(r3), .d4(r4),
                                    .d5(r5), .d6(r6), .d7(r7), .sel(addr_B), .out(data_B));
endmodule
