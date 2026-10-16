module rst_bridge (clk, rst_n, rst_n_sync);
     input clk;
     input rst_n;
     output reg rst_n_sync;

     reg q1;     

   always @(posedge clk or negedge rst_n) begin
       if (!rst_n) begin
          q1 <= 1'b0;
          rst_n_sync<=1'b0;
       end else begin 
          q1 <= 1'b1;
          rst_n_sync<=q1;
       end
   end
endmodule
   