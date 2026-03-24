`timescale 1ns / 1ps
module multiplexer_16bits_8_to_1(
        input[15:0] d0, d1, d2, d3, d4, d5, d6, d7,
        input[2:0] sel,
        output reg[15:0] out
    );
always @(*)begin
    case(sel)
        3'b000: out=d0;
        3'b001: out=d1;
        3'b010: out=d2;
        3'b011: out=d3;
        3'b100: out=d4;
        3'b101: out=d5;
        3'b110: out=d6;
        3'b111: out=d7;
        default: out=16'b0;
    endcase
end
endmodule

