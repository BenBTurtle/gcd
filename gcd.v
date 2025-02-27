module gcd(input clk,
input reset,
input load,
input [4:0] aIn,
input [4:0] bIn,
output reg [4:0] result,
output [7:0] disp0,
output [7:0] disp1,
output reg done);

reg [4:0] a, b; 
reg [4:0] mOut;
wire [1:0] state = {reset, load}; //remember to default these to 1


initial begin
	result <= 5'b00000;
	a <= 5'b00000;
	b <= 5'b00000;
end
	
always@ (posedge clk) begin

	case(state) //State dictates what the circuit does "11" the case when neither reset or set button is pressed
		2'b11 : begin
			mOut <= (a<b)? a : b; //min module translated to a statement synthesisable in an always statement
			if (mOut == 5'b00000) begin //checks for a minimum result of 0
				result <= (a>b)? a : b; //max module translated to a statement synthesisable in an always statement
				done <= 1'b1; //operation done
				a <= a; //intentional latch generation
				b <= b; //intentional latch generation
			end else begin
				if (a>=b) begin
					a <= a-b;
					b <= b; //Intentional latch generation
					done <= 1'b0;
					result <= result; //Intentional latch generation
				end else begin
					a <= a; //intentional latch generation
					b <= b-a;
					done <= 1'b0;
					result <= result; //Intentional latch generation
				end
			end
		end
		2'b01 : begin
			a <= 5'b00000;
			b <= 5'b00000; 
			done <= 1'b0;
			result <= 5'b00000;
		end
		2'b10 : begin
			a <= aIn;
			b <= bIn;
			done <= 1'b0;
			result <= result; //Intentional latch generation
		end
		2'b00 : begin
			a <= 5'b00000;
			b <= 5'b00000;
			done <= 1'b0;
			result <= 5'b00000;
		end
		default : begin
			a <= 5'b00000;
			b <= 5'b00000;
			done <= 1'b0;
			result <= result; //Intentional latch generation
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
wire [7:0] disp0, disp1;

gcd DUT(clk, reset, load, aIn, bIn, result, disp0, disp1, done);

always begin
	#2 clk = ~clk;
end

initial begin
	clk = 0; //set initial clock
	
	//start test cases
	reset = 1; load = 0; aIn = 30; bIn = 10; #4;// a = 30, b = 10
	reset = 1; load = 1; aIn = 30; bIn = 10; #100; //release store button and give some compute cycles, result should be 10
	
	reset = 0; load = 1; aIn = 30; bIn = 10; #4; //press reset
	reset = 1; load = 1; aIn = 30; bIn = 10; #100; //wait, result should be back to 0
	
	reset = 1; load = 0; aIn = 15; bIn = 25; #4; //a = 15, b = 25  b>a case
	reset = 1; load = 1; aIn = 15; bIn = 25; #100; //release load and wait for compute, result should be 5
	
	reset = 1; load = 0; aIn = 15; bIn = 6; #4; //a = 15, b = 6  a>b case
	reset = 1; load = 1; aIn = 15; bIn = 6; #100; //release load and wait for compute, result should be 3
	
	reset = 1; load = 1; aIn = 5; bIn = 27; #100; //change input values without pressing load button, result shouldnt change
	
	reset = 0; load = 1; aIn = 5; bIn = 27; #4; //press reset again
	reset = 1; load = 1; aIn = 5; bIn = 27; #100; //wait, result should be back to 0
	
	reset = 1; load = 0; aIn = 0; bIn = 4; #4; //a = 0, b = 4  zero case
	reset = 1; load = 1; aIn = 0; bIn = 4; #100; //release load and wait for compute, result should be 4
	
	$stop; //complete
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
