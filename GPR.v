module GPR(
    input [31:0] R15,//definit separat pt ca il folosim si ca PC
    input [3:0] A1,A2,//read adress
    input clk,
    input [3:0] A3, //write destination
    input [31:0] WD3, //write data
    output reg [31:0] RD1,RD2,//read ddata
    input [1:0] WE3//semnal control
);
    reg [31:0] register[14:0];

    always@(*) begin //citire asincrona
        RD1=(A1==4'b1111)? R15 : register[A1];
        RD2=(A2==4'b1111)? R15 : register[A2];
    end

    always@(posedge clk) begin //FARA ASSIGN IN ALWAYS
        if(WE3==2'b00) begin
            register[A3]<=WD3; 
        end 
    end
endmodule