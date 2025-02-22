module Dynamic_Digital_Tube(
    input wire system_clock,
    input wire system_reset_n,

    output wire ds,
    output wire oe,
    output wire shcp,
    output wire stcp
);


wire [19:0] data;
wire [5:0] floating_point;
wire sign;
wire segment_enable;


Data_Generation # (
    .COUNT_100ms_MAX (23 'd 4_999_999),
    .DATA_MAX (20 'd 999_999)
)
Data_Generation_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .data (data),
    .floating_point (floating_point),
    .sign (sign),
    .segment_enable (segment_enable)
);


Segment_595_Dynamic Segment_595_Dynamic_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .data (data),
    .floating_point (floating_point),
    .sign (sign),
    .segment_enable (segment_enable),

    .ds (ds),
    .oe (oe),
    .shcp (shcp),
    .stcp (stcp)
);

endmodule
