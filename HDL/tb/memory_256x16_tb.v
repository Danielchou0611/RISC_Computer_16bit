`timescale 1ns / 1ps
module memory_256x16_tb;
    reg clk;
    reg enable;
    reg [7:0] addr;
    reg [15:0] in;
    wire [15:0] out;
    memory_256x16 uut (
        .clk(clk), 
        .enable(enable), 
        .addr(addr), 
        .in(in), 
        .out(out)
    );
    always #5 clk=~clk;
    initial begin
        clk = 0;
        enable = 0;
        addr = 0;
        in = 0;

        // Wait 100 ns for global reset to finish
        #100;
      repeat (8) begin
        @(posedge clk);#5;
        enable = 1;
        addr = addr + 4;          // addr：1,2,3,...8
        in   = 16'h1000 + addr;     // 1001 ~ 1008
        end
        @(posedge clk);#5;
        enable = 0;
        addr = 8'd4;
        repeat (8) begin
        @(posedge clk);#5;
        $display("Read addr %0d: out = %h (expect %h)",
                  addr, out, 16'h1000 + addr);
        addr = addr + 4;
        end
        $finish;
    end

endmodule

