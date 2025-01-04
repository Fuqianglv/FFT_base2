
// BRAM_TDP_MACRO : In order to incorporate this function into the design,
//   Verilog   : the following instance declaration needs to be placed
//  instance   : in the body of the design code.  The instance name
// declaration : (BRAM_TDP_MACRO_inst) and/or the port declarations within the
//    code     : parenthesis may be changed to properly reference and
//             : connect this function to the design.  All inputs
//             : and outputs must be connected.

//  <-----Cut code below this line---->

// BRAM_TDP_MACRO: True Dual Port RAM
//                 Artix-7
// Xilinx HDL Language Template, version 2021.1

//////////////////////////////////////////////////////////////////////////
// DATA_WIDTH_A/B | BRAM_SIZE | RAM Depth | ADDRA/B Width | WEA/B Width //
// ==  ==  ==  ==  ==  ==  ==  = | ==  ==  ==  ==  ==  = | ==  ==  ==  ==  ==  = | ==  ==  ==  ==  ==  ==  ==  = | ==  ==  ==  ==  ==  ==  = //
//     19-36      |  "36Kb"   |    1024   |    10-bit     |    4-bit    //
//     10-18      |  "36Kb"   |    2048   |    11-bit     |    2-bit    //
//     10-18      |  "18Kb"   |    1024   |    10-bit     |    2-bit    //
//      5-9       |  "36Kb"   |    4096   |    12-bit     |    1-bit    //
//      5-9       |  "18Kb"   |    2048   |    11-bit     |    1-bit    //
//      3-4       |  "36Kb"   |    8192   |    13-bit     |    1-bit    //
//      3-4       |  "18Kb"   |    4096   |    12-bit     |    1-bit    //
//        2       |  "36Kb"   |   16384   |    14-bit     |    1-bit    //
//        2       |  "18Kb"   |    8192   |    13-bit     |    1-bit    //
//        1       |  "36Kb"   |   32768   |    15-bit     |    1-bit    //
//        1       |  "18Kb"   |   16384   |    14-bit     |    1-bit    //
//////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module dual_prot_ram #(parameter DATA_WIDTH = 8,
                        parameter BRAM_WIDTH = 10)
                       (input wire CLKA,                     // Port A clock
                        input wire CLKB,                     // Port B clock
                        input wire ENA,                      // Port A enable
                        input wire ENB,                      // Port B enable
                        input wire WEA,                      // Port A write enable
                        input wire WEB,                      // Port B write enable
                        input wire [BRAM_WIDTH-1:0] ADDRA,    // Port A address
                        input wire [BRAM_WIDTH-1:0] ADDRB,    // Port B address
                        input wire [2*DATA_WIDTH-1:0] DIA,   // Port A input data
                        input wire [2*DATA_WIDTH-1:0] DIB,   // Port B input data
                        output wire [2*DATA_WIDTH-1:0] DOA,  // Port A output data
                        output wire [2*DATA_WIDTH-1:0] DOB); // Port B output data
    BRAM_TDP_MACRO #(
    .BRAM_SIZE("18Kb"), // Target BRAM: "18Kb" or "36Kb"
    .DEVICE("7SERIES"), // Target device: "7SERIES"
    .DOA_REG(0),        // Optional port A output register (0 or 1)
    .DOB_REG(0),        // Optional port B output register (0 or 1)
    .INIT_A(36'h00000000),  // Initial values on port A output port
    .INIT_B(36'h00000000), // Initial values on port B output port
    .INIT_FILE ("NONE"),
    .READ_WIDTH_A (DATA_WIDTH<<1),   // Valid values are 1-36 (19-36 only valid when BRAM_SIZE = "36Kb")
    .READ_WIDTH_B (DATA_WIDTH<<1),   // Valid values are 1-36 (19-36 only valid when BRAM_SIZE = "36Kb")
    .SIM_COLLISION_CHECK ("NONE"), // Collision check enable "ALL", "WARNING_ONLY",
    //   "GENERATE_X_ONLY" or "NONE"
    .SRVAL_A(36'h00000000), // Set/Reset value for port A output
    .SRVAL_B(36'h00000000), // Set/Reset value for port B output
    .WRITE_MODE_A("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE"
    .WRITE_MODE_B("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE"
    .WRITE_WIDTH_A(DATA_WIDTH<<1), // Valid values are 1-36 (19-36 only valid when BRAM_SIZE = "36Kb")
    .WRITE_WIDTH_B(DATA_WIDTH<<1), // Valid values are 1-36 (19-36 only valid when BRAM_SIZE = "36Kb")
    .INIT_00(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_01(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_02(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_03(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_04(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_05(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_06(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_07(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_08(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_09(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0A(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0B(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0C(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0D(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0E(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_0F(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_10(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_11(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_12(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_13(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_14(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_15(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_16(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_17(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_18(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_19(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1A(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1B(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1C(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1D(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1E(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_1F(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_20(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_21(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_22(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_23(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_24(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_25(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_26(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_27(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_28(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_29(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2A(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2B(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2C(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2D(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2E(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_2F(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_30(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_31(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_32(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_33(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_34(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_35(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_36(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_37(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_38(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_39(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3A(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3B(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3C(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3D(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3E(256'h1111111111111111111111111111111111111111111111111111111111111111),
    .INIT_3F(256'h1111111111111111111111111111111111111111111111111111111111111111)
    
    // The next set of INIT_xx are valid when configured as 36Kb
     /*.INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
     
     // The next set of INITP_xx are for the parity bits
     .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
     
     // The next set of INITP_xx are valid when configured as 36Kb
     .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
     .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000)*/
    ) BRAM_TDP_MACRO_inst (
    .DOA(DOA),       // Output port-A data, width defined by READ_WIDTH_A parameter
    .DOB(DOB),       // Output port-B data, width defined by READ_WIDTH_B parameter
    .ADDRA(ADDRA),   // Input port-A address, width defined by Port A depth
    .ADDRB(ADDRB),   // Input port-B address, width defined by Port B depth
    .CLKA(CLKA),     // 1-bit input port-A clock
    .CLKB(CLKB),     // 1-bit input port-B clock
    .DIA(DIA),       // Input port-A data, width defined by WRITE_WIDTH_A parameter
    .DIB(DIB),       // Input port-B data, width defined by WRITE_WIDTH_B parameter
    .ENA(ENA),       // 1-bit input port-A enable
    .ENB(ENB),       // 1-bit input port-B enable
    .REGCEA(1'b0),      // 1-bit input port-A output register enable
    .REGCEB(1'b0),      // 1-bit input port-B output register enable
    .RSTA(1'b0),        // 1-bit input port-A reset
    .RSTB(1'b0),        // 1-bit input port-B reset
    .WEA({2{WEA}}),       // Input port-A write enable, width defined by Port A depth
    .WEB({2{WEB}})        // Input port-B write enable, width defined by Port B depth
    );
    
    // End of BRAM_TDP_MACRO_inst instantiation
endmodule
