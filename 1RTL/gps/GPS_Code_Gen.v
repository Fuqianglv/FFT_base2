`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/15 16:38:29
// Design Name:
// Module Name: GPS_Code_Gen
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


module GPS_Code_Gen(clk,
                    rst,
                    send_en,
                    enable,
                    sv_num,
                    code_cnt_init,
                    code,
                    code_cnt);
    input clk,rst,send_en,enable;
    input [5:0] sv_num;
    input [9:0] code_cnt_init;
    output reg [9:0] code_cnt;
    output reg code;
    
    reg [9:0] g1;
    reg g1_q;
    reg [9:0] g2;
    reg g2_q;
    wire [9:0] PrnCode [0:37];
    assign PrnCode[0]  = 10'h0;
    assign PrnCode[1]  = 10'h3ec;
    assign PrnCode[2]  = 10'h3d8;
    assign PrnCode[3]  = 10'h3b0;
    assign PrnCode[4]  = 10'h04b;
    assign PrnCode[5]  = 10'h096;
    assign PrnCode[6]  = 10'h2cb;
    assign PrnCode[7]  = 10'h196;
    assign PrnCode[8]  = 10'h32c;
    assign PrnCode[9]  = 10'h3ba;
    assign PrnCode[10] = 10'h374;
    assign PrnCode[11] = 10'h1d0;
    assign PrnCode[12] = 10'h3a0;
    assign PrnCode[13] = 10'h340;
    assign PrnCode[14] = 10'h280;
    assign PrnCode[15] = 10'h100;
    assign PrnCode[16] = 10'h113;
    assign PrnCode[17] = 10'h226;
    assign PrnCode[18] = 10'h04c;
    assign PrnCode[19] = 10'h098;
    assign PrnCode[20] = 10'h130;
    assign PrnCode[21] = 10'h260;
    assign PrnCode[22] = 10'h267;
    assign PrnCode[23] = 10'h338;
    assign PrnCode[24] = 10'h270;
    assign PrnCode[25] = 10'h0e0;
    assign PrnCode[26] = 10'h1c0;
    assign PrnCode[27] = 10'h380;
    assign PrnCode[28] = 10'h22b;
    assign PrnCode[29] = 10'h056;
    assign PrnCode[30] = 10'h0ac;
    assign PrnCode[31] = 10'h158;
    assign PrnCode[32] = 10'h058;
    assign PrnCode[33] = 10'h160;
    assign PrnCode[34] = 10'hb0;
    assign PrnCode[35] = 10'h316;
    assign PrnCode[36] = 10'h22c;
    assign PrnCode[37] = 10'hb0;
    
    reg [10:0] cnt;
    always @(posedge clk) begin
        if (!rst)begin
            cnt <= 0;
        end
        else if (cnt < 11'd1024)
        begin
            cnt <= cnt+1'b1;
        end
        else
            cnt <= cnt;
    end
    
    always @ (posedge clk)
        if (!rst)
        begin
            g1_q <= 0;
            g1   <= 10'b1111111111;
        end
        else if (cnt < 11'd1024)
        begin
            g1_q <= g1[0];
            g1   <= {(g1[7] ^ g1[0]), g1[9:1]};
        end
        else
            g1_q <= g1_q ;
    
    always @ (posedge clk)
        if (!rst)
        begin
            g2_q <= 0;
            g2   <= PrnCode[sv_num];
        end
        else if (cnt < 11'd1024)//send_en&&enable
        begin
            g2_q <= g2[0];
            g2   <= {(g2[8] ^ g2[7] ^ g2[4] ^ g2[2] ^ g2[1] ^ g2[0]), g2[9:1]};
        end
        else
            g2_q <= g2_q;
    
    reg [1022:0] code_reg;
    always @(posedge clk)
        if (!rst)
        begin
            code_reg <= 0;
        end
        else if (cnt < 11'd1024)
        begin
            code_reg <= {(g1_q ^ g2_q),code_reg[1022:1] };
        end
        else
            code_reg <= code_reg;
    
    
    always @(posedge clk)
        if (!rst)
        begin
            code_cnt <= code_cnt_init;
        end
        else if (send_en&&enable&&code_cnt == 10'd1022)
            code_cnt <= 0;
        else if (send_en&&enable)
        begin
            code_cnt <= code_cnt+1'b1;
        end
        else
            code_cnt <= code_cnt;
    
    always@(posedge clk or negedge rst)
        if (!rst)
        begin
            code <= 1'b0;
        end
        else if (send_en)
        begin
            code <= code_reg[code_cnt];
        end
        else
            code <= code;
    
endmodule
