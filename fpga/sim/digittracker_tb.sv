//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/93/2026
//Functionality: Testbench for digittracker module

`timescale 1 ns/1 ns


module digittracker_tb();
	logic clk;
	logic nreset;
	logic enable;
	logic all_unpressed;
	logic was_unpressed;
	logic [3:0] digit_in;
	logic [3:0] current_digit;
  digittracker
 dut (
.clk(clk), .nreset(nreset), .enable(enable), .all_unpressed(all_unpressed), .was_unpressed(was_unpressed), .digit_in(digit_in), .current_digit(current_digit)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	nreset = 1'b0;       
	enable=1'b1;
	@(posedge clk);
	#1
	nreset = 1'b1;   
	digit_in = 4'h9;
	all_unpressed=1'b0;
	@(posedge clk);
	#1
	assert(current_digit==4'h9)
		$display("PASSED! digit tracked at time: %0t.", $time);
	else 
		$error("FAILED! digit not tracked at time: %0t.", $time); 
	nreset = 1'b0;       
	
	@(posedge clk);
	#1
	assert(current_digit==4'b0000)
		$display("PASSED! digit reset at time: %0t.", $time);
	else 
		$error("FAILED! digit not reset at time: %0t.", $time); 
	nreset = 1'b1;   
	all_unpressed = 1'b1;
	@(posedge clk);
	#1
	assert(was_unpressed==1'b1)
		$display("PASSED! unpress tracked at time: %0t.", $time);
	else 
		$error("FAILED! unpress not tracked at time: %0t.", $time); 
	//nreset = 1'b0;       
	enable=1'b0;
	all_unpressed=1'b0;
	@(posedge clk);
	#1
	assert(was_unpressed==1'b1)
		$display("PASSED! disabled at time: %0t.", $time);
	else 
		$error("FAILED! not disabled at time: %0t.", $time); 
	//repeat(3) @(posedge clk);

	//force dut.counter = 25'd20_000_000;
	//@(posedge clk);
	//release dut.counter;



   #100 $stop;
  end

endmodule