module top(
    input  logic       pin_clock,
    input  logic       pin_n_reset,
    input  logic [3:0] pin_switch,
    output logic [3:0] pin_led
);    
    logic clk;
    prescaler #(.RATIO(100_000_000)) prescaler(
        .quick_clock(pin_clock),
        .slow_clock(clk)
    );
    
    ctrl_bus_if ctrl_bus();
    assign ctrl_bus.clk     = clk;
    assign ctrl_bus.n_reset = pin_n_reset;
    
    mother_board mother_board(.ctrl_bus, .switch(pin_switch), .led(pin_led));
endmodule
