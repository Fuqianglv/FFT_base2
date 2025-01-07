//copyright (c) 2024 by LFQ
//email: lvfuq@outlook.com

//********************************************************************************
//This module is FFT_BASE2
//********************************************************************************
module FFT_Base2#(parameter CLK_FREQ = 100_000_000,
                  parameter RATE = 4,
                  parameter N = 64,
                  parameter DATA_WIDTH = 8)
                 (input wire clk,
                  input wire enable,
                  input wire [DATA_WIDTH-1:0] i_in,
                  input wire [DATA_WIDTH-1:0] q_in);
    
    localparam BRAM_WIDTH = 10;
    localparam ADDR_WIDTH = $clog2(N);
    
    //define butterfly module input/output
    reg [2 * DATA_WIDTH-1:0] in_a;
    reg [2 * DATA_WIDTH-1:0] in_b;
    wire [2 * DATA_WIDTH-1:0] w;
    wire [2 * DATA_WIDTH-1:0] out_a;
    wire [2 * DATA_WIDTH-1:0] out_b;
    wire [2 * ADDR_WIDTH-1:0] m_in;
    wire [2 * ADDR_WIDTH-1:0] m_out;
    
    //define twiddlefactors module input/output
    localparam TF_ADDR_WIDTH = $clog2(N/2);
    wire [ADDR_WIDTH-1:0] addr;
    wire [2 * DATA_WIDTH-1:0] tf_out;
    wire [TF_ADDR_WIDTH-1:0] tf_addr;
    
    //define the downsample counter
    reg [32-1:0] downsample_counter = 0;
    reg flag_downsample             = 0;
    
    //define the bram module input/output
    reg ENA0                    = 0;
    reg ENB0                    = 0;
    reg WEA0                    = 0;
    reg WEB0                    = 0;
    reg ENA1                    = 0;
    reg ENB1                    = 0;
    reg WEA1                    = 0;
    reg WEB1                    = 0;
    reg [BRAM_WIDTH-1:0] ADDRA0 = 0;
    reg [BRAM_WIDTH-1:0] ADDRB0 = 0;
    reg [BRAM_WIDTH-1:0] ADDRA1 = 0;
    reg [BRAM_WIDTH-1:0] ADDRB1 = 0;
    reg [2*DATA_WIDTH-1:0] DIA0 = 0;
    reg [2*DATA_WIDTH-1:0] DIB0 = 0;
    reg [2*DATA_WIDTH-1:0] DIA1 = 0;
    reg [2*DATA_WIDTH-1:0] DIB1 = 0;
    wire [2*DATA_WIDTH-1:0] DOA0, DOB0;
    wire [2*DATA_WIDTH-1:0] DOA1, DOB1;
    
    //define state
    localparam IDLE = 2'd0,FFT_DATA_PADDING = 2'd1,FFT_OPERATION = 2'd2,FFT_RESULT_OUT = 2'd3;
    reg [1:0] current_state, next_state;
    reg data_padding_flag            = 0;
    reg fft_stage                    = 0;
    reg [ADDR_WIDTH-1:0] select_ks_j = 0;
    reg [ADDR_WIDTH-1:0] S           = 0;
    reg select_bramid                = 0;
    wire [ADDR_WIDTH-1:0] in_a_addr;
    wire [ADDR_WIDTH-1:0] in_b_addr;
    reg [ADDR_WIDTH-1:0] out_a_addr = 0;
    wire [ADDR_WIDTH-1:0] out_b_addr;
    wire [ADDR_WIDTH-1:0] out_a_addr_reg;
    wire [ADDR_WIDTH-1:0] out_b_addr_reg;
    reg fft_done = 0;
    reg [2*DATA_WIDTH-1:0] out_fft_data;
    
    //*******************************************************
    //state machine
    //*******************************************************
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
                else begin
                    next_state = next_state;
                end
            end
            FFT_DATA_PADDING:begin
                if (data_padding_flag)begin
                    next_state = FFT_OPERATION;
                end
                else begin
                    next_state = FFT_DATA_PADDING;
                end
            end
            FFT_OPERATION:begin
                if (S == 1'b1&&out_b_addr_reg == N-1)begin
                    next_state = FFT_RESULT_OUT;
                end
                else begin
                    next_state = FFT_OPERATION;
                end
            end
            FFT_RESULT_OUT:begin
                if (~fft_done)begin
                    next_state = IDLE;
                end
                else begin
                    next_state = FFT_RESULT_OUT;
                end
            end
            default:begin
                next_state = IDLE;
            end
        endcase
    end
    //state action
    always@(posedge clk)begin
        case(next_state)
            IDLE:begin
                ENA0              <= 0;
                ENB0              <= 0;
                WEA0              <= 0;
                WEB0              <= 0;
                ENA1              <= 0;
                ENB1              <= 0;
                WEA1              <= 0;
                WEB1              <= 0;
                ADDRA0            <= 0;
                ADDRB0            <= 0;
                ADDRA1            <= 0;
                ADDRB1            <= 0;
                DIA0              <= 0;
                DIB0              <= 0;
                DIA1              <= 0;
                DIB1              <= 0;
                data_padding_flag <= 0;
                select_bramid     <= 0;
                out_a_addr        <= 0;
                S                 <= 0;
                select_ks_j       <= 0;
                fft_done          <= 0;
            end
            FFT_DATA_PADDING:begin
                ENA0   <= 1;
                WEA0   <= flag_downsample;
                ADDRA0 <= ADDRA0+WEA0;
                DIA0   <= {i_in,q_in};
                if (ADDRA0 == N-1&&WEA0)begin
                    data_padding_flag <= 1;
                    select_ks_j       <= {ADDR_WIDTH{1'b1}} >> 1;
                    S                 <= {1'b1,{ADDR_WIDTH-1{1'b0}}};
                    select_bramid     <= 0;
                    out_a_addr        <= 0;
                    ADDRA0            <= 0;
                end
                else begin
                    data_padding_flag <= 0;
                end
            end
            FFT_OPERATION:begin
                ENA0 <= 1;
                ENB0 <= 1;
                ENA1 <= 1;
                ENB1 <= 1;
                WEA0 <= select_bramid;
                WEB0 <= select_bramid;
                WEA1 <= ~select_bramid;
                WEB1 <= ~select_bramid;
                if (~select_bramid)begin
                    ADDRA0 <= in_a_addr;//in_a
                    ADDRB0 <= in_b_addr;//in_b
                    ADDRA1 <= out_a_addr_reg;//out_a
                    ADDRB1 <= out_b_addr_reg;//out_b
                    in_a   <= DOA0;
                    in_b   <= DOB0;
                    DIA1   <= out_a;
                    DIB1   <= out_b;
                end
                else begin
                    ADDRA0 <= out_a_addr_reg;//out_a
                    ADDRB0 <= out_b_addr_reg;//out_b
                    ADDRA1 <= in_a_addr;//in_a
                    ADDRB1 <= in_b_addr;//in_b
                    in_a   <= DOA1;
                    in_b   <= DOB1;
                    DIA0   <= out_a;
                    DIB0   <= out_b;
                end
                if (out_b_addr_reg == N-1)begin
                    ADDRA0        <= out_a_addr_reg;//out_a
                    ADDRB0        <= out_b_addr_reg;//out_b
                    DIA0          <= out_a;
                    DIB0          <= out_b;
                    select_bramid <= ~select_bramid;
                    select_ks_j   <= select_ks_j >> 1;
                    S             <= S >> 1;
                    out_a_addr    <= 0;
                end
                else if(out_b_addr == N-1)
                begin
                    out_a_addr <= 0;
                end
                else
                begin
                    out_a_addr <= out_a_addr+1;
                end
            end
            FFT_RESULT_OUT:begin
                WEA0     <= 0;
                WEB0     <= 0;
                WEA1     <= 0;
                WEB1     <= 0;
                ENA0     <= 1;
                ENB0     <= 0;
                ENA1     <= 1;
                ENB1     <= 0;
                fft_done <= 1;
                if (~select_bramid)begin
                    ADDRA0 <= ADDRA0+1;//in_a
                end
                else begin
                    ADDRA1 <= ADDRA1+1;//out_a
                end
                if (ADDRA0 == N-1 || ADDRA1 == N-1)begin
                    fft_done <= 0;
                end
                out_fft_data <= DOA0;
            end
            default:begin
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
            downsample_counter <= 0;
        end
        else
        begin
            flag_downsample    <= 0;
            downsample_counter <= downsample_counter + 1;
        end
    end
    
    //*******************************************************
    //in/out address
    //*******************************************************
    assign in_a_addr      = (out_a_addr & select_ks_j) | ((out_a_addr & ~select_ks_j)<<1);
    assign in_b_addr      = in_a_addr+S;
    assign out_b_addr     = {1'b1, out_a_addr[ADDR_WIDTH-2:0]};
    assign m_in           = {out_a_addr,out_b_addr};
    assign out_a_addr_reg = m_out[2*ADDR_WIDTH-1:ADDR_WIDTH];
    assign out_b_addr_reg = m_out[ADDR_WIDTH-1:0];
    assign tf_addr        = out_a_addr & ~select_ks_j;
    //*******************************************************
    //twiddlefactors module
    //*******************************************************
    twiddlefactors_8 u_twiddlefactors(
    .clk    (clk),
    .addr   (tf_addr),
    .tf_out (tf_out)
    );
    
    //*******************************************************
    //buttefly module
    //*******************************************************
    butterfly #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
    )u_butterfly(
    .clk   (clk),
    .in_a  (in_a),
    .in_b  (in_b),
    .m_in  (m_in),
    .w     (tf_out),
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
