`timescale 1ns / 1ps
module DFF_16bits_register_tb;
    reg clk;
    reg enable;
    reg [15:0] D;
    wire [15:0] Q;

    DFF_16bits_register uut (
        .clk(clk), 
        .enable(enable), 
        .D(D), 
        .Q(Q)
    );
    initial clk = 0; always #5 clk = ~clk;
    initial begin
        enable = 1;
        D = 0;
        // Wait 100 ns for global reset to finish
        #100;

        D = 16'hAAAA; @(posedge clk); #10; $display("Q=%h (期望AAAA)", Q);
       D = 16'h5555; @(posedge clk); #10; $display("Q=%h (期望5555)", Q);
        D = 16'hF0F0; @(posedge clk); #10; $display("Q=%h (期望F0F0)", Q);
        D = 16'h0F0F; @(posedge clk); #10; $display("Q=%h (期望0F0F)", Q);
        $finish;
    end

endmodule
