`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:21 04/22/2016 
// Design Name: 
// Module Name:    mux_2t01 
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
module mux_2to1(
    input select,
    input [3:0] load,
    input [3:0] alu,
    output reg[3:0] out
    );
	 
	 always@(*)
	 begin
		if(select)
			out = load;
		else
			out = alu; 
	 end

endmodule
