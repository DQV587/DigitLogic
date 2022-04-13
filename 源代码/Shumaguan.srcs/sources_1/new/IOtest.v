`timescale 1ns / 1ps

module IOtest(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input enter,
    input reset,
    output [7:0] dm,
    output [3:0] wm,
    output [6:0] countdowndm,
    output [3:0] countdownwm,
    output reg success,
    output reg failure,
    output reg [3:0] stateLED
    );
    
    //ClkControl
    wire divclk;
    wire [4:0] timer;
    
    //Counter4
    wire [1:0] Numb;
    
    //Decoder
    wire [3:0] uporder;
    wire [3:0] downorder;
    
    //Counter10
    wire [3:0] A0;
    wire [3:0] A1;
    wire [3:0] A2;
    wire [3:0] A3;
    
    //ViewDecoder
    wire [6:0] dm0;
    wire [6:0] dm1;
    wire [6:0] dm2;
    wire [6:0] dm3;
    
    reg [1:0] state;
    wire unlock;
    wire enter_out;
    reg [1:0] counter;
    reg deadlock;
        //Output;
    xiaodou ENTER(enter,clk,enter_out);
    ClkControl control(reset,deadlock,clk,state,divclk,timer);
    
    Countdown counting(timer,clk,unlock,reset,deadlock,countdowndm,countdownwm);
    
    Counter4 counter4(divclk,left,right,reset,Numb);
    
    Decoder upper(Numb,up,reset,uporder);
    Decoder downer(Numb,down,reset,downorder);
    
    Counter10 count0(divclk,uporder[0],downorder[0],reset,A0);
    Counter10 count1(divclk,uporder[1],downorder[1],reset,A1);
    Counter10 count2(divclk,uporder[2],downorder[2],reset,A2);
    Counter10 count3(divclk,uporder[3],downorder[3],reset,A3);
    
    ViewDecoder LED0(A0,reset,dm0);
    ViewDecoder LED1(A1,reset,dm1);
    ViewDecoder LED2(A2,reset,dm2);
    ViewDecoder LED3(A3,reset,dm3);
    
    LEDView outer(clk,dm0,dm1,dm2,dm3,Numb,reset,dm,wm);
    
    Comparer judge(A0,A1,A2,A3,state,enter_out,clk,reset,unlock);
    
    initial begin
    stateLED<=4'b0001;
    state<=0;
    counter<=0;
    deadlock<=0;
    end
    
    always @(posedge enter_out or posedge reset or posedge deadlock or posedge timer)
    begin
        if(reset==1 || deadlock==1 || timer==10) begin
        state<=0;
        if(deadlock)
             stateLED<=4'b1111;
        else 
            stateLED<=4'b0001;
        end
        else begin
            if((state==0) && (enter_out==1))
            begin
                state <= 1;
                stateLED<=4'b0010;  
            end
            else if((state==1) && (enter_out==1))
            begin
                state <= 2;
                stateLED<=4'b0100;  
            end
            else if((state==2) && (unlock==1))
            begin
                state<=3;
                stateLED<=4'b1000;
                counter<=0;
            end
            else if((state==2) && (unlock==0))
            begin
                state<=1;
                stateLED<=4'b0010;
                counter=counter+1;
            end
        end
    end
    always @(posedge clk)
    begin
        if(counter==3) begin
           deadlock<=1;
           end   
    end    
    always @(unlock or reset or clk)
    begin
        if(reset==1)
        begin
            success <= 0;
            failure <= 0;
        end
        else
        begin
            if(unlock==0)
            begin
                success <= 0;
                failure <= 1;
            end
            else
            begin
                success <= 1;
                failure <= 0;
            end
        end
    end

endmodule
