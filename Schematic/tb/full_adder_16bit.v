// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/adder_16bit.sch - Mon Sep 29 15:29:27 2025

`timescale 1ns / 1ps

module adder_16bit_adder_16bit_sch_tb();

// Inputs
   reg [15:0] A;
   reg [15:0] B;

// Output
   wire [15:0] S;
   wire Cout;

// Bidirs

// Instantiate the UUT
   adder_16bit UUT (
		.A(A), 
		.B(B), 
		.S(S), 
		.Cout(Cout)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		A = 0;
		B = 0;
   `endif
	initial begin
		A = 16'h0001; B = 16'h0001; #10;   // 1 + 1 = 2
		$display("A+B:%b+%b | S=%b, Cout=%b",A, B, S, Cout);
		A = 16'h00FF; B = 16'h0001; #10;  // 255 + 1 = 256
		$display("A+B:%b+%b | S=%b, Cout=%b",A, B, S, Cout);
		A = 16'h0F0F; B = 16'h0101; #10;  // 3855 + 257 = 4112
		$display("A+B:%b+%b | S=%b, Cout=%b",A, B, S, Cout);
		A = 16'hFFFF; B = 16'h0001; #10;	
		$display("A+B:%b+%b | S=%b, Cout=%b",A, B, S, Cout);
		$finish;
	end
endmodule

