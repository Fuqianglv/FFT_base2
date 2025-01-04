//copyright (c) 2024 by LFQ
//email: lvfuq@outlook.com

//********************************************************************************
//This module is FFT_BASE2
//********************************************************************************
module FFT_BASE2#(parameter CLK_FREQ = 100_000_000,
                  parameter RES = 256,
                  parameter N = 16,
                  parameter DATA_WIDTH = 8)
                 (input wire clk,
                  input wire enable,
                  input wire [DATA_WIDTH-1:0] i_in,
                  input wire [DATA_WIDTH-1:0] q_in);
    
    localparam BRAM_WIDTH = 10;
    localparam RATE       = CLK_FREQ>>($clog2(RES)+$clog2(N));
    localparam CMD_WIDTH  = $clog2(N);
    
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
    
    //define the downsample counter
    reg [32-1:0] downsample_counter = 0;
    reg flag_downsample             = 0;
    
    //define the bram module input/output
    reg ENA0, ENB0, WEA0, WEB0;
    reg ENA1, ENB1, WEA1, WEB1;
    reg [BRAM_WIDTH-1:0] ADDRA0, ADDRB0;
    reg [BRAM_WIDTH-1:0] ADDRA1, ADDRB1;
    reg [2*DATA_WIDTH-1:0] DIA0, DIB0;
    reg [2*DATA_WIDTH-1:0] DIA1, DIB1;
    wire [2*DATA_WIDTH-1:0] DOA0, DOB0;
    wire [2*DATA_WIDTH-1:0] DOA1, DOB1;
    
    
    //*******************************************************
    //state machine
    //*******************************************************
    //define state
    localparam IDLE = 2'd0,FFT_DATA_PADDING = 2'd1,FFT_OPERATION = 2'd2,FFT_RESULT_OUT = 2'd3;
    reg [1:0] current_state, next_state;
    
    always@(posedge clk)begin
        current_state <= next_state;
    end
    //state transition
    always@(*)begin
        case(current_state)
            IDLE:begin
                if (enable)begin
                    next_state = FFT_DATA_PADDING;
                end
            end
            FFT_DATA_PADDING:begin
                next_state = FFT_OPERATION;
            end
            FFT_OPERATION:begin
                next_state = FFT_RESULT_OUT;
            end
            FFT_RESULT_OUT:begin
                next_state = IDLE;
            end
        endcase
    end
    //state action
    always@(posedge clk)begin
        case(next_state)
            IDLE:begin
                //do nothing
            end
            FFT_DATA_PADDING:begin
                //do nothing
            end
            FFT_OPERATION:begin
                //do nothing
            end
            FFT_RESULT_OUT:begin
                //do nothing
            end
        endcase
    end
    
    //*******************************************************
    //downsampling
    //*******************************************************
    
    
    //downsample the input data
    always@(posedge clk)
    begin
        if (downsample_counter == RATE-1)
        begin
            flag_downsample    <= 1;
            downsample_counter <= downsample_counter + 1;
        end
        else
        begin
            flag_downsample    <= 0;
            downsample_counter <= downsample_counter + 1;
        end
    end
    
    //*******************************************************
    //twiddlefactors module
    //*******************************************************
    twiddlefactors u_twiddlefactors(
    .clk    (clk),
    .addr   (addr),
    .tf_out (tf_out)
    );
    
    //*******************************************************
    //buttefly module
    //*******************************************************
    butterfly #(
    .DATA_WIDTH(DATA_WIDTH),
    .CMD_WIDTH(CMD_WIDTH)
    )u_butterfly(
    .clk   (clk),
    .in_a  (in_a),
    .in_b  (in_b),
    .m_in  (m_in),
    .w     (w),
    .out_a (out_a),
    .out_b (out_b),
    .m_out (m_out)
    );
    
    //*******************************************************
    //bram module
    //*******************************************************
    
    dual_prot_ram u0_dual_prot_ram(
    .CLKA  (clk),
    .CLKB  (clk),
    .ENA   (ENA0),
    .ENB   (ENB0),
    .WEA   (WEA0),
    .WEB   (WEB0),
    .ADDRA (ADDRA0),
    .ADDRB (ADDRB0),
    .DIA   (DIA0),
    .DIB   (DIB0),
    .DOA   (DOA0),
    .DOB   (DOB0)
    );
    
    dual_prot_ram u1_dual_prot_ram(
    .CLKA  (clk),
    .CLKB  (clk),
    .ENA   (ENA1),
    .ENB   (ENB1),
    .WEA   (WEA1),
    .WEB   (WEB1),
    .ADDRA (ADDRA1),
    .ADDRB (ADDRB1),
    .DIA   (DIA1),
    .DIB   (DIB1),
    .DOA   (DOA1),
    .DOB   (DOB1)
    );
    
    
    
endmodule
