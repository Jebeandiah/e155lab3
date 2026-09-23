//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module digitbuffer_tb();
	logic clk;
	logic nreset;
	logic enable;
	logic [3:0] digit_in;
	logic [3:0]digit_1;
	logic [3:0] digit_2;
  digitbuffer
 dut (
.clk(clk), .nreset(nreset), .enable(enable),  .digit_in(digit_in), .digit_1(digit_1), .digit_2(digit_2)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	digit_in=4'ha;
	enable =1'b0;
	nreset = 1'b0;       
	@(posedge clk);
	#1
	nreset = 1'b1;   
	enable =1'b1;

	digit_in = 4'h9;
	@(posedge clk);
	#1
		assert(digit_1==4'h9)
		$display("PASSED! shifted digit at time: %0t.", $time);
	else 
		$error("FAILED! shift not enabled at time: %0t.", $time);
	enable =1'b0;

	digit_in = 4'h5;
	@(posedge clk);
	#1
		assert(digit_1==4'h9)
		$display("PASSED! digit not shifted at time: %0t.", $time);
	else 
		$error("FAILED! shift not enabled at time: %0t.", $time);
		nreset = 1'b1;   
	enable =1'b1;

	digit_in = 4'h5;
	@(posedge clk);
	#1
		assert((digit_1==4'h5) &&(digit_2==4'h9))
		$display("PASSED! shifted both digits at time: %0t.", $time);
	else 
		$error("FAILED! shift not enabled at time: %0t.", $time);
	
	//force dut.counter = 25'd20_000_000;
	//@(posedge clk);
	//release dut.counter;



   #100 $stop;
  end

endmodule