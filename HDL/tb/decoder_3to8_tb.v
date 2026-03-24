`timescale 1ns / 1ps
module Decoder_3_to_8_tb;
    reg [2:0] in;
    reg enable;
    wire [7:0] out;
    Decoder_3_to_8 uut (
        .in(in), 
        .enable(enable), 
        .out(out)
    );
    initial begin
        in = 0;
        enable = 0;
        #10;
        repeat (8) begin
          #10; $display("%b\t%b", in, out);
        in = in + 1;  
        end
        enable = 1;in=0;
      repeat (8) begin
        #10; $display("%b\t%b", in, out);
        in = in + 1;
      end
        $finish;
    end 
endmodule
