`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:11:23 04/22/2016 
// Design Name: 
// Module Name:    ROM 
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
module ROM(
    input [3:0] ProgramCounter,
    output reg [7:0] instruction
    );

	always@(ProgramCounter)
	begin
		case(ProgramCounter)
			1: instruction = 8'b00000001;//load 0001 into r0 	r0=1
			2: instruction = 8'b10100011;//move r0 into r2 		r0=1, r2=1
			3: instruction = 8'b10011011;//move r2 into r1 		r0=1, r1=1, r2=1
			4: instruction = 8'b11011000;//add  r1 + r2 			r0=1, r1=2, r2=1
			5: instruction = 8'b11010010;//and  r1 & r0 			r0=1, r1=0, r2=1
			6: instruction = 8'b11001001;//sub  r0 - r2 			r0=0, r1=0, r2=1
			7: instruction = 8'b11001111;//not  ~r0            r0=15,r1=0, r2=1
			8: instruction = 8'b01001111;//store r0 LEDS should be 1111
			default: instruction = 8'b01001111;//store r0 LEDS should be 1111
		endcase
	end
	

endmodule
