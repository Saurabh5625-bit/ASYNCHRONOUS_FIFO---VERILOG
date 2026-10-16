module testbench;
     reg [3:0] d4;
     reg clk;
     reg [7:0] d8;
     wire [7:0] q8;
     wire [3:0] q4;
 
     width dut4(.d(d4), .clk(clk), .q(q4));

     width #(.WIDTH(8)) dut8(.d(d8), .q(q8), .clk(clk));

     always #5 clk=~clk;

     initial begin
        $dumpfile("width4.vcd");
        $dumpvars(0, testbench);
        $monitor("time=%0t, d4=%b, q4=%b, d8=%b, q8=%b", $time, d4, q4, d8, q8);
     
            d4=4'b0000; d8=8'b00000000; clk=0;
        #10 d4=4'b1000; d8=8'b00001000;
        #10 d4=4'b1010; d8=8'b00001010;
        #10 d4=4'b0101; d8=8'b00000101;
        #10 d4=4'b1100; d8=8'b00001100;
        #10 d4=4'b0011; d8=8'b00000011;
        #10 d4=4'b1111; d8=8'b00001111;
        #10 $finish;
     end
endmodule


    
 