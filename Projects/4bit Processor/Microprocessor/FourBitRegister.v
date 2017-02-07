`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:37:00 04/22/2016 
// Design Name: 
// Module Name:    FourBitRegister 
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
module RegisterFile(
    input clock,
    input [3:0] rx,
	 input [3:0] load,
	 input loadSelect,
    input enable,
	 input [1:0] rxSelect,
	 input [1:0] rySelect,
	 output [3:0] rxout,
	 output [3:0] ryout
    );
	 
	 wire [4:0] muxOut0, muxOut1, muxOut2, muxOut3;
	 wire [3:0] aluOrLoad, reg0out, reg1out, reg2out, reg3out;
	 

	 DFlip_Flop reg0 (clock, muxOut0, rxEnable0, reg0out),
					reg1 (clock, muxOut1, rxEnable1, reg1out),
					reg2 (clock, muxOut2, rxEnable2, reg2out),
					reg3 (clock, muxOut3, rxEnable3, reg3out);
					
    mux_2to1 muxLoad(loadSelect, load, rx, aluOrLoad);
	 mux_1to4 demux(aluOrLoad, rxSelect, muxOut0, muxOut1, muxOut2, muxOut3);
	 mux_1to4_rxry rxDemux(enable, rxSelect, rxEnable0, rxEnable1, rxEnable2, rxEnable3);
	 mux_4to1 rxMux(rxSelect, reg0out, reg1out, reg2out, reg3out, rxout),
				 ryMux(rySelect, reg0out, reg1out, reg2out, reg3out, ryout);	
		


endmodule
