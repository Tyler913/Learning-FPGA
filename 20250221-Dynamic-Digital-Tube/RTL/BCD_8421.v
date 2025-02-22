module BDC_8421(
    input wire system_clock,
    input wire system_reset_n,
    input wire [19:0] data,

    output reg [3:0] one,
    output reg [3:0] ten,
    output reg [3:0] hundred,
    output reg [3:0] thousand,
    output reg [3:0] ten_thousand,
    output reg [3:0] hundred_thousand
);

reg [4:0] count_shift;
reg [43:0] data_shift;
reg shift_flag;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_shift <= 5 'd 0;
    end
    else if ((count_shift == 5 'd 21) && (shift_flag == 1 'b 1)) begin
        count_shift <= 1 'd 0;
    end
    else if (shift_flag == 1 'b 1) begin
        count_shift <= count_shift + 5 'd 1;
    end
    else begin
        count_shift <= count_shift;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        data_shift <= 44 'd 0;
    end
    else if (count_shift == 5 'd 0) begin
        data_shift <= {24 'd 0, data};
    end
    else if ((count_shift <= 5 'd 20) && (shift_flag == 1 'b 0)) begin
        data_shift[23:20] <= (data_shift[23:20] > 4) ? (data_shift[23:20] + 2 'd 3) : (data_shift[23:20]);
        data_shift[27:24] <= (data_shift[27:24] > 4) ? (data_shift[27:24] + 2 'd 3) : (data_shift[27:24]);
        data_shift[31:28] <= (data_shift[31:28] > 4) ? (data_shift[31:28] + 2 'd 3) : (data_shift[31:28]);
        data_shift[35:32] <= (data_shift[35:32] > 4) ? (data_shift[35:32] + 2 'd 3) : (data_shift[35:32]);
        data_shift[39:36] <= (data_shift[39:36] > 4) ? (data_shift[39:36] + 2 'd 3) : (data_shift[39:36]);
        data_shift[43:40] <= (data_shift[43:40] > 4) ? (data_shift[43:40] + 2 'd 3) : (data_shift[43:40]);
    end
    else if ((count_shift <= 5 'd 20) && (shift_flag == 1 'b 1)) begin
        data_shift <= data_shift << 1;
    end
    else begin
        data_shift <= data_shift;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        shift_flag <= 1 'b 0;
    end
    else begin
        shift_flag <= ~ shift_flag;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        one <= 4 'd 0;
        ten <= 4 'd 0;
        hundred <= 4 'd 0;
        thousand <= 4 'd 0;
        ten_thousand <= 4 'd 0;
        hundred_thousand <= 4 'd 0;
    end
    else if (count_shift == 5 'd 21) begin
        one <= data_shift[23:20];
        ten <= data_shift[27:24];
        hundred <= data_shift[31:28];
        thousand <= data_shift[35:32];
        ten_thousand <= data_shift[39:36];
        hundred_thousand <= data_shift[43:40];
    end
end

endmodule
