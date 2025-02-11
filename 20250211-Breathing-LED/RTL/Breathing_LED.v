module Breathing_LED # (
    parameter COUNT_1us_MAX = 6 'd 49,
    parameter COUNT_1ms_MAX = 10 'd 999,
    parameter COUNT_1s_MAX = 10 'd 999
)
(
    input wire system_clock,
    input wire system_reset_n,

    output reg led_out
);

reg [5:0] count_1us;
reg [9:0] count_1ms;
reg [9:0] count_1s;
reg count_enable;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_1us <= 6 'd 0;
    end
    else if (count_1us == COUNT_1us_MAX) begin
        count_1us <= 6 'd 0;
    end
    else begin
        count_1us <= count_1us + 6 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_1ms <= 10 'd 0;
    end
    else if ((count_1ms == COUNT_1ms_MAX) && (count_1us == COUNT_1us_MAX)) begin
        count_1ms <= 10 'd 0;
    end
    else if (count_1us == COUNT_1us_MAX) begin
        count_1ms <= count_1ms + 10 'd 1;
    end
    else begin
        count_1ms <= count_1ms;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_1s <= 10 'd 0;
    end
    else if ((count_1s == COUNT_1s_MAX) && (count_1ms == COUNT_1ms_MAX) && (count_1us == COUNT_1us_MAX)) begin
        count_1s <= 10 'd 0;
    end
    else if ((count_1ms == COUNT_1ms_MAX) && (count_1us == COUNT_1us_MAX)) begin
        count_1s <= count_1s + 10 'd 1;
    end
    else begin
        count_1s <= count_1s;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_enable <= 1 'b 0;
    end
    else if ((count_1s == COUNT_1s_MAX) && (count_1ms == COUNT_1ms_MAX) && (count_1us == COUNT_1us_MAX)) begin
        count_enable <= ~ count_enable;
    end
    else begin
        count_enable <= count_enable;
    end
end


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        led_out <= 1 'b 1;
    end
    else if (((count_enable == 1 'b 0) && (count_1ms <= count_1s)) || ((count_enable == 1 'b 1) && (count_1ms >= count_1s))) begin
        led_out <= 1 'b 0;
    end
    else begin
        led_out <= 1 'b 1;
    end
end

endmodule
