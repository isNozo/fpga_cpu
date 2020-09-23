`timescale 1ns / 1ps

module test_shiftreg_p2s();
    logic       clk, rst, we;
    logic       sin;
    logic [7:0] pin;
    logic       sout;
    
    shiftreg_p2s#(.N(8)) shiftreg_p2s(.*);
    
    always #5 clk = ~clk;
    initial   clk = 1'b0;
    
    initial begin
        rst = 1'b0;
        #10;
        rst = 1'b1;
    end
    
    initial begin
        we = 1'b1;
        #20;
        we = 1'b0;
    end
    
    initial sin = 1'b1;
    initial pin = 8'b0010_1010;
    
    initial begin
        #500;
        $finish();
    end
endmodule
