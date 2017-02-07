`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:26 04/22/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [3:0]rx,
    input [3:0]ry,
    input [3:0]operation,
    output reg [3:0] out
    );

	always@(*)
	begin
		if(operation[3:2] == 2'b10)//Move ry into rx
			out = ry;
		else if(operation == 4'b1111)//Not rx
			out = ~rx;
		else if(operation == 4'b1110)//And rx & ry
			out = rx & ry;
		else if(operation == 4'b1101)//Sub rx - ry
			out = rx - ry;
		else if(operation == 4'b1100)//Add rx + ry
			out = rx + ry;
		else
			begin
				out = 0;
			end
	end
	

endmodule
