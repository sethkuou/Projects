`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:06 04/25/2016 
// Design Name: 
// Module Name:    FSMC 
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
module FSMC(
    input [1:0] button,
    input [7:0] switches,
    input [7:0] instructions,
    input clock,
    input reset,
    output reg loadSelect,
    output reg rxEnable,
    output reg ledEnable,
    output reg [3:0] load,
    output reg [1:0] rxSelect,
    output reg [1:0] rySelect,
    output reg [3:0] aluOperation,
    output reg [3:0] programCounter
    );
	 
	 reg[7:0] I;
	 reg ROM;
	 reg[5:0] PS, NS;
	 
	 parameter[6:0] idle = 0, ROMactive = 1, SingleStep = 2, Load = 3, ROMread = 4,
						 Not = 5, RUNorSinglestep = 6, ALU = 7, Operation = 8, Store = 9;
	 
always@(posedge clock)
begin
	if(reset)
		PS <= idle;
	else
		PS <= NS;
end

always@(*)
begin
	case(PS)
		idle:
			begin
				if(button == 2'b01)
					NS = ROMactive;
				else if(button == 2'b10)
					NS = RUNorSinglestep;
				else
					NS = idle;
			end
		ROMactive:
		 begin
			if(button == 2'b00)
				NS = RUNorSinglestep;
			else
				NS = ROMactive;
		 end
		RUNorSinglestep:
		 begin
			if(ROM)
				NS = ROMread;
			else if(button == 2'b10)
				NS = SingleStep;
			else
				NS = RUNorSinglestep;
		 end
		SingleStep:
		 begin
			if(button == 2'b00 && I[7:6] == 2'b00)
				NS = Load;
			else if(button == 2'b00 && I[7:6] == 2'b01)
				NS = Store;
			else if(button == 2'b00 && I[7] == 1'b1)
				NS = ALU;
			else
				NS = SingleStep;
		 end
		ROMread:
		 begin
			if(button == 2'b00 && I[7:6] == 2'b00)
				NS = Load;
			else if(button == 2'b00 && I[7:6] == 2'b01)
				NS = Store;
			else if(button == 2'b00 && I[7] == 1'b1)
				NS = ALU;
			else
				NS = ROMread;
		 end
		Load:
		 begin
			if(button == 2'b00)
				NS = RUNorSinglestep;
			else
				NS = Load;
		 end
		Store:
		 begin
			if(button == 2'b00)
				NS = RUNorSinglestep;
			else
				NS = Store;
		 end
		ALU:
		 begin
			if(I[7:6] == 2'b11 && I[1:0] == 2'b11)
				NS = Not;
			else
				NS = Operation;
		 end
		Not:
		 begin
			if(button == 2'b00)
				NS = RUNorSinglestep;
			else
				NS = Not;
		 end
		Operation:
		 begin
			if(button == 2'b00)
				NS = RUNorSinglestep;
			else
				NS = Operation;
		 end
		default:
			begin
				NS = idle;
			end
	  endcase
  end	
		
always@(posedge clock)
	begin
			case(PS)
		idle:
			begin
				I = switches;
				programCounter = 0;
				ROM = 0;
				load = 0;
				loadSelect = 0;
				rxEnable = 0;
				ledEnable = 0;
				rxSelect = 0;
				rySelect = 0;
				aluOperation = 0;
			end
		ROMactive:
		 begin
				I = instructions;
				programCounter = 1;
				ROM = 1;
		 end
		RUNorSinglestep:
		 begin
				I = (ROM) ? instructions : switches;
				rxEnable = 0;
				ledEnable = 0;
		 end
		SingleStep:
		 begin
				I = switches;
				programCounter = 0;
				rxEnable = 0;
				ledEnable = 0;
		 end
		ROMread:
		 begin
				I = instructions;
				rxEnable = 0;
				ledEnable = 0;
		 end
		Load:
		 begin
				programCounter = (ROM) ? ((programCounter < 4'b1001) ? (programCounter+4'b0001) : programCounter) : 4'b0000;
				load = I[3:0];
				loadSelect = 1;
				rxEnable = 1;
				ledEnable = 0;
				rxSelect = I[5:4];
		 end
		Store:
		 begin
			   programCounter = (ROM) ? ((programCounter < 4'b1001) ? (programCounter+4'b0001) : programCounter) : 4'b0000;
				rxEnable = 0;
				ledEnable = 1;
				rxSelect = I[5:4];
		 end
		ALU:
		 begin
				loadSelect = 0;
				rxEnable = 0;
				ledEnable = 0;
				rxSelect = I[5:4];
				rySelect = I[3:2];
				aluOperation[1:0] = I[1:0];
				aluOperation[3:2] = I[7:6];
		 end
		Not:
		 begin
				programCounter = (ROM) ? ((programCounter < 4'b1001) ? (programCounter+4'b0001) : programCounter) : 4'b0000;
				loadSelect = 0;
				rxEnable = 1;
				ledEnable = 0;
				rxSelect = I[5:4];
				aluOperation[1:0] = I[1:0];
				aluOperation[3:2] = I[7:6];
		 end
		Operation:
		 begin
				programCounter = (ROM) ? ((programCounter < 4'b1001) ? (programCounter+4'b0001) : programCounter) : 4'b0000;
				loadSelect = 0;
				rxEnable = 1;
				ledEnable = 0;
				rxSelect = I[5:4];
				rySelect = I[3:2];
				aluOperation[1:0] = I[1:0];
				aluOperation[3:2] = I[7:6];
		 end
		default:
			begin
				I = (ROM) ? instructions : switches;
				programCounter = 0;
				load = 0;
				loadSelect = 0;
				rxEnable = 0;
				ledEnable = 0;
				rxSelect = 0;
				rySelect = 0;
				aluOperation = 0;
			end
	  endcase
			
	end


endmodule
