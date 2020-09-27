module top(
    input  logic clk,
    input  logic rst,
    output logic uart_rxd_out
);
    typedef enum {
        SEND,
        WAIT,
        FIN
    } state;
    
    state       st, n_st;
    logic [7:0] data_in;
    logic       we, busy;
    
    send_serial send_serial(
        .clk,
        .rst,
        .data_in,
        .data_out(uart_rxd_out),
        .we,
        .busy
    );
    
    assign data_in = 8'h41;
    
    always_comb begin
        we = 1'b0;
        n_st = st;
        
        case (st)
            SEND: begin
                n_st = WAIT;
                we = 1'b1;
            end
            WAIT: begin
                if (~busy) n_st = FIN; 
            end
            FIN:;
            default:;
        endcase
    end
    
    always_ff @(posedge clk) begin
        if (~rst) st <= SEND;
        else      st <= n_st;
    end
endmodule
