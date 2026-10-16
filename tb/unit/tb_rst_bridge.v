module testbench;
     reg rst_n;
     reg clk;
     wire q1;
     wire rst_n_sync; 

	rst_bridge dut(.clk(clk), .rst_n(rst_n), .rst_n_sync(rst_n_sync));

	always #5 clk=~clk;

	initial begin
           $dumpfile("rst_bridge.vcd");
           $dumpvars(0, testbench);
           $monitor("time=%0t, rst_n=%b, q1=%b, rst_n_sync=%b", $time, rst_n, q1, rst_n_sync);

              rst_n = 0; clk=0;
	   #3 rst_n = 1;
	   #15 rst_n = 0;
	   #22 rst_n = 1;
	   #28 rst_n = 0;
	   #39 rst_n = 1;
	   #56 rst_n = 0;
	   #10 $finish;
        end
endmodule