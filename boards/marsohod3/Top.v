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
	case (c[28:25])
	4'b0000: L[7:0] = 8'b00000001;
	4'b0001: L[7:0] = 8'b00000010;
	4'b0010: L[7:0] = 8'b00000100;
	4'b0011: L[7:0] = 8'b00001000;
	4'b0100: L[7:0] = 8'b00010000;
	4'b0101: L[7:0] = 8'b00100000;
	4'b0110: L[7:0] = 8'b01000000;
	4'b0111: L[7:0] = 8'b10000000;
	4'b1000: L[7:0] = 8'b10000000;
	4'b1001: L[7:0] = 8'b01000000;
	4'b1010: L[7:0] = 8'b00100000;
	4'b1011: L[7:0] = 8'b00010000;
	4'b1100: L[7:0] = 8'b00001000;
	4'b1101: L[7:0] = 8'b00000100;
	4'b1110: L[7:0] = 8'b00000010;
	4'b1111: L[7:0] = 8'b00000001;
	endcase
end

endmodule
