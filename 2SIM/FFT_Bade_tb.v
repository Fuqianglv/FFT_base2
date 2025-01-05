//testbench for FFT_base2 module
`timescale 1ns / 1ps

module FFT_Base2_tb();
    
    parameter DATA_WIDTH = 8;
    // Inputs
    reg clk                      = 0;
    reg enable                   = 0;
    reg [2*DATA_WIDTH-1:0] i_in  = 0;
    reg [2*DATA_WIDTH-1:0] q_in  = 0;
    reg [DATA_WIDTH-1:0] i_in_re = 0;
    reg [DATA_WIDTH-1:0] i_in_im = 0;
    reg [DATA_WIDTH-1:0] q_in_re = 0;
    reg [DATA_WIDTH-1:0] q_in_im = 0;
    
    
    always #5 clk = ~clk;
    
    integer i;
    initial begin
        #100 enable = 1;
        for(i = 0; i < 1000; i = i + 1) begin
            i_in_re = i_in_re + 1;
            i_in_im = i_in_im + 1;
            q_in_re = q_in_re + 1;
            q_in_im = q_in_im + 1;
            i_in    = {i_in_re,i_in_im};
            q_in    = {q_in_re,q_in_im};
            #10;
        end
    end
    
    FFT_Base2#(
    .CLK_FREQ(100_000_000),
    .RATE(4),
    .N(16),
    .DATA_WIDTH(8)
    )u_FFT_Base2(
    .clk    (clk),
    .enable (enable),
    .i_in   (i_in),
    .q_in   (q_in)
    );
    
endmodule
