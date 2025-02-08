`timescale 1ns/1ns

module Stimulation_Button_Debounce();

reg system_clock;
reg system_reset_n;
reg key_in;
reg [7:0] counter;

wire key_flag;

initial begin
    system_clock = 1 'b 1;
    system_reset_n <= 1 'b 0;
    #20
    system_reset_n <= 1 'b 1;
end

always #10 system_clock = ~ system_clock;

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        counter <= 8 'd 0;
    end
    else if (counter == 8 'd 249) begin
        counter <= 8 'd 0;
    end
    else begin
        counter <= counter + 8 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        key_in <= 1 'b 0;
    end
    else if ((counter >= 8 'd 19) && (counter <= 8 'd 49) || 
            (counter >= 8 'd 149) && (counter <= 8 'd 199)) begin
        key_in <= {$random} % 2;
    end
    else if ((counter < 8 'd 19) || (counter > 8 'd 199)) begin
        key_in <= 1 'b 1;
    end
    else begin
        key_in <= 1 'b 0;
    end
end

Button_Debounce #(
    .COUNT_MAX (20 'd 24)
)
Button_Debounce_Instance (
    .system_clock (system_clock),
    .system_reset_n (system_reset_n),
    .key_in (key_in),

    .key_flag (key_flag)
);

endmodule
