module fifo#(parameter ADDR_WIDTH = 3, DATA_WIDTH = 8)(wclk, rclk, rst_n, winc, wdata, rinc, rdata, wfull, r_empty);
      input wclk;
      input rclk;
      input rst_n;
      input winc;
      input rinc;
      input [DATA_WIDTH-1:0] wdata;
      output wfull;
      output r_empty;
      output [DATA_WIDTH-1:0] rdata;
      wire wrst_n_sync;
      wire rrst_n_sync;
      wire wen;
	  wire [ADDR_WIDTH-1:0]waddr;
	  wire [ADDR_WIDTH-1:0]raddr;
	  wire [ADDR_WIDTH:0]wgray;
	  wire [ADDR_WIDTH:0]rgray;
	  wire [ADDR_WIDTH:0]wgray_sync = wgray;
	  wire [ADDR_WIDTH:0]rgray_sync = rgray;

    assign wen = winc && !wfull;
	
	
   rst_bridge wrst_bridge(.clk(wclk), .rst_n(rst_n), .rst_n_sync(wrst_n_sync));
   rst_bridge rrst_bridge(.clk(rclk), .rst_n(rst_n), .rst_n_sync(rrst_n_sync));

   sync2 #(.WIDTH(ADDR_WIDTH+1)) wsync2(.clk(wclk), .d(rgray), .q2());
   sync2 #(.WIDTH(ADDR_WIDTH+1)) rsync2(.clk(rclk), .d(wgray), .q2());

   dpram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))u_dpram(.wclk(wclk), .wen(wen), .waddr(waddr), .wdata(wdata), .rdata(rdata), .raddr(raddr));

   wrptr #(.ADDR_WIDTH(ADDR_WIDTH)) write(.wclk(wclk), .wrst_n(wrst_n_sync), .rgray_sync(rgray_sync), .winc(winc), .wfull(wfull), .waddr(waddr), .wgray(wgray)); 
   rptr  #(.ADDR_WIDTH(ADDR_WIDTH)) read(.rclk(rclk), .rrst_n(rrst_n_sync), .wgray_sync(wgray_sync), .rinc(rinc), .r_empty(r_empty), .raddr(raddr), .rgray(rgray));
   
endmodule    