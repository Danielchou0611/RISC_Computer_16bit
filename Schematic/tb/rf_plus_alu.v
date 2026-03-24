`timescale 1ns / 1ps
module RF_plus_ALU_16bit_RF_plus_ALU_16bit_sch_tb();
// Inputs
   reg CLK; reg CLR; reg m;
   reg [15:0] D; reg [2:0] write;
   reg [2:0] readaddrA; reg [2:0] readaddrB;
// Output
   wire [15:0] S;
   wire C; wire N; wire Z; wire V;

// Instantiate the UUT
   RF_plus_ALU_16bit UUT (
   .S(S), .C(C), .N(N), .Z(Z), .V(V), 
   .CLK(CLK), .CLR(CLR), .m(m)
   .D(D), .write(write), 
   .readaddrA(readaddrA), .readaddrB(readaddrB), 
   );
// Initialize Inputs
 always #5 CLK = ~CLK;
 initial begin
   CLK = 0; CLR = 1;
   D = 0; write = 0; readaddrA = 0; readaddrB = 0; m = 0;
   #10 CLR = 0;
   write = 3'd1; D = 16'h0003; #10;   // R1 = 3
   write = 3'd2; D = 16'h00f5; #10;   // R2 = 4
   readaddrA = 3'd1; readaddrB = 3'd2; m = 0; #10;
   $display("ADD: R1+R2=%h , C=%b Z=%b N=%b V=%b", S, C, Z, N, V);
   readaddrA = 3'd2; readaddrB = 3'd1; m = 1; #10;
   $display("SUB: R1-R2=%h , C=%b Z=%b N=%b V=%b", S, C, Z, N, V);
   write = 3'd3; D = 16'h7FFF; #10;   // R3 = 7FFF
   write = 3'd4; D = 16'h0001; #10;   // R4 = 0001
   readaddrA = 3'd3; readaddrB = 3'd4; m = 0; #10;
   $display("Overflow Test: 7FFF + 0001 = %h , V=%b", S, V);
   $finish;
 end
endmodule
