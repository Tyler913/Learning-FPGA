module Segment_Dynamic(
    input wire system_clock,
    input wire system_reset_n,
    input wire [19:0] data,
    input wire [5:0] floating_point,
    input wire sign,
    input wire segment_enable,

    output reg [5:0] selection,
    output reg [7:0] segment
);

parameter COUNT_1ms_MAX = 16 'd 49_999;

wire [3:0] one;
wire [3:0] ten;
wire [3:0] hundred;
wire [3:0] thousand;
wire [3:0] ten_thousand;
wire [3:0] hundred_thousand;

reg [23:0] data_register;
reg [15:0] count_1ms;
reg flag_1ms;
reg [2:0] count_selection;
reg [5:0] selection_register;
reg [3:0] data_display;
reg dot_display;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        data_register <= 24 'd 0;
    end
    else if ((hundred_thousand) || (floating_point[5])) begin
        data_register <= {hundred_thousand, ten_thousand, thousand, hundred, ten, one};
    end
    else if (((ten_thousand) || (floating_point[4])) && (sign == 1 'b 1)) begin
        data_register <= {4 'd 10, ten_thousand, thousand, hundred, ten, one};
    end
    else if (((ten_thousand) || (floating_point[4])) && (sign == 1 'b 0)) begin
        data_register <= {4 'd 11, ten_thousand, thousand, hundred, ten, one};
    end
    else if (((thousand) || (floating_point[3])) && (sign == 1 'b 1)) begin
        data_register <= {4 'd 11, 4 'd 10, thousand, hundred, ten, one};
    end
    else if (((thousand) || (floating_point[3])) && (sign == 1 'b 0)) begin
        data_register <= {4 'd 11, 4 'd 11, thousand, hundred, ten, one};
    end
    else if (((hundred) || (floating_point[2])) && (sign == 1 'b 1)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 10, hundred, ten, one};
    end
    else if (((hundred) || (floating_point[2])) && (sign == 1 'b 0)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 11, hundred, ten, one};
    end
    else if (((ten) || (floating_point[1])) && (sign == 1 'b 1)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 11, 4 'd 10, ten, one};
    end
    else if (((ten) || (floating_point[1])) && (sign == 1 'b 0)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 11, 4 'd 11, ten, one};
    end
    else if (((one) || (floating_point[0])) && (sign == 1 'b 1)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 11, 4 'd 11, 4 'd 10, one};
    end
    else if (((one) || (floating_point[0])) && (sign == 1 'b 0)) begin
        data_register <= {4 'd 11, 4 'd 11, 4 'd 11, 4 'd 11, 4 'd 11, one};
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_1ms <= 16 'd 0;
    end
    else if (count_1ms == COUNT_1ms_MAX) begin
        count_1ms <= 16 'd 0;
    end
    else begin
        count_1ms <= count_1ms + 16 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        flag_1ms <= 1 'b 0;
    end
    else if (count_1ms == COUNT_1ms_MAX) begin
        flag_1ms <= 1 'b 1;
    end
    else begin
        flag_1ms <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_selection <= 3 'd 0;
    end
    else if ((count_selection == 3 'd 5) && (flag_1ms == 1 'b 1)) begin
        count_selection <= 3 'd 0;
    end
    else if (flag_1ms <= 1 'b 1) begin
        count_selection <= count_selection + 3 'd 1;
    end
    else begin
        count_selection <= count_selection;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        selection_register <= 6 'b 000_000;
    end
    else if ((count_selection == 3 'd 0) && (flag_1ms == 1 'b 1)) begin
        selection_register <= 6 'b 000_001;
    end
    else if (flag_1ms == 1 'b 1) begin
        selection_register <= selection_register << 1;
    end
    else begin
        selection_register <= selection_register;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        data_display <= 4 'd 0;
    end
    else if ((segment_enable == 1 'b 1) && (flag_1ms == 1 'b 1)) begin
        case (count_selection)
            3 'd 0:
            data_display <= data_register[3:0];

            3 'd 1:
            data_display <= data_register[7:4];

            3 'd 2:
            data_display <= data_register[11:8];

            3 'd 3:
            data_display <= data_register[15:12];

            3 'd 4:
            data_display <= data_register[19:16];

            3 'd 5:
            data_display <= data_register[23:20];

            default:
            data_display <= 4 'b 0;
        endcase
    end
    else begin
        data_display <= data_display;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        dot_display <= 1 'b 1;
    end
    else if (flag_1ms == 1 'b 1) begin
        dot_display <= ~ floating_point[count_selection];
    end
    else begin
        dot_display <= dot_display;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        segment <= 8 'b 1111_1111;
    end
    else begin
        case (data_display)
            4 'd 0:
            segment <= {dot_display, 7 'b 100_0000};

            4 'd 1:
            segment <= {dot_display, 7 'b 111_1001};

            4 'd 2:
            segment <= {dot_display, 7 'b 010_0100};

            4 'd 3:
            segment <= {dot_display, 7 'b 011_0000};

            4 'd 4:
            segment <= {dot_display, 7 'b 001_1001};

            4 'd 5:
            segment <= {dot_display, 7 'b 001_0010};

            4 'd 6:
            segment <= {dot_display, 7 'b 000_0010};

            4 'd 7:
            segment <= {dot_display, 7 'b 111_1000};

            4 'd 8:
            segment <= {dot_display, 7 'b 000_0000};

            4 'd 9:
            segment <= {dot_display, 7 'b 001_0000};

            4 'd 10:
            segment <= 8 'b 1011_1111;

            4 'd 11:
            segment <= 8 'b 1111_1111;

            default:
            segment <= 8 'b 1100_0000;
        endcase
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        selection <= 6 'b 000_000;
    end
    else begin
        selection <= selection_register;
    end
end


BDC_8421 BDC_8421_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .data (data),

    .one (one),
    .ten (ten),
    .hundred (hundred),
    .thousand (thousand),
    .ten_thousand (ten_thousand),
    .hundred_thousand (hundred_thousand)
);

endmodule
