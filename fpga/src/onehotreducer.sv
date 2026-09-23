module onehotreducer(input logic [3:0] one_hot_in, output logic [1:0] index_out);
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