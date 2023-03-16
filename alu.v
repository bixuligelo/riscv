module alu(
	input[31:0] data1,
	input[31:0] data2,
	input[5:0] alu_ctr,
	input[31:0] instruction,
	output reg zero,
	output reg[31:0] alu_result
);


always @(*)
begin
	case(alu_ctr)
		1:alu_result<=data1+data2;
		2:alu_result<=data1-data2;
		3:alu_result<=data1<<data2;
		4:alu_result<=data1>>data2;
		5:alu_result<=data1<data2?1:0;
		6:alu_result<=data1^data2;
		7:alu_result<=data1|data2;
		8:alu_result<=data1&data2;
		9:alu_result<=data1+data2;
		10:alu_result<=data1^data2;
		11:alu_result<=data1|data2;
		12:alu_result<=data1&data2;
		13:alu_result<=data1<<data2;
		14:alu_result<=data1>>data2;
		15:alu_result<=data1+data2;
		16:alu_result<=data1+{instruction[31:25],instruction[11:7]};
		17:alu_result<=data1-data2;
		18:alu_result<={instruction[31:12],12'h0};
	endcase
end



always @(*)
begin
	if(alu_result) zero<=0;
	else zero<=1;
end

endmodule
