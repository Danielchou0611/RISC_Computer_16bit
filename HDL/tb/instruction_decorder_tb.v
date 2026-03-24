`timescale 1ns / 1ps
module instruction_decoder_tb;
    reg [15:0] instr;
    wire LHI;
    wire LLI;
    wire LDR_imm;
    wire LDR_reg;
    wire STR_imm;
    wire STR_reg;
    wire ADD;
    wire ADC;
    wire SUB;
    wire SBB;
    wire CMP;
    wire ADDI;
    wire SUBI;
    wire MOV;
    wire BCC;
    wire BCS;
    wire BNE;
    wire BEQ;
    wire BAL;
    wire JMP;
    wire JAL_imm;
    wire JAL_rm;
    wire JR;
    wire OUTR;
    wire HLT;
    Instruction_decoder uut (
        .instr(instr), 
        .LHI(LHI), 
        .LLI(LLI), 
        .LDR_imm(LDR_imm), 
        .LDR_reg(LDR_reg), 
        .STR_imm(STR_imm), 
        .STR_reg(STR_reg), 
        .ADD(ADD), 
        .ADC(ADC), 
        .SUB(SUB), 
        .SBB(SBB), 
        .CMP(CMP), 
        .ADDI(ADDI), 
        .SUBI(SUBI), 
        .MOV(MOV), 
        .BCC(BCC), 
        .BCS(BCS), 
        .BNE(BNE), 
        .BEQ(BEQ), 
        .BAL(BAL), 
        .JMP(JMP), 
        .JAL_imm(JAL_imm), 
        .JAL_rm(JAL_rm), 
        .JR(JR), 
        .OUTR(OUTR), 
        .HLT(HLT)
    );
    task show;
        begin
        #10;
        $display("Instr = %b", instr);
        $display(" LHI=%b , LLI=%b , LDRimm=%b , LDRreg=%b , STRimm=%b , STRreg=%b",
                 LHI,LLI,LDR_imm,LDR_reg,STR_imm,STR_reg);
        $display(" ADD=%b , ADC=%b , SUB=%b , SBB=%b , CMP=%b",
                 ADD,ADC,SUB,SBB,CMP);
        $display(" ADDI=%b , SUBI=%b , MOV=%b",
                 ADDI,SUBI,MOV);
            $display(" BCC=%b , BCS=%b , BNE=%b , BEQ=%b , BAL=%b",
                 BCC,BCS,BNE,BEQ,BAL);
        $display(" JMP=%b , JALimm=%b , JALrm=%b , JR=%b",
                 JMP,JAL_imm,JAL_rm,JR);
        $display(" OUTR=%b , HLT=%b", OUTR,HLT);
        $display("------------------------------------------------------------");
        end
    endtask
    initial begin
        instr = 16'hFFFF; 

        instr = 16'b00001_000_10101010; show();   // LHI
      instr = 16'b00010_000_01010101; show();   // LLI

        // ===== Load/Store =====
      instr = 16'b00011_001_010_00101; show();  // LDR_imm
      instr = 16'b00100_001_010_011_00; show(); // LDR_reg
      instr = 16'b00101_001_010_00011; show();  // STR_imm
      instr = 16'b00110_001_010_011_00; show(); // STR_reg

        // ===== ALU (reg-reg) =====
      instr = 16'b00000_001_010_011_00; show(); // ADD
      instr = 16'b00000_001_010_011_01; show(); // ADC
      instr = 16'b00000_001_010_011_10; show(); // SUB
      instr = 16'b00000_001_010_011_11; show(); // SBB
        instr = 16'b00110_000_010_011_01; show(); // CMP

        // ===== Immediate / MOV =====
      instr = 16'b00111_001_010_00101; show();  // ADDI
      instr = 16'b01000_001_010_00101; show();  // SUBI
      instr = 16'b01011_001_010_00000; show();  // MOV

        // ===== Branches =====
      instr = 16'b1100_0011_10101010; show();   // BCC
      instr = 16'b1100_0010_10101010; show();   // BCS
      instr = 16'b1100_0001_10101010; show();   // BNE
      instr = 16'b1100_0000_10101010; show();   // BEQ
      instr = 16'b1100_1110_10101010; show();   // BAL

        // ===== Jumps / Links =====
      instr = 16'b10000_01010101011; show();    // JMP
      instr = 16'b10001_001_10101010; show();   // JAL_imm
      instr = 16'b10010_001_010_000_00; show(); // JAL_rm
      instr = 16'b10011_000_01000000; show();   // JR

        // ===== Misc =====
      instr = 16'b11100_000_010_000_00; show();  // OUTR
      instr = 16'b11100_0000_00000_01; show();   // HLT

        $finish;
    end

endmodule

