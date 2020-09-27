`timescale 1ns / 1ps

module test_top();
    logic clk, rst, uart_rxd_out;
    
    top top(.*);
    
    always #5 clk = ~clk;
    initial   clk = 1'b0;
    
    initial begin
        rst = 1'b0;
        #10;
        rst = 1'b1;
    end
    
    defparam top.send_serial.WAIT_DIV = 5;
    initial top.data_in = 8'b0101_0011;
    
    initial begin
        top.we = 1'b0;
        #50
        top.we = 1'b1;
        #20;
        top.we = 1'b0;
        
        wait (top.busy == 1'b0);
        #20;
        $finish;
    end
endmodule
