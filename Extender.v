module Extender(
    input [23:0] Instruction, 
    input [1:0] ImmSrc,
    output reg [31:0] ExtImm //reg pentru a putea fi modificata valoarea in cadrul unui proces precum always
);

always @(*) begin //@(*) pentru a selecta toate semnalele din lista de sensibilitate 
    case (ImmSrc)
        2'b00:ExtImm={24'b0 , Instruction[7:0]}; //8 biti fara semn , pentru data processing
        2'b01:ExtImm={20'b0 , Instruction[11:0]}; //12 biti fara semn pentru LDR/STR
        2'b10:ExtImm={{6{Instruction[23]}} , Instruction[23:0] , 2'b00}; //24 biti pentru branching ; facem shl cu 2 pozitii pentru a calcula mereu adresa noii instructiuni
        default: ExtImm=32'bx;
    endcase
end

endmodule