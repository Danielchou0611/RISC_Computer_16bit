`timescale 1ns / 1ps
module complete_controller(
        input clk, 
        input reset_n, 
        input [15:0] instr,
        input [3:0] flags, //N, Z, V, C

        output reg        pc_ld,
      output reg        pc_j,
      output reg        pc_branch,
        output reg [15:0] pc_next,
        output reg [15:0] offset,
        // RF control
        output reg        RF_enable,
        output reg [2:0]  RF_write_addr,
        output reg [2:0]  RF_read_addrA,
        output reg [2:0]  RF_read_addrB,
        // write-back mux (00=ALU_out, 01=MBR, 02=imm, 03=PC+1)
        output reg [1:0]  RF_write_back_sel,
        // ALU control
        output reg        m,           // 0: add, 1: sub  (你的 ALU 定義)
        output reg [1:0]  ALU_Asel,    // 00=RF_A, 01=PC, 02=MAR, 03=0
        output reg [1:0]  ALU_Bsel,    // 00=RF_B, 01=imm, 02=1,   03=0
        output reg [15:0] imm,         // 立即數 / 位移
        // memory control
        output reg        mem_enable,        // 當成 write-enable 使用
        output reg [1:0]  mem_addr_sel,      // 0=PC, 1=MAR, 2=ALU_out
        output reg [1:0]  mem_write_data_sel,// 0=WDR,1=RF_A,2=RF_B,3=MBR
        // pipeline registers in datapath
        output reg        instr_ld,
        output reg        mem_addr_ld,
        output reg        mem_buf_ld,
        output reg        write_ld,
        output reg        output_ld
    );
     wire T0, T1, T2;
     wire LHI, LLI, LDR_imm, LDR_reg, STR_imm, STR_reg;
     wire ADD, ADC, SUB, SBB, CMP;
     wire ADDI, SUBI, MOV;
     wire BCC, BCS, BNE, BEQ, BAL;
     wire JMP, JAL_imm, JAL_rm, JR;
     wire OUTR, HLT;

     Timing_Generator TG(clk, reset_n, T0, T1, T2);
     Instruction_decoder ID(instr, LHI, LLI, LDR_imm, LDR_reg, STR_imm, STR_reg,   
                                    ADD, ADC, SUB, SBB, CMP, ADDI, SUBI, MOV, 
                                    BCC, BCS, BNE, BEQ, BAL, JMP, JAL_imm, JAL_rm, JR,
                                    OUTR, HLT);
     // decode
     wire [2:0] rd = instr[11:9];
    wire [2:0] ra = instr[8:6];
    wire [2:0] rb = instr[5:3];
    wire [7:0] imm8 = instr[7:0];
     wire [4:0] imm5     = instr[4:0];
    wire [15:0] imm5_ze = {11'b0, imm5};
    wire [15:0] imm8_se = {{8{imm8[7]}}, imm8};
    wire [15:0] imm_high = {imm8, 8'h00};
    wire [15:0] imm_low  = {8'h00, imm8};

    wire N = flags[3];
    wire Z = flags[2];
    wire V = flags[1];
    wire C = flags[0];
     //control 
     always @(*) begin
        // Default values
        pc_ld     = 0;
        pc_j      = 0;
        pc_branch = 0;
        pc_next   = 16'd0;
        offset    = 16'd0;
          RF_enable = 0;
        RF_write_addr = rd;
        RF_read_addrA = ra;
        RF_read_addrB = rb;
        RF_write_back_sel = 2'b00;
        m = 0;
        ALU_Asel = 2'b00; 
        ALU_Bsel = 2'b00;
        imm = imm8_se;
          mem_enable = 0;       // 0 = read, 1 = write
        mem_addr_sel = 2'b00; // PC
        mem_write_data_sel = 2'b00;
        instr_ld = 0;
        mem_addr_ld = 0;
        mem_buf_ld = 0;
        write_ld = 0;
        output_ld = 0;
          //T0(fetch)
          if (T0) begin
            mem_enable = 0;          // read
            mem_addr_sel = 0;        // PC
            instr_ld = 1;
        end
          //T1(no need PC+1), no control requiree
          //T2(execute)
          else if (T2) begin
                pc_ld = 1;
            // -------- LHI / LLI --------
            if (LHI) begin
                RF_enable = 1;
                RF_write_addr = rd;
                RF_write_back_sel = 2'b10;
                imm = imm_high;
            end
                else if (LLI) begin
                RF_enable = 1;
                RF_write_addr = rd;
                RF_write_back_sel = 2'b10;
                imm = imm_low;
            end
                // -------- LDR (Rm + imm8) --------
            else if (LDR_imm) begin
                ALU_Asel = 2'b00;  // RF_A
                ALU_Bsel = 2'b01;  // imm
                mem_addr_ld = 1;   // MAR <= ALU_out

                mem_enable = 0;    // read
                mem_addr_sel = 2'b01; // MAR
                mem_buf_ld = 1;

                RF_enable = 1;
                RF_write_addr = rd;
                RF_write_back_sel = 2'b01;
            end
                // -------- LDR (Rm + Rn) --------
            else if (LDR_reg) begin
                ALU_Asel = 2'b00; // Rm
                ALU_Bsel = 2'b00; // Rn
                mem_addr_ld = 1;

                mem_enable = 0;
                mem_addr_sel = 2'b01;
                mem_buf_ld = 1;

                RF_enable = 1;
                RF_write_addr = rd;
                RF_write_back_sel = 2'b01;
            end
                // -------- STR (Rm + imm), store Rd --------
            else if (STR_imm) begin
                ALU_Asel = 2'b00; 
                ALU_Bsel = 2'b01;
                mem_addr_ld = 1;

                write_ld = 1;  // WDR <= RF_A(rd)

                mem_enable = 1;
                mem_addr_sel = 2'b01;
                mem_write_data_sel = 2'b00; // WDR
            end
                else if (STR_reg) begin
                RF_read_addrA = ra;      // Rm
                RF_read_addrB = rb;      // Rn
                ALU_Asel      = 2'b00;
                ALU_Bsel      = 2'b00;   // addr = Rm + Rn

                mem_addr_sel      = 2'b10;
                mem_enable        = 1'b1;
                mem_write_data_sel= 2'b10;   // data = RF_B = Rn 
            end
                // -------- Arithmetic --------
            else if (ADD || ADC) begin
                RF_read_addrA = ra;
                RF_read_addrB = rb;
                ALU_Asel      = 2'b00;
                ALU_Bsel      = 2'b00;
                m             = 1'b0;        // add
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b00;   // ALU_out
            end
                else if (SUB || SBB) begin
                // SBB 暫時與 SUB 相同（不含 C）
                RF_read_addrA = ra;
                RF_read_addrB = rb;
                ALU_Asel      = 2'b00;
                ALU_Bsel      = 2'b00;
                m             = 1'b1;        // sub
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b00;
            end
                else if (CMP) begin
                RF_read_addrA = ra;
                RF_read_addrB = rb;
                ALU_Asel      = 2'b00;
                ALU_Bsel      = 2'b00;
                m             = 1'b1;        // Rm - Rn，僅更新 flags
            end
                // -------- ADDI / SUBI --------
            else if (ADDI) begin
                RF_read_addrA = ra;
                ALU_Asel      = 2'b00;   // Rm
                ALU_Bsel      = 2'b01;   // imm5
                imm           = imm5_ze;
                m             = 1'b0;
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b00;
            end
                else if (SUBI) begin
                RF_read_addrA = ra;
                ALU_Asel      = 2'b00;
                ALU_Bsel      = 2'b01;
                imm           = imm5_ze;
                m             = 1'b1;
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b00;
            end
                // -------- MOV Rd <- Rm --------
            else if (MOV) begin
                RF_read_addrA = ra;      // Rm
                ALU_Asel      = 2'b00;   // RF_A
                ALU_Bsel      = 2'b11;   // 常數 0
                m             = 1'b0;    // add
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b00; // ALU_out = Rm
            end

            // -------- Branch --------
            else if (BNE && !Z) begin
                pc_branch = 1;
                offset = imm8_se;
            end
                else if (BEQ && Z) begin
                pc_branch = 1;
                offset = imm8_se;
            end
            else if (BCC && !C) begin
                pc_branch = 1;
                offset = imm8_se;
            end
            else if (BCS && C) begin
                pc_branch = 1;
                offset = imm8_se;
            end
                else if (BAL) begin
                pc_branch = 1;
                offset = imm8_se;
            end
                // -------- JMP --------
                else if (JAL_imm) begin
                RF_enable         = 1'b1;
                RF_write_addr     = rd;
                RF_write_back_sel = 2'b11;   // PC+1（pc_add_1）
                pc_branch         = 1'b1;
                offset            = imm8_se;
            end
            else if (JMP) begin
                pc_j = 1;
                pc_next = {5'd0, instr[10:0]};
            end
                // ---------------- JAL Rd,Rm / JR Rd ----------------
            // 受限於目前 datapath（pc_next 無法直接接 RF_A），
            // 這裡暫時不實作真正效果，視為 NOP。
            else if (JAL_rm) begin
                // TODO: 需修改 datapath 才能支援 PC <- Rm
            end
            else if (JR) begin
                // TODO: 需修改 datapath 才能支援 PC <- Rd
            end
                // ---------------- OUTR Rm ----------------
            else if (OUTR) begin
                RF_read_addrA = ra;
                output_ld     = 1'b1;   // output_reg <= RF_A
            end
            // ---------------- HLT ----------------
            // 目前沒有 global "done" 或 clock gating 訊號，
            // 這裡先當作 NOP，若 top-level 需要可再加 done_flag。
            else if (HLT) begin
                // no control (可在 top-level 用 HLT 來停止模擬)
            end
            end // T2
    end // always 
endmodule
