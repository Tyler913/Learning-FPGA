`timescale 1ns/1ns

module Stimulation_block_nonblock_assign();

reg sys_clock;
reg sys_reset_n;
reg [1:0] in;

wire [1:0] out;


initial begin
    sys_clock = 1'b1;
    sys_reset_n <= 1'b0;
    in <= 2'b0;
    #20
    sys_reset_n <= 1'b1;
end


always #10 sys_clock = ~sys_clock;
always #20 in <= {$random} % 4;


Block_nonBlock_assign Block_nonBlock_assign_Instance (
    .sys_clock (sys_clock),
    .sys_reset_n (sys_reset_n),
    .in (in),

    .out (out)
);


endmodule
