// Copyright (c) 2024 LFQ
// This file is the output of the twiddlefactors template

module twiddlefactors (
    input  wire clk,
    input  wire [{{Nlog2 - 2}}:0] addr,
    output reg signed [{{2*tf_width-1}}:0] tf_out
  );

  always @ (posedge clk)
    begin
      case (addr)
      // tf_out <= {cos(-2pi*k/{{N}}),sin(-2pi*k/{{N}})}
      {% for tf in tfs %} {{Nlog2-1}}'d{{tf.k}}: tf_out <= { {{tf.re_sign}}{{tf_width}}'sd{{tf.re}}, {{tf.im_sign}}{{tf_width}}'sd{{tf.im}} };
      {% endfor %}  default:
          begin
            tf_out <= {{2*tf_width}}'d0;
          end
      endcase
    end
endmodule
