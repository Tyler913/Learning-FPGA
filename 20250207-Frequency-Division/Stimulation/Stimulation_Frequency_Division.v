`timescale 1ns/1ns

module Stimulation_Frequency_Division();

reg system_clock;
reg system_reset_n;

wire clock_flag;

initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;

Freequency_Division Stimulation_Frequency_Division(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .clock_flag (clock_flag)
);

endmodule
