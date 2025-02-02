module Full_Adder(
    input wire in_1,
    input wire in_2,
    input wire cin,

    output wire sum,
    output wire carry
);

wire h0_sum;
wire h0_carry;

wire h1_carry;

Half_Adder Half_Adder_Instance_0 (
    .in_1 (in_1),
    .in_2 (in_2),

    .sum (h0_sum),
    .carry (h0_carry)
);

Half_Adder Half_Adder_Instance_1 (
    .in_1 (cin), 
    .in_2 (h0_sum),

    .sum (sum),
    .carry (h1_carry)
);

assign carry = (h0_carry | h1_carry);

endmodule
