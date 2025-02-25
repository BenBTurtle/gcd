module gcd(input clk,
input reset,
input load,
input [4:0] aIn,
input [4:0] bIn,
output reg [4:0] result,
output [15:0] disp,
output reg done);

reg [4:0] a, b; 
wire [4:0] mOut, resCheck;

initial begin
result <= 5'b00000;
a <= 5'b00000;
b <= 5'b00000;
done <= 1'b0;
end

min m(a,b,mOut);



always@ (posedge clk) begin

//sets only if button is pressed
	a <= (load==0)? aIn : a;
	b <= (load==0)? bIn : b;
	
if (reset == 0) begin
	result <= 5'b00000;
	a <= 5'b00000;
	b <= 5'b00000;
	done <= 1'b0;
end else if (mOut != 0 && a-b >= 0) begin
	a <= a - b;
	b <= b;
	result <= result;
	done <= 1'b0;
end else if (mOut != 0 && a-b < 0) begin
	b <= b - a;
	a <= a;
	done <= 1'b0;
	result <= result;
end else if (mOut == 0) begin
	done <= 1'b1;
	a<= a;
	b<=b;
	result<=result;
end else begin
	result <= 5'b00000;
	a <= 5'b00000;
	b <= 5'b00000;
	done <= 1'b0;
end
	result <= (done == 1)? resCheck : result;
end

max maout(a,b,resCheck);

endmodule


module gcd_TB();
//inputs
reg clk, reset, load;
reg [4:0] aIn, bIn;
//outputs
wire [4:0] result;
wire done;
wire [15:0] disp;

gcd DUT(clk, reset, load, aIn, bIn, result, disp, done);

always begin
	#2 clk = ~clk;
end

initial begin
	clk = 0; reset = 1; load = 0; aIn = 30; bIn = 10; #10;
	reset = 0; load = 0; aIn = 30; bIn = 10; #10; //check for reset
	reset = 1; load = 0; aIn = 15; bIn = 25; #10; //b>a
	reset = 1; load = 1; aIn = 0; bIn = 10; #10; //check for correct load
	reset = 1; load = 0; aIn = 0; bIn = 10; #10; //now actually load
	$stop;
end

endmodule