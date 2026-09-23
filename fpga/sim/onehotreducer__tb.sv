//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: Testbench for reducer module

`timescale 1 ns/1 ns


module onehotreducer_tb();
	logic clk;
	
	logic [3:0] one_hot_in;
	logic [1:0] index_out;
  onehotreducer
 dut (
 .one_hot_in(one_hot_in), .index_out(index_out)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	one_hot_in=4'b1100;
	@(posedge clk);
	#1
	assert(index_out==2'd2)
		$display("PASSED! index decoded correctly at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);
	one_hot_in=4'b1110;
	@(posedge clk);
	#1
	assert(index_out==2'd1)
		$display("PASSED! index decoded correctly at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);
	one_hot_in=4'b1101;
	@(posedge clk);
	#1
	assert(index_out==2'd0)
		$display("PASSED! index decoded correctly at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);
	one_hot_in=4'b1000;
	@(posedge clk);
	#1
	assert(index_out==2'd3)
		$display("PASSED! index decoded correctly at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);
   #100 $stop;
  end

endmodule