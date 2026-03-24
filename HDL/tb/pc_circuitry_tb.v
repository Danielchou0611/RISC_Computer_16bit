`timescale 1ns / 1ps
module PC_Circuitry_tb;
    reg clk;
    reg reset;
    reg pc_load;
    reg pc_j;
    reg pc_branch;
    reg [15:0] pc_next;
    reg [15:0] offset;
    wire [15:0] pc;

    PC_Circuitry uut (
        .clk(clk), 
        .reset(reset),
        .pc_load(pc_load),		
        .pc_j(pc_j), 
        .pc_branch(pc_branch), 
        .pc_next(pc_next), 
        .offset(offset), 
        .pc(pc)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        pc_load = 0;
        pc_j = 0;
        pc_branch = 0;
        pc_next = 0;
        offset = 0;

        #100;
      reset=0;
        pc_load = 1;
        @(posedge clk); #5; 
      $display("[TIME %0t] PC = 0x%h", $time, pc);

      @(posedge clk); #5;
      $display("[TIME %0t] PC = 0x%h", $time, pc);

        offset = 16'd10;
      pc_branch = 1;
      @(posedge clk); #5;
      pc_branch = 0;
      $display("[TIME %0t] PC = 0x%h", $time, pc);

      @(posedge clk); #5;
      $display("[TIME %0t] PC = 0x%h", $time, pc);

        pc_next = 16'h1234;
      pc_j = 1;
      @(posedge clk); #5;
      pc_j = 0;
      $display("[TIME %0t] PC = 0x%h", $time, pc);

        @(posedge clk); #5;
      $display("[TIME %0t] PC = 0x%h", $time, pc);
        #5;
      $finish;

    end

endmodule


