`timescale 1ns / 1ns

module Stimulation_Waterflow_LED();

reg system_clock;
reg system_reset_n;

wire [3:0] led_out;

initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;


Waterflow_LED # (
    .COUNT_MAX (25 'd 24)
)
Waterflow_LED_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .led_out (led_out)
);

endmodule
