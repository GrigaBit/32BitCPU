module mux2 #(parameter Width=8)
    (input wire [Width-1:0] d0,d1,
    input wire s,
    output wire [Width-1:0] y);
    assign y=s? d1:d0;
endmodule