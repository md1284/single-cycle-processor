module single_cycle_process(rst, clk, hex0, hex1, hex2, hex3, hex4, hex5);

input rst, clk;

output[6:0] hex0, hex1, hex2, hex3, hex4, hex5;

wire out_clk;

wire[31:0] pc;
wire[31:0] pc4;
wire[31:0] jpc;
wire[31:0] bpc;
wire[31:0] new_pc;

wire[31:0] compared_bpc;

wire[31:0] inst;
wire[5:0] opcode;
wire[4:0] rs, rt, rd;
wire[4:0] shamt;
wire[5:0] func;

wire RegWrite, RegDst, ALUsrc, Branch, MemWrite, MemRead, MemtoReg, jump;
wire[1:0] ALUop;

wire[15:0] const_address;
wire[31:0] extend_const_address;
wire[25:0] jump_address;
wire[27:0] shift_jump_address;

wire[3:0] ALUcontrol;

wire[31:0] write_data;
wire[31:0] output_reg1, output_reg2;
wire[31:0] real_output_reg2;


wire[31:0] outalu;
wire isZero;

wire[31:0] read_data;

wire branch_zero_check;


clk_dll(rst, clk, out_clk);	// demultiply clock
instruction_memory(pc, inst);	// read a instruction


assign opcode = inst[31:26];
assign shamt = inst[10:6];
assign func = inst[5:0];

assign const_address = inst[15:0];
assign jump_address = inst[25:0];
assign shift_jump_address = (jump_address<<2);

control(opcode, RegWrite, RegDst, ALUsrc, Branch, MemWrite, MemRead, MemtoReg, ALUop, jump);	// assign control values
aludec(func, ALUop, ALUcontrol);	// assign alucontrol value
sign_ex(const_address, extend_const_address);	// for sign extension


assign rs = inst[25:21];
assign rt = inst[20:16];
assign rd = (RegDst == 1'b1) ? inst[15:11] : inst[20:16];


register_memory(out_clk, RegWrite, rs, rt, rd, write_data, output_reg1, output_reg2);	// read and write the register
mux(ALUsrc, output_reg2, extend_const_address, real_output_reg2);	// select real_output_reg2

alu_mips(output_reg1, real_output_reg2, shamt, ALUcontrol, outalu, isZero);	// calculate outalu
data_memory(MemRead, MemWrite, outalu, output_reg2, read_data);	// read and write value for data memory

mux(MemtoReg, outalu, read_data, write_data);	// select write_data


/* for calculating new pc value */
assign pc4 = pc+4;
assign jpc = {pc4[31:28], shift_jump_address[27:0]};
assign bpc = (extend_const_address<<2)+pc4;


assign branch_zero_check = Branch & isZero;
mux(branch_zero_check, pc4, bpc, compared_bpc);
mux(jump, compared_bpc, jpc, new_pc);

update_pc(rst, out_clk, new_pc, pc);	// update pc value

seg(rst, out_clk, pc, write_data, hex5, hex4, hex3, hex2, hex1, hex0);	// To represent pc and write_data

endmodule
