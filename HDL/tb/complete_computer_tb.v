`timescale 1ns / 1ps
module Complete_Computer_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg ext_we;
    reg test_normal;
    reg [15:0] ext_addr;
    reg [15:0] ext_data;

    // Outputs
    wire [15:0] pc;
    wire [15:0] instr;
    wire [15:0] mem_out;
    wire [15:0] OutR;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    Complete_Computer uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .ext_we(ext_we), 
        .test_normal(test_normal), 
        .ext_addr(ext_addr), 
        .ext_data(ext_data), 
        .pc(pc), 
        .instr(instr), 
        .mem_out(mem_out), 
        .OutR(OutR), 
        .done(done)
    );
    always #5 clk=~clk;
   initial begin
       $monitor("t=%0t | PC=%0d | instr=%h | mem_out=%h | OutR=%0d | done=%b",
                 $time, pc, instr, mem_out, OutR, done);
   end
    task write_hex(input [15:0] addr, input [15:0] data);
        begin
            @(posedge clk);
            ext_addr = addr;
            ext_data = data;
            ext_we   = 1;
            @(posedge clk);
            ext_we = 0;
            @(posedge clk); // IMPORTANT: Let memory settle
        end
   endtask	  

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        ext_we = 0;
        test_normal = 1;
        ext_addr = 0;
        ext_data = 0;

        // Wait 100 ns for global reset to finish
        #100;reset_n=1;
        write_hex(100, 16'h0007);   // A = 7
        write_hex(101, 16'h000D);   // B = 13
        write_hex(0, 16'h20C8);  // LLI R0,#100
        write_hex(1, 16'h0800);  // LHI R0,#0
        write_hex(2, 16'h2880);  // LDR R1,[R0,#0]
        write_hex(3, 16'h20C9);  // LLI R0,#101
        write_hex(4, 16'h0800);  // LHI R0,#0
        write_hex(5, 16'h2900);  // LDR R2,[R0,#0]
        write_hex(6, 16'h0000);  // NOP (safe timing)
        // Compare R1 - R2
        write_hex(7, 16'h0B08);  // CMP R1,R2  (R1 - R2)
        // If R1 < R2 → CARRY = 1 → BCS skip_swap
        write_hex(8, 16'h6802);  // BCS +2 → skip swap
        // Swap R1 ↔ R2
        write_hex(9, 16'h18C8);  // MOV R4,R1 (min)
        write_hex(10,16'h1948);  // MOV R5,R2 (max)
        write_hex(11,16'hE600);  // OUTR R4
        write_hex(12,16'hE680);  // OUTR R5
        write_hex(13,16'hE001);  // HLT
        @(posedge clk);
        test_normal = 0;
        wait(done);	
        $display("CPU halted.");
        #10;
        $finish;

    end

endmodule
