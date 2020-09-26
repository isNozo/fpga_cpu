module top(
    input  logic clk,
    input  logic rst,
    output logic uart_rxd_out
);
    logic [7:0] data_in;
    logic we, busy;
    
//    send_serial send_serial(
//        .clk,
//        .rst,
//        .data_in,
//        .data_out(uart_rxd_out),
//        .we,
//        .busy
//    );

    div_clk#(.WAIT_CNT(10)) div_clk(.clk_in(clk), .rst, .clk_out(uart_rxd_out));

endmodule
