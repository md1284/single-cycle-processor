module seg(rst, clk, pc, write_data, hex5, hex4, hex3, hex2, hex1, hex0);

input rst, clk;
input[31:0] pc, write_data;
output[6:0] hex5, hex4, hex3, hex2, hex1, hex0;

wire[19:0] repc_bcd;
wire[19:0] rewd_bcd;

reg[3:0] h0, h1, h2, h3, h4, h5;

bin2bcd(pc[17:0], repc_bcd);
bin2bcd(write_data[17:0], rewd_bcd);

always@(negedge rst or posedge clk) begin
	if (!rst) begin	// if rst then represent "------"
		h0 <= 4'b1111;
		h1 <= 4'b1111;
		h2 <= 4'b1111;
		h3 <= 4'b1111;
		h4 <= 4'b1111;
		h5 <= 4'b1111;
	end
	else begin	// otherwise represent number
		h0 <= rewd_bcd[3:0];
		h1 <= rewd_bcd[7:4];
		h2 <= rewd_bcd[11:8];
		h3 <= rewd_bcd[15:12];
		h4 <= repc_bcd[3:0];
		h5 <= repc_bcd[7:4];
	end
end

seg_digit(h0, hex0);
seg_digit(h1, hex1);
seg_digit(h2, hex2);
seg_digit(h3, hex3);

seg_digit(h4, hex4);
seg_digit(h5, hex5);

endmodule