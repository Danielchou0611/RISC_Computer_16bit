// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/multiplexer_8_to_1_16bits.sch - Sat Oct  4 18:04:23 2025

`timescale 1ns / 1ps

module multiplexer_8_to_1_16bits_multiplexer_8_to_1_16bits_sch_tb();

// Inputs
   reg s2;
   reg s1;
   reg s0;
   reg [15:0] d3;
   reg [15:0] d0;
   reg [15:0] d1;
   reg [15:0] d2;
   reg [15:0] d4;
   reg [15:0] d6;
   reg [15:0] d5;
   reg [15:0] d7;

// Output
   wire [15:0] S;

// Bidirs

// Instantiate the UUT
   multiplexer_8_to_1_16bits UUT (
		.s2(s2), 
		.s1(s1), 
		.s0(s0), 
		.d3(d3), 
		.d0(d0), 
		.d1(d1), 
		.d2(d2), 
		.d4(d4), 
		.d6(d6), 
		.d5(d5), 
		.d7(d7), 
		.S(S)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		s2 = 0;
		s1 = 0;
		s0 = 0;
		d3 = 0;
		d0 = 0;
		d1 = 0;
		d2 = 0;
		d4 = 0;
		d6 = 0;
		d5 = 0;
		d7 = 0;
   `endif
	 integer i;
	initial begin
    // 16-bit 可辨識圖樣
    d0 = 16'b0000000000000001;  // 0001h
    d1 = 16'b0000000000000111;  // 0003h
    d2 = 16'b0000000000011111;  // 0007h
    d3 = 16'b0000000001111111;  // 000Fh
    d4 = 16'b0000000111111111;  // 001Fh
    d5 = 16'b0000011111111111;  // 003Fh
    d6 = 16'b0001111111111111;  // 007Fh
    d7 = 16'b1111111111111111;  // FFFFh
	 s2=0;s1=0;s0=0;
    for (i=0; i<8; i=i+1) begin
      #10;
      $display("%b  %b  %b | %b ",s2, s1, s0,  S, );
      {s2,s1,s0}={s2,s1,s0}+1;
    end

    $stop;
  end
endmodule

