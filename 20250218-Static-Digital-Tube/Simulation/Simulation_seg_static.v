`timescale 1ns / 1ns

module Simulation_seg_static();

reg system_clock;
reg system_reset_n;

wire [5:0] selection;
wire [7:0] seg;


initial begin
    system_clock = 1 'b 1;
    system_reset_n = 1 'b 0;
    #20
    system_reset_n = 1 'b 1;
end

always #10 system_clock = ~ system_clock;


seg_static # (
    .COUNT_MAX (25 'd 24)
)
seg_static_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .selection (selection),
    .seg (seg)
);

endmodule
