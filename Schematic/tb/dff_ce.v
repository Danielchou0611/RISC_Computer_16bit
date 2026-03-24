// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/D_FF_16bit.sch - Sat Oct  4 20:08:51 2025

`timescale 1ns / 1ps

module D_FF_16bit_D_FF_16bit_sch_tb();

// Inputs
   reg [15:0] D;
   reg CE;
   reg C;
   reg CLR;

// Output
   wire [15:0] Q;

// Bidirs

// Instantiate the UUT
   D_FF_16bit UUT (
		.D(D), 
		.Q(Q), 
		.CE(CE), 
		.C(C), 
		.CLR(CLR)
   );
// Initialize Inputs
   initial begin
	  C = 0;
	  forever #5 C = ~C; // 每 10ns 一個週期
	end
	initial begin
	  // 非同步清除
	  CLR = 1; CE = 0; D = 16'h0000;
	  #10 CLR = 0; CE = 1;

	  // 輸入資料並觀察 Q
	  D = 16'hAAAA; @(posedge C); #1; $display("Q=%h (期望AAAA)", Q);
	  D = 16'h5555; @(posedge C); #1; $display("Q=%h (期望5555)", Q);
	  D = 16'hF0F0; @(posedge C); #1; $display("Q=%h (期望F0F0)", Q);
	  D = 16'h0F0F; @(posedge C); #1; $display("Q=%h (期望0F0F)", Q);

	  $finish;
	end
endmodule

