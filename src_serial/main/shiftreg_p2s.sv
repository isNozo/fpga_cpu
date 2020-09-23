module shiftreg_p2s #(parameter N) (
    input  logic         clk, rst, we,
    input  logic         sin,
    input  logic [N-1:0] pin,
    output logic         sout
);
    logic [N-1:0] data_reg, n_data_reg;
    
    assign sout = data_reg[0];
    
    always_comb begin
        if (we) n_data_reg = pin;
        else    n_data_reg = {sin, data_reg[N-1:1]};
    end
    
    always_ff @(posedge clk) begin
        if (~rst) data_reg <= 0;
        else      data_reg <= n_data_reg;
    end
endmodule
