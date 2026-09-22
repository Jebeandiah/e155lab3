//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module poller (input logic clk,nreset,enable, input logic [3:0] col,input logic [3:0] row,
output logic is_new_digit,output logic[3:0] digit_out);
	
	logic[1:0] sync_col_ind;
	logic[1:0] col_ind;
	logic[1:0] row_ind;
	logic[3:0] held_cols;
	one_hot_reducer col_red(col, col_ind);
	one_hot_reducer row_red(row, row_ind);
	// Simple clock divider


	
	
	always_ff @(posedge clk)
		begin
		is_new_digit <= 1'b0;
		if(nreset==0)
			begin
			digit_out<=4'hf;
			held_cols<=4'b0000;
			sync_col_ind<=2'd0;
			is_new_digit <= 1'b0;
			end
		else if(enable)
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
						if((held_cols==4'b0000)||({col_ind,row_ind}!=digit_out))
							is_new_digit <= 1'b1;
						digit_out<={col_ind,row_ind};
						end	
					
					end
					
				end
			end
		end
		
endmodule

