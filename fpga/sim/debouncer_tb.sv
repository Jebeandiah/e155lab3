//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module debouncer_tb();
	logic clk;
	logic nreset;
	logic all_unpressed;
	logic [3:0] digit_in;
	logic shift_enable;
	typedef enum logic [1:0] {
        TRACKING_DIGIT, SHIFT_ENABLED, DEBOUNCING
    } state_t;
  debouncer #(.DEBOUNCING_MAX(5))
 dut (
.clk(clk), .nreset(nreset), .all_unpressed(all_unpressed),  .digit_in(digit_in), .shift_enable(shift_enable)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	digit_in=4'ha;

	nreset = 1'b0;       
	@(posedge clk);
	#1
	nreset = 1'b1;   
	//digit_in = 4'h9;
	all_unpressed=1'b1;
	@(posedge clk);
	#1
		assert(shift_enable==1'b1)
		$display("PASSED! enabled shift at time: %0t.", $time);
	else 
		$error("FAILED! shift not enabled at time: %0t.", $time);
	digit_in=4'h5;
	@(posedge clk);
	#1
	assert(dut.state==DEBOUNCING)
		$display("PASSED! entered debouncing state at time: %0t.", $time);
	else 
		$error("FAILED! did not enter debouncing state at time: %0t.", $time);
 	all_unpressed=1'b1;
	digit_in=4'h5;
	@(posedge clk);
	#1
	assert(shift_enable==1'b0)
		$display("PASSED! press ignored during debounce at time: %0t.", $time);
	else 
		$error("FAILED! press not ignored during debounce at time: %0t.", $time);
	repeat(10) @(posedge clk);
	#1
	assert(dut.state==TRACKING_DIGIT)
		$display("PASSED! entered tracking state at time: %0t.", $time);
	else 
		$error("FAILED! did not enter tracking state at time: %0t.", $time);
	all_unpressed=1'b1;
	@(posedge clk);
	#1
	digit_in=4'h3;
	@(posedge clk);
	#1
	assert(shift_enable==1'b1)
		$display("PASSED! enabled shift after debounce at time: %0t.", $time);
	else 
		$error("FAILED! shift not enabled at time: %0t.", $time);
	//force dut.counter = 25'd20_000_000;
	//@(posedge clk);
	//release dut.counter;



   #100 $stop;
  end

endmodule