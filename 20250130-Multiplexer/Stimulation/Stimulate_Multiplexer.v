`timescale 1ns/1ns

module Stimulate_Multiplexer();

reg in_1;
reg in_2;
reg selection;

wire out;


initial begin
    
    in_1 <= 1'b0;
    in_2 <= 1'b0;
    selection <= 1'b0;

end


always #10 in_1 <= {$random} % 2;
always #10 in_2 <= {$random} % 2;
always #10 selection <= {$random} % 2;


initial begin

    $timeformat (-9, 0, "ns", 6);
    $monitor ("@time %t:in_1 = %b in_2 = %b selection = %b out = %b", $time, in_1, in_2, selection, out);

end

Multiplexer Stimulate_Multiplexer_instance_1 (

    .in_1 (in_1),
    .in_2 (in_2),
    .selection (selection),

    .out (out)

);

endmodule
