module wrptr #(parameter ADDR_WIDTH=3)(wclk, wrst_n, rgray_sync, winc, wfull, waddr, wgray);
     input wclk;
     input wrst_n;
     input winc;
     wire wr_en;
     wire wfull_next;
     input [ADDR_WIDTH:0] rgray_sync;
     output [ADDR_WIDTH-1:0]waddr;
     output reg [ADDR_WIDTH:0] wgray;
     reg [ADDR_WIDTH:0] wbin;
     wire [ADDR_WIDTH:0] wbin_next;
     wire [ADDR_WIDTH:0] wgray_next;
     output reg wfull;

     assign wr_en = winc && !wfull;
     assign wfull_next = wgray == {~rgray_sync[ADDR_WIDTH:ADDR_WIDTH-1], rgray_sync[ADDR_WIDTH-2:0]}; 
     assign wbin_next = wbin + wr_en;
     assign wgray_next = wbin_next ^ (wbin_next >>1);

     always @(posedge wclk or negedge wrst_n) begin
          if (!wrst_n) begin
            wbin <= 0;
            wgray <=0;
            wfull <=0;
          end else begin
            wbin <= wbin_next ;
            wgray <= wgray_next;
            wfull <= wfull_next;
          end
     end
 
     assign waddr = wbin [ADDR_WIDTH-1:0];
endmodule