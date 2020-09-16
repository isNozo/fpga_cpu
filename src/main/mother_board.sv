module mother_board(
    input  logic       clk,
    input  logic       n_reset,
    input  logic [3:0] switch,
    output logic [3:0] led
);
    logic [7:0] data;
    logic [3:0] addr;
    
    cpu cpu(.clk, .n_reset, .data, .switch, .addr, .led);
    rom rom(.addr, .data);
endmodule
