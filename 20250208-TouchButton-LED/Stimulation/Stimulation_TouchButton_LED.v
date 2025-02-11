`timescale 1ns / 1ns

module Stimulation_TouchButton_LED();

reg system_clock;
reg system_reset_n;
reg touch_button;

wire led;

initial begin
    system_clock = 1 'b 1;
    system_reset_n = 1 'b 0;
    touch_button <= 1 'b 1;
    #20
    system_reset_n <= 1 'b 1;
    #200
    touch_button <= 1 'b 0;
    #2000
    touch_button <= 1 'b 1;
    #1000
    touch_button <= 1 'b 0;
    #3000
    touch_button <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;


TouchButton_LED TouchButton_LED_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .touch_button (touch_button),

    .led (led)
);

endmodule
