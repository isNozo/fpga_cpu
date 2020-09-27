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
    logic [3:0] byte_cnt, n_byte_cnt;
    
    send_serial send_serial(
        .clk,
        .rst,
        .data_in,
        .data_out(uart_rxd_out),
        .we,
        .busy
    );
    
    always_comb begin
        case (byte_cnt)
            4'd0 : data_in = 8'h48; // H
            4'd1 : data_in = 8'h65; // e
            4'd2 : data_in = 8'h6c; // l
            4'd3 : data_in = 8'h6c; // l
            4'd4 : data_in = 8'h6f; // o
            4'd5 : data_in = 8'h2c; // ,
            4'd6 : data_in = 8'h20; //  
            4'd7 : data_in = 8'h46; // F
            4'd8 : data_in = 8'h50; // P
            4'd9 : data_in = 8'h47; // G
            4'd10: data_in = 8'h41; // A
            4'd11: data_in = 8'h0a; // \n
            default: data_in = 8'h00;
        endcase
    end
    
    always_comb begin
        we = 1'b0;
        n_st = st;
        n_byte_cnt = byte_cnt;
        
        case (st)
            SEND: begin
                n_st = WAIT;
                we = 1'b1;
            end
            WAIT: begin
                if (~busy) begin
                    if (byte_cnt == 11) begin
                        n_st = FIN;
                    end else begin
                        n_st = SEND;
                        n_byte_cnt = byte_cnt + 1;
                    end
                end
            end
            FIN:;
            default:;
        endcase
    end
    
    always_ff @(posedge clk) begin
        if (~rst) begin
            st       <= SEND;
            byte_cnt <= 0;
        end else begin
            st       <= n_st;
            byte_cnt <= n_byte_cnt;
        end
    end
endmodule
