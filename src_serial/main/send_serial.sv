module send_serial(
    input  logic       clk, rst,
    input  logic [7:0] data_in,
    output logic       data_out,
    input  logic       we,
    output logic       busy
);
    shiftreg_p2s#(.N(10)) shiftreg_p2s(
        .clk, .rst, .we,
        .sin(1'b1),
        .pin({1'b1, data_in, 1'b0}),
        .sout(data_out)
    );
endmodule
