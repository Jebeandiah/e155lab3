//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Takes input dip switches to multiplex
//their values onto two seven segment displays. Also flashes 4 leds 
//by sending a scanning signal to a 4x4 keypad and listening for responses.

module debouncer #(
parameter MAX_COUNT = 2_400_000,
parameter COUNTER_WIDTH = 24
) 	(input logic nreset, output out)
	logic[COUNTER_WIDTH-1:0]debounce_count;
	
	counter #(DEBOUNCE_COUNTS, COUNTER_WIDTH)  debounce_counter(clk, nreset,1'b1, debounce_count);
	
	
endmodule




