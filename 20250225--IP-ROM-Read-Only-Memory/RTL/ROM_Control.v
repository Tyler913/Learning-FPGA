module ROM_Control # (
    parameter COUNT_200ms_MAX = 24 'd 9_999_999
)
(
    input wire system_clock,
    input wire system_reset_n,
    input wire key1,
    input wire key2,

    output reg [7:0] address
);


reg [23:0] count_200ms;
reg key1_enable;
reg key2_enable;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_200ms <= 24 'd 0;
    end
    else if (count_200ms == COUNT_200ms_MAX || key1_enable == 1 'b 1 || key2_enable == 1 'b 1) begin
        count_200ms <= 24 'd 0;
    end
    else begin
        count_200ms <= count_200ms + 24 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        key1_enable <= 1 'b 0;
    end
    else if (key2 == 1 'b 1) begin
        key1_enable <= 1 'b 0;
    end
    else if (key1 == 1 'b 1) begin
        key1_enable <= ~ key1_enable;
    end
    else begin
        key1_enable <= key1_enable;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        key2_enable <= 1 'b 0;
    end
    else if (key1 == 1 'b 1) begin
        key2_enable <= 1 'b 0;
    end
    else if (key2 == 1 'b 1) begin
        key2_enable <= ~ key2_enable;
    end
    else begin
        key2_enable <= key2_enable;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        address <= 8 'd 0;
    end
    else if (address == 8 'd 255 && count_200ms == COUNT_200ms_MAX) begin
        address <= 8 'd 0;
    end
    else if (key1_enable == 1 'b 1) begin
        address <= 8 'd 99;
    end
    else if (key2_enable == 1 'b 1) begin
        address <= 8 'd 199;
    end
    else if (count_200ms == COUNT_200ms_MAX) begin
        address <= address + 8 'd 1;
    end
end

endmodule
