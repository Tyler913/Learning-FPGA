`timescale 1ns/1ns

module Stimulation_Register();

reg sys_clock;
reg sys_reset_n;
reg key_in;

wire led_out;


initial begin
    sys_clock = 1'b0;
    sys_reset_n <= 1'b0;
    key_in <= 1'b0;
    #20
    sys_reset_n <= 1'b1;
    #210
    sys_reset_n <= 0'b0;
    #40
    sys_clock <= 1'b1;
end


always #10 sys_clock = ~sys_clock;

always #20 key_in <= {$random} % 2;


initial begin
    $timeformat (-9, 0, "ns", 6);
    $monitor ("@time %t : key_in = %b, led_out = %b", $time, key_in, led_out);
end


Register Register_Instance (
    .sys_clock (sys_clock),
    .sys_reset_n (sys_reset_n),
    .key_in (key_in),

    .led_out (led_out)
);

endmodule
