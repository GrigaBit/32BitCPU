module flop (
    input  wire clk, 
    input  wire reset,
    input  wire [31:0] d,
    output reg  [31:0] q //musai de folosit daca utilizez variabila intr-un always
);

    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 32'b0;
        else 
            q <= d;
    end

endmodule
