// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/complete_datapath_module.sch - Sat Oct 11 15:35:18 2025

`timescale 1ns / 1ps

module complete_datapath_module_complete_datapath_module_sch_tb();

// Inputs
   reg CLK;
   reg CLR;
   reg CE;
   reg [15:0] control;
   reg [1:0] sel_op;
   reg [2:0] sel_mem;
   reg [4:0] addr_mem;
   reg [15:0] D;
   reg m;
   reg [2:0] write;
   reg [2:0] readAddrA;
   reg [2:0] readAddrB;

// Output
   wire [15:0] pc;
   wire V;
   wire Z;
   wire N;
   wire C;
   wire [15:0] S;

// Bidirs

// Instantiate the UUT
   complete_datapath_module UUT (
		.pc(pc), 
		.CLK(CLK), 
		.CLR(CLR), 
		.CE(CE), 
		.control(control), 
		.sel_op(sel_op), 
		.sel_mem(sel_mem), 
		.addr_mem(addr_mem), 
		.D(D), 
		.V(V), 
		.Z(Z), 
		.N(N), 
		.C(C), 
		.S(S), 
		.m(m), 
		.write(write), 
		.readAddrA(readAddrA), 
		.readAddrB(readAddrB)
   );
// Initialize Inputs
   initial CLK = 0;
	always #5 CLK = ~CLK; // 10ns period
	initial begin
      // 初始化
      CLR = 1; CE = 0;control = 0;sel_op = 2'b00;sel_mem = 3'd0;
      addr_mem = 0;D = 16'h0000;m = 0;write = 3'd0;
      readAddrA = 3'd0;readAddrB = 3'd0;#10;CLR = 0;
		//載入記憶體
		@(posedge CLK);sel_mem = 3'd0; addr_mem = 5'd1; D = 16'h0007; #10;  // MEM[1] = 3
      @(posedge CLK);sel_mem = 3'd0; addr_mem = 5'd2; D = 16'h0015; #10;  // MEM[2] = 5

      // 將記憶體內容載入 RF 暫存器 
      @(posedge CLK);write = 3'd1; D = 16'h0007; #10;  // R1 = 3
      @(posedge CLK);write = 3'd2; D = 16'h0015; #10;  // R2 = 5
		@(posedge CLK);
		write = 3'd0;readAddrA = 3'd1;readAddrB = 3'd2;
      m = 0; 
      #20;
      $display("=== 結果 ===\nPC = %h | R1(16'h0007) + R2(16'h0015) = %h ", pc, S); 
      $stop;
   end
endmodule

