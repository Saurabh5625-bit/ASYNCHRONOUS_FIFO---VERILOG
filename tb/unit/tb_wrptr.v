module testbench;
     reg wclk;
     reg wrst_n;
     reg winc;
     wire wfull;
     wire [2:0] waddr;
     wire [3:0] wgray;
     reg [3:0] rgray_sync;

   wrptr dut(.wclk(wclk), .wrst_n(wrst_n), .winc(winc), .wfull(wfull), .rgray_sync(rgray_sync), .waddr(waddr), .wgray(wgray));
   
   always #5 wclk=~wclk;

   initial begin
     $dumpfile("wrptr.vcd");
     $dumpvars(0, testbench);
     $monitor("time=%0t, wclk=%b, wrst_n=%b, winc=%b, wfull=%b, rgray_sync=%b, waddr=%b, wgray=%b" , $time, wclk, wrst_n, winc, wfull, rgray_sync, waddr, wgray);

     wclk = 0; wrst_n = 0; winc = 0; rgray_sync = 4'b0000;
     	#12 wrst_n = 1; winc = 1; rgray_sync = 4'b0000;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b0001;
        #100 wrst_n = 0; winc = 1; rgray_sync = 4'b0001;
        #20 wrst_n = 1; winc = 1; rgray_sync = 4'b0001; 
     	#220 wrst_n = 1; winc = 1; rgray_sync = 4'b0011; 
     	#40 wrst_n = 1; winc = 0; rgray_sync = 4'b0010;
     	#10 wrst_n = 1; winc = 1; rgray_sync = 4'b0110;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b0111;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b0101;
     	#10 wrst_n = 1; winc = 1; rgray_sync = 4'b0100;
     	#10 wrst_n = 1; winc = 1; rgray_sync = 4'b1100;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b1101;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b1111;
     	#10 wrst_n = 1; winc = 1; rgray_sync = 4'b0000;
     	#40 wrst_n = 1; winc = 0; rgray_sync = 4'b0001;
     	#21 wrst_n = 0; winc = 1; rgray_sync = 4'b0000;
     	#29 wrst_n = 1; winc = 1; rgray_sync = 4'b0000;
     	#11 wrst_n = 1; winc = 1; rgray_sync = 4'b0001;
     	#7 wrst_n = 1; winc = 1; rgray_sync = 4'b0011;
     	#3 wrst_n = 1; winc = 1; rgray_sync = 4'b0010;
     	#20 wrst_n = 1; winc = 1; rgray_sync = 4'b0110;
        #20 $finish;
    end
endmodule