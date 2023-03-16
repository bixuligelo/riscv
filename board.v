

module board(); //主板,把rscv_cpu,iram,dram 连接起来,也是testbench模块

reg clk;
reg reset;


initial 
begin
	$dumpfile("build/wave.vcd");        //生成的vcd文件名称
  $dumpvars(0, board);    //tb模块名称

	reset<=1'b1;
	#20;
	reset<=1'b0;
	#1000 $stop;
end

always 
begin
  clk = 1'b1;
  #5;
  clk = 1'b0;
  #5;
end

wire [31:0] pc;
wire [31:0] instruction;

wire dram_read;
wire dram_write;
wire[31:0] dram_addr;
wire[31:0] dram_data_out;
wire[31:0] dram_data_in;


riscv riscv1(.clk(clk),.reset(reset),
			.iram_data(instruction),.iram_addr(pc),  //指令存储器连线
			.dram_read(dram_read),.dram_write(dram_write),//数据存储器连线
			.dram_addr(dram_addr),.dram_data_out(dram_data_out),
			.dram_data_in(dram_data_in)
); //cpu

iram iram1(.address(pc),.instruction(instruction));  

dram dram1(.address(dram_addr),.dram_read(dram_read),.dram_write(dram_write),
			.write_data(dram_data_out),.read_data(dram_data_in)
);




endmodule
