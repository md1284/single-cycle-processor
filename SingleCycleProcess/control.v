module control(opcode, RegWrite, RegDst, ALUsrc, Branch, MemWrite, MemRead, MemtoReg, ALUop, jump);

input[5:0] opcode;

output RegWrite, RegDst, ALUsrc, Branch, MemWrite, MemRead, MemtoReg, jump;
output[1:0] ALUop;

reg[9:0] control_seq;

always@(opcode) begin	// calculate the control sequence
    case(opcode)
        6'b000000: control_seq = 10'b1100000100;	// R-type
        6'b100011: control_seq = 10'b1010011000;	// lw
        6'b101011: control_seq = 10'b0010100000;	// sw
        6'b000100: control_seq = 10'b0001000010;	// beq
        6'b001000: control_seq = 10'b1010000000;	// addi
        6'b001101: control_seq = 10'b1010000110;	// ori
        6'b000010: control_seq = 10'b0000000001;	// j
        default: control_seq = 10'b0;
    endcase
end

/* assign the control value */
assign RegWrite = control_seq[9];
assign RegDst = control_seq[8];
assign ALUsrc = control_seq[7];
assign Branch = control_seq[6];
assign MemWrite = control_seq[5];
assign MemRead = control_seq[4];
assign MemtoReg = control_seq[3];
assign ALUop = control_seq[2:1];
assign jump = control_seq[0];

endmodule