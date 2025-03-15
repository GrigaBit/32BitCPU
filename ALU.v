module ALU (
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [1:0] AluControl,
    output reg [31:0] AluOutput,
    output reg ZeroFlag,
    output reg CarryFlag,
    output reg OverflowFlag,
    output reg NegativeFlag
);

always @(*) begin
    AluOutput = 32'b0;
    CarryFlag = 0;
    OverflowFlag = 0;
    ZeroFlag = 0;
    NegativeFlag = 0;

    case (AluControl)
        2'b00: begin  // AND
            AluOutput = SrcA & SrcB;
            CarryFlag = 0;
            OverflowFlag = 0;
        end

        2'b01: begin  // OR
            AluOutput = SrcA | SrcB;
            CarryFlag = 0;
            OverflowFlag = 0;
        end

        2'b10: begin  // ADD
            {CarryFlag, AluOutput} = {1'b0, SrcA} + {1'b0, SrcB};
            OverflowFlag = (SrcA[31] == SrcB[31]) && (SrcA[31] != AluOutput[31]);
        end

        2'b11: begin  // SUBTRACT
            {CarryFlag, AluOutput} = {1'b0, SrcA} - {1'b0, SrcB};
            CarryFlag = (SrcA >= SrcB) ? 1 : 0;  // Correct borrow flag
            OverflowFlag = (SrcA[31] != SrcB[31]) && (SrcA[31] != AluOutput[31]);
        end

        default: begin
            AluOutput = 32'b0;
            CarryFlag = 0;
            OverflowFlag = 0;
        end
    endcase

    ZeroFlag = (AluOutput == 32'b0);
    NegativeFlag = AluOutput[31];
end

endmodule
