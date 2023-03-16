all:
	iverilog -o build/wave alu.v board.v decoder.v dram.v iram.v riscv.v
	vvp -n build/wave -lxt2
	gtkwave build/wave.vcd
