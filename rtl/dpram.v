module dpram #(parameter ADDR_WIDTH = 3, DATA_WIDTH =8) (wclk, wen, waddr, wdata, raddr, rdata);
	input wclk;
	input wen;
	input [ADDR_WIDTH-1:0] waddr;
	input [DATA_WIDTH-1:0] wdata;
	input [ADDR_WIDTH-1:0] raddr;
	output [DATA_WIDTH-1:0] rdata;

        localparam DEPTH = 1 << ADDR_WIDTH;

        reg [DATA_WIDTH-1:0] row[0:DEPTH-1];

        always @(posedge wclk)
            if (wen)
             row[waddr] <= wdata;
	
	assign rdata = row[raddr];
endmodule