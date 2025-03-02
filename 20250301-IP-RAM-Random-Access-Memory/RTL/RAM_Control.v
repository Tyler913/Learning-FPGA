module RAM_Control# (
    parameter COUNT_200ms_MAX = 24 'd 9_999_999
)
(
    input wire system_clock,
    input wire system_reset_n,
    input wire write_flag,
    input wire read_flag,

    output reg write_enable,
    output reg [7:0] address,
    output wire [7:0] write_data,
    output reg read_enable
);


reg [23:0] count_200ms;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count_200ms <= 24 'd 0;
    end
    else if ((count_200ms == COUNT_200ms_MAX) 
    || (write_flag == 1 'b 1) 
    || (read_flag == 1 'b 1)) begin
        count_200ms <=- 24 'd 0;
    end
    else if (read_enable == 1 'b 1) begin
        count_200ms <= count_200ms + 24 'd 1;
    end
    else begin
        count_200ms <= count_200ms;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        write_enable <= 1 'b 0;
    end
    else if (address == 8 'd 255) begin
        write_enable <= 1 'b 0;
    end
    else if (write_flag == 1 'b 1) begin
        write_enable <= 1 'b 1;
    end
    else begin
        write_enable <= write_enable;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        address <= 8 'd 0;
    end
    else if ((address == 8 'd 255 && write_enable == 1 'b 1) 
    || (address == 8 'd 255 && count_200ms == COUNT_200ms_MAX) 
    || (write_flag == 1 'b 1) 
    || (read_flag == 1 'b 1)) begin
        address <= 8 'd 0;
    end
    else if ((write_enable == 1 'b 1) 
    || (read_enable == 1 'b 1 && count_200ms == COUNT_200ms_MAX)) begin
        address <= address + 1 'b 1;
    end
    else begin
        address <= address;
    end
end

assign write_data = {write_enable == 1 'b 1} ? address : 8 'd 0;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        read_enable <= 1 'b 0;
    end
    else if (write_flag == 1 'b 1) begin
        read_enable <= 1 'b 0;
    end
    else if (read_flag == 1 'b 1) begin
        read_enable <= 1 'b 1;
    end
    else begin
        read_enable <= read_enable;
    end
end

endmodule
