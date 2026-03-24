// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/PC_Circuitry.sch - Thu Oct  9 15:37:51 2025

`timescale 1ns / 1ps

module PC_Circuitry_PC_Circuitry_sch_tb();

// Inputs
   reg [15:0] disp_se;
   reg [15:0] pc_jump;
   reg [15:0] jr_in;
   reg pc_ld;
   reg CLK;
   reg [1:0] s;
   reg CLR;

// Output
   wire [15:0] pc;

// Bidirs

// Instantiate the UUT
   PC_Circuitry UUT (
		.pc(pc), 
		.disp_se(disp_se), 
		.pc_jump(pc_jump), 
		.jr_in(jr_in), 
		.pc_ld(pc_ld), 
		.CLK(CLK), 
		.s(s), 
		.CLR(CLR)
   );
// Initialize Inputs
   initial begin
		CLK = 0;
	  CLR = 1;
	  pc_ld = 0;
	  s = 2'b00; // 預設不跳躍
	  disp_se = 16'h0000;
	  pc_jump = 16'h0000;
	  jr_in = 16'h0000;
	  #10 CLR = 0;
     s = 2'b00; #10 $display("Reset → PC = %h", pc);
	 end
	endmodule

