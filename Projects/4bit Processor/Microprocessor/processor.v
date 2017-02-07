`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:54 04/25/2016 
// Design Name: 
// Module Name:    processor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module processor(
    input [1:0] button,
    input [7:0] switches,
    input clock,
    input reset,
    output [3:0] leds
    );
	 
	 wire[7:0] instructions;
	 wire[3:0] rx, ry, rxOut, aluOperation, load, programCounter;
	 wire[1:0] debutton, rxSelect, rySelect; 
	 
//	 debouncer deb0(clock, button[0], debutton[0]),  //need these for the board
//				  deb1(clock, button[1], debutton[1]),  // commented out for testbenches
//				  debreset(clock, reset, resetBounce);

	 ALU myALU (rx, ry, aluOperation, rxOut);
	 LEDS myLEDS(rx, clock, ledEnable, leds);
	 ROM myROM(programCounter, instructions); 
	 RegisterFile  RegFile(clock, rxOut, load, loadSelect, rxEnable, rxSelect, rySelect, rx, ry);
	 FSMC Controler (button, switches, instructions, clock, reset, loadSelect, rxEnable, ledEnable, load, rxSelect, rySelect, aluOperation, programCounter);
	

	 
 

endmodule
