interface ctrl_bus_if();
    logic clk;
    logic rst;
    modport master(input clk, input rst);
endinterface
