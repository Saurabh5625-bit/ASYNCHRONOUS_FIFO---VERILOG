module sync2 #(parameter WIDTH=4) (clk, d, q2);
      input clk;
      input [WIDTH-1:0] d;
      output [WIDTH-1:0] q2;
      wire [WIDTH-1:0] q1;

    width #(.WIDTH(WIDTH))stage1(.clk(clk), .d(d), .q(q1));
    width #(.WIDTH(WIDTH))stage2(.clk(clk), .d(q1), .q(q2));

endmodule