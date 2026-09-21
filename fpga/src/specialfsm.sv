//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module specialfsm #(parameter DEBOUNCE_COUNTS = 2_400_000, parameter COUNTER_WIDTH = 24) (input logic clk,nreset, input logic [3:0] col,input logic [3:0] row,
output logic all_unpressed, output logic[3:0] digit_out);
	logic[COUNTER_WIDTH-1:0]debounce_count;
	
	logic is_waiting;
	logic[1:0] sync_col_ind;
	logic[1:0] col_ind;
	logic[1:0] row_ind;
	logic[3:0] held_cols;
	counter #(DEBOUNCE_COUNTS, COUNTER_WIDTH)  debounce_counter(clk, is_waiting,1'b1, debounce_count);
	one_hot_reducer col_red(col, col_ind);
	one_hot_reducer row_red(row, row_ind);
	// Simple clock divider
	assign all_unpressed = (held_cols==4'b0000);
	always_ff @(posedge clk)
		begin
		digit_out<=digit_out;
		held_cols<=held_cols;
		is_waiting<=is_waiting;
		sync_col_ind<=sync_col_ind;
		if(nreset==0)
			begin
			digit_out<=4'hf;
			held_cols<=4'b0000;
			is_waiting<=1'b0;
			sync_col_ind<=2'd0;
			end
		else if(is_waiting)
			begin
			if(debounce_count==(DEBOUNCE_COUNTS-1))
				is_waiting<=1'b0;
			end
		else
			begin
			if(sync_col_ind != col_ind)
				begin
				sync_col_ind<=col_ind;
				if(row == 4'b0)
					held_cols <= held_cols & (~col);
				else
					begin
					held_cols<=held_cols|col;
					if(((held_cols & (~col)) == 4'b0) &&((row==4'b1000)|(row==4'b0100)|(row==4'b0010)|(row==4'b0001)))
						begin
						digit_out<={col_ind,row_ind};
						if(held_cols==0)
							is_waiting<=1'b1;
						end	
					end
				end
			end
		end
		
endmodule

module one_hot_reducer(input logic [3:0] one_hot_in, output logic [1:0] index_out);
	always_comb
		begin
		if(one_hot_in[0])
			index_out=2'd0;
		else if(one_hot_in[1])
			index_out=2'd1;
		else if(one_hot_in[2])
			index_out=2'd2;
		else
			index_out=2'd3;
		end
	
endmodule