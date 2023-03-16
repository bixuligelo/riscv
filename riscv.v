module riscv(      //这个是cpu的顶层模块，时钟clk、复位键reset、指令存储器iram、数据存储器dram独立于cpu
	input clk,      //cpu 需要把alu,decoder,pc,registers连接起来 
	input reset,
	
	//指令存储器
	
	output [31:0] iram_addr,
	input  [31:0] iram_data,
	
	//数据存储器
	output dram_read,
	output dram_write,
	output [31:0] dram_addr,
	output [31:0] dram_data_out,
	input  [31:0] dram_data_in
	
);

reg [31:0] pc;
reg [31:0] registers [0:31]; ///通用寄存器
reg [7:0] temp;

initial
begin
	pc<=0;
	for(temp=0;temp<32;temp=temp+1)
		registers[temp]<=0;
end


assign iram_addr = pc;

wire [31:0] instruction= iram_data;
wire [5:0] alu_ctr;
wire zero;
wire alusrc;
wire [31:0]alu_result;
wire memwrite;
wire regwrite;
wire memtoreg;
wire memread;
wire branch;

decoder decoder1(.instruction(instruction),
					.alu_ctr(alu_ctr),
					.alusrc(alusrc),
					.memwrite(memwrite),
					.memread(memread),
					.regwrite(regwrite),
					.memtoreg(memtoreg),
					.branch(branch)
					);
				
alu alu1(.data1(registers[instruction[19:15]]),
			.data2(alusrc ? instruction[31:20] : registers[instruction[24:20]]),//alusrc=1为addi,alusrc=0为add
			.alu_ctr(alu_ctr),
			.zero(zero),
			.alu_result(alu_result),
			.instruction(instruction)
			);

			
assign dram_addr=alu_result;
assign dram_data_out=registers[instruction[24:20]];
assign dram_write=memwrite;
assign dram_read=memread;


always@(posedge clk) 
begin
	if (reset) begin
		for(temp=0;temp<32;temp=temp+1)
			registers[temp]<=0;
	end
	else if(regwrite) begin
		registers[instruction[11:7]]<=memtoreg?dram_data_in:alu_result;
	end
end

always@(posedge clk) 
begin
	if (reset) begin
		pc<=0;
	end
	else if(branch&&zero) begin
		pc<=pc+{instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
	end
	else
		pc<=pc+1;
end


endmodule




