`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/22 22:02:19
// Design Name:
// Module Name: Signa_Gen
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


module Signa_Gen(clk,
                 rst,
                 send_en,
                 sv_num,
                 fcarr_control,
                 fcode_control,
                 phase_init_carrier,
                 phase_init_code,
                 phase_init_navidata,
                 address_init_navidata,
                 code_cnt_init,
                 message1,
                 message2,
                 message3,
                 message4,
                 message5,
                 shut_time6s_sign,
                 signal_sin,
                 signal_cos,
                 acc_sum_carrier,
                 acc_sum_code,
                 acc_sum_navidata,
                 address_navidata,
                 code_cnt,
                 time6s_sign,
                 code,
                 phase_key);
    input clk,rst,send_en;
    input [5:0] sv_num;
    input [61:0] fcarr_control;
    input [61:0] fcode_control;
    input [62:0] phase_init_carrier;
    input [62:0] phase_init_code;
    input [14:0] phase_init_navidata;
    input [8:0] address_init_navidata;
    input [9:0] code_cnt_init;
    input [63:0]   message1;
    input [63:0]   message2;
    input [63:0]   message3;
    input [63:0]   message4;
    input [63:0]   message5;
    input shut_time6s_sign;
    
    output reg [11:0] signal_sin;
    output reg [11:0] signal_cos;
    output [63:0] acc_sum_carrier;
    output [63:0] acc_sum_code;
    output [14:0] acc_sum_navidata;
    output [8:0] address_navidata;
    output [9:0] code_cnt;
    output time6s_sign;
    
    wire [11:0] carrierWave_sin;
    wire [11:0] carrierWave_cos;
    output code;
    wire navidata;
    wire code_enable;
    output wire  [3:0] phase_key;
    
    always @(posedge clk or negedge rst)
        if (!rst)
        begin
            signal_sin <= 12'b000000000000;
            signal_cos <= 12'b000000000000;
        end
        else
        begin
            if (sv_num!= 0)
            begin
                if (code^navidata)
                begin
                    signal_sin <= ~carrierWave_sin+12'b000000000001;
                    signal_cos <= ~carrierWave_cos+12'b000000000001;
                end
                else
                begin
                    signal_sin <= carrierWave_sin;
                    signal_cos <= carrierWave_cos;
                end
            end
            else
            begin
                signal_sin <= 12'b000000000000;
                signal_cos <= 12'b000000000000;
            end
        end


    GPS_Carr_Nco  u_GPS_Carr_Nco (
    .clk                     (clk),
    .rst                     (rst),
    .f_control               (fcarr_control),
    .phase_init              (phase_init_carrier),
    .send_en                 (send_en),
    .enable                  (code_enable),
    
    .phase                   (phase_key),
    .acc_sum                 (acc_sum_carrier)
    );
    GPS_Carr_Gen  u_GPS_Carr_Gen (
    .clk                     (clk),
    .rst                     (rst),
    .send_en                 (send_en),
    .phase                   (phase_key),
    
    .carrierWave_sin         (carrierWave_sin),
    .carrierWave_cos         (carrierWave_cos)
    );
    
    GPS_Code_Nco  u_GPS_Code_Nco (
    .clk                     (clk),
    .rst                     (rst),
    .f_control               (fcode_control),
    .phase_init              (phase_init_code),
    .send_en                 (send_en),
    
    .enable                  (code_enable),
    .acc_sum                 (acc_sum_code)
    );
    GPS_Code_Gen  u_GPS_Code_Gen (
    .clk                     (clk),
    .rst                     (rst),
    .send_en                 (send_en),
    .enable                  (code_enable),
    .sv_num                  (sv_num),
    .code_cnt_init           (code_cnt_init),
    
    .code                    (code),
    .code_cnt                (code_cnt)
    );
    
    GPS_Navi_Nco  u_GPS_Navi_Nco (
    .clk                     (clk),
    .rst                     (rst),
    .send_en                 (send_en),
    .enable                  (code_enable),
    .phase_init              (phase_init_navidata),
    
    .navi_enable             (navi_enable),
    .cnt                     (acc_sum_navidata)
    );
    GPS_Navi_Gen  u_GPS_Navi_Gen (
    .clk                     (clk),
    .rst                     (rst),
    .send_en                 (send_en),
    .enable                  (navi_enable),
    .message1                (message1),
    .message2                (message2),
    .message3                (message3),
    .message4                (message4),
    .message5                (message5),
    .address_init            (address_init_navidata),
    .shut_time6s_sign        (shut_time6s_sign),
    
    .navidata                (navidata),
    .address                 (address_navidata),
    .time6s_sign             (time6s_sign)
    );
endmodule
