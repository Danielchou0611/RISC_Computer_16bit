`timescale 1ns / 1ps
module ALU_16bits(
        input [15:0] A, B, 
        input  m, 	    // m=0:add, m=1:sub
        output [15:0] S, 
        output N, Z, V, C
    );
    wire [15:0] B_xor = B ^ {16{m}};
    wire [16:0] c;	//record the carry out, c[0]=m, c[i+1]=ith carry out
    wire [15:0] sum;

    assign c[0]=m;
    genvar i;
    generate 
        for(i=0;i<16;i=i+1) begin : fulladder
            full_adder fa(.A(A[i]), .B(B_xor[i]), .Cin(c[i]), .S(sum[i]), .Cout(c[i+1]));
        end
    endgenerate
    assign S = sum;
    assign N = sum[15];			//N:MSB
    assign Z = (sum==0);			//sum==0	
    assign C = c[16];				//carry out
    assign V = c[16] ^ c[15];	//check overflow, cout[MSB]^cout[MSB-1]

endmodule

