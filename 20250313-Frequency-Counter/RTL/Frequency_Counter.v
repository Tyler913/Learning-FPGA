module Frequency_Counter(
    input wire system_clock,
    input wire system_reset_n,
    input wire clock_test,

    output reg [31:0] frequency    
);


parameter COUNT_GATE_S_MAX = 27 'd 74_999_999;
parameter COUNT_RISE_MAX = 27 'd 12_499_999;
parameter COUNT_STAND_FREQUENCY = 27 'd 100_000_000;


reg [26:0] count_gate_s;
reg gate_s;
reg gate_a;
reg [47:0] count_test_frequency;
reg gate_a_test_reg;
reg [47:0] count_test_frequency_reg;
reg [47:0] count_clock_stand;
reg [47:0] count_clock_stand_reg;
reg gate_a_stand_reg;
reg calculation_flag;

wire gate_a_fall_t;
wire clock_stand;
wire gate_a_fall_s;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        count_gate_s <= 27 'd 0;
    end
    else if (count_gate_s == COUNT_GATE_S_MAX) begin
        count_gate_s <= 27 'd 0;
    end
    else begin
        count_gate_s <= count_gate_s + 1'b1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        gate_s <= 1'b0;
    end
    else if (count_gate_s > COUNT_RISE_MAX && count_gate_s < (COUNT_GATE_S_MAX - COUNT_RISE_MAX)) begin
        gate_s <= 1'b1;
    end
    else begin
        gate_s <= 1'b0;
    end
end

always @(posedge clock_test or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        gate_a <= 1'b0;
    end
    else begin
        gate_a <= gate_s;
    end
end

always @(posedge clock_test or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        count_test_frequency <= 48 'd 0;
    end
    else if (gate_a == 1 'b 0) begin
        count_test_frequency <= 48 'd 0;
    end
    else if (gate_a == 1 'b 1) begin
        count_test_frequency <= count_test_frequency + 1'b1;
    end
end

always @(posedge clock_test or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        gate_a_test_reg <= 1'b0;
    end
    else begin
        gate_a_test_reg <= gate_a;
    end
end

assign gate_a_fall_t = ((gate_a_test_reg == 1'b1) && (gate_a == 1'b0)) ? 1 'b 1 : 1 'b 0;

always @(posedge clock_test or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        count_test_frequency_reg <= 48 'd 0;
    end
    else if (gate_a_fall_t == 1'b1) begin
        count_test_frequency_reg <= count_test_frequency;
    end
end

always @(posedge clock_stand or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        count_clock_stand <= 48 'd 0;
    end
    else if (gate_a == 1'b0) begin
        count_clock_stand <= 48 'd 0;
    end
    else if (gate_a == 1'b1) begin
        count_clock_stand <= count_clock_stand + 1'b1;
    end
end

always @(posedge clock_stand or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        gate_a_stand_reg <= 1'b0;
    end
    else begin
        gate_a_stand_reg <= gate_a;
    end
end

assign gate_a_fall_s = ((gate_a_stand_reg == 1'b1) && (gate_a == 1'b0)) ? 1 'b 1 : 1 'b 0;

always @(posedge clock_stand or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        count_clock_stand_reg <= 48 'd 0;
    end
    else if (gate_a_fall_s == 1'b1) begin
        count_clock_stand_reg <= count_clock_stand;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        calculation_flag <= 1'b0;
    end
    else if (count_gate_s == COUNT_GATE_S_MAX) begin
        calculation_flag <= 1'b1;
    end
    else begin
        calculation_flag <= 1'b0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1'b0) begin
        frequency <= 32 'd 0;
    end
    else if (calculation_flag == 1'b1) begin
        frequency <= (COUNT_STAND_FREQUENCY / count_clock_stand_reg) * count_test_frequency_reg;
    end
end


pll	pll_inst (
	.areset ( areset_sig ),
	.inclk0 ( inclk0_sig ),
	.c0 ( c0_sig )
);


endmodule
