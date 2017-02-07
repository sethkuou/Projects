`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:47 11/15/2016 
// Design Name: 
// Module Name:    TopBell 
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
module TopBell(
    input ExternalClock,
    input [4:0] Buttons, //Will be replaced with keyboard input
	 input devLever,
    output [7:0] Bells,
    output Right,
    output Left,
    output [2:0]Red,
    output [2:1]Blue,
    output [2:0]Green,
    output HSync,
    output VSync,
	 output [7:0]LEDs,
	 output [7:0]Segments,
	 output [3:0]Digits
    );
//buffer the clock
IBUFG padToClock(.I(ExternalClock), .O(InternalClock));
BUFG clockToClk(.I(InternalClock), .O(Clk));

wire [14:0]toMemVGA;
wire [15:0]memOutVGA;

wire [15:0]memOutCore;
wire [14:0]toMemCore;

wire we;
wire [15:0] writeMemory;

memToSevSeg letMeSee(memOutCore, Clk, Digits, Segments);
DualMemory mem(Clk, 1'b0,  //Write enable A
						toMemVGA,  //Where A
						16'b0,     //What write A
						memOutVGA, //A out
						Clk,
						we,      //Write enable B
						toMemCore,     //Where B
						writeMemory,     //What write B
						memOutCore); //B out

DualVGA VGA(Red, Green, Blue, Clk, toMemVGA, memOutVGA, HSync, VSync);
Core core(Clk, memOutCore, Buttons, devLever, Right, Left, Bells, toMemCore, writeMemory, we, LEDs);



endmodule
