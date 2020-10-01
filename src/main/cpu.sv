`include "lib_cpu.svh"

module cpu import lib_cpu :: *; (
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master   io_bus,
    mem_bus_if.master  mem_bus
);
    OPECODE opecode;
    logic [7:0] imm;
    decoder decoder(.data(mem_bus.data), .opecode, .imm);
    
    REGS current, next;
    assign mem_bus.addr = current.ip;
    assign io_bus.led   = current.out;
    
    alu alu(.opecode, .imm, .switch(io_bus.switch), .current, .next);
    write_reg write_reg(.ctrl_bus, .next, .current);
endmodule
