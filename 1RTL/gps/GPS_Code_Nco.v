`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/21 21:28:53
// Design Name:
// Module Name: GPS_Code_Nco
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


module GPS_Code_Nco(clk,
                    rst,
                    send_en,
                    f_control,
                    phase_init,
                    enable,
                    acc_sum);
    input clk, rst,send_en;
    input [61:0] f_control;
    input [62:0] phase_init;
    output enable;
    output reg [63:0] acc_sum;
    
    always @ (posedge clk)
     begin
     if (!rst) 
     begin
        acc_sum         <= phase_init;
     end
    
     else if (send_en) acc_sum <= acc_sum[62:0]+ f_control;
     end

    assign enable  = acc_sum[63];
    
    
endmodule
