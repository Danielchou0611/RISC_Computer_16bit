`timescale 1ns / 1ps
module multiplexer_16bits_8_to_1_tb;
    reg [15:0] d0;
    reg [15:0] d1;
    reg [15:0] d2;
    reg [15:0] d3;
    reg [15:0] d4;
    reg [15:0] d5;
    reg [15:0] d6;
    reg [15:0] d7;
    reg [2:0] sel;

    wire [15:0] out;
    multiplexer_16bits_8_to_1 uut (
        .d0(d0), 
        .d1(d1), 
        .d2(d2), 
        .d3(d3), 
        .d4(d4), 
        .d5(d5), 
        .d6(d6), 
        .d7(d7), 
        .sel(sel), 
        .out(out)
    );
    integer i;
    initial begin
        // Initialize Inputs
        d0 = 16'b0000000000000001;  // 0001h
      d1 = 16'b0000000000000111;  // 0003h
      d2 = 16'b0000000000011111;  // 0007h
      d3 = 16'b0000000001111111;  // 000Fh
      d4 = 16'b0000000111111111;  // 001Fh
      d5 = 16'b0000011111111111;  // 003Fh
      d6 = 16'b0001111111111111;  // 007Fh
      d7 = 16'b1111111111111111;  // FFFFh
        sel = 0;
        for (i=0; i<8; i=i+1) begin
            #10;
            $display("%b | %b ",sel, out);
            sel=sel+1;
        end
        $finish;

    end

endmodule


