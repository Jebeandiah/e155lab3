//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module poller_tb();
	logic clk;
	logic nreset;
	logic enable;
	logic[3:0] col;

	logic[3:0] row;
	logic is_new_digit;
	logic[3:0] digit_out;

  lab3_bl
 dut (
.clk(clk), .nreset(nreset), .enable(enable), .col(col), .row(row), .is_new_digit(is_new_digit), .digit_out(digit_out)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	reset = 1'b0;       
	enable = 1'b0;
	@(posedge clk);
	#1
	assert((dut.counter == 3'd0) && (fpga_blink_out == 1'd0))
		$display("PASSED! counter reset initially works at time: %0t.", $time);
	else 
		$error("FAILED! counter reset initially fails at time: %0t.", $time); 
	reset = 1'b1;       
	enable = 1'b0;

	repeat(3) @(posedge clk);
	#1
	
	assert((dut.counter == 3'd0) && (fpga_blink_out == 1'd0))
		$display("PASSED! not enable successfully prevents increment at time: %0t.", $time);
	else 
		$error("FAILED! not enable failed to prevent increment at time: %0t.", $time); 
			
	reset = 1'b1;       
	enable = 1'b1;
	@(posedge clk);
	#1
	assert((dut.counter == 3'd1))
	$display("PASSED!  successfully incremented at time: %0t.", $time);
	else 
		$error("FAILED! not successfully incremented at time: %0t.", $time); 
	enable = 1'b0;
	@(posedge clk);
	#1
	assert((dut.counter == 3'd1) && (fpga_blink_out == 1'd0))
	$display("PASSED!  successfully paused at time: %0t.", $time);
	else 
		$error("FAILED! not successfully paused at time: %0t.", $time); 
	enable = 1'b1;
	reset = 1'b0;       
	@(posedge clk);
	#1
	assert((dut.counter == 3'd0) && (fpga_blink_out == 1'd0))
	$display("PASSED!  successfully reset from non zero: %0t.", $time);
	else 
		$error("FAILED! did not reset from non zero: %0t.", $time); 
	reset = 1'b1;       

	force dut.counter = 25'd9_999_999;
	@(posedge clk);
	release dut.counter;
	#1
	assert(fpga_blink_out == 1'd0)
		$display("PASSED! light still off before half max at t: %0t.", $time);
	else 
		$error("FAILED! light still on before half max at t: %0t.", $time); 
	@(posedge clk);
	#1
	assert(fpga_blink_out == 1'd1)
		$display("PASSED! light on at half max at t: %0t.", $time);
	else 
		$error("FAILED! light off at half max at t: %0t.", $time); 
	force dut.counter = 25'd20_000_000;
	@(posedge clk);
	release dut.counter;
	#1
	assert((dut.counter == 3'd0) && (fpga_blink_out == 1'd1))
		$display("PASSED! counter wrapped at max and flashed light: %0t.", $time);
	else 
		$error("FAILED! counter did not wrap at max or flash light: %0t.", $time); 


   #100 $stop;
  end
endmodule