`timescale 1ns / 1ns

module Simulation_UART_RX();


reg system_clock;
reg system_reset_n;
reg rx;

wire [7:0] po_data;
wire po_flag;


initial begin
    system_clock = 1 'b 0;
    system_reset_n <= 1 'b 0;
    rx <= 1 'b 1;
    #20
    system_reset_n <= 1 'b 1;
end

initial begin
    #200
    rx_bit(8 'd 0);
    rx_bit(8 'd 1);
    rx_bit(8 'd 2);
    rx_bit(8 'd 3);
    rx_bit(8 'd 4);
    rx_bit(8 'd 5);
    rx_bit(8 'd 6);
    rx_bit(8 'd 7);
end


always #10 system_clock = ~system_clock;


task rx_bit (
    input [7:0] data
);

integer i;

for (i = 0 ; i < 10 ; i = i + 1) begin
    case (i)
        0: rx <= 1 'b 0;
        1: rx <= data[0];
        2: rx <= data[1];
        3: rx <= data[2];
        4: rx <= data[3];
        5: rx <= data[4];
        6: rx <= data[5];
        7: rx <= data[6];
        8: rx <= data[7];
        9: rx <= 1 'b 1;
    endcase
    #(5_208*20);
end

endtask


UART_RX # (
    .UART_BAUD_RATE('d 9600),
    .CLOCK_FREQ('d 50_000_000)
)
UART_RX_Instance (
    .system_clock(system_clock),
    .system_reset_n(system_reset_n),
    .rx(rx),

    .po_data(po_data),
    .po_flag(po_flag)
);

endmodule
