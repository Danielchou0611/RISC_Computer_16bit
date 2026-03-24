`timescale 1ns / 1ps
module DFF_16bits_register(
        input clk,
        input enable,
        input[15:0] D,
        output reg[15:0] Q
    );
always @(posedge clk) begin
    if (enable)
        Q <= D;      // clock-enable behavior
end

endmodule

