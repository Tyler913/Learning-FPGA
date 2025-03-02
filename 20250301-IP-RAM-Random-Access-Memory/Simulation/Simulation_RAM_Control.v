`timescale 1ns / 1ns

module Simulation_RAM_Control();

reg system_clock;
reg system_reset_n;
reg write_flag;
reg read_flag;

wire write_enable;
wire [7:0] address;
wire [7:0] write_data;
wire read_enable;

wire [7:0] data_out;


initial begin
    system_clock = 1 'b 1;
    system_reset_n = 1 'b 0;
    write_flag <= 1 'b 0;
    #20
    system_reset_n = 1 'b 1;
    #1_000
    read_flag <= 1 'b 1;
    #20
    read_flag <= 1 'b 0;
    #60_000
    write_flag <= 1 'b 1;
    #20
    write_flag <= 1 'b 1;

end


always #10 system_clock = ~ system_clock;


RAM_Control # (
    .COUNT_200ms_MAX (24 'd 10)
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
	.q ( data_out )
);


endmodule
