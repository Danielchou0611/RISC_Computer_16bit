// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/full_adder.sch - Mon Sep 29 11:03:35 2025

`timescale 1ns / 1ps

module full_adder_full_adder_sch_tb();

// Inputs
   reg Cin;
   reg A;
   reg B;

// Output
   wire S;
   wire Cout;

// Bidirs

// Instantiate the UUT
   full_adder UUT (
		.Cin(Cin), 
		.A(A), 
		.B(B), 
		.S(S), 
		.Cout(Cout)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		Cin = 0;
		A = 0;
		B = 0;
   `endif
	
	initial begin
      // 初始化
      Cin = 0; A = 0; B = 0;

      // 用所有組合測試 (共 8 種)
      {A,B,Cin} = 3'b000;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b001;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b010;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b011;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b100;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b101;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b110;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
      {A,B,Cin} = 3'b111;#10;
		$display("a b Cin=%d%d%d | S Cout=%d%d ", A, B, Cin, S, Cout);
		$finish;
   end
endmodule

