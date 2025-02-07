module Freequency_Division(
    input wire system_clock,
    input wire system_reset_n,

    output reg clock_flag
);

reg [2:0] count;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n  == 1 'b 0)
        count <= 3 'd 0;
    else if (count == 3 'd 5)
        count <= 3 'd 0;
    else
        count <= count + 3 'd 1;
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0)
        clock_flag <= 1 'b 0;
    else if (count == 3 'd 4)
        clock_flag <= 1 'b 1;
    else
        clock_flag <= 1 'b 0;
end


endmodule
