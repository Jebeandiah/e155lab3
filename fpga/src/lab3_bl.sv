//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Takes input dip switches to multiplex
//their values onto two seven segment displays. Also flashes 4 leds 
//by sending a scanning signal to a 4x4 keypad and listening for responses.

module lab3_bl #(
parameter MAX_COUNT = 400_000,
parameter COUNTER_WIDTH = 19
) (
	input 	logic nreset, input logic [3:0] scan_row_in,
	output 	logic [6:0] seg, [1:0] active_display,[3:0] scan_led, [3:0] scan_col_out
);
	logic [COUNTER_WIDTH-1:0] multiplexing_count;
	logic int_osc;
	logic[3:0] synced_row_in;

	logic[3:0] digit_1;
	logic[3:0] digit_2;
	logic all_unpressed;
	logic[3:0] processed_input;
	logic[3:0] s;

	//logic[3:0] one_hot_col;
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	counter #(MAX_COUNT, COUNTER_WIDTH) multiplexing_counter(int_osc, 1'b1,1'b1, multiplexing_count);
	scanner keypad_scanner(int_osc, 1'b1,1'b1,scan_col_out); 
	synchronizer row_syncer(int_osc, scan_row_in, synced_row_in);
	//synchronizer col_syncer(int_osc, scan_col_out, synced_col_out);


	digitbuffer digits(int_osc,nreset, all_unpressed, processed_input, digit_1, digit_2);
	assign scan_led = synced_row_in;

	specialfsm speshul(int_osc, nreset, scan_col_out, ~synced_row_in, all_unpressed, processed_input);
	//assign scan_led = scan_row_in;
	assign active_display = (multiplexing_count > MAX_COUNT/2) ? 2'b10 : 2'b01;
	assign	s = active_display[0] ? digit_1 : digit_2;	
	sevenseg sevseg(s, seg);

endmodule




