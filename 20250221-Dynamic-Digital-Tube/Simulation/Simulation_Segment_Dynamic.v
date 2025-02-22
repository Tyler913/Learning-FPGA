`timescale 1ns / 1ns

module Simulation_Segment_Dynamic();

reg system_clock;
reg system_reset_n;
reg [19:0] data;
reg [5:0] floating_point;
reg sign;
reg segment_enable;

wire [5:0] selection;
wire [7:0] segment;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    data <= 20 'd 0;
    floating_point <= 6 'b 0;
    sign <= 1 'b 0;
    segment_enable <= 1 'b 0;
    #30
    system_reset_n <= 1 'b 1;
    data <= 20 'd 9876;
    floating_point <= 6 'b 000_010;
    sign <= 1 'b 1;
    segment_enable <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;

defparam Segment_Dynamic_Instance.COUNT_1ms_MAX = 20 'd 5;


Segment_Dynamic Segment_Dynamic_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .data (data),
    .floating_point (floating_point),
    .sign (sign),
    .segment_enable (segment_enable),

    .selection (selection),
    .segment (segment)
);

endmodule
