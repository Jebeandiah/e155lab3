//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module debouncer #(parameter DEBOUNCING_MAX = 2_400_000, parameter DEBOUNCING_WIDTH = 24) (input logic clk,nreset, all_unpressed, input logic [3:0] digit_in,
output logic shift_enable);
	logic[DEBOUNCING_WIDTH-1:0]debounce_count;

	typedef enum logic [1:0] {
        TRACKING_DIGIT, SHIFT_ENABLED, DEBOUNCING
    } state_t;
    
	state_t state, next_state;

	logic is_debouncing;
	logic enable_shift;
	logic is_done_debouncing;
	logic is_tracking;
	logic [3:0] current_digit;
	logic was_unpressed;
	assign is_debouncing = (state!=TRACKING_DIGIT);
	assign is_tracking = (state!=DEBOUNCING);
	assign is_done_debouncing = debounce_count==(DEBOUNCING_MAX-1);
	assign enable_shift = ((was_unpressed&& !all_unpressed)||(current_digit != digit_in));
	
	counter #(DEBOUNCING_MAX, DEBOUNCING_WIDTH)  debounce_counter(clk, is_debouncing,1'b1, debounce_count);
	digittracker tracker(clk, nreset, is_tracking, all_unpressed,was_unpressed, digit_in, current_digit);
    // Next-state logic
	
	
    always_comb begin
        unique case (state)
            TRACKING_DIGIT: next_state = enable_shift ? SHIFT_ENABLED : TRACKING_DIGIT;
            SHIFT_ENABLED: next_state = DEBOUNCING;
            DEBOUNCING: next_state = is_done_debouncing ? TRACKING_DIGIT : DEBOUNCING;
			default: next_state = TRACKING_DIGIT;
        endcase
    end


	always_comb begin
        shift_enable = (state == SHIFT_ENABLED);
    end

    // State register
    always_ff @(posedge clk) begin
        if (nreset==0)
            state <= TRACKING_DIGIT;
        else
            state <= next_state;
    end
endmodule

