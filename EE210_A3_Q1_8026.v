module matrix_multiplier(C,A,B);//module for matrix multiplication 8026
parameter a=3,b=2,c=6;//parameters for dimenstions of the three matrices. Can be varied 8026
input [a*b*8-1:0] A;//first matrix input 8026
input [b*c*8-1:0] B;//second matrix input 8026
output [a*c*8-1:0] C;//output of the matrix multiplication is stored 8026

reg [a*c*8-1:0] C;//also defining C as reg type so as to store it's element easily by sumation of product of elements 8026
reg [7:0] A1 [0:a-1][0:b-1];//stores the input as a 3d array 8026
reg [7:0] B1 [0:b-1][0:c-1];//stores the input as a 3d array 8026
reg [7:0] M [0:a-1][0:c-1];// stores each element obtained on product and sumation of other to matrix elements 8026 
integer i,j,k;//integer for loop for multiplication 8026
integer r,p,d;//integer for loop for intialising reg type A1,B1,M 8026
    always@ (A or B)//always block for storing A in A1 and B in B1 8026
    begin //Initialise the matrices to convert from 1d to 3d array 8026
    r=0;//loop variable intialised to 0 8026
    p=0;//loop variable intialised to 0 8026
        for(r=0; r<a; r=r+1) begin//outermost loop 8026
		for(p=0; p<b; p=p+1) begin // middle loop 8026
			for(d=0; d<8; d=d+1) begin //innermost loop 8026
				A1[r][p][d] = A[r*b*8+p*8+d];//intialising the values in A1 form A 8026
			end
		end
	end
     r=0;//loop variable initialised to 0 8026
     p=0;//loop variable initialised to 0 8026
        for(r=0; r<b; r=r+1) begin//outermost loop 8026
		for(p=0; p<c; p=p+1) begin//middle loop 8026
			for(d=0; d<8; d=d+1) begin//innermost loop 8026
				B1[r][p][d] = B[r*c*8+p*8+d];//intialising the values in B1 form B 8026
			end
		end
	end
         r=0;//loop variable initialised to 0 8026
         p=0;//loop varaiable initialised to 0 8026
        for(r=0; r<a; r=r+1) begin//outermost loop 8026
		for(p=0; p<c; p=p+1) begin//middle loop 8026
			for(d=0; d<8; d=d+1) begin//innermost loop 8026
				M[r][p][d] = 1'd0;//storing 0 initially 8026
			end
		end
	end
       //Matrix multiplication 
        i = 0;j = 0;k = 0;//loop variables initialised to 0 8026
        for(i=0;i < 3;i=i+1)//outermost loop 8026
            for(j=0;j < 6;j=j+1)//middle loop 8026
                for(k=0;k < 2;k=k+1)//innermost loop 8026
                    M[i][j] = M[i][j] + (A1[i][k] * B1[k][j]);//elements of corresponding matrices multiplied and then added 8026
        //3 for loops for final assignment - 3D array to 1D array conversion.
         r=0;//loop variable initialised to 0 8026
         p=0;//loop variable initialised to 0 8026
        for(r=0; r<a; r=r+1) begin//outermost loop 8026
		for(p=0; p<c; p=p+1) begin//middle loop 8026
			for(d=0; d<8; d=d+1) begin//innermost loop 8026
			    C[r*c*8+p*8+d]=M[r][p][d];//values thus obtained are stored in output variable C 8026
			end
		end
	end           
    end 

endmodule
