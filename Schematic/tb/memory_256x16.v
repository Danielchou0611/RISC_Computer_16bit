`timescale 1ns / 1ps
module memory_module_256x16_memory_module_256x16_sch_tb();
// Inputs
reg [2:0] sel; reg [15:0] D;
reg clk; reg [4:0] addr;
// Output
wire [15:0] O0; wire [15:0] O1; wire [15:0] O2; wire [15:0] O3;
wire [15:0] O4; wire [15:0] O5; wire [15:0] O6; wire [15:0] O7;
wire [15:0] S;
// Instantiate the UUT
memory_module_256x16 UUT (
.O0(O0), .O1(O1), .O2(O2), .O3(O3),
.O4(O4), .O5(O5), .O6(O6), .O7(O7),
.sel(sel), .D(D), .clk(clk), .addr(addr)
.S(S),
);
// Initialize Inputs
always #5 clk = ~clk;
initial begin
    clk = 0; sel = 3'b000;
    addr = 5'b00000; D = 16'h0000;
    repeat (8) begin
    @(posedge clk);
    sel = sel + 1;
    addr = sel + 5; // addr：sel + 5
    D = 16'h1000 + sel; // 資料：0x1001 ~ 0x1008
    end
    @(posedge clk);
    sel = 3'b000;
    repeat (8) begin
    @(posedge clk);
    addr = sel + 5;
    @(posedge clk);
    $display("Read from sel %0d, addr %0d: S = %h (expect %h)", sel, addr, S, 16'h1000 + sel);
    sel = sel + 1;
    end
    $finish;
end
endmodule
