//copyright (c) 2024 by LFQ
//email: lvfuq@outlook.com

//********************************************************************************
//This module is used to calculate the butterfly operation in FFT
//The input is in_a, in_b, w, m_in
//The output is out_a, out_b, m_out
//The butterfly operation is as follows:
//out_a = in_a + w * in_b
//out_b = in_a - w * in_b
//m_out = m_in
//All the data is scaled by shifting left by DATA_WIDTH - 2 bits
//********************************************************************************


module butterfly #(parameter DATA_WIDTH = 8,
                   parameter CMD_WIDTH = 3)
                  (input wire clk,
                   input wire [2 * DATA_WIDTH-1:0] in_a,
                   input wire [2 * DATA_WIDTH-1:0] in_b,
                   input wire [CMD_WIDTH-1:0] m_in,           //sync output address
                   input wire [2 * DATA_WIDTH-1:0] w,         //twiddle factor
                   output reg [2 * DATA_WIDTH-1:0] out_a = 0,
                   output reg [2 * DATA_WIDTH-1:0] out_b = 0,
                   output reg [CMD_WIDTH-1:0] m_out = 0);     //sync output address
    //define input re/im and twiddle re/im
    wire signed [DATA_WIDTH- 1:0]in_a_re = 0;
    wire signed [DATA_WIDTH- 1:0]in_a_im = 0;
    wire signed [DATA_WIDTH- 1:0]in_b_re = 0;
    wire signed [DATA_WIDTH- 1:0]in_b_im = 0;
    wire signed [DATA_WIDTH- 1:0]w_re    = 0;
    wire signed [DATA_WIDTH- 1:0]w_im    = 0;
    //assign input re/im and twiddle factor re/im
    assign in_a_re = in_a[DATA_WIDTH-1:0];
    assign in_a_im = in_a[2*DATA_WIDTH-1:DATA_WIDTH];
    assign in_b_re = in_b[DATA_WIDTH-1:0];
    assign in_b_im = in_b[2*DATA_WIDTH-1:DATA_WIDTH];
    assign w_re    = w[DATA_WIDTH-1:0];
    assign w_im    = w[2*DATA_WIDTH-1:DATA_WIDTH];
    
    //*******************************************************
    //save the twiddle factor * in_b
    //*******************************************************
    reg signed [DATA_WIDTH-1:0] w_in_b_re  = 0;
    reg signed [DATA_WIDTH-1:0] w_in_b_im  = 0;
    reg signed [DATA_WIDTH-1:0] w_in_b_re1 = 0;
    reg signed [DATA_WIDTH-1:0] w_in_b_im1 = 0;
    reg signed [DATA_WIDTH-1:0] w_in_b_re2 = 0;
    reg signed [DATA_WIDTH-1:0] w_in_b_im2 = 0;
    
    always@(posedge clk)
    begin
        w_in_b_re1 <= w_re * in_b_re >>> (DATA_WIDTH - 2);
        w_in_b_im1 <= w_re * in_b_im >>> (DATA_WIDTH - 2);
        w_in_b_re2 <= w_im * in_b_im >>> (DATA_WIDTH - 2); //-w_im * in_b_im;
        w_in_b_im2 <= w_im * in_b_re >>> (DATA_WIDTH - 2);//w_im * in_b_re;
        
        w_in_b_re <= w_in_b_re1 - w_in_b_re2;
        w_in_b_im <= w_in_b_im1 + w_in_b_im2;
    end
    
    //*******************************************************
    //calculate the butterfly operation
    //*******************************************************
    always@(posedge clk)
    begin
        out_a[DATA_WIDTH - 1 : 0]              <= (in_a_im + w_in_b_im) >>> 1;
        out_a[2 * DATA_WIDTH - 1 : DATA_WIDTH] <= (in_a_re + w_in_b_re) >>> 1;
        out_b[DATA_WIDTH - 1 : 0]              <= (in_a_im - w_in_b_im) >>> 1;
        out_b[2 * DATA_WIDTH - 1 : DATA_WIDTH] <= (in_a_re - w_in_b_re) >>> 1;
    end
    
    //*******************************************************
    //output the sync address
    //*******************************************************
    reg [CMD_WIDTH-1:0] m_in_1 = 0;
    reg [CMD_WIDTH-1:0] m_in_2 = 0;
    reg [CMD_WIDTH-1:0] m_in_3 = 0;
    always@(posedge clk)
    begin
        m_in_1 <= m_in;
        m_in_2 <= m_in_1;
        m_in_3 <= m_in_2;
        m_out <= m_in_3;
    end
endmodule
