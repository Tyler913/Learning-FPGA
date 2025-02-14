module Finite_State_Machine(
    input wire sys_clock,
    input wire sys_reset_n,
    input wire money_input,

    output reg po_cola
);

parameter IDLE = 3 'b 001;
parameter ONE = 3 'b 010;
parameter TWO = 3 'b 100;

reg [2:0] state;


always @(posedge sys_clock or negedge sys_reset_n) begin
    if (sys_reset_n == 1 'b 0) begin
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE: 
            if (money_input == 1 'b 1) begin
                state <= ONE;
            end
            else begin
                state <= IDLE;
            end

            ONE: 
            if (money_input == 1 'b 1) begin
                state <= TWO;
            end
            else begin
                state <= ONE;
            end

            TWO:
            if (money_input == 1 'b 1) begin
                state <= IDLE;
            end
            else begin
                state <= TWO;
            end

            default:
            state <= IDLE;
        endcase
    end
end

always @(posedge sys_clock or negedge sys_reset_n) begin
    if (sys_reset_n == 1 'b 0) begin
        po_cola <= 1 'b 0;
    end
    else if ((state == TWO) && (money_input == 1 'b 1)) begin
        po_cola <= 1 'b 1;
    end
    else begin
        po_cola <= 1 'b 0;
    end
end

endmodule
