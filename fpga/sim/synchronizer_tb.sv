//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/23/2026
//Functionality: Testbench for synchronizer module

`timescale 1 ns/1 ns


module synchronizer_tb();
	logic clk;
	
	logic [3:0] async_in;
	logic [3:0] sync_out;
  synchronizer
 dut (
.clk(clk),  .async_in(async_in), .sync_out(sync_out)
    );

   always begin
     clk = 0; #5;
     clk = 1; #5;
  end
  initial begin
	async_in=4'h6;
	@(posedge clk);
	#1
	@(posedge clk);
	#1
	@(posedge clk);
	#1
	async_in=4'h5;
	@(posedge clk);
	#1
	assert(sync_out!=4'h5)
		$display("PASSED! digit delayed at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);
	
	@(posedge clk);
	#1
	assert(sync_out==4'h5)
		$display("PASSED! digit arrived at time: %0t.", $time);
	else 
		$error("FAILED! digit not delayed at time: %0t.", $time);

   #100 $stop;
  end

endmodule