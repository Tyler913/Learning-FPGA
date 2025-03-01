module ROM(
    input wire system_clock, 
    input wire system_reset_n,
    input wire key1,
    input wire key2,

    output wire ds,
    output wire oe,
    output wire shcp,
    output wire stcp
);


wire key1_flag;
wire key2_flag;
wire [7:0] address;
wire [7:0] data;


Button_Debounce # (
    .COUNT_MAX (20 'd 999_999)
)
Button_Debounce_Instance_1 (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key_in (key1),

    .key_flag (key1_flag)
);


Button_Debounce # (
    .COUNT_MAX (20 'd 999_999)
)
Button_Debounce_Instance_2 (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key_in (key2),

    .key_flag (key2_flag)
);


ROM_Control # (
    .COUNT_200ms_MAX (24 'd 9_999_999)
)
ROM_Control_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key1 (key1_flag),
    .key2 (key2_flag),

    .address (address)
);


ROM_8x256	ROM_8x256_inst (
	.address ( address ),
	.clock ( system_clock ),
	.q ( data )
);


seg_595_dynamic seg_595_dynamic_Instance (
    .sys_clk (system_clock),
    .sys_rst_n (system_reset_n),
    .data ({12 'b 0, data}),
    .point (6 'b 000_000),
    .sign (1 'b 0),
    .seg_en (1 'b 1),

    .ds (ds),
    .oe (oe), 
    .shcp (shcp),
    .stcp (stcp)
);


endmodule
