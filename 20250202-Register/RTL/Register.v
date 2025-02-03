module Register(
    input wire sys_clock,
    input wire sys_reset_n,
    input wire key_in,

    output reg led_out
);

always @(posedge sys_clock) // or negedge sys_reset_n)
    if (sys_reset_n == 1'b0)
        led_out <= 1'b0;
    else
        led_out <= key_in;

endmodule
