
module testbench_mul;//test bench for mutiplication of two numbers 8026
reg clk, start;//clock and start inputs 8026
reg [7:0] a, b;//input of the two numbers to be multiplied 8026
wire [15:0] ab;//output for storing the product 8026
multiplier m1(ab, a, b, clk, start);//instantiating the multiplier 8026
initial begin //initial block for intialising the clock,and the product variable 8026
clk = 0;//initialising the clock 8026
$display("b = 80 a = 26");//disp
b = 8'b01010000; a = 8'b00011010; start = 1; #50 start = 0;//values of a and b are given 8026
#80 $display("done ab = %b %d",ab,ab);//displaying the output 8026
$finish;
end
always #5 clk = !clk;//setting the clock speed 8026
always @(posedge clk) $strobe("ab: %b %d", ab,ab);
endmodule//end of the module for multiplication of numbers 8026
