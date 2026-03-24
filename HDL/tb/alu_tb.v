`timescale 1ns / 1ps
module ALU_16bits_tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg m;

    // Outputs
    wire [15:0] S;
    wire N;
    wire Z;
    wire V;
    wire C;

    // Instantiate the Unit Under Test (UUT)
    ALU_16bits uut (
        .A(A), 
        .B(B), 
        .m(m), 
        .S(S), 
        .N(N), 
        .Z(Z), 
        .V(V), 
        .C(C)
    );

    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        m = 0;
        #100;
        $display("m\tA\tB\tS\tC N Z V");
        A = 16'd100;
        B = 16'd200;
        m = 0;
        #10;
        $display("%b\t%h\t%h\t%h\t%b %b %b %b",  m, A, B, S, C, N, Z, V);

        A = 16'h4000;
        B = 16'h4000;
        m = 0;
        #10;
        $display("%b\t%h\t%h\t%h\t%b %b %b %b",  m, A, B, S, C, N, Z, V);

        A = 16'd50;
        B = 16'd100;
        m = 1;
        #10;
        $display("%b\t%h\t%h\t%h\t%b %b %b %b",  m, A, B, S, C, N, Z, V);

        A = 16'd1234;
        B = 16'd1234;
        m = 1;
        #10;
        $display("%b\t%h\t%h\t%h\t%b %b %b %b",  m, A, B, S, C, N, Z, V);

        A = 16'hFFFF;
        B = 16'h0001;
        m = 0;
        #10;
        $display("%b\t%h\t%h\t%h\t%b %b %b %b",  m, A, B, S, C, N, Z, V);
        $finish;
    end

endmodule

