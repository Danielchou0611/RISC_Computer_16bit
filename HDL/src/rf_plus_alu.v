`timescale 1ns / 1ps
module RF_plus_ALU_16bits(
        input clk, enable,
        input [15:0] data,
        input [2:0] write_addr,
        input [2:0] read_addr_A, read_addr_B,
        input m,
        input [15:0] ALU_A, ALU_B, 	// for datapath
        output [15:0] S,
        output N, Z, V, C, 
        output [15:0] RF_A, RF_B	//for debug
    );
    wire [15:0] RF_data_A, RF_data_B;	//register file connect

    register_file RF(clk, read_addr_A, read_addr_B, write_addr, enable, data, RF_data_A, RF_data_B);
    ALU_16bits ALU(ALU_A, ALU_B, m, S, N, Z, V, C);
    assign RF_A = RF_data_A;
    assign RF_B = RF_data_B;

endmodule

