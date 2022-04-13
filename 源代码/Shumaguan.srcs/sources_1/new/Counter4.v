`timescale 1ns / 1ps
//¿ØÖÆ×óÓÒ¼üÑ¡ÔñÃÜÂëÎ»
module Counter4(
    input clk,
    input left,
    input right,
    input reset,
    output reg [1:0] Numb
    );   
    initial
    begin
        Numb <= 2'b00;
    end
    
    always@(posedge clk or posedge reset)
    begin
        if(reset==1)
        begin
            Numb <= 2'b00;
        end
        else
        begin
            if(left==1)
            begin
                if(Numb==3)
                    Numb <= 0;
                else
                    Numb <= Numb + 1;
            end
        
            if(right==1)
            begin
                if(Numb==0)
                    Numb <= 3;
                else
                    Numb <= Numb - 1;
            end
        end
    end
    
endmodule
