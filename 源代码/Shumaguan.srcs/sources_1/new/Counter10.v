`timescale 1ns / 1ps
//�������¼�ѡ��������ֵ
module Counter10(
    input clk,
    input up,
    input down,
    input reset,
    output reg [3:0] Numb
    );   
    initial
    begin
        Numb <= 0;
    end
    
    always@(posedge clk or posedge reset)
    begin
        if(reset==1)
        begin
            Numb <= 0;
        end
        else 
        begin
            if(up==1)
            begin
                if(Numb==9)
                    Numb <= 0;
                else
                    Numb <= Numb + 1;
            end
        
            if(down==1)
            begin
                if(Numb==0)
                    Numb <= 9;
                else
                    Numb <= Numb - 1;
            end  
        end
    end
endmodule
