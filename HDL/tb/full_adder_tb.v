`timescale 1ns / 1ps
module full_adder_tb;
    reg A;
    reg B;
    reg Cin;

    wire S;
    wire Cout;

    full_adder uut (
        .A(A),
        .B(B), 
        .Cin(Cin), 
        .S(S), 
        .Cout(Cout)
    );
    initial begin
        A = 0;
        B = 0;
        Cin = 0;

        // Wait 100 ns for global reset to finish
        #100;
        {A,B,Cin} = 3'b000; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b001; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b010; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b011; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b100; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b101; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b110; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);

        {A,B,Cin} = 3'b111; #10;
        $display("A=%b B=%b Cin=%b | S=%b Cout=%b", A, B, Cin, S, Cout);
        $finish;

    end

endmodule

