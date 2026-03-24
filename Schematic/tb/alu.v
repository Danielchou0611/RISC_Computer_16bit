// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/ALU_16bit.sch - Tue Oct  7 13:59:37 2025

`timescale 1ns / 1ps

module ALU_16bit_ALU_16bit_sch_tb();

// Inputs
   reg [15:0] A;
   reg [15:0] B;
   reg m;

// Output
   wire [15:0] S;
   wire C;
   wire N;
   wire Z;
   wire V;

// Bidirs

// Instantiate the UUT
   ALU_16bit UUT (
		.A(A), 
		.B(B), 
		.m(m), 
		.S(S), 
		.C(C), 
		.N(N), 
		.Z(Z), 
		.V(V)
   );
// Initialize Inputs
   initial begin

    // 測試 1：加法，無溢位
    A = 16'd100;
    B = 16'd200;
    m = 0;
    #10;
    $display("%0t\t%b\t%h\t%h\t%h\t%b %b %b %b", $time, m, A, B, S, C, N, Z, V);
	 
	 A = 16'h4000;
    B = 16'h4000;
    m = 0;
    #10;
    $display("%0t\t%b\t%h\t%h\t%h\t%b %b %b %b", $time, m, A, B, S, C, N, Z, V);

    // 測試 3：減法，結果為負
    A = 16'd50;
    B = 16'd100;
    m = 1;
    #10;
    $display("%0t\t%b\t%h\t%h\t%h\t%b %b %b %b", $time, m, A, B, S, C, N, Z, V);
	 
	 A = 16'd1234;
    B = 16'd1234;
    m = 1;
    #10;
    $display("%0t\t%b\t%h\t%h\t%h\t%b %b %b %b", $time, m, A, B, S, C, N, Z, V);

    // 測試 5：加法，進位產生
		A = 16'hFFFF; // 65535
		B = 16'h0001; // 1
		m = 0;        // 加法
		#10
    $display("%0t\t%b\t%h\t%h\t%h\t%b %b %b %b", $time, m, A, B, S, C, N, Z, V);
    $finish;
  end
endmodule

