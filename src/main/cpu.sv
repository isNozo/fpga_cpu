`include "lib_cpu.svh"

module cpu import lib_cpu :: *; (
    ctrl_bus_if.master ctrl_bus,
    io_bus_if.master   io_bus,
    mem_bus_if.master  mem_bus
);
    logic [3:0] a, next_a;
    logic [3:0] b, next_b;
    logic       cf, next_cf;
    logic [3:0] ip, next_ip;
    logic [3:0] out, next_out;
    
    always_ff @(posedge ctrl_bus.clk) begin
        if (~ctrl_bus.n_reset) begin 
            a   <= '0;
            b   <= '0;
            cf  <= '0;
            ip  <= '0;
            out <= '0;
        end else begin
            a   <= next_a;
            b   <= next_b;
            cf  <= next_cf;
            ip  <= next_ip;
            out <= next_out;
        end
    end
    
    OPECODE opecode;
    logic [3:0] imm;
    decoder decoder(.data(mem_bus.data), .opecode, .imm);
    assign mem_bus.addr = ip;
    assign io_bus.led   = out;
    
    always_comb begin
        next_a   = a;
        next_b   = b;
        next_cf  = 1'b0;
        next_ip  = ip + 1;
        next_out = out;
        
        unique case (opecode)
            ADD_A_IMM: {next_cf, next_a} = a + imm;
            ADD_B_IMM: {next_cf, next_b} = b + imm;
            MOV_A_IMM: next_a   = imm;
            MOV_B_IMM: next_b   = imm;
            MOV_A_B  : next_a   = b;
            MOV_B_A  : next_b   = a;
            JMP_IMM  : next_ip  = imm;
            JNC_IMM  : next_ip  = cf ? ip + 1 : imm;
            IN_A     : next_a   = io_bus.switch;
            IN_B     : next_b   = io_bus.switch;
            OUT_B    : next_out = b;
            OUT_IMM  : next_out = imm;
            default  : ;
        endcase
    end
endmodule
