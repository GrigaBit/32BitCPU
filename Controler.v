`include "Decoder.v"
`include "CondLogic.v"

module controller(
    input clk, reset,
    input [31:12] Instr,
    input [3:0] ALUFlags,
    output wire [1:0] RegSrc,
    output wire [1:0] RegWrite,
    output wire [1:0] ImmSrc,
    output wire ALUSrc,
    output wire [1:0] ALUControl,
    output wire MemWrite, MemtoReg,
    output wire PCSrc

);
    
    // Internal wires  
    wire [1:0] FlagW;
    wire PCS, RegW, MemW;

    // Integrate decoder (PC logic + main decode + ALU decoder)  
    Decoder dec(
        Instr[27:26], Instr[25:20], Instr[15:12],
        FlagW, PCS, RegW, MemW,
        MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl
    );

    // Integrate cond logic block 
    condlogic cl(
        clk, reset, Instr[31:28], ALUFlags,
        FlagW, PCS, RegW, MemW,
        PCSrc, RegWrite, MemWrite
    );
endmodule
