module testbench;
     reg [7:0] wdata;
     reg wclk;
     wire [7:0] rdata;
     reg [2:0] waddr;
     reg [2:0] raddr;
     reg wen;

     dpram dut(.wclk(wclk), .wdata(wdata), .rdata(rdata), .waddr(waddr), .raddr(raddr), .wen(wen));

     always #5 wclk=~wclk;

     initial begin
        $dumpfile("dpram.vcd");
        $dumpvars(0, testbench);
        $monitor("time=%0t, wdata=%b, waddr=%b, raddr=%b, rdata=%b, wen=%b", $time, wdata, waddr, raddr, rdata, wen);
 

            wen= 1; waddr=3'b000;  raddr = 3'b000; wdata=8'b00000000; wclk=0;
        #10 wen = 1; waddr=3'b001; wdata=8'b00001000;
        #10 wen = 1; waddr=3'b010; wdata=8'b00001010;
        #10 wen = 1; waddr=3'b011; wdata=8'b00000101;
        #10 wen = 0; waddr=3'b000; raddr = 3'b000; wdata=8'b00001100;
        #10 wen = 0; waddr=3'b010; raddr = 3'b001; wdata=8'b00000011;
        #10 wen = 0; waddr=3'b110; raddr = 3'b010; wdata=8'b00001111;
        #10 wen = 0;  raddr = 3'b110;
        #10 wen = 0;  raddr = 3'b011; 
        #10 $finish;
     end
endmodule