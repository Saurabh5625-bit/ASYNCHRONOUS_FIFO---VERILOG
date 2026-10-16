module testbench;
     reg rclk;
     reg rrst_n;
     reg rinc;
     wire r_empty;
     wire [2:0] raddr;
     wire [3:0] rgray;
     reg [3:0] wgray_sync;

   rptr dut(.rclk(rclk), .rrst_n(rrst_n), .rinc(rinc), .r_empty(r_empty), .wgray_sync(wgray_sync), .raddr(raddr), .rgray(rgray));
   
   always #5 rclk=~rclk;

   initial begin
     $dumpfile("rptr.vcd");
     $dumpvars(0, testbench);
     $monitor("time=%0t, rclk=%b, rrst_n=%b, rinc=%b, r_empty=%b, wgray_sync=%b, raddr=%b, rgray=%b" , $time, rclk, rrst_n, rinc, r_empty, wgray_sync, raddr, rgray);

     rclk = 0; rrst_n = 0; rinc = 0; wgray_sync = 4'b0000;
     	#12 rrst_n = 1; rinc = 1; wgray_sync = 4'b0000;
     	#30 rrst_n = 0; rinc = 1; wgray_sync = 4'b0001;
        #30 rrst_n = 0; rinc = 1; wgray_sync = 4'b0001;
        #20 rrst_n = 1; rinc = 1; wgray_sync = 4'b0001; 
     	#20 rrst_n = 1; rinc = 1; wgray_sync = 4'b0011; 
     	#20 rrst_n = 1; rinc = 0; wgray_sync = 4'b0010;
     	#20 rrst_n = 1; rinc = 1; wgray_sync = 4'b0110;
     	#60 rrst_n = 1; rinc = 1; wgray_sync = 4'b0111;
     	#90 rrst_n = 1; rinc = 1; wgray_sync = 4'b0101;
     	#30 rrst_n = 1; rinc = 1; wgray_sync = 4'b0100;
     	#20 rrst_n = 1; rinc = 1; wgray_sync = 4'b1100;
        #70 $finish;
     end
endmodule