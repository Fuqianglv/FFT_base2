`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/23 10:27:55
// Design Name:
// Module Name: GPS_Navi_Nco
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


module GPS_Navi_Nco(clk,
                    rst,
                    send_en,
                    enable,
                    phase_init,
                    navi_enable,
                    cnt);
    input clk, rst,send_en,enable;
    input [14:0] phase_init;
    output reg navi_enable;
    
    output reg [14:0] cnt;
    
    always@(posedge clk or negedge rst)
        if (!rst)
        begin
            cnt         <= phase_init;
            navi_enable <= 1'b0;
        end
        else if (send_en&&enable)
        begin
            if (cnt == 15'd20459)
            begin
                cnt         <= 15'd0;
                navi_enable <= 1'b1;
            end
            else
            begin
                cnt <= cnt+1;
            end
        end
        else
        begin
            navi_enable <= 1'b0;
        end
    
endmodule
