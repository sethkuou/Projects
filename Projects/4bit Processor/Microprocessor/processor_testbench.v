`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:43:05 04/25/2016
// Design Name:   processor
// Module Name:   X:/.win_desktop/Microprocessor/processor_testbench.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module processor_testbench;

	// Inputs
	reg [1:0] button;
	reg [7:0] switches;
	reg clock;
	reg reset;

	// Outputs
	wire [3:0] leds;

	// Instantiate the Unit Under Test (UUT)
	processor uut (
		.button(button), 
		.switches(switches), 
		.clock(clock), 
		.reset(reset), 
		.leds(leds)
	);
	integer test = 0;
	always #5 clock =~ clock;
	initial begin
		// Initialize Inputs
		button = 0;
		switches = 0;
		clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//SingleStep
		//  Reset
		reset=1; #10; reset=0; #10;
		//	load		 		
	   switches=8'b00001101; #10; button=2'b10; #10; button=2'b00; #10; button=2'b10; #10; button=2'b00; #10;
		// store 					
		switches=8'b01001111; #10; button=2'b10; #10; button=2'b00; #10; test = 1; #10 test = 0; #10;
		//  move 								
		switches = 8'b10010011; #10; button = 2'b10; #10; button = 2'b00; #20;
		//load 1010 in r0						         
		switches = 8'b00001010; #10; button=2'b10; #10; button=2'b00; #10; 
		//and						
		switches=8'b11010010; #10; button=2'b10; #10; button=2'b00; #20;
		//not
		switches=8'b11000011; #10 button=2'b10; #10; button=2'b00; #20;
		//add 
		switches = 8'b11000100; #10; button=2'b10; #10; button=2'b00; #20;
		
		//ROM
		//Reset								
		reset=1; #10; reset=0; #10;
		//Read Rom button
      button=2'b01; #10; button=2'b00; #200; test=2; #10; test=0; #10;		
		
		$display("...SIMULATION FINISHED");
	end
	
	always@(negedge clock)
	begin
		case(test)
			1:
				if(leds != 4'b1101)
					$display("Test 1 Error LEDs should be 1101. actually: %b",leds);
			2:
				if(leds != 4'b1111)
					$display("Test 2 Error LEDs should be 1111. actually: %b",leds);

		endcase
	end

      
endmodule

