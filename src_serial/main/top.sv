module top(
    input  logic CLK100MHZ,
    input  logic ck_rst,
    output logic uart_rxd_out
);
    send_serial send_serial(.clk(CLK100MHZ), .rst(ck_rst), .data_out(uart_rxd_out));
endmodule
