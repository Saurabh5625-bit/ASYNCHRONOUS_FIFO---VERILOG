module testbench;
     reg [3:0] d04;
     wire [3:0] q24;
     reg clk;
     reg [7:0] d08;
     wire [7:0] q28;


sync2 dut4(.clk(clk), .d(d04), .q2(q24));
sync2 #(.WIDTH(8)) dut8(.clk(clk), .d(d08), .q2(q28));

     always #5 clk = ~clk;

     initial begin 
          $dumpfile("sync2.vcd");
          $dumpvars(0, testbench);
          $monitor("time=%0t, d04=%b, q24=%b, d08=%b, q28=%b", $time, d04, q24, d08, q28);

            d04=4'b0000; d08=8'b00000000; clk=0;
        #3 d04=4'b1000; d08=8'b00001000;
        #7 d04=4'b1010; d08=8'b00001010;
        #4 d04=4'b0101; d08=8'b00000101;
        #12 d04=4'b1100; d08=8'b00001100;
        #6 d04=4'b0011; d08=8'b00000011;
        #9 d04=4'b1111; d08=8'b00001111;
        #20 $finish;
     end
endmodule


