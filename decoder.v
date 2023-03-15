module decoder(
	input[31:0] instruction,
	output reg [5:0] alu_ctr,//alu操作符最重要
	output reg alusrc,
	output reg memwrite,
	output reg regwrite,
	output reg memtoreg,
	output reg branch,
	output reg memread
);

wire [6:0] opcode=instruction[6:0];
wire [2:0] f3=instruction[14:12];
wire [6:0] f7=instruction[31:25];

always@(*)
begin
	case(opcode)
		7'b0110011://R型指令
		begin
			alusrc<=0;
			memtoreg<=0;
			regwrite<=1;
			memwrite<=0;
			branch<=0;
			memread<=0;
			case(f7)
				7'b0000000:
					case(f3)
						3'b000:alu_ctr<=1;//add
						3'b001:alu_ctr<=3;//sll
						3'b101:alu_ctr<=4;//srl
						3'b010:alu_ctr<=5;//slt
						3'b100:alu_ctr<=6;//xor
						3'b110:alu_ctr<=7;//or
						3'b111:alu_ctr<=8;//and
					endcase
				7'b0100000:
					case(f3)
						3'b000:alu_ctr<=2;//sub
					endcase
			endcase		
		end
		7'b0010011://I型指令
			begin
				alusrc<=1;
				memtoreg<=0;
				regwrite<=1;
				memwrite<=0;
				branch<=0;
				memread<=0;
				case(f3)
					3'b000:alu_ctr<=9;//addi
					3'b100:alu_ctr<=10;//xori
					3'b110:alu_ctr<=11;//ori
					3'b111:alu_ctr<=12;//andi
					3'b001:alu_ctr<=13;//slli
					3'b101:alu_ctr<=14;//srli
				endcase
			end
		7'b0000011://I型指令
			begin
				alusrc<=1;
				memtoreg<=1;
				regwrite<=1;
				memwrite<=0;
				branch<=0;
				memread<=1;
				case(f3)
					3'b011:alu_ctr<=15;//lw
				endcase
			end
		7'b0100011://S型指令
			begin
				regwrite<=0;
				memwrite<=1;
				branch<=0;
				memread<=0;
				case(f3)
					3'b010:alu_ctr<=16;//sw
				endcase
			end
		7'b1100011://B型指令
			begin
				alusrc<=0;
				regwrite<=0;
				memwrite<=0;
				branch<=1;
				memread<=0;	
				case(f3)
					3'b000:alu_ctr<=17;//beq
				endcase
			end
		7'b0110111://U型指令
			begin
				memtoreg<=0;
				regwrite<=1;
				memwrite<=0;
				branch<=0;
				memread<=0;
				alu_ctr<=18;//lui
			end
	endcase
end




endmodule
