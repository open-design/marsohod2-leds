tb.vcd: tb.vvp
	vvp $^

tb.vvp: tb.v ../counter.v
	iverilog -o$@ -tvvp $^

.PHONY: clean
clean:
	rm -f tb.vcd  tb.vvp
