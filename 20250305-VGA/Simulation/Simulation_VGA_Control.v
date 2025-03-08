`timescale 1ns / 1ns


module Simulation_VGA_Control();


reg system_clock;
reg system_reset_n;

wire vga_clock;
wire locked;

wire rest_n;

wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire hsync;
wire vsync;
wire [15:0] vga_rgb;
reg [15:0] pixel_data;


initial begin
    system_clock = 1'b0;
    system_reset_n = 1'b0;
    #20;
    system_reset_n = 1'b1;
end

always #10 system_clock = ~system_clock;


assign rest_n = locked & system_reset_n;


always @(posedge vga_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        pixel_data <= 16'h0000;
    end
    else if (pixel_x >= 10 'd 0 && pixel_x <= 10 'd 639
            && pixel_y >= 10 'd 0 && pixel_y <= 10 'd 479) begin
        pixel_data <= 16'hFFFF;
    end
    else begin
        pixel_data <= 16'h0000;
    end
end


pll	pll_inst (
	.areset (~ system_reset_n ),
	.inclk0 ( system_clock ),

	.c0 ( vga_clock ),
	.locked ( locked )
	);


VGA_Control VGA_Control_Instance(
    .system_clock (vga_clock),
    .system_reset_n (rest_n),
    .pixel_data (pixel_data),

    .pixel_x (pixel_x),
    .pixel_y (pixel_y),
    .hsync (hsync),
    .vsync (vsync),
    .vga_rgb (vga_rgb)
);

endmodule
