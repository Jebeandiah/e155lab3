//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module testbenchtop();
logic[3:0] scan_row_in;
logic [6:0] seg; 
logic [1:0] active_display;
logic[3:0] scan_col_out;
logic nreset;
  lab3_bl #(.DEBOUNCING_MAX(12000))
 dut (
.nreset(nreset), .scan_row_in(scan_row_in), .seg(seg), .active_display(active_display), .scan_col_out(scan_col_out)
    );
  initial begin

	scan_row_in = 4'b1111;//setup inputs
	#999
	nreset=1'b0;
	#21
	nreset=1'b1;
	#21
	scan_row_in = 4'b0111;//first input
	repeat (3) #85333; //wait for debounce so new input can be accepted
	scan_row_in = 4'b1111;//unpress
	#85333
	#21333 //shift to new column

	scan_row_in = 4'b0111;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b1011;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
	$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	
	#21338 //shift to new column and skew

	scan_row_in = 4'b1011;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b0111;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
		$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	#21338 //shift to new column and skew
	scan_row_in = 4'b0111;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b1011;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
	$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	
	#21338 //shift to new column and skew
	scan_row_in = 4'b1011;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b0111;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
		$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	#21338 //shift to new column and skew
	scan_row_in = 4'b0111;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b1011;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
	$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	
	#21338 //shift to new column and skew
	scan_row_in = 4'b1011;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b0111;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
		$error("FAILED! Bounce did register another press at time: %0t.", $time); 
		#21338 //shift to new column and skew
	scan_row_in = 4'b0111;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b1011;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
	$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	
	#21338 //shift to new column and skew
	scan_row_in = 4'b1011;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b0111;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
		$error("FAILED! Bounce did register another press at time: %0t.", $time); 
		#21338 //shift to new column and skew
	scan_row_in = 4'b0111;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b1011;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
	$error("FAILED! Bounce did register another press at time: %0t.", $time); 
	
	#21338 //shift to new column and skew
	scan_row_in = 4'b1011;//setup inputs
	// #21;       //wait to ensure signal gets read through clock
	// scan_row_in = 4'1111;//setup inputs
	//repeat (500) #85333;
	#85333;
	scan_row_in = 4'b1111;//bounce
	#85333
	scan_row_in = 4'b0111;
	#85333;
	scan_row_in = 4'b1111;//debounce over
	#21334
	scan_row_in = 4'b1111;//debounce over
	assert (dut.digit_1!=dut.digit_2)   //check outputs
		$display("PASSED!Bounce did not register additional press at time: %0t.", $time);
	else 
		$error("FAILED! Bounce did register another press at time: %0t.", $time); 
   #100 $stop;
  end
endmodule