module UART_TX #(
    parameter UART_BAUD_RATE = 16'd9600,
    parameter CLOCK_FREQ = 'd 500_000_000
)
(
    input wire system_clock,
    input wire system_reset_n,
    input wire [7:0] pi_data,
    input wire pi_flag,

    output reg tx
);


parameter BAUD_CNT_MAX = CLOCK_FREQ / UART_BAUD_RATE;


reg work_en;
reg [3:0] bit_cnt;
reg [15:0] baud_cnt;
reg bit_flag;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        work_en <= 1 'b 0;
    end
    else if (pi_flag == 1 'b 1) begin
        work_en <= 1 'b 1;
    end
    else if (bit_cnt == 4 'd 9 && bit_flag == 1 'b 1) begin
        work_en <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        baud_cnt <= 16 'd 0;
    end
    else if ((work_en == 1 'b 0) || (baud_cnt == BAUD_CNT_MAX - 1 'd 1)) begin
        baud_cnt <= 16 'd 0;
    end
    else if (work_en == 1 'b 1) begin
        baud_cnt <= baud_cnt + 1 'b 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        bit_flag <= 1 'b 0;
    end
    else if (baud_cnt == 16 'd 1) begin
        bit_flag <= 1 'b 1;
    end
    else begin
        bit_flag <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        bit_cnt <= 4 'd 0;
    end
    else if ((bit_cnt == 4 'd 9) && (bit_flag == 1 'b 1)) begin
        bit_cnt <= 4 'd 0;
    end
    else if ((work_en == 1 'b 1) && (bit_flag == 1 'b 1)) begin
        bit_cnt <= bit_cnt + 1 'b 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        tx <= 1 'b 1;
    end
    else if (bit_flag == 1 'b 1) begin
        case (bit_cnt)
            4 'd 0: tx <= 1 'b 0;
            4 'd 1: tx <= pi_data[0];
            4 'd 2: tx <= pi_data[1];
            4 'd 3: tx <= pi_data[2];
            4 'd 4: tx <= pi_data[3];
            4 'd 5: tx <= pi_data[4];
            4 'd 6: tx <= pi_data[5];
            4 'd 7: tx <= pi_data[6];
            4 'd 8: tx <= pi_data[7];
            4 'd 9: tx <= 1 'b 1;

            default: tx <= 1 'b 1;
        endcase
    end
end

endmodule
