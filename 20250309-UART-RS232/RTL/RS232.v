module RS232(
    input wire system_clock,
    input wire system_reset_n,
    input wire rx,

    output wire tx
);


wire [7:0] rx_data;
wire rx_flag;


UART_RX # (
    .UART_BAUD_RATE('d9600),
    .CLOCK_FREQ('d50_000_000)
)
UART_RX_INST(
    .system_clock(system_clock),
    .system_reset_n(system_reset_n),
    .rx(rx),
    .po_data(rx_data),
    .po_flag(rx_flag)
);


UART_TX # (
    .UART_BAUD_RATE('d9600),
    .CLOCK_FREQ('d50_000_000)
)
UART_TX_INST(
    .system_clock(system_clock),
    .system_reset_n(system_reset_n),
    .pi_data(pi_data),
    .pi_flag(pi_flag),
    .tx(tx)
);


endmodule
