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
module Core(
    input clk,
	 input [15:0] fromMemory,
	 input[4:0] buttons, //LURDS
	 input devLever,
    output Right,
    output Left,
    output [8:1] Bells,
	 output reg [14:0]toMemory,
	 output reg [15:0]writeMemory,
	 output reg we,
	 output [7:0] LEDs
    );
wire [4:0] dbuttons;
assign LEDs = state;

Debouncer left(clk, buttons[4], 1'b1, dbuttons[4]);
Debouncer up(clk, buttons[3], 1'b1, dbuttons[3]);
Debouncer right(clk, buttons[2], 1'b1, proceed);
assign dbuttons[2] = (!devLever && proceed); //If the dev lever is on, the right button is invisible.
Debouncer down(clk, buttons[1], 1'b1, dbuttons[1]);
Debouncer select(clk, buttons[0], 1'b1, dbuttons[0]);


reg [10:0] toBells;
reg newBell;
wire More;
BellController bells(toBells, clk, newBell, Right, Left, Bells, More);

reg [15:0] PC;
initial PC = 16'h4000;

reg [15:0] memaddr;
initial memaddr = 16'd0;

reg[15:0] toSet;
initial toSet = 16'd0;

reg [5:0] state;//max 64
initial state = 5'b01111;

reg [15:0] instr;
initial instr = 16'd0;

reg lastRight;
initial lastRight = 1'b0;

reg [15:0]RegSelection, RegTwo, RegThree, RegFour, RegFive, RegSix, RegSeven, RegEight, jalReg, leftReg, rightReg, outputReg;
initial RegSelection = 16'd1;
initial RegTwo = 16'd0;
initial RegThree = 16'd0;
initial RegFour = 16'd0;
initial RegFive = 16'd0;
initial RegSix = 16'd0;
initial RegSeven = 16'd0;
initial RegEight = 16'd0;
initial jalReg = 16'h4000;

reg [15:0] flip;
initial flip = 16'd0;


always@(*) begin//For deciding left regstier
	leftReg <= 16'd0;
	case(instr[9:5])
		0: leftReg <= dbuttons;
		1: leftReg <= RegSelection; 
		2: leftReg <= RegTwo;
		3: leftReg <= RegThree;
		4:	leftReg <= RegFour;
		5: leftReg <= RegFive;
		6: leftReg <= RegSix;
		7: leftReg <= RegSeven;
		8: leftReg <= RegEight;
	endcase
end

always@(*) begin//For deciding right regstier
	rightReg <= 16'd0;
	case(instr[4:0])
		0: rightReg <= dbuttons;
		1: rightReg <= RegSelection; 
		2: rightReg <= RegTwo;
		3: rightReg <= RegThree;
		4:	rightReg <= RegFour;
		5: rightReg <= RegFive;
		6: rightReg <= RegSix;
		7: rightReg <= RegSeven;
		8: rightReg <= RegEight;
	endcase
end

always @(*)
begin
	toMemory <= PC;
	toBells <= 11'd0;
	newBell <= 1'b0;
	we <= 1'b0;
	writeMemory <= 16'd0;
	case (state)
		2: toMemory <= PC+1;
		4: toMemory <= PC+1;
		6: begin
			toBells <= instr[10:0];
			newBell <= 1'b1;
		end
		10: toMemory <= PC+1;
		12: toMemory <= memaddr;
		14: toMemory <= PC+1;
		17: begin
				we <= 1;
				writeMemory <= rightReg;
				toMemory <= memaddr;
		end
		20: toMemory <= memaddr;
		22: begin
				we <= 1;
				toMemory <= memaddr;
				writeMemory <= flip;
		end
		24: toMemory <= PC+1;
		35: toMemory <=PC+1;
		38: toMemory <=PC+1;
		41: begin
				we<=1;
				toMemory <= rightReg;
				writeMemory <= toSet;
		end
		45: toMemory <= leftReg;

	endcase
end

//Instructions
always @ (posedge clk)
begin
	lastRight <= proceed;
	case (state)
		15: state<=0;
		0: begin
			if (!devLever || !lastRight && proceed)
				state<=33;
		end
		1: begin
			state<=0;
			case (fromMemory[15:11]) //This is where the op code is.
				0: state<=4;	//JOE
				1: state<=2;	//jump
				2: state<=10;	//load
				3:	state<=14;	//store
				4: state<=19;	//invert
				5: state<=24;	//set
				6: state<=27;	//add
				7: state<=29;	//sub
				8: state<=31;	//shift
				9: state<=35;  //jal
				10: state<=37; //return
				11: state<=38; //setmem
				12: state<=43; //and
				13: state<=45; //loadmem
				30: state<=6;	//play
				31: state<=9;	//done
			endcase
		end
		2: state<=3; //Jump begins
		3: begin
			PC <= fromMemory;
			state<=0;
		end
		4: state<=5; //JOE begins
		5: begin
			state<=0;
			PC <= PC+2;
			if (instr[10]) begin //literal flag
				if(rightReg == instr[9:5])
					PC<=fromMemory;
			end
			else begin
				if(rightReg == leftReg)
					PC<=fromMemory;
			end
		end
		6: state<=7; //Play begins
		7: begin
			if(dbuttons[4])begin
				PC <= 16'h4000;
				state <= 0;
			end
			else if (More)
				state<=8;
		end
		8: begin
			PC <= PC+1;
			state<=0;
		end
		9: begin  //Done begins
			PC <= 16'h4000;
			state<=0;
		end
		10:begin //Load begins
			state <= 11;
		end
		11:begin
			memaddr <= fromMemory;
			state <= 12;
		end
		12: state <= 13;
		13:begin
			outputReg <= fromMemory;
			state <= 34;
			PC<=PC+2;
		end
		14: state <= 16; //Store begins
		16: begin
			memaddr <= fromMemory;
			state <= 17;
		end
		17: state <= 18;
		18: begin
				PC <= PC+2;
				state <= 0;
		end
		19: begin //Invert begins
			memaddr <= rightReg;
			state <= 20;
		end
		20: state <= 21;
		21: begin
			flip <= {fromMemory[15:8],fromMemory[3:0],fromMemory[7:4]};
			state <= 22;
		end
		22: state <= 23;
		23: begin
			PC <= PC + 1;
			state <= 0;
		end
		24: state <=25; //Set begins
		25: begin
			outputReg <= fromMemory;
			state <= 26;
		end
		26: begin
			state<=34;
			PC <= PC+2;
		end
		27:begin //add begins
			if(instr[10]) begin //literal
				outputReg <= rightReg + instr[9:5];
			end
			else begin
				outputReg <= rightReg + leftReg;
			end
			state <= 28;
		end
		28:begin
			PC <= PC+1;
			state <= 34;
		end
		29:begin //sub begins
			if(instr[10]) begin //literal
				outputReg <= rightReg - instr[9:5];
			end
			else begin
				outputReg <= rightReg - leftReg;
			end
			state <= 30;
		end
		30:begin
			PC <= PC+1;
			state <= 34;
		end
		31:begin //shift begins
			if(instr[10]) begin//shift left
				outputReg <= rightReg<<instr[9:5];
			end
			else begin//shift right
				outputReg <= rightReg>>instr[9:5];
			end
			state<=32;
		end
		32: begin
			PC <= PC + 1;
			state <= 34;
		end
		33:begin
			instr <= fromMemory;
			state <= 1;
		end
		34: begin
				case(instr[4:0])
					1: RegSelection <= outputReg;
					2: RegTwo <= outputReg;
					3: RegThree <= outputReg;
					4: RegFour <= outputReg;
					5: RegFive <= outputReg;
					6: RegSix <= outputReg;
					7: RegSeven <= outputReg;
					8: RegEight <= outputReg;
				endcase
				state <= 0;
		end
		35: begin //Jump and link
			jalReg<=PC+2;
			state<=36;
		end
		36: begin
			PC <= fromMemory;
			state <= 0;
		end
		37: begin
			PC <= jalReg;
			state <= 0;
		end
		38: state<=39;
		39: begin
			toSet<=fromMemory;
			state<=40;
		end
		40: state<=41;
		41: state<=42;
		42: begin
			PC <= PC + 2;
			state<=0;
		end
		43: begin //AND begins
			if(instr[10])begin
				outputReg <= rightReg & instr[9:5];
			end
			else begin
				outputReg <= leftReg & rightReg;
			end
			state <= 44;
		end
		44:begin
			PC <= PC+1;
			state <= 34;
		end
		45: //LoadMem begins
			state <=46;
		46: begin
			outputReg <= fromMemory;
			state <=34;
			PC <= PC + 1;
		end
		
		/*19: begin
			flip <= {fromMemory[15:8],fromMemory[3:0],fromMemory[7:4]};
			state <= 20;
		end
		20: state <= 21;
		21: begin
			PC <= PC+2;
			state <=0;
		end*/
	endcase
end

endmodule
