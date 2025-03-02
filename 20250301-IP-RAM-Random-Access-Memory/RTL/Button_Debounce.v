module Button_Debounce #(
    parameter COUNT_MAX = 20 'd 999_999
)
(
    input wire system_clock,
    input wire system_reset_n,
    input wire key_in,

    output reg key_flag
);

reg [19:0] count_20ms;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_20ms <= 20 'd 0;
    end
    else if (key_in == 1 'b 1) begin
        count_20ms <= 20 'd 0;
    end
    else if (count_20ms == COUNT_MAX) begin
        count_20ms <= COUNT_MAX;
    end
    else begin
        count_20ms <= count_20ms + 20 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        key_flag <= 1 'b 0;
    end
    else if (count_20ms == (COUNT_MAX - 20 'd 1)) begin
        key_flag <= 1 'b 1;
    end
    else begin
        key_flag <= 1 'b 0;
    end
end

endmodule
