module decSevenSegmentDecoder(input [3:0] in,
output [7:0] out);

reg [7:0] wout;

always@ (*) begin
	case(in)
		4'h0: wout = 8'b11000000;
		4'h1: wout = 8'b11111001;
		4'h2: wout = 8'b10100100;
		4'h3: wout = 8'b10110000; 
		4'h4: wout = 8'b10011001; 
		4'h5: wout = 8'b10010010; 
		4'h6: wout = 8'b10000010; 
		4'h7: wout = 8'b11111000; 
		4'h8: wout = 8'b10000000;
		4'h9: wout = 8'b10010000;
		default: wout = 8'b01111111; //invalid returns a decimal place only
	endcase
end

assign out = wout;

endmodule