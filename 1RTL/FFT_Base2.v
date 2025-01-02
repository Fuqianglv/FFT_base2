//copyright (c) 2024 by LFQ
//email: lvfuq@outlook.com

//********************************************************************************
//This module is FFT_BASE2 
//********************************************************************************
module FFT_BASE2#(
    parameter N=16,
    parameter DATA_WIDTH = 8
)(
    input  wire clk
);


localparam CMD_WIDTH = $clog2(N);

//define butterfly module input/output
wire [2 * DATA_WIDTH-1:0] in_a;
wire [2 * DATA_WIDTH-1:0] in_b;
wire [2 * DATA_WIDTH-1:0] w;
wire [2 * DATA_WIDTH-1:0] out_a;
wire [2 * DATA_WIDTH-1:0] out_b;
wire [2 * CMD_WIDTH-1:0] m_in;
wire [2 * CMD_WIDTH-1:0] m_out;

//define twiddlefactors module input/output
wire [CMD_WIDTH-1:0] addr;
wire [2 * DATA_WIDTH-1:0] tf_out;

//*******************************************************
//twiddlefactors module
//*******************************************************
twiddlefactors u_twiddlefactors(
    .clk    (clk    ),
    .addr   (addr   ),
    .tf_out (tf_out )
);

//*******************************************************
//buttefly module
//*******************************************************
butterfly #(
    .DATA_WIDTH(DATA_WIDTH),
    .CMD_WIDTH(CMD_WIDTH)
)u_butterfly(
    .clk   (clk   ),
    .in_a  (in_a  ),
    .in_b  (in_b  ),
    .m_in  (m_in  ),
    .w     (w     ),
    .out_a (out_a ),
    .out_b (out_b ),
    .m_out (m_out )
);


endmodule