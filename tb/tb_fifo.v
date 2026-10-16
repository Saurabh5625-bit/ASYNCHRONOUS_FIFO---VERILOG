`timescale 1ns/1ps

module testbench #(parameter real WHALF =3, RHALF = 7, TEND =20000);
     reg wclk;
	 reg rclk;
	 reg winc;
	 reg rinc;
	 reg rst_n;
	 reg [7:0] wdata;
	 wire wfull;
	 wire r_empty;
	 wire [7:0] rdata;
	 reg [7:0] expected [0:1023];
	 integer wr_count, rd_count, errors, total_write, total_read;
	 	 
	 
   fifo dut(.wclk(wclk), .rclk(rclk), .rst_n(rst_n), .winc(winc), .wdata(wdata), .rinc(rinc), .rdata(rdata), .wfull(wfull), .r_empty(r_empty));

     always #WHALF wclk = ~wclk;
     always #RHALF rclk = ~rclk;
	 always @(negedge wclk) winc <= $random;
	 always @(negedge rclk) rinc <=$random;
	 
	 always @(negedge rst_n) begin
        wr_count = 0;
        rd_count = 0;
     end 		
	    
	 
	 always @(posedge wclk) begin
	     if (dut.wrst_n_sync && winc && !wfull) begin
		 expected[wr_count] = wdata; 
		 wr_count = wr_count +1;
		 wdata <= wdata + 1;
		 total_write = total_write + 1;
		 end
		 if (wr_count - rd_count > 8) begin
		 errors = errors +1;
		 $display("OVERFLOW: time=%0t", $time);
		 end
	 end	 
	 
	 always @(posedge rclk) begin
	    if (dut.rrst_n_sync && rinc && !r_empty) begin
		    if (rdata !== expected[rd_count])begin
			   errors = errors +1;
			   $display("time=%0t, rdata=%h, expected[rd_count]= %h", $time, rdata, expected[rd_count]);
			end
		    rd_count = rd_count +1;
			total_read = total_read + 1;
        end	
        if (rd_count > wr_count) begin
        errors = errors +1;
		$display("UNDERFLOW: time=%0t", $time);
        end	    		
	 end	
		

   initial begin
     $dumpfile("fifo.vcd");
     $dumpvars(0,testbench);
     //$monitor("time=%0t, wclk=%b, rclk=%b, rst_n=%b, winc=%b, wdata=%h, rinc=%b, rdata=%h, wfull=%b, r_empty=%b", $time, wclk, rclk, rst_n, winc, wdata, rinc, rdata, wfull, r_empty);

             wclk = 0; rclk = 0; rst_n = 0; winc = 0; rinc = 0; wdata = 8'h00; wr_count = 0; rd_count = 0; errors = 0; total_write = 0; total_read = 0;
        #25.3 rst_n = 1;
		#(TEND/2) rst_n = 0;
		#20 rst_n = 1;
		
	#(TEND/2);
	if (errors == 0)
         $display("PASS: %0d writes, %0d reads", total_write, total_read);
         else 
         $display("FAIL: %0d writes, %0d errors, %0d reads", total_write, errors, total_read);
       $finish;
   end
endmodule   