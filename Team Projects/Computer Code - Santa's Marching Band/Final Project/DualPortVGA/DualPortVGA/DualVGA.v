`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:08 11/14/2016 
// Design Name: 
// Module Name:    DualVGA 
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
module DualVGA(
    output reg [2:0]Red,
    output reg [2:0]Green,
    output reg [2:1]Blue,
    input Clock,
	 output [14:0]toMem,
	 input [15:0]memOut,
    output HSync,
    output VSync
    );
	initial Red = 3'b0;
	initial Green = 3'b0;
	initial Blue = 2'b0;
	
	parameter HActive = 640;
	parameter HFront = 16;
	parameter HSyncLength = 96;
	parameter HBack = 48;
	
	parameter VActive = 480;
	parameter VFront = 10;
	parameter VSyncLength = 2;
	parameter VBack = 33;

	wire active;

	reg [9:0]XPos;
	initial XPos = 10'b0;
	reg [9:0]YPos;
	initial YPos = 10'b0;
	wire [15:0]wasteOut;
						
	reg [1:0]cycle;
	initial cycle = 2'b0;
	
	reg [7:0]colors;
	initial colors = 8'd0;
	
	assign HSync = ~(HActive + HFront <= XPos && XPos < HActive + HFront + HSyncLength);
	assign VSync = ~(VActive + VFront <= YPos + 1 && YPos + 1 < VActive + VFront + VSyncLength);
	assign active = (XPos < HActive && YPos < VActive);
	assign toMem = (cycle==2'b01) ? {2'd0, YPos [8:3], XPos[9:3]} : (15'd8192 + {memOut[15:8], YPos[2:1]});
	
	always @ (posedge Clock)
	begin
		cycle <= cycle + 1'b1; //We intentionally want this to roll over. This will set the VGA clock speed to 25 MHz.
		
		// on cycle 0, do nothing
		
		//On cycle 1, send what position is needed
		
		//On cycle 2, send what part of the character we need, we should also be able to latch the color.
		if (cycle == 2'b10)
			colors <= {memOut[7:4], memOut[3:0]};
		
		if (cycle == 2'b11) //On cycle 3, output to the VGA
		begin
		   {Red, Green, Blue} <= 8'd0;
		   	
			if (active)
			begin
				if (memOut[ {~YPos[0], 3'd7-XPos[2:0]} ])
					//{Red, Green, Blue} <= 8'b11111111;
					{Red, Green, Blue} <= {colors[7], colors[6], colors[6], colors[5], colors[5], colors[5], colors[4], colors[4]};
				else
					{Red, Green, Blue} <= {colors[3], colors[2], colors[2], colors[1], colors[1], colors[1], colors[0], colors[0]};
			
			end
			XPos <= XPos + 1'b1;
			if (XPos+1 >= HActive + HFront + HSyncLength + HBack)
				XPos <= 10'b0;
			if (XPos == HActive + HFront)
				YPos <= YPos + 1'b1;
			if (YPos+1 >= VActive + VFront + VSyncLength + VBack)
				YPos <= 10'b0;
		end
	end
	
endmodule
