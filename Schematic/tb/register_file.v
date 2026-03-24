// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/register_file.sch - Sat Oct  4 20:40:11 2025

`timescale 1ns / 1ps

module register_file_register_file_sch_tb();

// Inputs
   reg [15:0] D;
   reg [2:0] A;
   reg [2:0] AddrB;
   reg [2:0] AddrA;
   reg C;
   reg CLR;

// Output
   wire [15:0] S1;
   wire [15:0] S2;

// Bidirs

// Instantiate the UUT
   register_file UUT (
		.D(D), 
		.A(A), 
		.AddrB(AddrB), 
		.AddrA(AddrA), 
		.S1(S1), 
		.S2(S2), 
		.C(C), 
		.CLR(CLR)
   );
// Initialize Inputs
   initial begin
	    C = 0; CLR = 1;
        D = 0; A = 0; AddrA = 0; AddrB = 0;
        #5 CLR = 0;  // 釋放reset

        // 寫入幾筆資料（每拍上升緣寫入）
        A = 3'd1; D = 16'h1111; #5 C = 1; #5 C = 0;
        A = 3'd2; D = 16'h2222; #5 C = 1; #5 C = 0;
        A = 3'd3; D = 16'h3333; #5 C = 1; #5 C = 0;

        // 讀取不同暫存器
        AddrA = 3'd1; AddrB = 3'd2; #5;
        $display("S1=%h (R1=1111), S2=%h (R2=2222)", S1, S2);

        AddrA = 3'd3; AddrB = 3'd0; #5;
        $display("S1=%h (R3=3333), S2=%h (R0=0000)", S1, S2);
        $finish;
	end
endmodule

