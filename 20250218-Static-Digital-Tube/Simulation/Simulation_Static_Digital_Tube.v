`timescale 1ns / 1ns

module Simulation_Static_Digital_Tube();

reg system_clock;
reg system_reset_n;

wire ds;
wire shcp;
wire stcp;
wire oe;

wire [5:0] selection;
wire [7:0] seg;


initial begin
    system_clock = 1 'b 1;
    system_reset_n = 1 'b 0;
    #20
    system_reset_n = 1 'b 1;
end

always #10 system_clock = ~ system_clock;


Static_Digital_Tube Static_Digital_Tube_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),

    .ds (ds),
    .shcp (shcp),
    .stcp (stcp),
    .oe (oe)
);

endmodule
