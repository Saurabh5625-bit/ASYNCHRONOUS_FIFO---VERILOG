module rptr #(parameter ADDR_WIDTH=3)(rclk, rrst_n, wgray_sync, rinc, r_empty, raddr, rgray);
     input rclk;
     input rrst_n;
     input rinc;
     wire r_en;
     wire r_empty_next;
     input [ADDR_WIDTH:0] wgray_sync;
     output [ADDR_WIDTH-1:0]raddr;
     output reg [ADDR_WIDTH:0] rgray;
     reg [ADDR_WIDTH:0] rbin;
     wire [ADDR_WIDTH:0] rbin_next;
     wire [ADDR_WIDTH:0] rgray_next;
     output reg r_empty;

     assign r_en = rinc && !r_empty;
     assign r_empty_next = rgray_next == wgray_sync;  
     assign rbin_next = rbin + r_en;
     assign rgray_next = rbin_next ^ (rbin_next >>1);

     always @(posedge rclk or negedge rrst_n) begin
          if (!rrst_n) begin
            rbin <= 0;
            rgray <=0;
            r_empty <=0;
          end else begin
            rbin <= rbin_next ;
            rgray <= rgray_next;
            r_empty <= r_empty_next;
          end
     end
 
     assign raddr = rbin [ADDR_WIDTH-1:0];
endmodule