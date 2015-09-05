`timescale 1ns / 1ps

module Top(
	input  CLK100MHZ,
	output [7:0] LED
	);

wire c0;

altpll0 pll(CLK100MHZ, c0);

wire [31:0] c;
counter #(.WIDTH(32)) cn(c[31:0], c0, 1'b0);

reg [7:0] L;
assign LED[7:0] = L[7:0];

always @(*)
begin
	case (c[29:28])
	2'b00: L[7:0] = 8'b00000111;
	2'b01: L[7:0] = 8'b00011100;
	2'b10: L[7:0] = 8'b00111000;
	2'b11: L[7:0] = 8'b11100000;
	endcase
end

endmodule
