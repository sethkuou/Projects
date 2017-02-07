`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:33 04/22/2016 
// Design Name: 
// Module Name:    mux_1to4 
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
module mux_1to4(
    input [3:0] in,
    input [1:0] select,
    output reg[4:0] out0,
    output reg[4:0] out1,
    output reg[4:0] out2,
    output reg[4:0] out3
    );
	 
	 always@(*)
		begin
			if(select == 2'b00)
			begin
				out0[3:0] = in;
				out0[4] = 1'b0;
				out1 = 5'b10000;
				out2 = 5'b10000;
				out3 = 5'b10000;
			end
			else if(select == 2'b01)
			begin
				out0 = 5'b10000;
				out1[3:0] = in;
				out1[4] = 1'b0;
				out2 = 5'b10000;
				out3 = 5'b10000;
			end
			else if(select == 2'b10)
			begin
				out0 = 5'b10000;
				out1 = 5'b10000;
				out2[3:0] = in;
				out2[4] = 1'b0;
				out3 = 5'b10000;
			end
			else
			begin
				out0 = 5'b10000;
				out1 = 5'b10000;
				out2 = 5'b10000;
				out3[3:0] = in;
				out3[4] = 1'b0;
			end
		end
endmodule
