module gcd(input clk,
input reset,
input load,
input [4:0] aIn,
input [4:0] bIn,
output reg [4:0] result,
output [7:0] disp0,
output [7:0] disp1,
output reg done,
output reg debug);

reg [4:0] a, b; 
wire [4:0] mOut, resCheck;
wire [1:0] state = {reset, load}; //remember to default these to 1

min m(a,b,mOut);
max maout(a,b,resCheck);

always@ (clk) begin

	case(state)
		2'b11 : begin
			if (mOut == 5'b00000) begin
				result <= resCheck;
				a <= a;
				b <= b;
				done <= 1'b1;
			end else begin
				if (a>=b) begin
					a <= a-b;
					b <=b;
				end else begin
					a <= a;
					b <= b-a;
				end
			end
		end
		2'b01 : begin
			a <= 5'b00000;
			b <= 5'b00000;
			done <= 1'b0;
		end
		2'b10 : begin
			a <= aIn;
			b <= bIn;
			done <= 1'b0;
		end
		2'b00 : begin
			a <= 5'b00000;
			b <= 5'b00000;
			done <= 1'b0;
		end
		default : begin
			a <= 5'b00000;
			b <= 5'b00000;
			done <= 1'b0;
			debug <= 1'b1;
		end	
	endcase
end



fiveBitSevenSegmentDecoder displayResults(result, disp1, disp0);

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



/* OLD non functional design in case I need it again
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
*/
