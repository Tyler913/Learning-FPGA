module Waterflow_LED # (
    parameter COUNT_MAX = 25 'd 24_999_999
)
(
    input wire system_clock,
    input wire system_reset_n,

    output reg [3:0] led_out
);

reg count_flag;
reg [24:0] count;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count <= 25 'd 0;
    end
    else if (count == COUNT_MAX) begin
        count <= 25 'd 0;
    end
    else begin
        count <= count + 25 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_flag <= 1 'b 0;
    end
    else if (count == (COUNT_MAX - 25 'd 1)) begin
        count_flag <= 1 'b 1;
    end
    else begin
        count_flag <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        led_out <= 4 'b 1110;
    end
    else if ((led_out == 4 'b 0111) && (count_flag == 1 'b 1)) begin
        led_out <= 4 'b 1110;
    end
    else if (count_flag == 1 'b 1) begin
        led_out <= (led_out << 1) | 4 'b 0001;
    end
    else begin
        led_out <= led_out;
    end
end

endmodule
