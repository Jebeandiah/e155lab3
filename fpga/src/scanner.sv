//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/15/2026
//Functionality: Splits counter modules width in 4
//and assigns output for each section to scan each column
//at 2hz

module scanner #(
parameter MAX_COUNT = 100_000,
parameter COUNTER_WIDTH = 17
) (input logic clk, reset, enable,
output logic [3:0] one_hot_col);
logic [COUNTER_WIDTH-1:0] counter;
//typedef enum logic[1:0] {COL0, COL1, COL2, COL3} scanning_col;
counter #(MAX_COUNT, COUNTER_WIDTH) scanning_counter(clk, reset,enable, counter);
localparam QUARTER_MAX = MAX_COUNT / 4;

always_comb
begin
	if(reset ==0)
		one_hot_col = 4'b1000;
	else if(counter<= (QUARTER_MAX-1))
		one_hot_col = 4'b1000;
	else if(counter<=((2*QUARTER_MAX)-1))
		one_hot_col = 4'b0100;
	else if(counter<=((QUARTER_MAX*3)-1))
		one_hot_col = 4'b0010;
	else
		one_hot_col = 4'b0001;

end
		
endmodule