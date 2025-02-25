module max(input [4:0] a,
input [4:0] b,
output reg [4:0] maxNum);

always@(*) begin
	maxNum <= (a>b)? a : b;
end
endmodule

module min(input [4:0] a,
input [4:0] b,
output reg [4:0] minNum);

always@(*) begin
	minNum <= (a<b)? a : b;
end
endmodule

