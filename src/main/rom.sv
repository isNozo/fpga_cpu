module rom(
    input  logic [3:0] addr,
    output logic [7:0] data
);
    logic [7:0] rom_array [16];
    initial $readmemh("rom_data.mem", rom_array);
    assign data = rom_array[addr];
endmodule
