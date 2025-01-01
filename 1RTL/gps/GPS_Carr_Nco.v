`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/22 17:38:11
// Design Name:
// Module Name: GPS_Carr_Nco
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


module GPS_Carr_Nco(clk,
                    rst,
                    send_en,
                    enable,
                    f_control,
                    phase_init,
                    phase,
                    acc_sum);
    input clk, rst,send_en,enable;
    input [61:0] f_control;
    input [62:0] phase_init;
    
    output [3:0] phase;
    output reg [63:0] acc_sum;
    
    always @ (posedge clk)
    begin
        if (!rst) acc_sum             <= phase_init;
        else if (send_en) acc_sum <= acc_sum[62:0]+ f_control;
    end
    assign phase   = acc_sum[62:59];
    
endmodule
