module TouchButton_LED(
    input wire system_clock,
    input wire system_reset_n,
    input wire touch_button,

    output reg led
);

reg touch_key_1;
reg touch_key_2;
wire touch_flag;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        touch_key_1 <= 1 'b 1;
        touch_key_2 <= 1 'b 1;
    end
    else begin
        touch_key_1 <= touch_button;
        touch_key_2 <= touch_key_1;
    end
end

assign touch_flag = (touch_key_1 == 1 'b 0) && (touch_key_2 == 1 'b 1);

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        led <= 1 'b 1;
    end
    else if (touch_flag == 1 'b 1) begin
        led <= ~ led;
    end
    else begin
        led <= led;
    end
end

endmodule
