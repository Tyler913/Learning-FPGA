module FIFO(
    input wire system_clock,
    input wire [7:0] i_data,
    input wire write_request,
    input wire read_request,

    output wire empty,
    output wire full,
    output wire [7:0] o_data,
    output wire [7:0] usedw
);


fifo_s_8x256	fifo_s_8x256_inst (
	.clock ( system_clock ),
	.data ( i_data ),
	.rdreq ( read_request ),
	.wrreq ( write_request ),
	.empty ( empty ),
	.full ( full ),
	.q ( o_data ),
	.usedw ( usedw )
);

endmodule
