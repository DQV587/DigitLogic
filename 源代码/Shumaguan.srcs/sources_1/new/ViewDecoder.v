`timescale 1ns / 1ps
//将输入数字译码为七段数码管上显示设置
module ViewDecoder(
    input [3:0] Numb,
    input reset,
    output reg [6:0] View
    );   
    always@(*)
    begin
        if(reset==1)
            begin
                View = 0;
            end
        else
        begin
            case(Numb)
            4'b0000:
                View = 7'b1111110;
            4'b0001:
                View = 7'b0110000;
            4'b0010:
                View = 7'b1101101;
            4'b0011:
                View = 7'b1111001;
            4'b0100:
                View = 7'b0110011;
            4'b0101:
                View = 7'b1011011;
            4'b0110:
                View = 7'b1011111;
            4'b0111:
                View = 7'b1110000;
            4'b1000:
                View = 7'b1111111;
            4'b1001:
                View = 7'b1111011;
            default:
                View = 7'b1111111;
            endcase
        end
    end

endmodule
