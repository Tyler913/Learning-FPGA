module VGA_Control(
    input wire system_clock,
    input wire system_reset_n,
    input wire [15:0] pixel_data,

    output wire [9:0] pixel_x,
    output wire [9:0] pixel_y,
    output wire hsync,
    output wire vsync,
    output wire vga_rgb
);


parameter H_SYNC = 10 'd 96;
parameter H_BACK = 10 'd 40;
parameter H_LEFT = 10 'd 8;
parameter H_VALID = 10 'd 640;
parameter H_RIGHT = 10 'd 8;
parameter H_FRONT = 10 'd 8;
parameter H_TOTAL = 10 'd 800;

parameter V_SYNC = 10 'd 2;
parameter V_BACK = 10 'd 25;
parameter V_TOP = 10 'd 8;
parameter V_VALID = 10 'd 480;
parameter V_BOTTOM = 10 'd 8;
parameter V_FRONT = 10 'd 2;
parameter V_TOTAL = 10 'd 525;


reg [9:0] count_h;
reg [9:0] count_v;
wire rgb_valid;
wire pixel_data_request;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_h <= 10 'b 0;
    end
    else if (count_h == H_TOTAL - 1 'b 1) begin
        count_h <= 10 'd 0;
    end
    else begin
        count_h <= count_h + 1 'b 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_v <= 10 'd 0;
    end
    else if ((count_v == V_TOTAL - 1 'b 1) && (count_h == H_TOTAL - 1 'b 1)) begin
        count_v <= 10 'd 0;
    end
    else if (count_h == H_TOTAL - 1 'b 1) begin
        count_v <= count_v + 1 'b 1;
    end
    else begin
        count_v <= count_v;
    end
end

assign rgb_valid = ((count_h >= H_SYNC + H_BACK + H_LEFT)
                && (count_h < H_SYNC + H_BACK + H_LEFT + H_VALID)
                && (count_v >= V_SYNC + V_BACK + V_TOP)
                && (count_v < V_SYNC + V_BACK + V_TOP + V_VALID));

assign pixel_data_request = ((count_h >= H_SYNC + H_BACK + H_LEFT - 1 'd 1)
                && (count_h < H_SYNC + H_BACK + H_LEFT + H_VALID - 1 'd 1)
                && (count_v >= V_SYNC + V_BACK + V_TOP)
                && (count_v < V_SYNC + V_BACK + V_TOP + V_VALID));

assign pixel_x = (rgb_valid == 1 'b 1) ? (count_h - (H_SYNC + H_BACK + H_LEFT) - 1 'b 1) : 10 'd 0;

assign pixel_y = (rgb_valid == 1 'b 1) ? (count_v - (V_SYNC + V_BACK + V_TOP)) : 10 'd 0;

assign hsync = (count_h <= H_SYNC) ? 1 'b 1 : 1 'b 0;

assign vsync = (count_v <= V_SYNC) ? 1 'b 1 : 1 'b 0;

assign vga_rgb = (rgb_valid == 1 'b 1) ? pixel_data : 16 'd 0;

endmodule
