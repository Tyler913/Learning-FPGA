module Vending_Machine(
    input wire system_clock,
    input wire system_reset_n,
    input wire half_dollar,
    input wire one_dollar,

    output reg coke,
    output reg changes
);


parameter IDLE = 5 'b 00001;
parameter HALF = 5 'b 00010;
parameter ONE = 5 'b 00100;
parameter ONE_HALF = 5 'b 01000;
parameter TWO = 5 'b 10000;


wire [1:0] money_input;
reg [4:0] state;


assign money_input = {half_dollar, one_dollar};


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE:
            if (money_input == 2 'b 01) begin
                state <= HALF;
            end
            else if (money_input == 2 'b 10) begin
                state <= ONE;
            end
            else begin
                state <= IDLE;
            end

            HALF:
            if (money_input == 2 'b 01) begin
                state <= ONE;
            end
            else if (money_input == 2 'b 10) begin
                state <= ONE_HALF;
            end
            else begin
                state <= HALF;
            end

            ONE:
            if (money_input == 2 'b 01) begin
                state <= ONE_HALF;
            end
            else if (money_input == 2 'b 10) begin
                state <= TWO;
            end
            else begin
                state <= ONE;
            end

            ONE_HALF:
            if (money_input == 2 'b 01) begin
                state <= TWO;
            end
            else if (money_input == 2 'b 10) begin
                state <= IDLE;
            end
            else begin
                state <= ONE_HALF;
            end

            TWO:
            if ((money_input == 2 'b 01) || (money_input == 2 'b 10)) begin
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


always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        coke <= 1 'b 0;
    end
    else if (
        ((money_input == 2 'b 10) && (state == ONE_HALF))
    || ((money_input == 2 'b 01) && (state == TWO)) 
    || ((money_input == 2 'b 10) && (state == TWO))) begin
        coke <= 1 'b 1;
    end
    else begin
        coke <= 1 'b 0;
    end
end

always @(posedge system_clock or negedge system_reset_n) begin
    if (system_reset_n == 1 'b 0) begin
        changes <= 1 'b 0;
    end
    else if ((money_input == 2 'b 10) && (state == TWO)) begin
        changes <= 1 'b 1;
    end
    else begin
        changes <= 1 'b 0;
    end
end

endmodule
