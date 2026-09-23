//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: Shifts digits read from keypad onto two seven segment displays

module lab3_bl #(
parameter MULTIPLEXING_MAX = 400_000,
parameter MULTIPLEXING_WIDTH = 19,
parameter DEBOUNCING_MAX = 2_400_000,
parameter DEBOUNCING_WIDTH = 24
) (
	input 	logic nreset, input logic [3:0] scan_row_in,
	output 	logic [6:0] seg, [1:0] active_display,[3:0] scan_col_out
);
	logic [MULTIPLEXING_WIDTH-1:0] multiplexing_count;
	logic int_osc;
	logic[3:0] synced_row_in;

	logic[3:0] digit_1;
	logic[3:0] digit_2;
	logic shift_enable;
	logic all_unpressed;
	logic[3:0] processed_digit;
	logic[3:0] s;

	//logic[3:0] one_hot_col;
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	counter #(MULTIPLEXING_MAX, MULTIPLEXING_WIDTH) multiplexing_counter(int_osc, nreset,1'b1, multiplexing_count);
	scanner keypad_scanner(int_osc, nreset,1'b1,scan_col_out); 
	synchronizer row_syncer(int_osc, scan_row_in, synced_row_in);
	//synchronizer col_syncer(int_osc, scan_col_out, synced_col_out);
	poller keypad_poller(int_osc, nreset, scan_col_out, ~synced_row_in, all_unpressed, processed_digit);

	digitbuffer digits(int_osc,nreset, shift_enable, processed_digit, digit_1, digit_2);
	//assign scan_led = synced_row_in;

	debouncer #(DEBOUNCING_MAX, DEBOUNCING_WIDTH) keypad_debouncer(int_osc, nreset, all_unpressed,processed_digit,  shift_enable);
	assign active_display = (multiplexing_count > MULTIPLEXING_MAX/2) ? 2'b10 : 2'b01;
	assign	s = active_display[0] ? digit_1 : digit_2;	
	scrambledsevenseg sevseg(s, seg);
 
endmodule 
  



