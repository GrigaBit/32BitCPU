`include "Controler.v"
`include "Datapath.v"

module cpu(input clk, reset,
			output  [31:0] PC,
			input  [31:0] Instr,
			output  MemWrite,
			output [31:0] ALUResult, WriteData,
			input  [31:0] ReadData);

wire [3:0] ALUFlags;
wire RegWrite,ALUSrc, MemtoReg, PCSrc;
wire [1:0] RegSrc, ImmSrc, ALUControl;

controller c(clk, reset, Instr[31:12], ALUFlags,
			RegSrc, RegWrite, ImmSrc,
			ALUSrc, ALUControl,
			MemWrite, MemtoReg, PCSrc);


datapath dp(clk, reset,RegSrc, RegWrite, ImmSrc,
			ALUSrc, ALUControl,MemtoReg, PCSrc,
			ALUFlags, PC, Instr,ALUResult, WriteData, ReadData);
  
endmodule