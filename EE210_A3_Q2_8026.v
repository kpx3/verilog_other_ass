module DIV_datapath (low, L1,L2, LdC,LdP, CLRC, INC, data_in, clk); //datapath module for quotient and remainder 8026
input L1,L2, LdC, CLRC, INC, clk,LdP;//inputs 8026
input [15:0] data_in;//data input from controller 8026
output low;//output LESS to check if number is low than 10 8026
wire [15:0] W, Y, T, ou;//Declaring W,Y,T and ou wires 8026

LESS COMP (low, W);//instantiating LESS 8026
PIPO1 D (W, data_in,T, L1,L2, clk);	//instantiating PIPO1 8026
PIPO2 P (Y,LdP,clk);//instantiating PIPO2 8026
CNTR C (ou, LdC, INC,clk);//instantiating CNTR 8026
SUBTRACT CT (T, W, Y) ;	//instantiating SUBTRACT 8026	
endmodule//ending datapath module 8026

module PIPO1 (dout,d1,d2,ld1,ld2,clk);//module PIPO1 8026
input [15:0] d1;//input d1 8026
input [15:0] d2;//input d2 8026
input ld1,ld2, clk;//input loads ld1 ,ld2 and clock clock 8026
output reg [15:0] dout;	//output dout 8026
always @(posedge clk)//positive edge of the clock activates 8026
	if(ld1) dout <= d1;//d1 is transferred to dout 8026
	else if(ld2) dout<=d2;//d2 is transferred to dout 8026
endmodule//end of module 8026


module PIPO2 (dout,ld,clk);//module PIPO2 8026
input ld,clk;//input ld and clk 8026
output reg [15:0] dout;	//output dout 8026
always @(posedge clk)//positive edge of the clock activates 8026
	if(ld) dout <= 16'b0000000000001010;//initialising dout to 10 8026
endmodule//end of module 8026


module SUBTRACT (out, in1, in2);//module SUBTRACT to output the difference of inputs 8026
input [15:0] in1, in2;//input in1 and d2 8026
output reg [15:0] out;//output out as reg 8026
always @(*)
	out =in1-in2 ;//out is the difference of in1 and in2  8026
endmodule

module LESS (low, data);//module LESS to stop the opeation if number becomes low than 10 8026
input [15:0] data;//input data 8026
output low;//output low 8026
assign low =(data <10);//when data low tahn 10 breaks the cycle 8026
endmodule 

module CNTR (dout,ld,inc,clk);//module CNTR to count 8026
input ld,inc,clk;//inputs 8026
output reg [15:0] dout;//output register dout 8026

always @(posedge clk)//positive edge of the clock activates 8026
	if(ld) dout<=16'd0;//assign 0 to dout when ld is activated 8026
	else if(inc) dout <= dout+1;//increments dout by 1 8026
endmodule																		


module controller (L1,L2, LdC,LdP, CLRC,INC,done, clk,low, start);//control path module - controller 8026
input clk, low,start;//inputs clock,low and start 8026
output reg L1,L2,LdC,CLRC,INC,done,LdP; //outputs of controller that are input to data path 8026
reg [2:0] state;//2 bit register to determine the state   8026
 parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011;	//parameters for subtracted 8026

always @(posedge clk)//positive edge of the clock activates 8026
	begin
	  case (state)//determine the cases for each state 8026
		S0: if(start) state<=S1;//puts state in S1 8026
		S1: begin//case statement for S1 8026
        #2 if (low) state<=S3;//if low lower than 10 move directly to S3 8026
        else state<=S2;//State goes to S2 8026
       end//end of case statement for S1 8026
		S2: #2 if (low) state<=S3; //signal less than 1 ,state goes to S3 8026
		S3: state <=S3;//state goes to S3 8026
		default: state <=S0;//default state S0 8026
	   endcase//end of cases for state 8026
	end
always @(state)//always block for State 8026
	begin
	  case (state)//cases to be followed for values of different signals at the states 8026
		S0: begin #1 L1 =0;L2=0; LdC=0;CLRC=0;INC=0;LdP=0;end//At S0,all the values put to be zero ,so give data_in to Bus	8026
		S1: begin #1 L1 =1;LdC=1;CLRC=1;LdP=1; end //At S1,put L1=1 so as to give data_in to W,LdC=1 ,CLRC=1 to clear C and LdP =1 8026
		S2: begin #1 L1=0;LdC=0;CLRC=0;L2=1;INC=1;end//At S2,regive 0 to L1 and assign 1 to L2,so it continuously takes input from T,LdC and CLRC= 0 and INC=1 to increase counter by everytime		8026
		S3: begin #1 done=1;L1=0;LdC=0;INC=0;L2=0;LdP=0;end//this marks completion of operation,hence done =1 and rest be assigned 0 		8026
		default: begin #1 LdC=0;L1=0;L2=0;CLRC=0;INC=0;LdP=0;end//the default state similar to S0 assigns everything as 0				8026
	   endcase
	end
endmodule //end of control path module controller													8026
