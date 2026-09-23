//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module poller (input logic clk,nreset, input logic [3:0] col,input logic [3:0] row,
output logic all_unpressed,output logic[3:0] digit_out);
	
	logic[1:0] sync_col_ind;

	logic[3:0] held_cols;
	logic[1:0] col_ind;
	logic[1:0] row_ind;
	onehotreducer col_red(col, col_ind);
	onehotreducer row_red(row, row_ind);
	// Simple clock divider


	assign all_unpressed = (held_cols==0);
	
	always_ff @(posedge clk)
		begin
		if(nreset==0)
			begin
			digit_out<=4'hf;
			held_cols<=4'b0000;
			sync_col_ind<=2'd0;
			end
		else if(sync_col_ind != col_ind)
			begin
			sync_col_ind<=col_ind;
			if(row == 4'b0)
				held_cols <= held_cols & (~col);
			else
				begin
				held_cols<=held_cols|col;
				if(((held_cols & (~col)) == 4'b0) &&((row==4'b1000)|(row==4'b0100)|(row==4'b0010)|(row==4'b0001)))				
					digit_out<={col_ind,row_ind};
				end	
			end
		end
		
endmodule

