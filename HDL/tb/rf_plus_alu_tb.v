`timescale 1ns / 1ps
module RF_plus_ALU_16bits_tb;

    // Inputs
    reg clk;
    reg enable;
    reg [15:0] data;
    reg [2:0] write_addr;
    reg [2:0] read_addr_A;
    reg [2:0] read_addr_B;
    reg m;
    reg [15:0] ALU_A;
    reg [15:0] ALU_B;

    // Outputs
    wire [15:0] S;
    wire N;
    wire Z;
    wire V;
    wire C;
    wire [15:0] RF_A;
    wire [15:0] RF_B;

    // Instantiate the Unit Under Test (UUT)
    RF_plus_ALU_16bits uut (
        .clk(clk), 
        .enable(enable), 
        .data(data), 
        .write_addr(write_addr), 
        .read_addr_A(read_addr_A), 
        .read_addr_B(read_addr_B), 
        .ALU_A(ALU_A),
      .ALU_B(ALU_B),
        .m(m), 
        .S(S), 
        .N(N), 
        .Z(Z), 
        .V(V), 
        .C(C), 
        .RF_A(RF_A), 
        .RF_B(RF_B)
    );
    always #5 clk=~clk;
    initial begin
        clk = 0; enable = 0; data = 0;
      write_addr = 0; read_addr_A = 0; read_addr_B = 0; 
        ALU_A=0; ALU_B=0; m = 0;
      #100;

        @(posedge clk); #5;
      enable = 1;
      write_addr = 3'd1;
      data = 16'h0003;

        @(posedge clk); #5;
      write_addr = 3'd2;
      data = 16'h00F5;	

        @(posedge clk); #5;
      enable = 0;

        read_addr_A = 3'd1;
      read_addr_B = 3'd2;
      m = 0;
        #20; // wait RF outputs stable
      ALU_A = RF_A;
      ALU_B = RF_B;

      #20;
      $display("ADD: R1=%h  R2=%h  S=%h  C=%b Z=%b N=%b V=%b",RF_A, RF_B, S, C, Z, N, V); 

        @(posedge clk); #1;
      read_addr_A = 3'd2;
      read_addr_B = 3'd1;
      m = 1;
        #20;
      ALU_A = RF_A;
      ALU_B = RF_B;

      #20;
      $display("SUB: R2=%h  R1=%h  S=%h  C=%b Z=%b N=%b V=%b",RF_A, RF_B, S, C, Z, N, V);

      @(posedge clk); #5;
      enable = 1;
      write_addr = 3'd3;
      data = 16'h7FFF;

      @(posedge clk); #5;
      enable=1;
      write_addr = 3'd4;
      data = 16'h0001;

      @(posedge clk); #5;
      enable = 0;

      read_addr_A = 3'd3;
      read_addr_B = 3'd4;
      m = 0;
      #20;
      ALU_A = RF_A;
      ALU_B = RF_B;

      #20;
      $display("(Overflow)ADD: R3=%h  R4=%h  S=%h  C=%b Z=%b N=%b V=%b",RF_A, RF_B, S, C, Z, N, V);
      $finish;

    end

endmodule

