//testbench for FFT_base2 module
`timescale 1ns / 1ps

module FFT_Base2_tb();
    
    parameter DATA_WIDTH = 8;
    // Inputs
    reg clk                   = 0;
    reg enable                = 0;
    reg [DATA_WIDTH-1:0] i_in = 0;
    reg [DATA_WIDTH-1:0] q_in = 0;
    reg [15:0] temp_array [0:999];
    
    integer i;
    initial begin
        $readmemb("E:/LFQ/FFT/6TOOL/data_before_fft.txt", temp_array);
        #100 enable = 1;
        for(i = 0; i < 1000; i = i + 1) begin
            i_in = temp_array[i][2*DATA_WIDTH-1:DATA_WIDTH];
            q_in = temp_array[i][DATA_WIDTH-1:0];
            #10;
        end
    end
    // ...existing code...
    
    always #5 clk = ~clk;
    
    
    FFT_Base2#(
    .CLK_FREQ(100_000_000),
    .RATE(4),
    .N(8),
    .DATA_WIDTH(8)
    )u_FFT_Base2(
    .clk    (clk),
    .enable (enable),
    .i_in   (i_in),
    .q_in   (q_in)
    );
    
endmodule
