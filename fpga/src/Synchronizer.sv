//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Syncs async inputs with one intermed stage

module synchronizer #(parameter WIDTH = 4) (input logic clk, input logic [WIDTH-1:0] async_in,
output logic[WIDTH-1:0] sync_out); 
	logic[WIDTH-1:0] intermed;
	// Simple clock divider
	always_ff @(posedge clk)
	begin
		intermed <= async_in;
		sync_out <= intermed;
	end
		
endmodule
