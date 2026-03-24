// Verilog test fixture created from schematic /home/ise/Xilinx_Projects/test/ttt.sch - Mon Oct 13 16:18:21 2025

`timescale 1ns / 1ps

module ttt_ttt_sch_tb();

// Inputs
   reg CE;
   reg CLK;
   reg CLR;
   reg [2:0] state;

// Output
   wire [7:0] T;
   wire [2:0] tmp;

// Bidirs

// Instantiate the UUT
   ttt UUT (
		.CE(CE), 
		.CLK(CLK), 
		.CLR(CLR), 
		.T(T), 
		.state(state), 
		.tmp(tmp)
   );
// Initialize Inputs
   always #5 CLK = ~CLK;

initial begin
    // 初始化
    CLK = 0;
    CE  = 0;
    CLR = 0;
    state = 3'b000;
	 @(posedge CLK);
	 #50;
    CLR = 0;
    #20;
	 CE  = 1;
    repeat (10) begin
        @(posedge CLK);
        #20;            
        $display("Time=%0t | state=%b | tmp=%b | T=%b", $time, state, tmp, T);
		  state <= tmp;//  D_FF 將 tmp 傳回 state
    end

    $stop;
end
endmodule

