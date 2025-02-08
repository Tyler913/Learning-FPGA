`timescale 1ns/1ns

module Stimulation_Frequency_Division_Odd();

reg system_clock;
reg system_reset_n;

wire division_clock;

initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;

Frequency_Division_Odd Stimulation_Frequency_Division_Odd(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .division_clock_flag (division_clock)
);

endmodule
