module dram(
	input[31:0] address,
	input dram_read,
	input dram_write,
	input[31:0] write_data,
	output reg[31:0] read_data
);

reg [31:0] memory[32:0];

always@(*)
begin
	if(dram_read) read_data<=memory[address];
	if(dram_write) memory[address]<=write_data;
end


endmodule
