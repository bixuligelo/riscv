module iram(
	input [31:0] address,
	output [31:0] instruction
);

reg [31:0] memory[32:0];

initial
begin
	memory[0]<=32'b000000000011_00000_000_00001_0010011;//addi r[1],r[0],3;
	memory[1]<=32'b0000000_00001_00001_000_00010_0110011;//add  r[2],r[1],r[1];
end

assign instruction=memory[address];

endmodule
