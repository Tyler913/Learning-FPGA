`timescale 1ns / 1ns

module Simulation_Data_Generation();

reg system_clock;
reg system_reset_n;

wire [19:0] data;
wire [5:0] floating_point;
wire sign;
wire segment_enable;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end


always #20 system_clock = ~ system_clock;


Data_Generation # (
    .COUNT_100ms_MAX (9),
    .DATA_MAX (9)
)
Data_Generation_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .data (data),
    .floating_point (floating_point),
    .sign (sign),
    .segment_enable (segment_enable)
);

endmodule
