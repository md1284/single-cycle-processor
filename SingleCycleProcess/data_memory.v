module data_memory(MemRead, MemWrite, Address, Write_data, Read_data);

input MemRead, MemWrite;
input[31:0] Address, Write_data;
output[31:0] Read_data;

reg[31:0] data_mem[63:0];
wire[5:0] idx;

assign idx = Address[5:0];

always@(MemWrite or Write_data) begin
   $readmemb("memory.mem", data_mem);	// for read memory.mem

   if(MemWrite == 1'b1) begin	// for write the value to data_memory
		data_mem[idx] = Write_data;
   end
end

assign Read_data = (MemRead == 1'b1) ? data_mem[idx]:32'b0;	// for read the value

endmodule