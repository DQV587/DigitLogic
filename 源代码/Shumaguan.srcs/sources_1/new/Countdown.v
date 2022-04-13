`timescale 1ns / 1ps
//根据计时来操控数码管显示时间
module Countdown(
    input [4:0] Numb,
    input clk,
    input unlock,
    input reset,
    input deadlock,
    output reg [6:0] dm,
    output reg [3:0] wm
    );   
    reg [3:0] A0 = 0;
    reg [3:0] A1 = 0;
    wire [6:0] B0;
    wire [6:0] B1;
    
    reg [14:0] div_cnt = 0; 
    reg divclk = 0;
    reg [1:0] dis_bit = 0;

    parameter  maxcnt=25000;

    always @(posedge clk or posedge reset)//分频
    begin
        if(reset==1)
        begin
            div_cnt = 0; 
            divclk = 0;
        end
        else 
        begin
            if(div_cnt  == maxcnt)  
            begin
                divclk  = ~divclk;
                div_cnt = 0;
            end
            else    
            begin 
                div_cnt = div_cnt +1'b1;
            end
        end
     end
     
     always@(posedge divclk or posedge reset)
     begin
        if(reset==1)
        begin
            A0 <= 0;
            A1 <= 0;
        end
        else
        begin
            A0 <= (10 - Numb) % 10;
            A1 <= (10 - Numb) / 10;
        end
     end
     
     ViewDecoder Decoder0(A0,reset,B0);
     ViewDecoder Decoder1(A1,reset,B1);
     
     always@(posedge divclk or posedge reset)
     begin
        if(reset==1)
        begin
            wm <= 0;
            dm <= 0;
            dis_bit <= 0;
        end
        else
        begin
            if(dis_bit >= 3)
                dis_bit = 0;
            else
                dis_bit = dis_bit + 1;
      
            case(dis_bit)
                2'b00:
                begin
                    wm <= 4'b0100;
                    if(deadlock)
                    dm<=7'b1001111;
                    else
                    dm <= B0;
                end
                2'b01:
                begin
                    wm <= 4'b1000;
                    if(deadlock)
                    dm<=7'b0111101;
                    else
                    dm <= B1;
                end
                2'b10:
                begin
                    wm<=4'b0010;
                    if(unlock)
                        dm<=7'b1111110;
                    else if(deadlock)
                        dm<=7'b1110111;
                    else
                        dm<=7'b0001110;
                end
                2'b11:
                begin
                    wm<=4'b0001;
                    if(unlock) 
                        dm<=7'b1100111;
                    else if(deadlock)
                        dm<=7'b0111101;
                    else
                        dm<=7'b1001110;
                end
                default:
                begin
                    wm <= 4'b0000;
                    dm <= 0;
                end
            endcase
        end
     end
   
endmodule
