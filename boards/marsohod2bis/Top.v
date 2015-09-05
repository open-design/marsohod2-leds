`timescale 1ns / 1ps

module Top(
    input  clk,
    output [2:0] LED
    );

wire c0;

altpll0 pll(clk, c0);

wire [31:0] c;
counter #(.WIDTH(32)) cn(c[31:0], c0, 1'b0);

reg [2:0] L;
assign LED[2:0] = L[2:0];

always @(*)
begin
	case (c[29:28])
	2'b00: L[2:0] = 3'b001;
	2'b01: L[2:0] = 3'b010;
	2'b10: L[2:0] = 3'b100;
	2'b11: L[2:0] = 3'b000;
	endcase
end

endmodule
