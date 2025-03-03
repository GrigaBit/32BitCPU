module Decoder (
    input [1:0] Op,
    input [5:0] Funct,
    input [3:0] Rd,
    output reg [1:0] FlagW,
    output reg PCS, RegW, MemW,
    output reg MemtoReg, AluSrc,
    output reg [1:0] ImmSrc, RegSrc, AluControl
);

reg Branch, ALUop;
reg [9:0] controls;

always @(*) begin
    casex (Op)
        2'b00: 
            if (Funct[5]) 
                controls = 10'b0001001001; // Imm DP
            else 
                controls = 10'b0000001001; // Reg DP
        2'b01: 
            if (Funct[0]) 
                controls = 10'b0101011000; // LDR
            else 
                controls = 10'b0011010100; // STR
        2'b10: 
            controls = 10'b1001100010; // Branch
        default: 
            controls = 10'b0000000000;
    endcase
end

always @(*) begin
    {Branch, MemtoReg, MemW, AluSrc, ImmSrc, RegW, RegSrc, ALUop} = controls;
end

always @(*) begin 
    if (ALUop) begin 
        case (Funct[4:1])
            4'b0100: AluControl = 2'b00; // ADD
            4'b0010: AluControl = 2'b01; // SUB
            4'b0000: AluControl = 2'b10; // AND
            4'b1100: AluControl = 2'b11; // ORR
            default: AluControl = 2'b00; // Default ADD
        endcase

        FlagW[1] = Funct[0];
        FlagW[0] = Funct[0] & ((AluControl == 2'b00) | (AluControl == 2'b01));
    end 
    else begin
        AluControl = 2'b00; //non DP add
        FlagW = 2'b00; // no Flags
    end
end

always @(*) begin
    PCS = ((Rd == 4'b1111) && RegW) | Branch;
end

endmodule
