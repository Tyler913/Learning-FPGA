`timescale 1ms / 1ns

module Simulation_BCD_8421();

reg system_clock;
reg system_reset_n;
reg [19:0] data;

wire [3:0] one;
wire [3:0] ten;
wire [3:0] hundred;
wire [3:0] thousand;
wire [3:0] ten_thousand;
wire [3:0] hundred_thousand;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
    data <= 20 'd 123_456;
    #3000
    data <= 20 'd 654_321;
    #3000
    data <= 20 'd 987_654;
    #3000
    data <= 20 'd 999_999;
end

always #10 system_clock = ~ system_clock;

BDC_8421 BDC_8421_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .data (data),

    .one (one),
    .ten (ten),
    .hundred (hundred),
    .thousand (thousand),
    .ten_thousand (ten_thousand),
    .hundred_thousand (hundred_thousand)
);

endmodule
