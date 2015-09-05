`timescale 1ns / 1ns

module testbench;

reg clk;
initial clk = 1'b0;
always
    #20 clk = ~clk;

reg reset;
initial
begin
	reset = 1'b0;
	#10;
	reset = 1'b1;
	#60;
	reset = 1'b0;
end

wire [31:0] c;
counter #(.WIDTH(32)) counter(c[31:0], clk, reset);

initial
begin
	$dumpfile("tb.vcd");
	$dumpvars(0, testbench);

	#1000;
	$finish;
end

endmodule
