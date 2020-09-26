module div_clk #(parameter WAIT_CNT) (
    input  logic clk_in, rst,
    output logic clk_out
);
    localparam WAIT_LEN = $clog2(WAIT_CNT);
    
    logic [WAIT_LEN-1:0] cnt, n_cnt;
    logic gen_clk, n_gen_clk;
    
    assign clk_out = gen_clk;
    
    always_comb begin
        if (cnt == (WAIT_CNT-1)) begin
            n_cnt     = 0;
            n_gen_clk = ~gen_clk;
        end else begin
            n_cnt     = cnt + 1;
            n_gen_clk = gen_clk;
        end
    end
    
    always_ff @(posedge clk_in) begin
        if (~rst) begin
            cnt     <= 0;
            gen_clk <= 0;
        end else begin
            cnt     <= n_cnt;
            gen_clk <= n_gen_clk;
        end
    end
endmodule