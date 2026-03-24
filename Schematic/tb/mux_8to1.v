// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/multiplexer_8_to_1.sch - Sun Sep 28 22:09:18 2025

`timescale 1ns / 1ps

module multiplexer_8_to_1_multiplexer_8_to_1_sch_tb();

// Inputs
   reg s0;
   reg s1;
   reg s2;
   reg d0;
   reg d1;
   reg d2;
   reg d3;
   reg d4;
   reg d6;
   reg d7;
   reg d5;

// Output
   wire y;

// Bidirs

// Instantiate the UUT
   multiplexer_8_to_1 UUT (
		.s0(s0), 
		.s1(s1), 
		.s2(s2), 
		.d0(d0), 
		.d1(d1), 
		.d2(d2), 
		.d3(d3), 
		.d4(d4), 
		.d6(d6), 
		.d7(d7), 
		.d5(d5), 
		.y(y)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		s0 = 0;
		s1 = 0;
		s2 = 0;
		d0 = 0;
		d1 = 0;
		d2 = 0;
		d3 = 0;
		d4 = 0;
		d6 = 0;
		d7 = 0;
		d5 = 0;
   `endif
	initial begin
		d0=0;d1=1;d2=0;d3=1;d4=0;d5=1;d6=0;d7=1;
		{s0,s1,s2} = 3'b000; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b001; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b010; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b011; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b100; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b101; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b110; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		{s0,s1,s2} = 3'b111; #10;
		$display("S0S1S2 | Y = %d%d%d%d", s0, s1, s2, y);
		
		$finish;
	end
endmodule

