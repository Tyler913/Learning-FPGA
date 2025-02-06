`timescale 1ns/1ns

module Stimulation_Counter();

reg system_clock;
reg system_reset_n;

wire led_out;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1'b 1;
end


always #10 system_clock = ~system_clock;


initial begin
    $timeformat(-9, 0, "ns", 6);
    $monitor("@time %t: led_out = %b", $time, led_out);
end


Counter #(
    .CONSTANT_MAX (25 'd 24)
) 
Counter_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .led_out (led_out)
);


endmodule
