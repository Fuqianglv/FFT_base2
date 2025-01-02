//testbench for FFT_base2 module
`timescale 1ns / 1ps

module dual_prot_ram_tb();
    
    parameter DATA_WIDTH = 16;
    parameter CMD_WIDTH  = 4;
    
    reg CLKA, CLKB, ENA, ENB, WEA, WEB;
    reg [CMD_WIDTH-1:0] ADDRA, ADDRB;
    reg [DATA_WIDTH-1:0]DIA, DIB;
    wire [DATA_WIDTH-1:0] DOA, DOB;
    
    dual_prot_ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .CMD_WIDTH(CMD_WIDTH)
    )u_dual_prot_ram(
    .CLKA  (CLKA),
    .CLKB  (CLKB),
    .ENA   (ENA),
    .ENB   (ENB),
    .WEA   (WEA),
    .WEB   (WEB),
    .ADDRA (ADDRA),
    .ADDRB (ADDRB),
    .DIA   (DIA),
    .DIB   (DIB),
    .DOA   (DOA),
    .DOB   (DOB)
    );
    
    initial begin
        // Initialize signals
        CLKA  = 0;
        CLKB  = 0;
        ENA   = 0;
        ENB   = 0;
        WEA   = 0;
        WEB   = 0;
        ADDRA = 0;
        ADDRB = 0;
        DIA   = 0;
        DIB   = 0;
    end
    
    initial begin
        // Toggle clock
        forever #5 CLKA = ~CLKA;
    end
    
    initial begin
        // Toggle clock
        forever #5 CLKB = ~CLKB;
    end

    //用for循环写入数据到BRAM
    integer i; // Declare loop variable outside the for loop
    initial begin
        // Initialize signals
        ENA   = 0;          // Enable signal for BRAM
        WEA   = 0;          // Write enable signal for BRAM
        ADDRA = 4'b0000;    // Address for BRAM (starting address)
        DIA   = 16'd0;      // Data input to BRAM
        
        // Write data to BRAM using for loop
        for (i = 0; i < 16; i = i + 1) begin
            begin
                #10;                  // Wait 10 time units
                ENA   = 1;              // Enable BRAM for writing
                WEA   = 1;              // Enable write operation
                ADDRA = i;            // Set address to i
                DIA   = i;   // Set data to some value (e.g., 10 times the address)
                
                // Add more logic here if needed (e.g., waiting for writing to finish)
            end
        end
        
        // After writing, disable the write enable signal
        ENA = 0;
        WEA = 0;
    end
    
    //用for循环读取数据到BRAM
    initial begin
        // Initialize signals
        ENB   = 0;          // Enable signal for BRAM
        WEB   = 0;          // Write enable signal for BRAM
        ADDRB = 4'b0000;    // Address for BRAM (starting address)
        
        // Read data from BRAM using for loop
        for (i = 0; i < 16; i = i + 1) begin
            begin
                #10;                  // Wait 10 time units
                ENB   = 1;              // Enable BRAM for reading
                WEB   = 0;              // Disable write operation
                ADDRB = i;            // Set address to i
                
                // Add more logic here if needed (e.g., waiting for reading to finish)
            end
        end
        
        // After reading, disable the write enable signal
        ENB = 0;
        WEB = 0;
    end
    
endmodule
