module VGA_Pixel(
    input wire system_clock,
    input wire system_reset_n,
    input wire [9:0] pixel_x,
    input wire [9:0] pixel_y,

    output reg [15:0] pixel_data
);


parameter H_VALID = 10'd640;
parameter V_VALID = 10'd480;

parameter RED = 16'hF800;
parameter ORANGE = 16'hFC00;
parameter YELLOW = 16'hFFE0;
parameter GREEN = 16'h07E0;
parameter CYAN = 16'h07FF;
parameter BLUE = 16'h001F;
parameter PURPLE = 16'hF81F;
parameter BLACK = 16'h0000;
parameter WHITE = 16'hFFFF;
parameter GRAY = 16'h8410;
    

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        pixel_data <= BLACK;
    end
    else if (pixel_x >= 0 && pixel_x < (H_VALID / 10) * 1) begin
        pixel_data <= RED;
    end
    else if (pixel_x >= (H_VALID / 10) * 1 && pixel_x < (H_VALID / 10) * 2) begin
        pixel_data <= ORANGE;
    end
    else if (pixel_x >= (H_VALID / 10) * 2 && pixel_x < (H_VALID / 10) * 3) begin
        pixel_data <= YELLOW;
    end
    else if (pixel_x >= (H_VALID / 10) * 3 && pixel_x < (H_VALID / 10) * 4) begin
        pixel_data <= GREEN;
    end
    else if (pixel_x >= (H_VALID / 10) * 4 && pixel_x < (H_VALID / 10) * 5) begin
        pixel_data <= CYAN;
    end
    else if (pixel_x >= (H_VALID / 10) * 5 && pixel_x < (H_VALID / 10) * 6) begin
        pixel_data <= BLUE;
    end
    else if (pixel_x >= (H_VALID / 10) * 6 && pixel_x < (H_VALID / 10) * 7) begin
        pixel_data <= PURPLE;
    end
    else if (pixel_x >= (H_VALID / 10) * 7 && pixel_x < (H_VALID / 10) * 8) begin
        pixel_data <= BLACK;
    end
    else if (pixel_x >= (H_VALID / 10) * 8 && pixel_x < (H_VALID / 10) * 9) begin
        pixel_data <= WHITE;
    end
    else if (pixel_x >= (H_VALID / 10) * 9 && pixel_x < H_VALID) begin
        pixel_data <= GRAY;
    end
    else begin
        pixel_data <= BLACK;
    end
end

endmodule
