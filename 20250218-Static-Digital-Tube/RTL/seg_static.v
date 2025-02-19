module seg_static # (
    parameter COUNT_MAX = 25 'd 24_999_999
)
(
    input wire system_clock,
    input wire system_reset_n,

    output reg [5:0] selection,
    output reg [7:0] seg
);

reg [24:0] count;
reg [3:0] data;
reg count_flag;


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
        data <= 4 'd 0;
    end
    else if ((count_flag == 1 'b 1) && (data == 4 'd 15)) begin
        data <= 4 'd 0;
    end
    else if (count == COUNT_MAX) begin
        data <= data + 4 'd 1;
    end
    else begin
        data <= data;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_flag <= 1 'b 0;
    end
    else if (count == (COUNT_MAX - 1)) begin
        count_flag <= 1 'b 1;
    end
    else begin
        count_flag <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        selection <= 6 'd 0;
    end
    else begin
        selection <= 6 'b 111_111;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        seg <= 8 'h C0;
    end
    else begin
        case (data)
            4 'd 0:
            seg <= 8 'h C0;

            4 'd 1:
            seg <= 8 'h F9;

            4 'd 2:
            seg <= 8 'h A4;

            4 'd 3:
            seg <= 8 'h B0;

            4 'd 4:
            seg <= 8 'h 99;

            4 'd 5:
            seg <= 8 'h 92;

            4 'd 6:
            seg <= 8 'h 82;

            4 'd 7:
            seg <= 8 'h F8;

            4 'd 8:
            seg <= 8 'h 80;

            4 'd 9:
            seg <= 8 'h 90;

            4 'd 10:
            seg <= 8 'h 88;

            4 'd 11:
            seg <= 8 'h 83;

            4 'd 12:
            seg <= 8 'h C6;

            4 'd 13:
            seg <= 8 'h A1;

            4 'd 14:
            seg <= 8 'h 86;

            4 'd 15:
            seg <= 8 'h 8E;

            default:
            seg <= 8 'h FF;
        endcase
    end
end

endmodule
