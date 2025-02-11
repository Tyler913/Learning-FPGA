`timescale 1ns / 1ns

module Stimulation_Breathing_LED();

reg system_clock;
reg system_reset_n;

wire led_out;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;


Breathing_LED # (
    .COUNT_1us_MAX (6 'd 4),
    .COUNT_1ms_MAX (10 'd 9),
    .COUNT_1s_MAX (10 'd 9)
)
Breathing_LED_Stimulation (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .led_out (led_out)
);

endmodule
