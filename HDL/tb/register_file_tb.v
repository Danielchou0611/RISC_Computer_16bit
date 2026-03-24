`timescale 1ns / 1ps
module register_file_tb;
    reg clk;
    reg [2:0] addr_A;
    reg [2:0] addr_B;
    reg [2:0] write_reg;
    reg enable;

    reg [15:0] write_data;	wire [15:0] data_A;
    wire [15:0] data_B;
    register_file uut (
        .clk(clk), 
        .addr_A(addr_A), 
        .addr_B(addr_B), 
        .write_reg(write_reg), 
        .enable(enable), 
        .write_data(write_data), 
        .data_A(data_A), 
        .data_B(data_B)
    );
    initial clk=0; always #5 clk = ~clk;
    initial begin
        clk = 0; addr_A = 0; addr_B = 0;
        write_reg = 0; write_data = 0; enable = 0;
        // Wait 100 ns for global reset to finish
        #100;
      @(posedge clk); write_reg = 3'd1; write_data = 16'h1111; enable=1; 
        @(posedge clk); enable=0;
        @(posedge clk); write_reg = 3'd2; write_data = 16'h2222; enable=1; 
        @(posedge clk); enable=0;
        @(posedge clk); write_reg = 3'd3; write_data = 16'h3333; enable=1; 
        @(posedge clk); enable=0;

        addr_A = 3'd1; addr_B = 3'd3;
      #10;
      $display("READ1  A=%h  B=%h", data_A, data_B);

        @(posedge clk); write_reg = 3'd3; write_data = 16'h7777; 
        enable=1; @(posedge clk); enable=0;
        addr_A = 3'd2;
        #10; 
        $display("READ1  A=%h  B=%h", data_A, data_B);
        $finish;
    end

endmodule
