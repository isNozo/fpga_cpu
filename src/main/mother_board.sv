module mother_board(
    ctrl_bus_if.master ctrl_bus,
    input  logic [3:0] switch,
    output logic [3:0] led
);
    logic [7:0] data;
    logic [3:0] addr;
    
    cpu cpu(.ctrl_bus, .data, .switch, .addr, .led);
    rom rom(.addr, .data);
endmodule
