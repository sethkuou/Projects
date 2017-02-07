`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	CS3700
// Engineer: 	Seth Kingston
// 
// Create Date:    09:36:36 03/11/2016 
// Design Name: 
// Module Name:    DFlip_Flop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 	Dflip flop for Problem 3
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DFlip_Flop(
	 input Clock,
    input [4:0]D, 
	 input enable,
	 output reg[3:0] Q
	 );
	 
	 always @(posedge Clock)
	 if(enable && D != 5'b10000)
		Q = D[3:0];
	 else
		Q = Q;


endmodule
