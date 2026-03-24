`timescale 1ns / 1ps
module complete_controller_tb;
    // Inputs
    reg clk;
    reg reset_n;
    reg [15:0] instr;
    reg [3:0] flags;
    // Outputs
    wire pc_ld;
    wire pc_j;
    wire pc_branch;
    wire [15:0] pc_next;
    wire [15:0] offset;
    wire RF_enable;
    wire [2:0] RF_write_addr;
    wire [2:0] RF_read_addrA;
    wire [2:0] RF_read_addrB;
    wire [1:0] RF_write_back_sel;
    wire m;
    wire [1:0] ALU_Asel;
    wire [1:0] ALU_Bsel;
    wire [15:0] imm;
    wire mem_enable;
    wire [1:0] mem_addr_sel;
    wire [1:0] mem_write_data_sel;
    wire instr_ld;
    wire mem_addr_ld;
    wire mem_buf_ld;
    wire write_ld;
    wire output_ld;

    // Instantiate the Unit Under Test (UUT)
    complete_controller uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .instr(instr), 
        .flags(flags), 
        .pc_ld(pc_ld), 
        .pc_j(pc_j), 
        .pc_branch(pc_branch), 
        .pc_next(pc_next), 
        .offset(offset), 
        .RF_enable(RF_enable), 
        .RF_write_addr(RF_write_addr), 
        .RF_read_addrA(RF_read_addrA), 
        .RF_read_addrB(RF_read_addrB), 
        .RF_write_back_sel(RF_write_back_sel), 
        .m(m), 
        .ALU_Asel(ALU_Asel), 
        .ALU_Bsel(ALU_Bsel), 
        .imm(imm), 
        .mem_enable(mem_enable), 
        .mem_addr_sel(mem_addr_sel), 
        .mem_write_data_sel(mem_write_data_sel), 
        .instr_ld(instr_ld), 
        .mem_addr_ld(mem_addr_ld), 
        .mem_buf_ld(mem_buf_ld), 
        .write_ld(write_ld), 
        .output_ld(output_ld)
    );
    always #5 clk=~clk;
    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        instr = 0;
        flags = 0;

        #100;
        reset_n=1;
        $display("LHI");
      instr = 16'b00001_000_00000000; #40;
      $display("LLI");
      instr = 16'b00010_001_00000011; #40;

        $display("ADD");
      instr = 16'b00000_010_011_100_00; #40;
      $display("ADC");
      instr = 16'b00000_010_011_100_01; #40;
      $display("SUB");
      instr = 16'b00000_010_011_100_10; #40;
      $display("SBB");
      instr = 16'b00000_010_011_100_11; #40;
        $display("CMP");
      instr = 16'b00110_00000000001; #40;
      $display("ADDI");
      instr = 16'b00111_010_000000101; #40;
      $display("SUBI");
      instr = 16'b01000_010_000000101; #40;
      $display("MOV");
      instr = 16'b01011_010_011_000000; #40;

        $display("LDR_imm");
      instr = 16'b00011_010_00000011; #40;
      $display("LDR_reg");
      instr = 16'b00100_010_011_000000; #40;
      $display("STR_imm");
      instr = 16'b00101_010_00000011; #40;
      $display("STR_reg");
      instr = 16'b00110_010_011_000000; #40;

        $display("BEQ");
      instr = 16'b1100_0000_00000010; flags = 4'b0100; #40;
      $display("BNE");
      instr = 16'b1100_0001_00000011; flags = 4'b0000; #40;
      $display("BCS");
      instr = 16'b1100_0010_00000011; flags = 4'b0001; #40;
      $display("BCC");
      instr = 16'b1100_0011_00000011; flags = 4'b0000; #40;
      $display("BAL");
      instr = 16'b1100_1110_00000100; #40;

        $display("JMP");
      instr = 16'b10000_000_00000000; #40;
      $display("JAL_imm");
      instr = 16'b10001_000_00000001; #40;
      $display("JAL_rm");
      instr = 16'b10010_000_00000000; #40;
      $display("JR");
      instr = 16'b10011_000_00000000; #40;

        $display("OUTR");
      instr = 16'b11100_000_00000000; #40;
      $display("HLT");
      instr = 16'b11100_000_00000001; #40;

        $finish;

    end
    initial begin
        $monitor("t=%0t instr=%h | pc_ld=%b pc_j=%b pc_branch=%b pc_next=%h offset=%h | RF_en=%b RF_wr=%d RF_A=%d RF_B=%d wb_sel=%b | ALU_Asel=%b ALU_Bsel=%b m=%b imm=%h | mem_en=%b addr_sel=%b wdata_sel=%b | instr_ld=%b mem_addr_ld=%b mem_buf_ld=%b write_ld=%b output_ld=%b",
                 $time, instr,
                 pc_ld, pc_j, pc_branch, pc_next, offset,
                 RF_enable, RF_write_addr, RF_read_addrA, RF_read_addrB, RF_write_back_sel,
                      ALU_Asel, ALU_Bsel, m, imm,
                 mem_enable, mem_addr_sel, mem_write_data_sel,
                 instr_ld, mem_addr_ld, mem_buf_ld, write_ld, output_ld);
    end

endmodule
