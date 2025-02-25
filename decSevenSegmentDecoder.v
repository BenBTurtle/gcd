module fiveBitSevenSegmentDecoder(input [4:0] in,
output [7:0] disp1,
output [7:0] disp0);

reg [7:0] wout1;
reg [7:0] wout0;


//This is a brute force implementation, Feel free to update this later with a less brute force solution
always@ (*) begin
	case(in) //NOTE: wout1/disp1 = hex1 and wout0/disp0 = hex0 on MAX10 FPGA
		0: begin wout1 = 8'b11000000; wout0 = 8'b11000000; end
		1: begin wout1 = 8'b11000000; wout0 = 8'b11111001; end
		2: begin wout1 = 8'b11000000; wout0 = 8'b10100100; end
		3: begin wout1 = 8'b11000000; wout0 = 8'b10110000; end
		4: begin wout1 = 8'b11000000; wout0 = 8'b10011001; end
		5: begin wout1 = 8'b11000000; wout0 = 8'b10010010; end
		6: begin wout1 = 8'b11000000; wout0 = 8'b10000010; end
		7: begin wout1 = 8'b11000000; wout0 = 8'b11111000; end
		8: begin wout1 = 8'b11000000; wout0 = 8'b10000000; end
		9: begin wout1 = 8'b11000000; wout0 = 8'b10010000; end
		10: begin wout1 = 8'b11111001; wout0 = 8'b11000000; end
		11: begin wout1 = 8'b11111001; wout0 = 8'b11111001; end
		12: begin wout1 = 8'b11111001; wout0 = 8'b10100100; end
		13: begin wout1 = 8'b11111001; wout0 = 8'b10110000; end
		14: begin wout1 = 8'b11111001; wout0 = 8'b10011001; end
		15: begin wout1 = 8'b11111001; wout0 = 8'b10010010; end
		16: begin wout1 = 8'b11111001; wout0 = 8'b10000010; end
		17: begin wout1 = 8'b11111001; wout0 = 8'b11111000; end
		18: begin wout1 = 8'b11111001; wout0 = 8'b10000000; end
		19: begin wout1 = 8'b11111001; wout0 = 8'b10010000; end
		20: begin wout1 = 8'b10100100; wout0 = 8'b11000000; end
		21: begin wout1 = 8'b10100100; wout0 = 8'b11111001; end
		22: begin wout1 = 8'b10100100; wout0 = 8'b10100100; end
		23: begin wout1 = 8'b10100100; wout0 = 8'b10110000; end
		24: begin wout1 = 8'b10100100; wout0 = 8'b10011001; end
		25: begin wout1 = 8'b10100100; wout0 = 8'b10010010; end
		26: begin wout1 = 8'b10100100; wout0 = 8'b10000010; end
		27: begin wout1 = 8'b10100100; wout0 = 8'b11111000; end
		28: begin wout1 = 8'b10100100; wout0 = 8'b10000000; end
		29: begin wout1 = 8'b10100100; wout0 = 8'b10010000; end
		30: begin wout1 = 8'b10110000; wout0 = 8'b11000000; end
		31: begin wout1 = 8'b10110000; wout0 = 8'b11111001; end
		default: begin wout1 = 8'b01111111; wout0 = 8'b01111111; end //invalid returns a decimal place only
	endcase
end

assign disp1 = wout1;
assign disp0 = wout0;

endmodule

/* Reference table dec
0 = 8'b11000000
1 = 8'b11111001
2 = 8'b10100100
3 = 8'b10110000
4 = 8'b10011001
5 = 8'b10010010
6 = 8'b10000010
7 = 8'b11111000
8 = 8'b10000000
9 = 8'b10010000
end reference table */