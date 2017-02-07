`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:25 11/10/2016 
// Design Name: 
// Module Name:    BellOut 
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
module BellController(
    input [10:0] Instruction,
    input Clock,
	 input newData,
    output reg Right,
    output reg Left,
    output reg [8:1] Bells,
	 output reg More
    );
parameter ringLength = 8000000;
parameter OneBeat =    60000000; 

reg doubleFlag;
reg [8:1] LeftRing;
reg [8:1] RightRing;
reg [28:0] Timer;
reg [23:0] BellRing;
initial BellRing = 0;
initial Timer = 0;

always @ (posedge Clock)
begin
	// Decrement the two timers
	if (Timer != 0)
		Timer <= Timer - 1'b1;
	if (BellRing != 0)
		BellRing <= BellRing - 1'b1;
	
	//If we should stop ringing the bells
	if (BellRing == 0)
	begin
		Right <= 1'b0;
		if (doubleFlag)
		begin
			Left <= 1'b1;
			doubleFlag <= 1'b0;
			Bells <= LeftRing;
			BellRing <= ringLength;
		end
		else
		begin
			Bells <= 8'd0;
			Left <= 1'b0;
		end
	end
	
	
	// If note length has finished
	if (Timer == 0) //no "else if" since we want it to check again
	begin
		if (newData == 1'b1)
		begin
			//TIMER
			if (Instruction[10:9] == 2'd0)
				Timer <= OneBeat >> 1;
			if (Instruction[10:9] == 2'd1)
				Timer <= OneBeat;
			if (Instruction[10:9] == 2'd2)
				Timer <= OneBeat << 1;
			if (Instruction[10:9] == 2'd3)
				Timer <= OneBeat << 2;
				
			if (Instruction[8])
			begin
				LeftRing = { //These are the left notes
					Instruction[7:4] == 5'd6  || Instruction[3:0] == 5'd6,
					Instruction[7:4] == 5'd8  || Instruction[3:0] == 5'd8,
					Instruction[7:4] == 5'd9  || Instruction[3:0] == 5'd9,
					Instruction[7:4] == 5'd11 || Instruction[3:0] == 5'd11,
					Instruction[7:4] == 5'd0  || Instruction[3:0] == 5'd0,
					Instruction[7:4] == 5'd2  || Instruction[3:0] == 5'd2,
					Instruction[7:4] == 5'd4  || Instruction[3:0] == 5'd4,
					Instruction[7:4] == 5'd3  || Instruction[3:0] == 5'd3};
				RightRing = { //These are the right notes
					Instruction[7:4] == 5'd15 || Instruction[3:0] == 5'd15,
					Instruction[7:4] == 5'd7  || Instruction[3:0] == 5'd7,
					Instruction[7:4] == 5'd14 || Instruction[3:0] == 5'd14,
					Instruction[7:4] == 5'd12 || Instruction[3:0] == 5'd12,
					Instruction[7:4] == 5'd10 || Instruction[3:0] == 5'd10,
					Instruction[7:4] == 5'd1  || Instruction[3:0] == 5'd1,
					Instruction[7:4] == 5'd13 || Instruction[3:0] == 5'd13,
					Instruction[7:4] == 5'd5  || Instruction[3:0] == 5'd5};
			end
			else
			begin
				LeftRing = 8'd0;
				RightRing = 8'd0;
			end
					
			if (|LeftRing && |RightRing) //If both right and left, ring right first, and set the doubleFlag
			begin
				doubleFlag <= 1'b1;
				Bells      <= RightRing;
				BellRing   <= ringLength;
				Right      <= 1'b1;
				Left       <= 1'b0;
			end
			else if (|LeftRing) //If just left
			begin
				doubleFlag <= 1'b0;
				Bells      <= LeftRing;
				BellRing   <= ringLength;
				Right      <= 1'b0;
				Left       <= 1'b1;
			end
			else if (|RightRing)
			begin //If just right
				doubleFlag <= 1'b0;
				Bells      <= RightRing;
				BellRing   <= ringLength;
				Right      <= 1'b1;
				Left       <= 1'b0;
			end
			else
			begin
				doubleFlag <= 1'b0;
				Bells      <= 8'd0;
				BellRing   <= ringLength;
				Right      <= 1'b0;
				Left       <= 1'b0;
			end
			More <= 1'b0; //We don't need more yet.
		end
		else
		begin
 
		end
	end
end

endmodule
