//testbench for FFT_base2 module
`timescale 1ns / 1ps
module TB();
    
    parameter DATA_WIDTH = 16;
    parameter CMD_WIDTH  = 3;
    // Inputs
    reg clk                       = 1;
    reg [2 * DATA_WIDTH-1:0] in_a = 0;
    reg [2 * DATA_WIDTH-1:0] in_b = 0;
    reg [CMD_WIDTH-1:0] m_in      = 0;
    reg [2 * DATA_WIDTH-1:0] w    = 0;
    // Outputs
    wire [2 * DATA_WIDTH-1:0] out_a;
    wire [2 * DATA_WIDTH-1:0] out_b;
    wire [CMD_WIDTH-1:0] m_out;
    
   always #5 clk = ~clk;
    
    initial begin
        in_a = 0;
        in_b = 0;
        m_in = 0;
        w    = 0;
        #0.001
        #10;
        in_a = { 16'sd16304,  -16'sd0 };
        in_b = { 16'sd6384,  -16'sd110 };
        w    = { 16'sd16384,  -16'sd0 };
        m_in = 3'b001;
        #10;
        in_a = { 16'sd1634,  -16'sd110 };
        in_b = { 16'sd1384,  -16'sd0 };
        w    = { 16'sd11585,  -16'sd11585 };
        m_in = 3'b010;
        #10;
        in_a = { 16'sd12384,  -16'sd034 };
        in_b = { 16'sd1634,  -16'sd021 };
        w    = { 16'sd15137,  -16'sd6270 };
        m_in = 3'b011;
        #10;
        in_a = { 16'sd384,  -16'sd01212 };
        in_b = { 16'sd1184,  -16'sd345 };
        w    = { -16'sd6270,  -16'sd15137 };
        m_in = 3'b100;
        #10;
        in_a = { 16'sd1184,  -16'sd139 };
        in_b = { 16'sd184,  -16'sd16384};
        w    = { -16'sd15137,  -16'sd6270 };
        m_in = 3'b101;
        #100;
        $finish;
    end

    

    wire signed [DATA_WIDTH- 1:0]in_a_re;
    wire signed [DATA_WIDTH- 1:0]in_a_im;
    wire signed [DATA_WIDTH- 1:0]in_b_re;
    wire signed [DATA_WIDTH- 1:0]in_b_im;
    wire signed [DATA_WIDTH- 1:0]w_re   ;
    wire signed [DATA_WIDTH- 1:0]w_im   ;
    wire signed [DATA_WIDTH- 1:0]out_a_re;
    wire signed [DATA_WIDTH- 1:0]out_a_im;
    wire signed [DATA_WIDTH- 1:0]out_b_re;
    wire signed [DATA_WIDTH- 1:0]out_b_im;

    assign in_a_re = in_a[DATA_WIDTH-1:0];
    assign in_a_im = in_a[2*DATA_WIDTH-1:DATA_WIDTH];
    assign in_b_re = in_b[DATA_WIDTH-1:0];
    assign in_b_im = in_b[2*DATA_WIDTH-1:DATA_WIDTH];
    assign w_re    = w[DATA_WIDTH-1:0];
    assign w_im    = w[2*DATA_WIDTH-1:DATA_WIDTH];
    assign out_a_im = out_a[DATA_WIDTH-1:0];
    assign out_a_re = out_a[2*DATA_WIDTH-1:DATA_WIDTH];
    assign out_b_im = out_b[DATA_WIDTH-1:0];
    assign out_b_re = out_b[2*DATA_WIDTH-1:DATA_WIDTH];

    
    
    butterfly #(
    .DATA_WIDTH(DATA_WIDTH),
    .CMD_WIDTH(CMD_WIDTH)
    ) u_butterfly (
    .clk(clk),
    .in_a(in_a),
    .in_b(in_b),
    .m_in(m_in),
    .w(w),
    .out_a(out_a),
    .out_b(out_b),
    .m_out(m_out)
    );
    
endmodule
