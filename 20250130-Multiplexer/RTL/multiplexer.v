module Multiplexer (
    input   wire    [0:0]   in_1,
    input   wire            in_2,
    input   wire            selection,

    output  reg             out   
);

always @(*)
    if (selection == 1'b1)
        out = in_1;
    else
        out = in_2;

endmodule
