`timescale 1ns / 1ns

module Simulation_ROM_Control();

reg system_clock;
reg system_reset_n;
reg key1;
reg key2;

wire [7:0] address;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    key1 <= 1 'b 0;
    key2 <= 1 'b 0;
    #30
    system_reset_n <= 1 'b 1;
    #700_000
    key1 <= 1 'b 1;
    #20
    key1 <= 1 'b 0;
    #20_000
    key1 <= 1 'b 1;
    #20
    key1 <= 1 'b 0;
    #600_000

    key2 <= 1 'b 1;
    #20
    key2 <= 1 'b 0;
    #20000
    key2 <= 1 'b 1;
    #20
    key2 <= 1 'b 0;
    #600_000;
end


always #10 system_clock = ~ system_clock;


ROM_Control # (
    .COUNT_200ms_MAX (24 'd 99)
)
ROM_Control_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key1 (key1),
    .key2 (key2),

    .address (address)
);

endmodule
