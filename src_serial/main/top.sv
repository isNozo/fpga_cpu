module top(
    input  logic CLK100MHZ,
    input  logic ck_rst,
    output logic uart_rxd_out
);
    logic [7:0] data_in;
    assign data_in = 8'h41;
    
    logic we, busy;
    
//    send_serial send_serial(
//        .clk(CLK100MHZ),
//        .rst(ck_rst),
//        .data_in,
//        .data_out(uart_rxd_out),
//        .we,
//        .busy
//    );

    shiftreg_p2s#(.N(8)) (
        .clk(CLK100MHZ),
        .rst(ck_rst),
        .we,
        .sin(1'b1),
        .pin(data_in),
        .sout(uart_rxd_out)
    );

endmodule
