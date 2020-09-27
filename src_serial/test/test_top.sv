`timescale 1ns / 1ps

module test_top();
    logic clk, rst, uart_rxd_out;
    
    top top(.*);
    
    defparam top.send_serial.WAIT_DIV = 5;
    
    always #5 clk = ~clk;
    initial   clk = 1'b0;

    initial begin
        rst = 1'b0;
        #10;
        rst = 1'b1;
        
        #100;
        wait (top.busy == 1'b0);
        #100;
        $finish;
    end
endmodule
