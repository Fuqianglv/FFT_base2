// Copyright (c) 2024 LFQ
// This file is the output of the twiddlefactors template

module twiddlefactors (
    input  wire clk,
    input  wire [5:0] addr,
    output reg signed [15:0] tf_out
  );

  always @ (posedge clk)
    begin
      case (addr)
      // tf_out <= {cos(-2pi*k/128),sin(-2pi*k/128)}
       6'd0: tf_out <= { 8'sd64, -8'sd0 };
       6'd1: tf_out <= { 8'sd64, -8'sd3 };
       6'd2: tf_out <= { 8'sd64, -8'sd6 };
       6'd3: tf_out <= { 8'sd63, -8'sd9 };
       6'd4: tf_out <= { 8'sd63, -8'sd12 };
       6'd5: tf_out <= { 8'sd62, -8'sd16 };
       6'd6: tf_out <= { 8'sd61, -8'sd19 };
       6'd7: tf_out <= { 8'sd60, -8'sd22 };
       6'd8: tf_out <= { 8'sd59, -8'sd24 };
       6'd9: tf_out <= { 8'sd58, -8'sd27 };
       6'd10: tf_out <= { 8'sd56, -8'sd30 };
       6'd11: tf_out <= { 8'sd55, -8'sd33 };
       6'd12: tf_out <= { 8'sd53, -8'sd36 };
       6'd13: tf_out <= { 8'sd51, -8'sd38 };
       6'd14: tf_out <= { 8'sd49, -8'sd41 };
       6'd15: tf_out <= { 8'sd47, -8'sd43 };
       6'd16: tf_out <= { 8'sd45, -8'sd45 };
       6'd17: tf_out <= { 8'sd43, -8'sd47 };
       6'd18: tf_out <= { 8'sd41, -8'sd49 };
       6'd19: tf_out <= { 8'sd38, -8'sd51 };
       6'd20: tf_out <= { 8'sd36, -8'sd53 };
       6'd21: tf_out <= { 8'sd33, -8'sd55 };
       6'd22: tf_out <= { 8'sd30, -8'sd56 };
       6'd23: tf_out <= { 8'sd27, -8'sd58 };
       6'd24: tf_out <= { 8'sd24, -8'sd59 };
       6'd25: tf_out <= { 8'sd22, -8'sd60 };
       6'd26: tf_out <= { 8'sd19, -8'sd61 };
       6'd27: tf_out <= { 8'sd16, -8'sd62 };
       6'd28: tf_out <= { 8'sd12, -8'sd63 };
       6'd29: tf_out <= { 8'sd9, -8'sd63 };
       6'd30: tf_out <= { 8'sd6, -8'sd64 };
       6'd31: tf_out <= { 8'sd3, -8'sd64 };
       6'd32: tf_out <= { 8'sd0, -8'sd64 };
       6'd33: tf_out <= { -8'sd3, -8'sd64 };
       6'd34: tf_out <= { -8'sd6, -8'sd64 };
       6'd35: tf_out <= { -8'sd9, -8'sd63 };
       6'd36: tf_out <= { -8'sd12, -8'sd63 };
       6'd37: tf_out <= { -8'sd16, -8'sd62 };
       6'd38: tf_out <= { -8'sd19, -8'sd61 };
       6'd39: tf_out <= { -8'sd22, -8'sd60 };
       6'd40: tf_out <= { -8'sd24, -8'sd59 };
       6'd41: tf_out <= { -8'sd27, -8'sd58 };
       6'd42: tf_out <= { -8'sd30, -8'sd56 };
       6'd43: tf_out <= { -8'sd33, -8'sd55 };
       6'd44: tf_out <= { -8'sd36, -8'sd53 };
       6'd45: tf_out <= { -8'sd38, -8'sd51 };
       6'd46: tf_out <= { -8'sd41, -8'sd49 };
       6'd47: tf_out <= { -8'sd43, -8'sd47 };
       6'd48: tf_out <= { -8'sd45, -8'sd45 };
       6'd49: tf_out <= { -8'sd47, -8'sd43 };
       6'd50: tf_out <= { -8'sd49, -8'sd41 };
       6'd51: tf_out <= { -8'sd51, -8'sd38 };
       6'd52: tf_out <= { -8'sd53, -8'sd36 };
       6'd53: tf_out <= { -8'sd55, -8'sd33 };
       6'd54: tf_out <= { -8'sd56, -8'sd30 };
       6'd55: tf_out <= { -8'sd58, -8'sd27 };
       6'd56: tf_out <= { -8'sd59, -8'sd24 };
       6'd57: tf_out <= { -8'sd60, -8'sd22 };
       6'd58: tf_out <= { -8'sd61, -8'sd19 };
       6'd59: tf_out <= { -8'sd62, -8'sd16 };
       6'd60: tf_out <= { -8'sd63, -8'sd12 };
       6'd61: tf_out <= { -8'sd63, -8'sd9 };
       6'd62: tf_out <= { -8'sd64, -8'sd6 };
       6'd63: tf_out <= { -8'sd64, -8'sd3 };
        default:
          begin
            tf_out <= 16'd0;
          end
      endcase
    end
endmodule