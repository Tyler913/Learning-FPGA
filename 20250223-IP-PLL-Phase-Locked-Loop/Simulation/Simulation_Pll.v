`timescale 1ns / 1ns

module Simulation_Pll();


reg system_clock;
wire clock_multiple_2;
wire clock_division_2;
wire clock_phase_90;
wire clock_duty_cycle_20;
wire locked;

initial system_clock = 1 'b 1;

always #10 system_clock = ~ system_clock;


pll pll_Instance (
    .system_clock       (system_clock),
    
    .clock_multiple_2   (clock_multiple_2),
    .clock_division_2   (clock_division_2),
    .clock_phase_90     (clock_phase_90),
    .clock_duty_cycle_20(clock_duty_cycle_20),
    .locked             (locked)
);

endmodule
