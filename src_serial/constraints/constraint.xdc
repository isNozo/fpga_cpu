# https://github.com/Digilent/digilent-xdc/blob/master/Arty-S7-50-Master.xdc

## Clock Signals
set_property -dict { PACKAGE_PIN R2    IOSTANDARD SSTL135 } [get_ports { clk }]; #IO_L12P_T1_MRCC_34 Sch=ddr3_clk[200]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5.000}  [get_ports { clk }]; # 100MHZ

## Misc. ChipKit Ports
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { ck_ioa }]; #IO_25_15 Sch=ck_ioa
set_property -dict { PACKAGE_PIN C18   IOSTANDARD LVCMOS33 } [get_ports { neg_rst }]; #IO_L11N_T1_SRCC_15

## USB-UART Interface
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out }]; #IO_25_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in }]; #IO_L24N_T3_A00_D16_14 Sch=uart_txd_in
