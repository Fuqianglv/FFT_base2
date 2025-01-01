`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/23 10:26:16
// Design Name:
// Module Name: GPS_Navi_Gen
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


module GPS_Navi_Gen(clk,
                    rst,
                    send_en,
                    message1,
                    message2,
                    message3,
                    message4,
                    message5,
                    navidata,
                    address_init,
                    shut_time6s_sign,
                    enable,
                    address,
                    time6s_sign);
    
    input clk,rst,send_en;
    input [63:0]   message1;
    input [63:0]   message2;
    input [63:0]   message3;
    input [63:0]   message4;
    input [63:0]   message5;
    input [8:0] address_init;
    input shut_time6s_sign;
    output navidata;
    
    output reg [8:0] address;
    output reg time6s_sign;
    
    input enable;
    wire [0:29] word1,word2,word3,word4,word5;
    wire [0:29] word6,word7,word8,word9,word10;
    
    assign word1[0:29]  = message1[29: 0];
    assign word2[0:29]  = message1[61:32];
    assign word3[0:29]  = message2[29: 0];
    assign word4[0:29]  = message2[61:32];
    assign word5[0:29]  = message3[29: 0];
    assign word6[0:29]  = message3[61:32];
    assign word7[0:29]  = message4[29: 0];
    assign word8[0:29]  = message4[61:32];
    assign word9[0:29]  = message5[29: 0];
    assign word10[0:29] = message5[61:32];
    
    reg [0:299] navimessage;
    always@(posedge clk)
        if (!rst)
        begin
            address <= address_init;
        end
        else if (send_en&&enable)
        begin
            if (address == 299)
            begin
                address <= 0;
            end
            else
            begin
                address <= address+1;
            end
        end
        else
        begin
            address <= address;
        end
    
    always @(posedge clk) begin
        if (!rst)
        begin
            navimessage[0:299] <= {word1[0:29],word2[0:29],word3[0:29],word4[0:29],word5[0:29],word6[0:29],word7[0:29],word8[0:29],word9[0:29],word10[0:29]};
        end
        else if (send_en&&(address == 299)&&enable)
        begin
            navimessage[0:299] <= {word1[0:29],word2[0:29],word3[0:29],word4[0:29],word5[0:29],word6[0:29],word7[0:29],word8[0:29],word9[0:29],word10[0:29]};
        end
        else
        begin
            navimessage <= navimessage;
        end
    end
    
    assign	navidata = navimessage[address];
    
    always @(posedge clk)
        if (!rst)
        begin
            time6s_sign <= 1'b0;
        end
        else if (send_en&&enable&&address == 299)
        begin
            time6s_sign <= 1;
        end
        else if (shut_time6s_sign)
        begin
            time6s_sign <= 1'b0;
        end
        else
        begin
            time6s_sign <= time6s_sign;
        end
endmodule
    
