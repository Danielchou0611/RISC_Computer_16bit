`timescale 1ns / 1ps
module Instruction_decoder(
        input [15:0] instr, 
        output reg LHI, LLI, LDR_imm, LDR_reg, STR_imm, STR_reg,   
        output reg ADD, ADC, SUB, SBB, CMP, 
        output reg ADDI, SUBI, MOV, 
        output reg BCC, BCS, BNE, BEQ, BAL,
        output reg JMP, JAL_imm, JAL_rm, JR,
        output reg OUTR, HLT
    );
    wire [4:0] opcode5 = instr[15:11];
    wire [3:0] opcode4 = instr[15:12];
    wire [3:0] branch_code = instr[11:8];
    wire [1:0] function2 = instr[1:0];

    always @(*)begin
        LHI=0; LLI=0; LDR_imm=0; LDR_reg=0; STR_imm=0; STR_reg=0; 
        ADD=0; ADC=0; SUB=0; SBB=0; CMP=0;
        ADDI=0; SUBI=0; MOV=0;
        BCC=0; BCS=0; BNE=0; BEQ=0; BAL=0;
        JMP=0; JAL_imm=0; JAL_rm=0; JR=0;
        OUTR=0; HLT=0;

        if(opcode5 == 5'b00001)
            LHI=1;
        if(opcode5 == 5'b00010)
            LLI=1;
        if(opcode5 == 5'b00011)
            LDR_imm=1;
        if(opcode5 == 5'b00100)
            LDR_reg=1;
        if(opcode5 == 5'b00101)
            STR_imm=1;

        if(opcode5 == 5'b00110 && function2 == 2'b00)
            STR_reg=1;
        if(opcode5 == 5'b00110 && function2 == 2'b01)
            CMP=1;

        if(opcode5 == 5'b00000)begin
            case (function2) 
                2'b00: ADD=1;
                2'b01: ADC=1;
                2'b10: SUB=1;
                2'b11: SBB=1;
            endcase
        end

        if(opcode5 == 5'b00111)
            ADDI=1;
        if(opcode5 == 5'b01000)
            SUBI=1;
        if(opcode5 == 5'b01011)
            MOV=1;

        if(opcode4 == 4'b1100)begin
            case(branch_code)
                4'b0011: BCC=1;
                4'b0010: BCS=1;
                4'b0001: BNE=1;
                4'b0000: BEQ=1;
                4'b1110: BAL=1;
            endcase
        end

        if(opcode5 == 5'b10000)
            JMP=1;
        if(opcode5 == 5'b10001)
            JAL_imm=1;
        if(opcode5 == 5'b10010)
            JAL_rm=1;
        if(opcode5 == 5'b10011)
            JR=1;

        if(opcode5 == 5'b11100 && function2 == 2'b00)
            OUTR=1;
        if(opcode5 == 5'b11100 && function2 == 2'b01)
            HLT=1;
    end

endmodule
