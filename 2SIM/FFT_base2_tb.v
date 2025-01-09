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
    
    // Outputs
    wire out_fft_data_flag;
    wire [2*DATA_WIDTH-1:0] out_fft_data;
    
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
    
    reg [31:0] counter = 0;
    
    always @(posedge clk) begin
        if (out_fft_data_flag)
            counter <= counter + 1;
        
        else
        counter <= 0;
    end
    
    wire [DATA_WIDTH-1:0] out_re;
    wire [DATA_WIDTH-1:0] out_im;
    assign out_re = out_fft_data[2*DATA_WIDTH-1:DATA_WIDTH];
    assign out_im = out_fft_data[DATA_WIDTH-1:0];
    
    FFT_Base2#(
    .CLK_FREQ(100_000_000),
    .RATE(4),
    .N(128),
    .DATA_WIDTH(8)
    )u_FFT_Base2(
    .clk               (clk),
    .enable            (enable),
    .i_in              (i_in),
    .q_in              (q_in),
    .out_fft_data_flag (out_fft_data_flag),
    .out_fft_data      (out_fft_data)
    );
    
endmodule
