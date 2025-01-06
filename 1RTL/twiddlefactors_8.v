// Copyright (c) 2024 LFQ
// This file is the output of the twiddlefactors template

module twiddlefactors_8 (
    input  wire clk,
    input  wire [1:0] addr,
    output reg signed [15:0] tf_out
  );

  always @ (posedge clk)
    begin
      case (addr)
      // tf_out <= {cos(-2pi*k/8),sin(-2pi*k/8)}
       2'd0: tf_out <= { 8'sd64, -8'sd0 };
       2'd1: tf_out <= { 8'sd45, -8'sd45 };
       2'd2: tf_out <= { 8'sd0, -8'sd64 };
       2'd3: tf_out <= { -8'sd45, -8'sd45 };
        default:
          begin
            tf_out <= 16'd0;
          end
      endcase
    end
endmodule