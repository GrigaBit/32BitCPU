`include "mux.v"
`include "GPR.V"
`include "flop.v"
`include "Extender.v"
`include "ALU.v"
`include "Adder.v"

module datapath(
    input clk,
    input reset,
    input [1:0] RegSrc,
    input RegWrite,
    input [1:0] ImmSrc,
    input ALUSrc,
    input [1:0] ALUControl,
    input MemToReg,
    input PCSrc,
    output [3:0] ALUFlags,
    output [31:0] PC,
    input [31:0] Instr,
    output [31:0] ALUOutput, WriteData,
    input [31:0] ReadData
);

    wire [31:0] PCNext, PCReg, PCplus4, PCplus8;
    wire [31:0] ExtImm, SrcA, SrcB, Result;
    wire [3:0] A1, A2, A3;
    wire ZeroFlag, CarryFlag, OverflowFlag, NegativeFlag;

    assign ALUFlags = {NegativeFlag, ZeroFlag, CarryFlag, OverflowFlag};

    // PC Logic
    mux2 #(32) pcmux(
        .y(PCNext),
        .d0(PCplus4),
        .d1(Result),
        .s(PCSrc)
    );

    flop pcreg(
        .clk(clk),
        .reset(reset),
        .d(PCNext),
        .q(PCReg)
    );
    assign PC = PCReg;

    adder pcadd1(
        .a(PCReg),
        .b(32'b100),
        .y(PCplus4)
    );

    adder pcadd2(
        .a(PCplus4),
        .b(32'b100),
        .y(PCplus8)
    );

    // Register File Logic
    mux2 #(4) ra1mux(
        .d0(Instr[19:16]),
        .d1(4'b1111),
        .s(RegSrc[0]),
        .y(A1)
    );

    mux2 #(4) ra2mux(
        .d0(Instr[3:0]),
        .d1(Instr[15:12]),
        .s(RegSrc[1]),
        .y(A2)
    );

    GPR rf(
        .clk(clk),
        .WE3(RegWrite),
        .A1(A1),
        .A2(A2),
        .A3(Instr[15:12]),
        .WD3(Result),
        .R15(PCplus8),
        .RD1(SrcA),
        .RD2(WriteData)
    );

    Extender ext(
        .Instruction(Instr[23:0]),
        .ImmSrc(ImmSrc),
        .ExtImm(ExtImm)
    );

    // ALU Logic
    mux2 #(32) srcbmux(
        .d0(WriteData),
        .d1(ExtImm),
        .s(ALUSrc),
        .y(SrcB)
    );
    
    ALU alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .AluControl(ALUControl),
        .AluOutput(ALUOutput),
        .ZeroFlag(ZeroFlag),
        .CarryFlag(CarryFlag),
        .OverflowFlag(OverflowFlag),
        .NegativeFlag(NegativeFlag)
    );
    
endmodule