//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: Shift register for digits

module digitbuffer(input logic clk, nreset, enable, input logic [3:0] digit_in,
	
	output logic [3:0]digit_1,output logic [3:0] digit_2);
	 
	always_ff @(posedge clk)
		begin
		if(nreset==0)
			begin
			digit_1 <= 4'hf;
			digit_2 <= 4'hf;
			end
		else if(enable) 
			begin
			
			//if(((!all_unpressed) && were_all_unpressed)||(digit_in!=digit_1))
				
			digit_2<=digit_1;
			digit_1<=digit_in;
				
			end
		end

endmodule




