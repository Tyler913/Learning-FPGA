module hc595_control(
    input wire system_clock,
    input wire system_reset_n,
    input wire [5:0] selection,
    input wire [7:0] seg,

    output reg ds,
    output reg shcp,
    output reg stcp,
    output wire oe
);

wire [13:0] data;

reg [1:0] count;
reg [3:0] count_bit;


assign data = {seg[0], seg[1], seg[2], seg[3], seg[4], seg[5], seg[6], seg[7], selection};


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
        count_bit <= 4 'd 0;
    end
    else if ((count_bit == 4 'd 13) && (count == 2 'd 3)) begin
        count_bit <= 4 'd 0;
    end
    else begin
        count_bit <= count_bit + 4 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        ds <= 1 'b 0;
    end
    else if (count == 2 'd 0) begin
        ds <= data[count_bit];
    end
    else begin
        ds <= ds;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        shcp <= 1 'b 0;
    end
    else if (count == 2 'd 2) begin
        shcp <= 1 'b 1;
    end
    else if (count == 2 'd 0) begin
        shcp <= 1 'b 0;
    end
    else begin
        shcp <= shcp;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        stcp <= 1 'b 0;
    end
    else if ((count == 2 'd 0) && (count_bit == 4 'd 0)) begin
        stcp <= 1 'b 1;
    end
    else if ((count == 2 'd 2) && (count_bit == 4 'd 0)) begin
        stcp <= 1 'b 0;
    end
    else begin
        stcp <= stcp;
    end
end

assign oe = 1 'b 0;

endmodule
