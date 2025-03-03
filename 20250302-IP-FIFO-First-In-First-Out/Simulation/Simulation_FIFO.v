`timescale 1ns / 1ns

module Simulation_FIFO();

reg system_clock;
reg [7:0] i_data;
reg write_request;
reg read_request;

reg system_reset_n;
reg [1:0] count;

wire empty;
wire full;
wire [7:0] o_data;
wire usedw;


initial begin
    system_clock = 1 'b 1;
    system_reset_n = 1 'b 0;
    #20
    system_reset_n = 1 'b 1;
end

always #10 system_clock = ~ system_clock;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count <= 2 'd 0;
    end
    else if (count == 2 'd 3) begin
        count <= 2 'd 0;
    end
    else begin
        count <= count + 2 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        write_request <= 1 'b 1;
    end
    else if (count == 2 'd 0 && read_request == 1 'b 0) begin
        write_request <= 1 'b 1;
    end
    else begin
        write_request <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        i_data <= 8 'd 0;
    end
    else if (i_data == 8 'd 255 && write_request == 1 'b 1) begin
        i_data <= 8 'd 0;
    end
    else if (write_request == 1 'b 1) begin
        i_data <= i_data + 8 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        read_request <= 1 'b 0;
    end
    else if (full == 1 'b 1) begin
        read_request <= 1 'b 1;
    end
    else if (empty == 1 'b 1) begin
        read_request <= 1 'b 0;
    end
end


FIFO FIFO_Instance(
    .system_clock (system_clock),
    .i_data (i_data),
    .write_request (write_request),
    .read_request (read_request),

    .empty (empty),
    .full (full),
    .o_data (o_data),
    .usedw (usedw)
);

endmodule
