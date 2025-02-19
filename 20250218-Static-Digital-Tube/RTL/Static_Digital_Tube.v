module Static_Digital_Tube(
    input wire system_clock,
    input wire system_reset_n,

    output wire ds,
    output wire shcp,
    output wire stcp,
    output wire oe
);


wire [5:0] selection;
wire [7:0] seg;


seg_static #(
    .COUNT_MAX (25 'd 24_999_999)
)
seg_static_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .selection (selection),
    .seg (seg)
);


hc595_control hc595_control_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .selection (selection),
    .seg (seg),

    .ds (ds),
    .shcp (shcp),
    .stcp (stcp),
    .oe (oe)
);

endmodule
