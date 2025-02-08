module Frequency_Division_Odd(
    input wire system_clock,
    input wire system_reset_n,

    // output wire division_clock
    output reg division_clock_flag
);


reg [2:0] count;
// reg posedge_clock;
// reg negedge_clock;


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        count <= 3 'd 0;
    end
    else if (count == 3 'd 4) begin
        count <= 3 'd 0;
    end
    else begin
        count <= count + 3 'd 1;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        division_clock_flag <= 1 'b 0;
    end
    else if (count == 3 'd 3) begin
        division_clock_flag <= 1 'b 1;
    end
    else begin
        division_clock_flag <= 1 'b 0;
    end
end


// always @(posedge system_clock or negedge system_reset_n) begin
//     if (system_reset_n == 1 'b 0) begin
//         posedge_clock <= 1 'b 0;
//     end
//     else if (count == 3 'd 2) begin
//         posedge_clock <= 1 'b 1;
//     end
//     else if (count == 3 'd 4) begin
//         posedge_clock <= 1 'd 0;
//     end
//     else begin
//         posedge_clock <= posedge_clock;
//     end
// end


// always @(negedge system_clock or negedge system_reset_n) begin
//     if (system_reset_n == 1 'b 0) begin
//         negedge_clock <= 1 'b 0;
//     end
//     else if (count == 3 'd 2) begin
//         negedge_clock <= 1 'b 1;
//     end
//     else if (count == 3 'd 4) begin
//         negedge_clock <= 1 'b 0;
//     end
//     else begin
//         negedge_clock <= negedge_clock;
//     end
// end




// assign division_clock = posedge_clock | negedge_clock;


endmodule
