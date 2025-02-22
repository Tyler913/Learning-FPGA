module Data_Generation # (
    parameter COUNT_100ms_MAX = 23 'd 4_999_999,
    parameter DATA_MAX = 20 'd 999_999
)
(
    input wire system_clock,
    input wire system_reset_n,

    output reg [19:0] data,
    output wire [5:0] floating_point,
    output wire sign,
    output reg segment_enable
);

reg [22:0] count_100ms;
reg count100ms_flag;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_100ms <= 23 'd 0;
    end
    else if (count_100ms == COUNT_100ms_MAX) begin
        count_100ms <= 23 'd 0;
    end
    else begin
        count_100ms <= count_100ms + 23 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count100ms_flag <= 1 'b 0;
    end
    else if (count_100ms == COUNT_100ms_MAX - 1 'd 1) begin
        count100ms_flag <= 1 'b 1;
    end
    else begin
        count100ms_flag <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        data <= 20 'd 0;
    end
    else if (data == DATA_MAX && count100ms_flag == 1 'b 1) begin
        data <= 20 'd 0;
    end
    else if (count100ms_flag == 1 'b 1) begin
        data <= data + 1 'd 1;
    end
    else begin
        data <= data;
    end
end

assign floating_point = 6 'b 000_000;

assign sign = 1 'b 0;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        segment_enable <= 1 'b 0;
    end
    else begin
        segment_enable <= 1 'b 1;
    end
end

endmodule
