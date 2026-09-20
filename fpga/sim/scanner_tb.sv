//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module scanner_tb();

  logic   clk;
  logic reset;
  logic enable; 
  logic [3:0] one_hot_col;
  localparam MAX_COUNT = 24_000_000;
  scanner # (MAX_COUNT, 25)
 dut (
.clk(clk), .reset(reset), .enable(enable), .one_hot_col(one_hot_col)
    );

  always begin
     clk = 0; #5;
     clk = 1; #5;
  end

  initial begin
	reset = 1'b0;       
	enable = 1'b0;
	@(posedge clk);
	#10
	assert((dut.one_hot_col == 4'b1000)&&dut.counter==0)
		$display("PASSED! counter reset initially works at time: %0t.", $time);
	else 
		$error("FAILED! counter reset initially fails at time: %0t.", $time); 
	reset = 1'b1;       
	enable = 1'b0;

	repeat(3) @(posedge clk);
	#10
	
	assert((dut.counter == 0) && (dut.one_hot_col == 4'b1000))
		$display("PASSED! not enable successfully prevents increment at time: %0t.", $time);
	else 
		$error("FAILED! not enable failed to prevent increment at time: %0t.", $time); 
			
	reset = 1'b1;       
	enable = 1'b1;
	@(posedge clk);
	#10
	assert((dut.counter == 1) && (dut.one_hot_col == 4'b1000))
	$display("PASSED!  successfully incremented at time: %0t.", $time);
	else 
		$error("FAILED! not successfully incremented at time: %0t.", $time); 
	enable = 1'b0;
	@(posedge clk);
	#10
	assert((dut.counter == 1) && (dut.one_hot_col == 4'b1000))
	$display("PASSED!  successfully paused at time: %0t.", $time);
	else 
		$error("FAILED! not successfully paused at time: %0t.", $time); 
	enable = 1'b1;
	
	force dut.scanning_counter.counter = MAX_COUNT/4-1;
	release dut.scanning_counter.counter;

	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b1000)
		$display("PASSED! light still off at half max at t: %0t.", $time);
	else 
		$error("FAILED! light still on at half max at t: %0t.", $time); 
	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0100)
		$display("PASSED! light on after half max at t: %0t.", $time);
	else 
		$error("FAILED! light off after half max at t: %0t.", $time); 
		
	reset = 1'b0;
	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b1000)
		$display("PASSED! reset from non zero at t: %0t.", $time);
	else 
		$error("FAILED! did not reset successfully: %0t.", $time); 
	reset = 1'b1;
	force dut.scanning_counter.counter = MAX_COUNT/2-1;
	release dut.scanning_counter.counter;

	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0100)
		$display("PASSED! light still off at half max at t: %0t.", $time);
	else 
		$error("FAILED! light still on at half max at t: %0t.", $time); 
	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0010)
		$display("PASSED! light on after half max at t: %0t.", $time);
	else 
		$error("FAILED! light off after half max at t: %0t.", $time); 
	force dut.scanning_counter.counter = MAX_COUNT/4*3-1;
	release dut.scanning_counter.counter;

	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0010)
		$display("PASSED! light still off at half max at t: %0t.", $time);
	else 
		$error("FAILED! light still on at half max at t: %0t.", $time); 
	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0001)
		$display("PASSED! light on after half max at t: %0t.", $time);
	else 
		$error("FAILED! light off after half max at t: %0t.", $time); 
		force dut.scanning_counter.counter = MAX_COUNT-1;
	release dut.scanning_counter.counter;

	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b0001)
		$display("PASSED! light still off at half max at t: %0t.", $time);
	else 
		$error("FAILED! light still on at half max at t: %0t.", $time); 
	@(posedge clk);
	#1
	assert(dut.one_hot_col == 4'b1000)
		$display("PASSED! light on after half max at t: %0t.", $time);
	else 
		$error("FAILED! light off after half max at t: %0t.", $time); 

   #100 $stop;
  end
endmodule