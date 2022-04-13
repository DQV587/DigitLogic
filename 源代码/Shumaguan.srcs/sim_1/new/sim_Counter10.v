`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 17:16:50
// Design Name: 
// Module Name: sim_Counter10
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


module sim_Counter10();

    reg clk,up,down;
    wire [3:0] Numb;
    
    Counter10 my(clk,up,down,Numb);
    
    initial
    begin
        clk = 0; up = 0; down = 0;
    end
    
    always #7.5 clk <= ~clk;
    
    always
    begin
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 up <= 1;down <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
        #15 down <= 1;up <= 0;
    end

endmodule
