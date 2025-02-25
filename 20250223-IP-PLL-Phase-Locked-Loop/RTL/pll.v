module pll(
    input wire system_clock,
    
    output wire clock_multiple_2,
    output wire clock_division_2,
    output wire clock_phase_90,
    output wire clock_duty_cycle_20,
    output wire locked
);


PLL	PLL_inst (
	.inclk0 ( system_clock ),
	.c0 ( clock_multiple_2 ),
	.c1 ( clock_division_2 ),
	.c2 ( clock_phase_90 ),
	.c3 ( clock_duty_cycle_20 ),
	.locked ( locked )
	);

endmodule
