//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module poller_tb();
	logic clk;
	logic nreset;
	logic[3:0] col;

	logic[3:0] row;
	logic all_unpressed;
	logic[3:0] digit_out;
	logic[3:0] saved_digit_out;
  poller
 dut (
.clk(clk), .nreset(nreset), .col(col), .row(row), .all_unpressed(all_unpressed), .digit_out(digit_out)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	nreset = 1'b0;       
	col = 4'b1000;
	row = 4'b0000;
	@(posedge clk);
	#1
	nreset = 1'b1;       
	@(posedge clk);
	#1
	col = 4'b0100;
	row = 4'b1000;
	@(posedge clk);
	#1
	saved_digit_out =digit_out;
	assert(!all_unpressed)
		$display("PASSED! press received at time: %0t.", $time);
	else 
		$error("FAILED! press not received at time: %0t.", $time); 
	nreset = 1'b0;
	@(posedge clk);
	#1
	assert(digit_out==4'hf)
		$display("PASSED! reset at time: %0t.", $time);
	else 
		$error("FAILED! not reset at time: %0t.", $time); 
	nreset = 1'b1;  
	col = 4'b0100;
	row = 4'b0000;	
	@(posedge clk);
	#1
	
	col = 4'b0010;
	row = 4'b0010;
	@(posedge clk);
	#1
	assert(digit_out!=saved_digit_out)
		$display("PASSED! single digit registered at time: %0t.", $time);
	else 
		$error("FAILED! digit not registered at time: %0t.", $time); 
	@(posedge clk);
	#1
	@(posedge clk);
	#1
	col = 4'b0100;
	row = 4'b0000;
		@(posedge clk);
	#1
	col = 4'b1000;
	row = 4'b1000;
	@(posedge clk);
	#1
	saved_digit_out = digit_out;
	col = 4'b0100;
	row = 4'b1000;
		@(posedge clk);
	#1
	assert(saved_digit_out==digit_out)
		$display("PASSED! no new digit when multipress at time: %0t.", $time);
	else 
		$error("FAILED! new digit when multipress at time: %0t.", $time); 

	//repeat(3) @(posedge clk);

	//force dut.counter = 25'd20_000_000;
	//@(posedge clk);
	//release dut.counter;



   #100 $stop;
  end
endmodule