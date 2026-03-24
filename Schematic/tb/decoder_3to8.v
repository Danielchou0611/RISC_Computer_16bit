// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/decoder_3_to_8.sch - Sat Sep 27 12:02:33 2025

`timescale 1ns / 1ps

module decoder_3_to_8_decoder_3_to_8_sch_tb();

// Inputs
   reg A2;
   reg A1;
   reg A0;

// Output
   wire D0;
   wire D1;
   wire D2;
   wire D3;
   wire D4;
   wire D5;
   wire D6;
   wire D7;

// Bidirs

// Instantiate the UUT
   decoder_3_to_8 UUT (
        .A2(A2), 
        .A1(A1), 
        .A0(A0), 
        .D0(D0), 
        .D1(D1), 
        .D2(D2), 
        .D3(D3), 
        .D4(D4), 
        .D5(D5), 
        .D6(D6), 
        .D7(D7)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
        A2 = 0;
        A1 = 0;
        A0 = 0;
   `endif
    initial begin
    A2=0; A1=0; A0=0;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=0; A1=0; A0=1;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=0; A1=1; A0=0;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=0; A1=1; A0=1;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=1; A1=0; A0=0;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=1; A1=0; A0=1;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=1; A1=1; A0=0;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    A2=1; A1=1; A0=1;#10;
    $display("A2A1A0= %d%d%d,  out=%d%d%d%d%d%d%d%d", A2, A1, A0, D0, D1, D2, D3, D4, D5, D6, D7);

    $finish;
    end
endmodule

