`timescale 1ns / 1ps
//¿ØÖÆÊäÈëÃÜÂëÏÔÊ¾
module LEDView(
    input clk,
    input [6:0] A0,
    input [6:0] A1,
    input [6:0] A2,
    input [6:0] A3,
    input [1:0] Numb,
    input reset,
    output  [7:0] dm,
    output  [3:0] wm
    );
    
    reg [7:0] dm = 0;
    reg [3:0] wm = 4'b0001;
    reg [14:0] div_cnt = 0; 
    reg divclk = 0;
    reg [1:0] disp_bit = 0;

    parameter  maxcnt=25000;

    always @(posedge clk or posedge reset)//·ÖÆµ
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
            dm = 0;
            wm = 4'b0001;
            disp_bit = 0;
        end
        else
        begin
            if(disp_bit >= 3)
                disp_bit = 0;
            else
                disp_bit = disp_bit + 1;
            case(disp_bit)
                2'b00:
                begin
                    wm <= 4'b0001;
                    if(Numb==2'b00)
                        dm <= {1'b1,A0};
                    else
                        dm <= {1'b0,A0};
                end
                2'b01:
                begin
                    wm <= 4'b0010;
                    if(Numb==2'b01)
                        dm <= {1'b1,A1};
                    else
                        dm <= {1'b0,A1};
                end
                2'b10:
                begin
                    wm <= 4'b0100;
                    if(Numb==2'b10)
                        dm <= {1'b1,A2};
                    else
                        dm <= {1'b0,A2};
                end
                2'b11:
                begin
                    wm <= 4'b1000;
                    if(Numb==2'b11)
                        dm <= {1'b1,A3};
                    else
                        dm <= {1'b0,A3};
                end
            endcase
        end
    end
    
endmodule
