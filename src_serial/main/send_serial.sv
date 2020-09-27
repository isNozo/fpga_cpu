module send_serial #(parameter WAIT_DIV=868) (
    input  logic       clk, rst,
    input  logic [7:0] data_in,
    output logic       data_out,
    input  logic       we,
    output logic       busy
);
    localparam WAIT_LEN = $clog2(WAIT_DIV);
    
    typedef enum {
        IDLE,
        SEND
    } state;
    
    state                st, n_st;
    logic [9:0]          data, n_data;
    logic [WAIT_LEN-1:0] wait_cnt, n_wait_cnt;
    logic [3:0]          bit_cnt, n_bit_cnt;
    
    assign data_out = data[0];
    
    always_comb begin
        busy       = 1'b0;
        n_st       = st;
        n_data     = data;
        n_wait_cnt = wait_cnt;
        n_bit_cnt  = bit_cnt;
        
        case(st)
            IDLE: begin
                if (we) begin
                    n_st   = SEND;
                    n_data = {1'b1, data_in, 1'b0};
                end
            end
            SEND: begin
                busy = 1'b1;
                
                if (wait_cnt == WAIT_DIV - 1) begin
                    n_wait_cnt = 0;
                    
                    if (bit_cnt == 4'd9) begin
                        n_bit_cnt = 0;
                        n_st      = IDLE;
                    end else begin
                        n_bit_cnt = bit_cnt + 1;
                        n_data    = {1'b1, data[9:1]};
                    end
                end else begin
                    n_wait_cnt = wait_cnt + 1;
                end
            end
            default: ;
        endcase
    end
    
    always_ff @(posedge clk) begin
        if (~rst) begin
            st       <= IDLE;
            data     <= 0;
            wait_cnt <= 0;
            bit_cnt  <= 0;
        end else begin
            st       <= n_st;
            data     <= n_data;
            wait_cnt <= n_wait_cnt;
            bit_cnt  <= n_bit_cnt;
        end
    end
endmodule
