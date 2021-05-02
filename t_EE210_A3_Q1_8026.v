
module tbmat_A3_Q1;//test bench for matirx multiplication 8026
parameter a = 3;parameter b = 2;parameter c = 6;//parameters of dimenstions of matrices 8026
    reg [a*b*8-1:0] A;//input A 8026
    reg [b*c*8-1:0] B;//input B 8026
    wire [a*c*8-1:0] C;//output C 8026
    //reg [7:0] 	C1[0:a-1][0:c-1];
    integer i;//variable for loop 8026
    matrix_multiplier m1(C,A,B);//instantiating the matrix multiplier 8026 
    initial begin //block for displaying the product matix obtained
        A = 0;  B = 0;  #10;
        A = {8'd1,8'd0,8'd1,8'd1,8'd0,8'd1};//matirx A is given values 8026
        B = {8'd1,8'd0,8'd1,8'd0,8'd1,8'd0,8'd1,8'd0,8'd1,8'd1,8'd0,8'd1};//matrix B is given values 8026
	for(i = a*c*8-8; i>=0;i=i-8)begin//for loop for printing the elements of product matrix obtained 8026
		#10 $write("%d ",{C[i+7],C[i+6],C[i+5],C[i+4],C[i+3],C[i+2],C[i+1],C[i]});//printing the elements here 8026
                
	end
	
	
    end
      
endmodule//end of test bench module 8026
