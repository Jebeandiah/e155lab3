//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module debouncingpoller #(parameter DEBOUNCE_MAX = 2_400_000, parameter DEBOUNCE_WIDTH = 24) (input logic clk,nreset, input logic [3:0] col,input logic [3:0] row,
output logic shift_enable, output logic[3:0] digit_out);
	logic[DEBOUNCE_WIDTH-1:0]debounce_count;

	typedef enum logic [1:0] {
        POLLING, SHIFT_ENABLED, DEBOUNCING
    } state_t;
    
	state_t state, next_state;

	logic is_debouncing;
	logic is_new_digit;
	logic is_done_debouncing;
	logic is_polling;
	assign is_debouncing = (state!=POLLING);
	assign is_polling = (state!=DEBOUNCING);
	assign is_done_debouncing = debounce_count==(DEBOUNCE_MAX-1);
	
	counter #(DEBOUNCE_MAX, DEBOUNCE_WIDTH)  debounce_counter(clk, is_debouncing,1'b1, debounce_count);
	poller _poller(clk, nreset, is_polling, col, row, is_new_digit, digit_out);
    // Next-state logic
	
	
    always_comb begin
        unique case (state)
            POLLING: next_state = is_new_digit ? SHIFT_ENABLED : POLLING;
            SHIFT_ENABLED: next_state = DEBOUNCING;
            DEBOUNCING: next_state = is_done_debouncing ? POLLING : DEBOUNCING;
			default: next_state = POLLING;
        endcase
    end


	always_comb begin
        shift_enable = (state == SHIFT_ENABLED);
    end

    // State register
    always_ff @(posedge clk) begin
        if (nreset==0)
            state <= POLLING;
        else
            state <= next_state;
    end
endmodule

