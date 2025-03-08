module VGA(
    input wire system_clock,
    input wire system_reset_n,

    output wire hsync,
    output wire vsync,
    output wire [15:0] vga_rgb
);


wire vga_clock;
wire locked;
wire rest_n;

wire [9:0] pixel_x;
wire [9:0] pixel_y;


assign rest_n = locked & system_reset_n;


pll	pll_inst (
	.areset ( ~ system_reset_n ),
	.inclk0 ( system_clock ),

	.c0 ( vga_clock ),
	.locked ( locked )
);


VGA_Control VGA_Control_Instance(
    .system_clock ( vga_clock ),
    .system_reset_n ( rest_n ),
    .pixel_data ( pixel_data ),

    .pixel_x ( pixel_x ),
    .pixel_y ( pixel_y ),
    .hsync ( hsync ),
    .vsync ( vsync ),
    .vga_rgb ( vga_rgb )
);


VGA_Pixel VGA_Pixel_Instance(
    .system_clock ( vga_clock ),
    .system_reset_n ( rest_n ),
    .pixel_x ( pixel_x ),
    .pixel_y ( pixel_y ),
    
    .pixel_data ( pixel_data )
);

endmodule
