module Segment_595_Dynamic(
    input wire system_clock,
    input wire system_reset_n,
    input wire [19:0] data,
    input wire [5:0] floating_point,
    input wire sign,
    input wire segment_enable,

    output wire ds,
    output wire oe,
    output wire shcp,
    output wire stcp
);


wire [5:0] selection;
wire [7:0] segment;


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


hc595_control hc595_control_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .selection (selection),
    .seg (segment),

    .ds (ds),
    .shcp (shcp),
    .stcp (stcp),
    .oe (oe)
);

endmodule
