`timescale 1ns / 1ps
module Timing_Generator_tb;
    reg clk;
    reg reset_n;
    wire T0;
    wire T1;
    wire T2;

    Timing_Generator uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .T0(T0), 
        .T1(T1), 
        .T2(T2)
    );
    always #5 clk=~clk;
    initial begin
        clk = 0;
        reset_n = 0;
        #100;

        reset_n=1;
        repeat (15) begin
          @(posedge clk);
          #5; // small delay so signals are stable before printing
          $display("Time=%t | state: T0=%b T1=%b T2=%b", $time, T0, T1, T2);
      end
        #5;
        $finish;
    end

endmodule

