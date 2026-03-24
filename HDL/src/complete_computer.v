`timescale 1ns / 1ps
module Complete_Computer(
        input clk, 
        input reset_n, 
        input        ext_we,
        input        test_normal,
        input [15:0] ext_addr,
        input [15:0] ext_data,

        output [15:0] pc, 
        output [15:0] instr, 
        output [15:0] mem_out, 
        output [15:0] OutR, 
        output reg done
    );
    wire reset=~reset_n;
    wire pc_ld, pc_j, pc_branch;
   wire [15:0] pc_next, offset;
   wire RF_enable;
   wire [2:0] RF_write_addr, RF_read_addrA, RF_read_addrB;
   wire [1:0] RF_write_back_sel;
   wire m;
   wire [1:0] ALU_Asel, ALU_Bsel;
   wire [15:0] imm;
   wire mem_enable;
   wire [1:0] mem_addr_sel, mem_write_data_sel;
   wire instr_ld, mem_addr_ld, mem_buf_ld, write_ld, output_ld;
   wire [3:0] flags;
   wire [15:0] RF_Aout, RF_Bout, ALU_out;
    wire [15:0] RF_out;
   assign OutR = RF_out;

    wire        cpu_mem_we;
   wire [7:0]  cpu_mem_addr;
   wire [15:0] cpu_mem_in;
   wire [15:0] mem_dout;

    complete_controller controller(clk, reset_n, instr, flags, pc_ld, pc_j, pc_branch, pc_next, offset, 
                                             RF_enable, RF_write_addr, RF_read_addrA, RF_read_addrB, RF_write_back_sel, 
                                             m, ALU_Asel, ALU_Bsel, imm, mem_enable, mem_addr_sel, mem_write_data_sel, 
                                             instr_ld, mem_addr_ld, mem_buf_ld, write_ld, output_ld);

    Complete_datapath datapath(clk, reset, pc_ld, pc_j, pc_branch, pc_next, offset, 
                                        RF_enable, RF_write_addr, RF_read_addrA, RF_read_addrB, RF_write_back_sel,
                                        m, ALU_Asel, ALU_Bsel, imm, mem_enable, mem_addr_sel, mem_write_data_sel, 
                                        instr_ld, mem_addr_ld, mem_buf_ld, write_ld, output_ld, mem_dout, 
                                        instr, pc, RF_Aout, RF_Bout, ALU_out, RF_out, flags, cpu_mem_we, cpu_mem_addr, cpu_mem_in);
    reg        mem_we_mux;
   reg [7:0]  mem_addr_mux;
   reg [15:0] mem_in_mux;
    always @(*) begin
        if (test_normal) begin
            // External programming mode
            mem_we_mux   = ext_we;
            mem_addr_mux = ext_addr[7:0];
            mem_in_mux   = ext_data;
        end else begin
            // CPU normal run mode
            mem_we_mux   = cpu_mem_we;
            mem_addr_mux = cpu_mem_addr;
            mem_in_mux   = cpu_mem_in;
        end
   end
    memory_256x16 memory(clk, mem_we_mux, mem_addr_mux, mem_in_mux, mem_dout);
    assign mem_out = mem_dout;
    wire is_hlt;
    assign is_hlt = (instr[15:11] == 5'b11100) && (instr[1:0] == 2'b01);

    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 1'b0;
        else if (is_hlt)
            done <= 1'b1;   // stay high after HLT
   end

endmodule
