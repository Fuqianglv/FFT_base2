`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2022/12/22 22:39:33
// Design Name:
// Module Name: Signal_Gen_tb
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


module Signal_Gen_tb();
    
    // Signa_Gen Parameters
    parameter CLK_Freq = 125000000;//Mhz
    parameter ns = 1000000000;//ns
    parameter PERIOD = 8;//125Mhz
    
    
    // Signa_Gen Inputs
    reg   clk                   = 0 ;
    reg   rst                   = 0 ;
    reg   send_en               = 0 ;
    reg   [5:0]  sv_num         = 3 ;
    reg   [61:0]  fcarr_control = 0 ;
    reg   [61:0]  fcode_control = 0 ;
    reg   [62:0]  phase_init_carrier           = 0 ;
    reg   [62:0]  phase_init_code              = 0 ;
    reg   [14:0]  phase_init_navidata          = 15'd20459;
    reg   [8:0]  address_init_navidata         = 9'd299 ;
    reg   [9:0]  code_cnt_init                 = 1022 ;
    reg   [63:0]  message1      = 64'h22c05614258c09a0 ;
    reg   [63:0]  message2      = 64'h22c05614258c09a0 ;
    reg   [63:0]  message3      = 64'h22c05614258c09a0 ;
    reg   [63:0]  message4      = 64'h22c05614258c09a0 ;
    reg   [63:0]  message5      = 64'h22c05614258c09a0 ;
    reg   shut_time6s_sign                     = 0 ;
    

// Signa_Gen Outputs
wire  [11:0]  signal_sin                   ;
wire  [11:0]  signal_cos                   ;
wire  [63:0]  acc_sum_carrier              ;
wire  [63:0]  acc_sum_code                 ;
wire  [14:0]  acc_sum_navidata             ;
wire  [8:0]  address_navidata              ;
wire  [9:0]  code_cnt                      ;
wire  time6s_sign                          ;
    
    initial
    begin
        forever #(PERIOD/2)  clk = ~clk;
    end
    
    initial
    begin
        #(PERIOD*2) rst = 1;
    end
    
    Signa_Gen  u_Signa_Gen (
    .clk                     ( clk                           ),
    .rst                     ( rst                           ),
    .send_en                 ( send_en                       ),
    .sv_num                  ( sv_num                 [5:0]  ),
    .fcarr_control           ( fcarr_control          [61:0] ),
    .fcode_control           ( fcode_control          [61:0] ),
    .phase_init_carrier      ( phase_init_carrier     [62:0] ),
    .phase_init_code         ( phase_init_code        [62:0] ),
    .phase_init_navidata     ( phase_init_navidata    [14:0] ),
    .address_init_navidata   ( address_init_navidata  [8:0]  ),
    .code_cnt_init           ( code_cnt_init          [9:0]  ),
    .message1                ( message1               [63:0] ),
    .message2                ( message2               [63:0] ),
    .message3                ( message3               [63:0] ),
    .message4                ( message4               [63:0] ),
    .message5                ( message5               [63:0] ),
    .shut_time6s_sign        ( shut_time6s_sign              ),

    .signal_sin              ( signal_sin             [11:0] ),
    .signal_cos              ( signal_cos             [11:0] ),
    .acc_sum_carrier         ( acc_sum_carrier        [63:0] ),
    .acc_sum_code            ( acc_sum_code           [63:0] ),
    .acc_sum_navidata        ( acc_sum_navidata       [14:0] ),
    .address_navidata        ( address_navidata       [8:0]  ),
    .code_cnt                ( code_cnt               [9:0]  ),
    .time6s_sign             ( time6s_sign                   )
);
    
    initial
    begin
        fcarr_control = 62'd301936306998477940;
        fcode_control = 62'd75484076749619485;
        #2000 send_en       = 1;
        
        
        sv_num        = 3;
        message1      = 64'h22c05614257709a0 ;
        message2      = 64'h05645519755990da ;
        message3      = 64'hb63ff62fcc9880a9 ;
        message4      = 64'h4fec09728b05b698 ;
        message5      = 64'h003ff61151fa6668 ;
        #300 shut_time6s_sign=1;
        #20 shut_time6s_sign=0;
        $finish;
    end
endmodule
