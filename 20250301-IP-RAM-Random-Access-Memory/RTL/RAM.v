module RAM(
    input wire system_clock,
    input wire system_reset_n,
    input wire write_key,
    input wire read_key,

    output wire ds,
    output wire oe,
    output wire shcp,
    output wire stcp
);


wire write_flag;
wire read_flag;

wire write_enable;
wire [7:0] address;
wire [7:0] write_data;
wire read_enable;

wire [7:0] out_data;


Button_Debounce # (
    .COUNT_MAX (20 'd 999_999)
)
Button_Debounce_Instance_Write (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key_in (write_key),

    .key_flag (write_flag)
);

Button_Debounce # (
    .COUNT_MAX (20 'd 999_999)
)
Button_Debounce_Instance_Read (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key_in (read_key),

    .key_flag (read_flag)
);


RAM_Control # (
    .COUNT_200ms_MAX (24 'd 9_999_999)
)
RAM_Control_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .write_flag (write_flag),
    .read_flag (read_flag),

    .write_enable (write_enable),
    .address (address),
    .write_data (write_data),
    .read_enable (read_enable)
);


ram_8x256_single	ram_8x256_single_inst (
	.aclr ( ~ system_reset_n ),
	.address ( address ),
	.clock ( system_clock ),
	.data ( write_data ),
	.rden ( read_enable ),
	.wren ( write_enable ),
	.q ( out_data )
);


seg_595_dynamic seg_595_dynamic_instance (
    .sys_clk (system_clock),
    .sys_rst_n (system_reset_n),
    .data ({12 'd 0, out_data}),
    .point (6 'b 000_000),
    .sign (1 'b 0),
    .seg_en ( 1 'b 1),

    .ds (ds),
    .oe (oe),
    .shcp (shcp),
    .stcp (stcp)
);

endmodule
