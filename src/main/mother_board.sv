module mother_board(
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master   io_bus
);
    logic [7:0] data;
    logic [3:0] addr;
    
    cpu cpu(.ctrl_bus, .io_bus, .data, .addr);
    rom rom(.addr, .data);
endmodule
