`timescale 1ns / 1ps
module Complete_datapath(
        input clk,
        input reset,
        //PC controll
        input pc_ld,
        input pc_j,
        input pc_branch, 
        input [15:0] pc_next, 
        input [15:0] offset, 

        //Register file
        input RF_enable,  
        input [2:0] RF_write_addr,
        input [2:0] RF_read_addrA,
      input [2:0]	RF_read_addrB, 

        // Write-back MUX select
      input [1:0] RF_write_back_sel,   // 00=ALU_out, 01=MBR, 02=imm_ext, 03=PC+1

        //ALU control
        input m,
        input [1:0] ALU_Asel,    // 00=RF_A, 01=PC, 02=MAR, 03=0
        input [1:0] ALU_Bsel,    // 00=RF_B, 01=imm_ext, 02=1, 03=0
        input [15:0] imm,			// I-type, immediate

        //memory
        input mem_enable, 
        input [1:0] mem_addr_sel,  // 0=PC, 1=MAR(memory address reg), 2=ALU_out
        input [1:0] mem_write_data_sel,    // 0=WDR(write data reg), 1=RF_A, 2=RF_B, 3=MBR(memory buffer reg)

        //some signal decide the datapath
        input instr_ld, 
        input mem_addr_ld, 
        input mem_buf_ld, 
        input write_ld, 
        input output_ld,

        //output
        output [15:0] instr, 
        output [15:0] pc, 
        output [15:0] RF_Aout,
        output [15:0] RF_Bout,
        output [15:0] ALU_out,
        output [15:0] RF_out, 	
        output [3:0] flags 	//store N, Z, V, C
    );
     PC_Circuitry PC(clk, reset, pc_ld, pc_j, pc_branch, pc_next, offset, pc);
     wire [15:0] pc_add_1;
    assign pc_add_1 = pc + 16'd1;

     reg [15:0] instr_reg, mem_addr_reg, mem_buf_reg, write_reg, output_reg;
     wire [15:0] RF_A, RF_B;
     reg [15:0] ALU_A, ALU_B;
     wire N, Z, V, C;
     always @(*) begin
        case(ALU_Asel)
            2'b00: ALU_A = RF_A;
            2'b01: ALU_A = pc;
            2'b10: ALU_A = mem_addr_reg;
            default : ALU_A = 16'd0;
        endcase
     end

     always @(*) begin
        case(ALU_Bsel)
            2'b00: ALU_B = RF_B;
            2'b01: ALU_B = imm;
            2'b10: ALU_B = 16'd1;	//PC+1
            default: ALU_B = 16'd0;
        endcase
     end

     reg [15:0] RF_write_back_data;
     always @(*) begin
        case(RF_write_back_sel)
            2'b00: RF_write_back_data = ALU_out;   // ALU result
         2'b01: RF_write_back_data = mem_buf_reg;       // value from memory
         2'b10: RF_write_back_data = imm;       // extended immediate
         2'b11: RF_write_back_data = pc_add_1;  // return address etc.
         default: RF_write_back_data = 16'd0;
        endcase
     end
     //RF_ALU
     RF_plus_ALU_16bits RF(clk, RF_enable, RF_write_back_data, RF_write_addr, RF_read_addrA, RF_read_addrB,
                           m, ALU_A, ALU_B, ALU_out, N, Z, V, C, RF_A, RF_B);
     assign RF_Aout = RF_A;
     assign RF_Bout = RF_B;
     assign flags={N, Z, V, C};

     // memory
     reg [15:0] mem_addr;
     reg [15:0] mem_in;
    wire [15:0] mem_out;
     always @(*) begin
        case(mem_addr_sel)
            2'b00: mem_addr = pc;
         2'b01: mem_addr = mem_addr_reg;
         2'b10: mem_addr = ALU_out;
         default: mem_addr = 16'd0;
        endcase
     end
     always @(*) begin
        case(mem_write_data_sel)
            2'b00: mem_in = write_reg;
         2'b01: mem_in = RF_A;
         2'b10: mem_in = RF_B;
            2'b11: mem_in = mem_buf_reg;
         default: mem_in = 16'd0;
        endcase
     end
     memory_256x16 mem(clk, mem_enable, mem_addr[7:0], mem_in, mem_out); 

     //state_register

     always @(posedge clk or posedge reset)begin
        if(reset)begin
            instr_reg <= 16'd0;
            mem_addr_reg <= 16'd0;
            mem_buf_reg <= 16'd0;
            write_reg <= 16'd0;
            output_reg <= 16'd0;
        end
        else begin
            if(instr_ld) 
                instr_reg <= mem_out;
            if(mem_addr_ld)
                mem_addr_reg <= ALU_out;
            if(mem_buf_ld)
                mem_buf_reg <= mem_out;
            if(write_ld)
                write_reg <= RF_A;
            if(output_ld)
                output_reg <=RF_A;
        end
     end
     assign instr = instr_reg;
     assign RF_out = output_reg;

endmodule
