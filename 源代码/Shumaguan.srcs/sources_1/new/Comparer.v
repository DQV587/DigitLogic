`timescale 1ns / 1ps

module Comparer(
    input [3:0] A0,
    input [3:0] A1,
    input [3:0] A2,
    input [3:0] A3,
    input [1:0] state,
    input enter,
    input clk,
    input reset,
    output reg unlock
    );
 
    reg [3:0] D0;
    reg [3:0] D1;
    reg [3:0] D2;
    reg [3:0] D3;
    
    initial
    begin
        D0 <= 1;
        D1 <= 2;
        D2 <= 0;
        D3 <= 2;
        unlock <= 0;
    end
    
    always @(posedge clk or posedge reset)
    begin
        if(reset==1)
        begin
            unlock <= 0;
        end
        else 
        begin
            if(state==3 && enter==1)
            begin
                    D0 <= A0;
                    D1 <= A1;
                    D2 <= A2;
                    D3 <= A3;
            end
            else 
                begin
                    if(state==2 && A0==D0 && A1==D1 && A2==D2 && A3==D3)
                        unlock <= 1;
                    else
                        unlock <= 0;
                end
        end
    end
    
endmodule
