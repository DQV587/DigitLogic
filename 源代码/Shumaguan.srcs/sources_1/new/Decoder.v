`timescale 1ns / 1ps
//寄存器，控制对哪一位密码进行改变
module Decoder(
    input [1:0] Location,
    input order,
    input reset,
    output reg [3:0] Control
    );
    
    initial
    begin
        Control = 0;
    end
    
    always@(*)
    begin
        if(reset==1)
        begin
            Control = 0;
        end
        else
        begin
            case(Location)
            2'b00:
            begin
                Control[0] <= order;
                Control[1] <= 1'b0;
                Control[2] <= 1'b0;
                Control[3] <= 1'b0;
            end
            2'b01:
            begin
                Control[0] <= 1'b0;
                Control[1] <= order;
                Control[2] <= 1'b0;
                Control[3] <= 1'b0;
            end
            2'b10:
            begin
                Control[0] <= 1'b0;
                Control[1] <= 1'b0;
                Control[2] <= order;
                Control[3] <= 1'b0;
            end
            2'b11:
                begin
                Control[0] <= 1'b0;
                Control[1] <= 1'b0;
                Control[2] <= 1'b0;
                Control[3] <= order;
            end
            default:
                Control = 2'b0000;
            endcase
        end
    end
    
endmodule
