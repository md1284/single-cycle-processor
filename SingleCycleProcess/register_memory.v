module register_memory(clk, regWrite, rs, rt, rd, write_data, output_reg1, output_reg2);

input clk;
input regWrite;
input[4:0] rs, rt, rd;
input[31:0] write_data;

output[31:0] output_reg1, output_reg2;

reg[31:0] reg_mem[31:0];

initial begin	// initialize register
reg_mem[0]=32'b0;
reg_mem[1]=32'b0;
reg_mem[2]=32'b0;
reg_mem[3]=32'b0;
reg_mem[4]=32'b0;
reg_mem[5]=32'b0;
reg_mem[6]=32'b0;
reg_mem[7]=32'b0;
reg_mem[8]=32'b0;
reg_mem[9]=32'b0;
reg_mem[10]=32'b0;
reg_mem[11]=32'b0;
reg_mem[12]=32'b0;
reg_mem[13]=32'b0;
reg_mem[14]=32'b0;
reg_mem[15]=32'b0;
reg_mem[16]=32'b0;
reg_mem[17]=32'b0;
reg_mem[18]=32'b0;
reg_mem[19]=32'b0;
reg_mem[20]=32'b0;
reg_mem[21]=32'b0;
reg_mem[22]=32'b0;
reg_mem[23]=32'b0;
reg_mem[24]=32'b0;
reg_mem[25]=32'b0;
reg_mem[26]=32'b0;
reg_mem[27]=32'b0;
reg_mem[28]=32'b0;
reg_mem[29]=32'b0;
reg_mem[30]=32'b0;
reg_mem[31]=32'b0;
end

always@(posedge clk) begin
	if(regWrite == 1'b1)	// for write register
		reg_mem[rd] = write_data;
end

assign output_reg1 = (rs!=0) ? reg_mem[rs] : 0;	// for read register
assign output_reg2 = (rt!=0) ? reg_mem[rt] : 0;

endmodule