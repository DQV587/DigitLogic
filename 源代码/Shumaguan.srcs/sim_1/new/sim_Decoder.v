`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/09 18:25:28
// Design Name: 
// Module Name: sim_Decoder
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


module sim_Decoder(

    );
    reg [1:0] Location;
    reg order;
    wire [3:0] Control;
    
    Decoder my(Location,order,Control);
    
    initial
    begin
        Location = 0;
        order = 0;
    end
    
    always
    begin
        #10 Location = 0;order = 1;
        #10 Location = 1;order = 1;
        #10 Location = 2;order = 1;
        #10 Location = 3;order = 1;
        #10 Location = 0;order = 0;
        #10 Location = 1;order = 0;
        #10 Location = 2;order = 0;
        #10 Location = 3;order = 0;
    end
    
endmodule
