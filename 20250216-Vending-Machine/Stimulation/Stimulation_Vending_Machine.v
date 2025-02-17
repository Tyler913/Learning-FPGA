`timescale 1ns / 1ns

module Stimulation_Vending_Machine();

reg system_clock;
reg system_reset_n;
reg half_dollar;
reg one_dollar;

reg random_data;

wire coke;
wire changes;


initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~system_clock;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        random_data <= 1 'b 0;
    end
    else begin
        random_data <= {$random} % 2;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        half_dollar <= 1 'b 0;
    end
    else begin
        half_dollar <= random_data;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        one_dollar <= 1 'b 0;
    end
    else begin
        one_dollar <= ~ random_data;
    end
end


initial begin
    $timeformat(-9, 0, "ns", 6);
    $monitor("@time %t: hale_dollar = %b, one_dollar = %b, coke = %b, changes = %b, money_input = %b, state = %b", $time, half_dollar, one_dollar, coke, changes, money_input, state);
end

Vending_Machine Vending_Machine_Instance(
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .half_dollar (half_dollar),
    .one_dollar (one_dollar),

    .coke (coke),
    .changes (changes)
);


wire [1:0] money_input = Vending_Machine_Instance.money_input;
wire [4:0] state = Vending_Machine_Instance.state;

endmodule
