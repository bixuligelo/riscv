module board; //主板
reg clk;
reg reset;
assign reset=1b'1;
assign #10 clk=~clk;

wire [31:0] pc;
wire [31:0] instruction;
wire [5:0] alu_ctr;

riscv riscv(.clk(clk),.reset(reset),
			.iram_data(instruction),iram_addr(pc),  //指令存储器连线
			


); //cpu

iram iram(.address(pc),.instruction(instruction));  

decoder decoder(.instruction(instruction),.alu_ctr(alu_ctr));








endmodule
