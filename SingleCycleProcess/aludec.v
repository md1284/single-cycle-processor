module aludec(func, aluop, alucontrol);
input   [5:0] func;
input   [1:0] aluop;
output reg [3:0] alucontrol;

always @(aluop, func)
begin
    case(aluop)
      2'b00: alucontrol <= 4'b0010;  // add
      2'b01: alucontrol <= 4'b0110;  // sub
		2'b11: alucontrol <= 4'b0001;	 // ori
      default: case(func)           // RTYPE
          6'b100000: alucontrol <= 4'b0010; // add
          6'b100010: alucontrol <= 4'b0110; // sub
          6'b100100: alucontrol <= 4'b0000; // and
          6'b100101: alucontrol <= 4'b0001; // or
          6'b101011: alucontrol <= 4'b0111; // sltu
			 6'b000000: alucontrol <= 4'b0101; // sll
          default:   alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
end

endmodule
