//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module debounced_poller_tb();
	logic clk;
	logic nreset;
	logic[3:0] col;

	logic[3:0] row;
	logic is_new_digit;
	logic[3:0] digit_out;
	logic[3:0] saved_digit_out;
  debounced_poller
 dut (
.clk(clk), .nreset(nreset), .col(col), .row(row), .is_new_digit(is_new_digit), .digit_out(digit_out)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	nreset = 1'b0;       
	enable = 1'b0;
	col = 4'b1000;
	row = 4'b0000;
	@(posedge clk);
	#1
	nreset = 1'b1;       
	enable = 1'b1;
	@(posedge clk);
	#1
	col = 4'b0100;
	row = 4'b1000;
	@(posedge clk);
	#1
	assert(is_new_digit)
		$display("PASSED! new digit received at time: %0t.", $time);
	else 
		$error("FAILED! new digit noy received at time: %0t.", $time); 
	nreset = 1'b0;
	@(posedge clk);
	#1
	assert(digit_out==4'hf)
		$display("PASSED! reset at time: %0t.", $time);
	else 
		$error("FAILED! not reset at time: %0t.", $time); 
	nreset = 1'b1;       
	enable = 1'b0;
	@(posedge clk);
	#1
	col = 4'b0100;
	row = 4'b1000;
	@(posedge clk);
	#1
	assert(digit_out==4'hf)
		$display("PASSED! disabled at time: %0t.", $time);
	else 
		$error("FAILED! not disabled at time: %0t.", $time); 
	@(posedge clk);
	#1
	nreset = 1'b1;       
	enable = 1'b1;
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
	assert(!is_new_digit)
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