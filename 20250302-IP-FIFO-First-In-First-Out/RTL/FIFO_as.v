module FIFO_as(
    input wire write_clock,
    input wire write_request,
    input wire [7:0] write_data,
    input wire read_clock,
    input wire read_request,
    
    output wire [15:0] read_data,
    output wire write_empty,
    output wire write_full,
    output wire [8:0] write_usedw,
    output wire read_empty,
    output wire read_full,
    output wire [7:0] read_usedw
);


fifo_as_8x256	fifo_as_8x256_inst (
	.data ( write_data ),
	.rdclk ( read_clock ),
	.rdreq ( read_request ),
	.wrclk ( write_clock ),
	.wrreq ( write_request ),

	.q ( read_data ),
	.rdempty ( read_empty ),
	.rdfull ( read_full ),
	.rdusedw ( read_usedw ),
	.wrempty ( write_empty ),
	.wrfull ( write_full ),
	.wrusedw ( write_usedw )
);

endmodule
