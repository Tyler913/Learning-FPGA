module UART_RX # (
    parameter UART_BAUD_RATE = 'd9600,
    parameter CLOCK_FREQ = 'd50_000_000
)
(
    input wire  system_clock,
    input wire system_reset_n,
    input wire rx,

    output reg [7:0] po_data,
    output reg po_flag
);


parameter BAUD_CNT_MAX = CLOCK_FREQ / UART_BAUD_RATE;


reg rx_reg1;
reg rx_reg2;
reg rx_reg3;

reg start_flag;
reg work_en;
reg [15:0] baud_cnt;
reg bit_flag;
reg [3:0] bit_cnt;
reg [7:0] rx_data;
reg rx_flag;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        rx_reg1 <= 1'b1;
    end
    else begin
        rx_reg1 <= rx;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        rx_reg2 <= 1'b1;
    end
    else begin
        rx_reg2 <= rx_reg1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        rx_reg3 <= 1'b1;
    end
    else begin
        rx_reg3 <= rx_reg2;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        start_flag <= 1'b0;
    end
    else if ((rx_reg3 == 1 'b 1) && (rx_reg2 == 1'b 0) && (work_en == 1'b 0)) begin
        start_flag <= 1'b 1;
    end
    else begin
        start_flag <= 1'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        work_en <= 1'b0;
    end
    else if (start_flag == 1'b 1) begin
        work_en <= 1'b 1;
    end
    else if ((bit_cnt == 4 'd 8) && (bit_flag == 1'b 1)) begin
        work_en <= 1'b 0;
    end
    else begin
        work_en <= work_en;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        baud_cnt <= 16'd0;
    end
    else if ((baud_cnt == BAUD_CNT_MAX - 1 'd 1) && (work_en == 1 'b 0)) begin
        baud_cnt <= 16'd0;
    end
    else begin
        baud_cnt <= baud_cnt + 1 'b 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        bit_flag <= 1'b0;
    end
    else if (baud_cnt == (BAUD_CNT_MAX) / 2 - 1 'd 1) begin
        bit_flag <= 1'b 1;
    end
    else begin
        bit_flag <= 1'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        bit_cnt <= 4'd0;
    end
    else if ((bit_cnt == 4 'd 8) && (bit_flag == 1'b 1)) begin
        bit_cnt <= 4'd0;
    end
    else if (bit_flag == 1'b 1) begin
        bit_cnt <= bit_cnt + 1 'b 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        rx_data <= 8'd0;
    end
    else if ((bit_cnt >= 4 'd 1) && (bit_cnt <= 4 'd 8) && (bit_flag == 1'b 1)) begin
        rx_data <= {rx_reg3, rx_data[7:1]};
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        rx_flag <= 1'b0;
    end
    else if ((bit_cnt == 4 'd 8) && (bit_flag == 1 'b 1)) begin
        rx_flag <= 1'b 1;
    end
    else begin
        rx_flag <= 1'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        po_data <= 8'd0;
    end
    else if (rx_flag == 1'b 1) begin
        po_data <= rx_data;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        po_flag <= 1'b0;
    end
    else begin
        po_flag <= rx_flag;
    end
end

endmodule
