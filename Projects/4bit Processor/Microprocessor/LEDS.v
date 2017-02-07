`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:37 04/22/2016 
// Design Name: 
// Module Name:    LEDS 
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
module LEDS(
    input [3:0] rx,
    input clock,
    input enable,
    output reg[3:0] leds
    );

 always@(posedge clock)
	if(enable)
		leds = rx;
	else
		leds = leds;

endmodule
