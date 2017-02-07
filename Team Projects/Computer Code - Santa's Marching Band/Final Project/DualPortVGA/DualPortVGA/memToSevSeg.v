`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:31 11/22/2016 
// Design Name: 
// Module Name:    memToSevSeg 
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
module memToSevSeg(
    input [15:0] Input,
	 input clk,
    output reg [3:0]Segment,
    output reg [7:0]Display
    );
reg [14:0] timer;
reg [3:0] draw;

initial timer = 15'd0;
initial Segment = 4'b1110;
initial Display = 8'd0;


always @ (posedge clk)
begin
	timer <= timer+1'b1; //we want this to roll over
	if (timer == 15'b111111111111111)
	begin
		if (Segment == 4'b1110)
			Segment <= 4'b1101;
		if (Segment == 4'b1101)
			Segment <= 4'b1011;
		if (Segment == 4'b1011)
			Segment <= 4'b0111;
		if (Segment == 4'b0111)
			Segment <= 4'b1110;
	end
	if (Segment == 4'b1110)
		draw <= Input [3:0];
	if (Segment == 4'b1101)
		draw <= Input [7:4];
	if (Segment == 4'b1011)
		draw <= Input [11:8];
	if (Segment == 4'b0111)
		draw <= Input[15:12];
		
	case (draw)
		0: Display = 8'b00000011;
		1: Display = 8'b10011111;
		2: Display = 8'b00100101;
		3: Display = 8'b00001101;
		4: Display = 8'b10011001;
		5: Display = 8'b01001001;
		6: Display = 8'b01000001;
		7: Display = 8'b00011111;
		8: Display = 8'b00000001;
		9: Display = 8'b00011001;
		10: Display = 8'b00010001;
		11: Display = 8'b11000001;
		12: Display = 8'b01100011;
		13: Display = 8'b10000101;
		14: Display = 8'b01100001;
		15: Display = 8'b01110001;
	endcase
end

endmodule
