`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/22 12:40:10
// Design Name:
// Module Name: GPS_Carr_Gen
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


module GPS_Carr_Gen(clk,
                    rst,
                    send_en,
                    phase,
                    carrierWave_sin,
                    carrierWave_cos);
    input clk,rst,send_en;
    input [3:0] phase;
    output reg [11:0] carrierWave_sin;
    output reg [11:0] carrierWave_cos;
    reg [11:0] carrierWave_sin_d2;
    reg [11:0] carrierWave_cos_d2;
    
    always@(posedge clk or negedge rst)
        if (!rst)
        begin
            carrierWave_sin <= 12'd0;
            carrierWave_cos <= 12'd0;
        end
        else
        begin
            if (send_en)
            //    [0    1    2    3    4    5     6    7     8    9     10    11    12    13    14    15]
            //    [0    22.5 45   67.5 90   112.5 135  157.5 180  202.5 225   247.5 270   292.5 315   337.5]
            //sin [0    783  1447 1891 2047 1891  1447 783   0   -783  -1447 -1891 -2047 -1891 -1447 -783]
            //cos [2047 1891 1447 783  0   -783  -1447-1891 -2047-1891 -1447 -783   0     783   1447  1891]

            //    [0    1    2    3    4    5     6    7     8    9     10    11    12    13    14    15]
            //    [0    45   45   90   90   135   135  180   180  225   225   270   270   315   315   360]
            //sin [0    1447 1447 2047 2047 1447  1447 0     0   -1447 -1447 -2047 -2047 -1447 -1447 -783]
            //cos [2047 1447 1447 0    0   -1447 -1447-2047 -2047-1447 -1447 -0     0     1447  1447  1447]
                case(phase)
                    0:begin
                        carrierWave_sin <= 12'd0;
                        carrierWave_cos <= 12'd2047;
                    end
                    1:begin
                        carrierWave_sin <= 12'd1447;
                        carrierWave_cos <= 12'd1447;
                    end
                    2:begin
                        carrierWave_sin <= 12'd1447;
                        carrierWave_cos <= 12'd1447;
                    end
                    3:begin
                        carrierWave_sin <= 12'd2047;
                        carrierWave_cos <= 12'd0;
                    end
                    4:begin
                        carrierWave_sin <= 12'd2047;
                        carrierWave_cos <= 12'd0;
                    end
                    5:begin
                        carrierWave_sin <= 12'd1447;
                        carrierWave_cos <= 12'd2649;
                    end
                    6:begin
                        carrierWave_sin <= 12'd1447;
                        carrierWave_cos <= 12'd2649;
                    end
                    7:begin
                        carrierWave_sin <= 12'd0;
                        carrierWave_cos <= 12'd2049;
                    end
                    8:begin
                        carrierWave_sin <= 12'd0;
                        carrierWave_cos <= 12'd2049;
                    end
                    9:begin
                        carrierWave_sin <= 12'd2649;
                        carrierWave_cos <= 12'd2649;
                    end
                    10:begin
                        carrierWave_sin <= 12'd2649;
                        carrierWave_cos <= 12'd2649;
                    end
                    11:begin
                        carrierWave_sin <= 12'd2049;
                        carrierWave_cos <= 12'd0;
                    end
                    12:begin
                        carrierWave_sin <= 12'd2049;
                        carrierWave_cos <= 12'd0;
                    end
                    13:begin
                        carrierWave_sin <= 12'd2649;
                        carrierWave_cos <= 12'd1447;
                    end
                    14:begin
                        carrierWave_sin <= 12'd2649;
                        carrierWave_cos <= 12'd1447;
                    end
                    15:begin
                        carrierWave_sin <= 12'd0;
                        carrierWave_cos <= 12'd2047;
                    end
                endcase
                end
                endmodule
