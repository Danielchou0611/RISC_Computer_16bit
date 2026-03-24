`timescale 1ns / 1ps
module full_adder(
        input A, B, Cin, 
        output reg S, Cout
    );
     always @(*)begin
        {Cout, S}= A + B + Cin;
     end
endmodule
