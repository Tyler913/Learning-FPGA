`timescale 1ns/1ns


module Stimulation_Half_Adder ();

reg in_1;
reg in_2;

wire out;
wire carry;

initial begin
    in_1 <= 1'b0;
    in_2 <= 1'b0;
end

always #10 in_1 <= {$random} % 2;
always #10 in_2 <= {$random} % 2;


initial begin
    $timeformat (-9, 0, "ns", 6);
    $monitor ("@time %t : in_1 = %b, in_2 = %b, sum = %b, carry = %b", $time, in_1, in_2, sum, carry);
end


Half_Adder Half_Adder_Instance (
    .in_1 (in_1),
    .in_2 (in_2),

    .sum (sum),
    .carry (carry)
);


endmodule
