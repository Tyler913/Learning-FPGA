`timescale 1ns / 1ns

module Simulation_ROM(); 

reg system_clock;
reg system_reset_n;
reg key1;
reg key2;

wire ds;
wire oe;
wire shcp;
wire stcp;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    key1 <= 1 'b 1;
    key2 <= 1 'b 1;
    #20
    system_reset_n <= 1 'b 1;

    #700_000
    key1 <= 1 'b 0;
    #20
    key1 <= 1 'b 0;
end


always #10 system_clock = ~ system_clock;


ROM ROM_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key1 (key1),
    .key2 (key2),

    .ds (ds),
    .oe (oe),
    .shcp (shcp),
    .stcp (stcp)
);

endmodule
