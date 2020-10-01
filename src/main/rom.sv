module rom(
    mem_bus_if.slave mem_bus
);
    logic [15:0] rom_array [256];
    initial $readmemh("rom_data.mem", rom_array);
    assign mem_bus.data = rom_array[mem_bus.addr];
endmodule
