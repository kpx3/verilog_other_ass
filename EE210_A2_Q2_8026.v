module multiplier(prod, mc, mp, clk, start);//module for booth multiplier 8026
output [15:0] prod;//output of the product of two numbers 8026
input [7:0] mc, mp;//two input numbers 8026
input clk, start;//input for clock and starting 8026
reg [7:0] A, Q, M;//three intermediate numbers which will help in determining the output 8026
reg Q_1;//stores the least significant bit 8026
wire [7:0] sum, difference;//sum and difference intermediate numbers 8026
always @(posedge clk)//posetive edge of clock 8026
begin
 if (start) begin //intialising 8026
 A <= 8'b0; //intialsing A 8026
 M <= mc;//intialisng M with the first number  8026
 Q <= mp;//intialisng Q with the second number 8026
 Q_1 <= 1'b0;//initialising Q_1 with 0 8026
 end
 else begin
 case ({Q[0], Q_1}) //using two least significant bits of the number to decide which operation to be performed 8026
 2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};//using sum to update the values 8026
 2'b1_0 : {A, Q, Q_1} <= {difference[7], difference, Q};//using difference to update the values 8026
 default: {A, Q, Q_1} <= {A[7], A, Q};//default case using the same values again 8026
 endcase
 end
end
alu adder (sum, A, M, 1'b0);//sum of first number and A 8026
alu subtracter (difference, A, ~M, 1'b1);//difference of A and first number 8026
assign prod = {A, Q};//stroing the product of two numbers thus obtained 8026
endmodule

module alu(out, a, b, cin);//alu for adding and subracting 8026
output [7:0] out;//output 8026
input [7:0] a;//two input numbers 8026
input [7:0] b;//two input numbers 8026
input cin; //input one bit for adding and subracting 8026
assign out = a + b + cin;//output of the operations 8026
endmodule