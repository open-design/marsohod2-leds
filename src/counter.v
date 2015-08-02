module counter(out, clk, reset);

	parameter WIDTH = 27;

	output [WIDTH - 1 : 0] out;
	input	       clk, reset;

	reg [WIDTH - 1 : 0]   out;
	wire	       clk, reset;

	always @(posedge clk)
		if (reset)
			out <= 0;
		else
			out <= out + 1;

endmodule /* counter */