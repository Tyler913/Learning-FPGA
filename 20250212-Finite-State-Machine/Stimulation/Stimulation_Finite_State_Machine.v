`timescale 1ns / 1ns

module Stimulation_Finite_State_Machine();

reg sys_clock;
reg sys_reset_n;
reg money_input;

wire po_cola;

wire [2:0] state = Finite_State_Machine_Instance.state;


initial begin
    sys_clock = 1 'b 1;
    sys_reset_n <= 1 'b 0;
    #20
    sys_reset_n <= 1 'b 1;
end

always #10 sys_clock = ~ sys_clock;


always @(posedge sys_clock or negedge sys_reset_n) begin
    if (sys_reset_n == 1 'b 0) begin
        money_input <= 1 'b 0;
    end
    else begin
        money_input <= {$random} % 2;
    end
end

initial begin
    $timeformat (-9, 0, "ns", 6);
    $monitor ("@time %t : money_input = %b, state = %b, po_cola = %b", $time, money_input, state, po_cola);
end


Finite_State_Machine Finite_State_Machine_Instance(
    .sys_clock (sys_clock),
    .sys_reset_n (sys_reset_n),
    .money_input (money_input),

    .po_cola (po_cola)
);

endmodule
