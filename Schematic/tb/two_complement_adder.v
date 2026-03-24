// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/ttt.sch - Sat Oct  4 14:44:46 2025

`timescale 1ns / 1ps

module ttt_ttt_sch_tb();

// Inputs
   reg [15:0] A;
   reg [15:0] B;
   reg m;

// Output
   wire [15:0] S;
   wire C_out;

// Bidirs

// Instantiate the UUT
   ttt UUT (
		.A(A), 
		.B(B), 
		.S(S), 
		.m(m), 
		.C_out(C_out)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		A = 0;
		B = 0;
		m = 0;
   `endif
	initial begin
		m=0; A=16'd1234; B=16'd876; #10;     // 1234 + 876 = 2110
		$display("m=0(ADD), A=%b B=%b -> S=%b , Cout=%b", A, B,  S, C_out);
		m=0; A=16'd32767; B=16'd1; #10;     // 1234 + 876 = 2110
		$display("m=0(ADD),  A=%b B=%b -> S=%b , Cout=%b", A, B,  S, C_out);
		m=1; A=16'd1234; B=16'd876; #10;     // 1234 + 876 = 2110
		$display("m=1(SUB),  A=%b B=%b -> S=%b , Cout=%b", A, B,  S, C_out);
		m=1; A=-16'd20000; B=-16'd12345; #10;     // 1234 + 876 = 2110
		$display("m=1(SUB),  A=%b B=%b -> S=%b , Cout=%b", A, B,  S, C_out);
		$finish;
	end
endmodule

