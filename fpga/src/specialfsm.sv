//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module specialfsm #(parameter DEBOUNCE_COUNTS = 2_400_000, parameter COUNTER_WIDTH = 24) (input logic clk,nreset, input logic [3:0] col,input logic [3:0] row,
output logic shift_enable, output logic[3:0] digit_out);
	logic[COUNTER_WIDTH-1:0]debounce_count;
		 typedef enum logic [1:0] {
        POLLING, SHIFT_ENABLE, DEBOUNCING
    } state_t;
```
    state_t state, next_state;
	logic is_new_digit;
	logic is_waiting;
	assign is_waiting = debounce_count!=0;
    // Next-state logic
    always_comb begin
        unique case (state)
            POLLING: next_state = is_new_digit ? SHIFT_ENABLE : POLLING;
            SHIFT_ENABLE: next_state = DEBOUNCING;
            DEBOUNCING: next_state = is_waiting ? DEBOUNCING : POLLING;
        endcase
    end
	logic debounce_nreset;
	counter #(DEBOUNCE_COUNTS, COUNTER_WIDTH)  debounce_counter(clk, debounce_nreset,1'b1, debounce_count);
	one_hot_reducer col_red(col, col_ind);
	one_hot_reducer row_red(row, row_ind);

	poller polle(clk, nreset, state==POLLING, col, row, is_new_digit, is_new_digit, digit_out)
	always_comb begin
        shift_enable = (state == SHIFT_ENABLE);
    end

    // State register
    always_ff @(posedge clk or negedge reset) begin
        if (!reset)
            state <= SCANNING;
        else
            state <= next_state;
    end
endmodule

