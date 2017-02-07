`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Cs3700 	
// Engineer: 	Seth Kingston
// 
// Create Date:    09:57:08 03/11/2016 
// Design Name: 	8 to 1 mux
// Module Name:    eight_to_one_mux 
// Project Name: 		universal shift register
// Target Devices: 
// Tool versions: 
// Description: 		8 to 1 mux
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4to1(
	input[1:0] select,
	input [3:0] in0,
	input [3:0] in1,
	input [3:0] in2,
	input [3:0] in3,
	output reg [3:0] out
    );
	 
	always@(*)
	begin
		if(select == 2'b00)
			out = in0;
		else if(select == 2'b01)
			out = in1;
		else if(select == 2'b10)
			out = in2;
		else
			out = in3;
	end


endmodule
