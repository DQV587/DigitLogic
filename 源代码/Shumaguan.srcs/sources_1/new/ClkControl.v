`timescale 1ns / 1ps
//输出分频后时钟和时间
module ClkControl(
    input reset,
    input deadlock,
    input clk,
    input [1:0] state,
    output reg divclk,
    output reg [4:0] timer
    );
    reg [30:0] div_cnt0 = 0;
    reg [30:0] div_cnt1 = 0;
    
    parameter maxcnt = 5000000;
    parameter maxcount = 100000000;
    initial begin
    timer<=0;
    divclk<=0;
    end
    //分频
    always @(posedge clk or posedge reset)
    begin
        if(reset==1 || deadlock==1 || state==0)
        begin
            divclk <= 0;
            div_cnt0 <= 0;
        end
        else
        begin
            if((timer<10) && (state%2==1))
            begin
                if(div_cnt0 == maxcnt)  
                begin
                    divclk  = ~divclk;
                    div_cnt0 = 0;
                end
                else    
                begin 
                    div_cnt0 = div_cnt0 +1'b1;     
                end
            end
            else
                divclk = 0;
        end
    end
    
    always @(posedge clk or posedge reset)
    begin
        if(reset==1 || deadlock==1 || state==0)
        begin
            div_cnt1 <= 0;
            timer <= 0;
        end
        else if((timer < 10) && (state==1))
        begin
            if(div_cnt1 == maxcount)
            begin
                timer <= timer + 1;
                div_cnt1 <= 0;
            end
            else
                div_cnt1 <= div_cnt1 + 1;
        end
     end
    
endmodule
