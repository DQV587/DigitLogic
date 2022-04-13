`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 18:00:01
// Design Name: 
// Module Name: sim_Counter4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_Counter4(

    );
    reg clk,left,right;
    wire [1:0] Numb;
    
    Counter4 mycounter4(clk,left,right,Numb);
    
    initial
    begin
        clk = 0; left = 0; right = 0;
    end
    
    always #7.5 clk <= ~clk;
    
    always
    begin
        #15 left <= 1;right <= 0;
        #15 left <= 1;right <= 0;
        #15 left <= 1;right <= 0;
        #15 left <= 1;right <= 0;
        #15 right <= 1;left <= 0;
        #15 right <= 1;left <= 0;
        #15 right <= 1;left <= 0;
        #15 right <= 1;left <= 0;
    end
    
endmodule
