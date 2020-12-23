module mux(control, zero, non_zero, result);

input control;
input[31:0] zero, non_zero;

output [31:0] result;

assign result = (control == 1'b0) ? zero : non_zero;	// select result

endmodule