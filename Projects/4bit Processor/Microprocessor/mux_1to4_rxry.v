`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:53 04/22/2016 
// Design Name: 
// Module Name:    mux_1to4_rxry 
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
module mux_1to4_rxry(
    input in,
    input [1:0] select,
    output reg out0,
    output reg out1,
    output reg out2,
    output reg out3
    );
  always@(*)
	 begin
		if(select == 2'b00)
		begin
			out0 = in;
			out1 = 1'b0;
			out2 = 1'b0;
			out3 = 1'b0;
		end
		else if(select == 2'b01)
		begin
			out0 = 1'b0;
			out1 = in;
			out2 = 1'b0;
			out3 = 1'b0;
		end
		else if(select == 2'b10)
		begin
			out0 = 1'b0;
			out1 = 1'b0;
			out2 = in;
			out3 = 1'b0;
		end
		else
		begin
			out0 = 1'b0;
			out1 = 1'b0;
			out2 = 1'b0;
			out3 = in;
		end
	end


endmodule
