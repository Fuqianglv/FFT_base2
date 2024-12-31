//testbench for FFT_base2 module
`timescale 1ns / 1ps
module TB();
    
    parameter DATA_WIDTH = 16;
    parameter CMD_WIDTH  = 3;
    // Inputs
    reg clk                       = 0;
    reg [2 * DATA_WIDTH-1:0] in_a = 0;
    reg [2 * DATA_WIDTH-1:0] in_b = 0;
    reg [CMD_WIDTH-1:0] m_in      = 0;
    reg [2 * DATA_WIDTH-1:0] w    = 0;
    // Outputs
    wire [2 * DATA_WIDTH-1:0] out_a;
    wire [2 * DATA_WIDTH-1:0] out_b;
    wire [CMD_WIDTH-1:0] m_out;
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        in_a = 0;
        in_b = 0;
        m_in = 0;
        w    = 0;
        #10;
        in_a = { 16'sd16384,  -16'sd0 };
        in_b = { 16'sd16384,  -16'sd110 };
        w    = { 16'sd16384,  -16'sd0 };
        m_in = 3'b001;
        #10;
        in_a = { 16'sd16384,  -16'sd110 };
        in_b = { 16'sd16384,  -16'sd0 };
        w    = { 16'sd11585,  -16'sd11585 };
        m_in = 3'b010;
        #10;
        in_a = { 16'sd16384,  -16'sd034 };
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
        #10;
        $finish;
    end
    
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
