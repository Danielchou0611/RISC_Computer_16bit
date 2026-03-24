`timescale 1ns / 1ps
module PC_Circuitry(
        input clk, reset, 
        input pc_load, 	//renew pc or not
        input pc_j,		//j-type or not
        input pc_branch, 	//branch or net
        input [15:0] pc_next, //next pc for j-type
        input [15:0] offset,  // branch offset
        output reg [15:0] pc
    );
    wire [15:0] adder_input, adder_result;
    assign adder_input = pc_branch ? offset : 16'd1;

    two_complement_adder add_branch(pc, adder_input, adder_result);

    always @(posedge clk)begin
        if(reset)
            pc <= 16'd0;
        else if(pc_load) 
            pc <= pc_j ? pc_next : adder_result;
    end

endmodule

