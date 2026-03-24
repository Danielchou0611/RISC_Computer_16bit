`timescale 1ns / 1ps
//T0(Fetch)->T1(Decode)->T2(Execute), multicycle, and single cycle don't need T1
module Timing_Generator(
        input clk, 
        input reset_n, //0 is reset
        output reg T0, 
        output reg T1, 
        output reg T2
    );
    reg [1:0] state, next_state;
    //localparam: not allow the external override, mean localparam is use for this module , and other module can not revise it
    //state and encoding
    localparam state_T0=2'd0;
    localparam state_T1=2'd1;
    localparam state_T2=2'd2;
    //state_register , synchronous renew and asynchronous reset
    always @(posedge clk or negedge reset_n)begin
        if(!reset_n)
            state <= state_T0;
        else
            state <= next_state;
    end
    //decide next state
    always @(*)begin
        case(state) 
            state_T0: next_state=state_T1;	//if state_value == state_T0_value
            state_T1: next_state=state_T2;
            state_T2: next_state=state_T0;
            default:  next_state=state_T0;
        endcase
    end
    //moore machine, output the T0, T1, T2, which is now state(true)
    always @(*)begin
        T0=(state==state_T0);
        T1=(state==state_T1);
        T2=(state==state_T2);
    end

endmodule
