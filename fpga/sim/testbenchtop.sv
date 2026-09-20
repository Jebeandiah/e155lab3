//Author: Ben Lertwachara - blertwachara@hmc.edu
//Date: 9/9/2026
//Functionality: Testbench for heartbeat module

`timescale 1 ns/1 ns


module testbenchtop();

  logic[3:0] s_1;
logic [3:0] s_2;
logic[3:0] scan_row_in;
logic [6:0] seg; 
logic [1:0] active_display;logic[3:0] scan_led; 
logic[3:0] scan_col_out;
logic[6:0] last_seg = 7'b0;
  lab2_bl
 dut (
.s_1(s_1), .s_2(s_2), .scan_row_in(scan_row_in), .seg(seg), .active_display(active_display), .scan_led(scan_led), .scan_col_out(scan_col_out)
    );

  initial begin
	s_2 = 4'h8;
	s_1 = 4'h1;
		scan_row_in = 4'b0;//setup inputs
	#10;       
	//wait required time
	force dut.multiplexing_counter.reset =0;
	#4166667
	force dut.multiplexing_counter.reset =1;
	#4166667
	last_seg=seg;

	#4166667
	assert ((seg == 7'b1111001) || (seg==7'b0000000) && (last_seg != seg))   //check outputs
		$display("PASSED! seven seg mux at time: %0t.", $time);
	else 
		$error("FAILED! SEVEN seg mux at time: %0t.", $time); 
	last_seg=seg;

	#4166667
	assert ((seg == 7'b1111001) || (seg==7'b0000000) && (last_seg != seg))       //check outputs
		$display("PASSED! seven seg mux at time: %0t.", $time);
	else 
		$error("FAILED! SEVEN seg mux at time: %0t.", $time); 
	last_seg=seg;

	#4166667
	assert ((seg == 7'b1111001) || (seg==7'b0000000) && (last_seg != seg))       //check outputs
		$display("PASSED! seven seg mux at time: %0t.", $time);
	else 
		$error("FAILED! SEVEN seg mux at time: %0t.", $time); 
	last_seg=seg;

	#4166667
	assert ((seg == 7'b1111001) || (seg==7'b0000000) && (last_seg != seg))       //check outputs
		$display("PASSED! seven seg mux at time: %0t.", $time);
	else 
		$error("FAILED! SEVEN seg mux at time: %0t.", $time); 
	last_seg=seg;

	#4166667
	assert ((seg == 7'b1111001) || (seg==7'b0000000) && (last_seg != seg))       //check outputs
		$display("PASSED! seven seg mux at time: %0t.", $time);
	else 
		$error("FAILED! SEVEN seg mux at time: %0t.", $time); 
	scan_row_in = 4'b1000;//setup inputs
	#1
	assert (scan_led == scan_row_in)       //check outputs
		$display("PASSED! scanned correct at time: %0t.", $time);
	else 
		$error("FAILED! scanned correct at time: %0t.", $time); 
	scan_row_in = 4'b0100;//setup inputs
	#1
	assert (scan_led == scan_row_in)       //check outputs
		$display("PASSED! scanned correct at time: %0t.", $time);
	else 
		$error("FAILED! scanned correct at time: %0t.", $time);
		scan_row_in = 4'b0010;//setup inputs
	#1
	assert (scan_led == scan_row_in)       //check outputs
		$display("PASSED! scanned correct at time: %0t.", $time);
	else 
		$error("FAILED! scanned correct at time: %0t.", $time);
		scan_row_in = 4'b0001;//setup inputs
	#1
	assert (scan_led == scan_row_in)       //check outputs
		$display("PASSED! scanned correct at time: %0t.", $time);
	else 
		$error("FAILED! scanned correct at time: %0t.", $time);
   #100 $stop;
  end
endmodule