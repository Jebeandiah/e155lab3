//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Counter with configureable max
//count, reset, and enable functionality

module counter #(
parameter MAX_COUNT = 200_000,
parameter COUNTER_WIDTH = 25
) (input logic clk, reset, enable,
output logic[COUNTER_WIDTH-1:0] counter);
	
	// Simple clock divider
	always_ff @(posedge clk)
	begin
		if(reset == 0) 
			counter <=0;
		else if(counter == MAX_COUNT-1) 
			counter <= 0;
		else if(enable == 1)
			counter <= counter+1'b1;
	end
		
endmodule