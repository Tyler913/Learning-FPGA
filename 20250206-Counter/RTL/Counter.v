module Counter #(
    parameter CONSTANT_MAX = 25 'd 24_999_999
) (
    input wire system_clock,
    input wire system_reset_n,

    output reg led_out
);


// parameter CONSTANT_MAX = 25 'd 24_999_999;
// localparam CONSTANT_MAX = 25 'd 24_999_999;

reg [24:0] constant;
reg constant_flag;


always @(posedge system_clock or negedge system_reset_n)
    if (system_reset_n == 1 'b 0)
        constant <= 25 'd 0;
    else if (constant == CONSTANT_MAX) 
        constant <= 25 'd 0;
    else
        constant <= constant + 25 'd 1;

always @(posedge system_clock or negedge system_reset_n)
    if (system_reset_n == 1 'b 0) 
        constant_flag <= 1 'b 0;
    else if (constant == (CONSTANT_MAX - 25 'd 1))
        constant_flag <= 1 'b 1;
    else
        constant_flag <= 1 'b 0;

always @(posedge system_clock or negedge system_reset_n)
    if (system_reset_n == 1 'b 0)
        led_out <= 1 'b 0;
    else if (constant_flag == 1 'b 1)
        led_out <= ~led_out;
    else
        led_out <= led_out;

endmodule
