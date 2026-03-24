`timescale 1ns / 1ps
module memory_256x16(
        input clk, enable, 
        input [7:0] addr,
        input [15:0] in, 
        output reg [15:0] out
    );
    reg [15:0] memory[255:0];	//256x16 memory
    always @(posedge clk) begin	//sequential, synchronous write
        if(enable)
            memory[addr] <= in;
    end
    always @(*) begin		//combinational(no clk), asynchronous read
        out = memory[addr];
    end

endmodule
