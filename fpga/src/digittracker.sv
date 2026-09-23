//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: tracks last input to tell if theres a change

module digittracker (input logic clk,nreset,enable, all_unpressed,output logic was_unpressed, input logic [3:0] digit_in, output logic [3:0] current_digit);
	

	always_ff @(posedge clk)
		begin
		if(nreset==0)
			begin
			current_digit<=4'b0000;
			was_unpressed <=1'b0;
			end
		else if(enable)
			was_unpressed <= all_unpressed;
			
			if((digit_in!=current_digit)||(was_unpressed && !all_unpressed))
				current_digit <= digit_in;

		end
		
endmodule

