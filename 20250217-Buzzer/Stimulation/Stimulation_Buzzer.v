`timescale 1ns / 1ns

module Stimulation_Buzzer();

reg system_clock;
reg system_reset_n;

wire buzzer;

initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;


Buzzer # (
    .COUNT_MAX (25 'd 24_999_99),
    .DO (18 'd 19083),
    .RE (18 'd 17006),
    .MI (18 'd 15151),
    .FA (18 'd 14326),
    .SO (18 'd 12755),
    .LA (18 'd 11363),
    .XI (18 'd 10121)
)
Buzzer_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .buzzer (buzzer)
);

endmodule
