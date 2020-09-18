`include "lib_cpu.svh"

module cpu import lib_cpu :: *; (
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master   io_bus,
    mem_bus_if.master  mem_bus
);
    REGS current, next;
    
    always_ff @(posedge ctrl_bus.clk) begin
        if (~ctrl_bus.n_reset) current <= '0;
        else                   current <= next;
    end
    
    OPECODE opecode;
    logic [3:0] imm;
    decoder decoder(.data(mem_bus.data), .opecode, .imm);
    assign mem_bus.addr = current.ip;
    assign io_bus.led   = current.out;
    
    always_comb begin
        next = current;
        next.cf = 1'b0;
        next.ip = current.ip + 1;
        
        unique case (opecode)
            ADD_A_IMM: {next.cf, next.a} = current.a + imm;
            ADD_B_IMM: {next.cf, next.b} = current.b + imm;
            MOV_A_IMM: next.a   = imm;
            MOV_B_IMM: next.b   = imm;
            MOV_A_B  : next.a   = current.b;
            MOV_B_A  : next.b   = current.a;
            JMP_IMM  : next.ip  = imm;
            JNC_IMM  : next.ip  = current.cf ? current.ip + 1 : imm;
            IN_A     : next.a   = io_bus.switch;
            IN_B     : next.b   = io_bus.switch;
            OUT_B    : next.out = current.b;
            OUT_IMM  : next.out = imm;
            default  : ;
        endcase
    end
endmodule
