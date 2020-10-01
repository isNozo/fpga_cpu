`include "lib_cpu.svh"

module alu import lib_cpu :: *; (
    input  OPECODE     opecode,
    input  logic [7:0] imm,
    input  logic [3:0] switch,
    input  REGS        current,
    output REGS        next
);
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
            IN_A     : next.a   = {current.a[7:4], switch};
            IN_B     : next.b   = {current.b[7:4], switch};
            OUT_B    : next.out = current.b;
            OUT_IMM  : next.out = imm;
            default  : ;
        endcase
    end
endmodule
