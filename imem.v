module imem(
    input [31:0] a,
    output reg [31:0] rd
);
    reg [31:0] RAM[63:0];

    initial begin
        $readmemh("memfile.dat", RAM);
    end

    always @(*) begin
        rd = RAM[a[31:2]]; // word aligned
    end
endmodule