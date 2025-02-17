module Buzzer # (
    parameter COUNT_MAX = 25 'd 24_999_999,
    parameter DO = 18 'd 190839,
    parameter RE = 18 'd 170067,
    parameter MI = 18 'd 151514,
    parameter FA = 18 'd 143265,
    parameter SO = 18 'd 127550,
    parameter LA = 18 'd 113635,
    parameter XI = 18 'd 101213
)
(
    input wire system_clock,
    input wire system_reset_n,

    output reg buzzer
);

reg [24:0] count;
reg [2:0] count_500ms;
reg [17:0] frequency_count;
reg [17:0] frequency_data;
wire [16:0] duty_data;


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
        count_500ms <= 3 'd 0;
    end
    else if ((count_500ms == 3 'd 6) && (count == COUNT_MAX)) begin
        count_500ms <= 3 'd 0;
    end
    else if (count == COUNT_MAX) begin
        count_500ms <= count_500ms + 3 'd 1;
    end
    else begin
        count_500ms <= count_500ms;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        frequency_count <= 18 'd 0;
    end
    // ! Question Mark Here!!!
    else if ((frequency_count == frequency_data) || (count == COUNT_MAX)) begin
        frequency_count <= 18 'd 0;
    end
    else begin
        frequency_count <= frequency_count + 18 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        frequency_data <= DO;
    end
    else begin
        case (count_500ms)
            3 'd 0:
            frequency_data <= DO;

            3 'd 1:
            frequency_data <= RE;

            3 'd 2:
            frequency_data <= MI;

            3 'd 3:
            frequency_data <= FA;

            3 'd 4:
            frequency_data <= SO;

            3 'd 5:
            frequency_data <= LA;

            3 'd 6:
            frequency_data <= XI;

            default:
            frequency_data <= DO;
        endcase
    end
end

assign duty_data = frequency_data >> 1;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        buzzer <= 1 'b 0;
    end
    else if (frequency_count > duty_data) begin
        buzzer <= 1 'b 1;
    end
    else begin
        buzzer <= 1 'b 0;
    end
end

endmodule
