
module seq_det (output reg z,input y,clk,rst);//module for detecting a given sequence 8026
 reg[2:0] state,next_state;//intermediate states 8026
 parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101,S6=3'b110;//parameters to define each state 8026
 always @(posedge clk, negedge rst)//block for reseting and updating the current state 8026
  if(rst==0) begin state<=S0; end//reseting 8026
  else state<=next_state;//updating the current state 8026
 always @(state,y)//block for determining the next state 8026
  case(state)//case block determing the next state 8026
   S0: if(y) next_state=S0 ;else next_state = S1;
   S1: if(y) next_state=S0 ;else next_state = S2;
   S2: if(y) next_state=S3 ;else next_state = S1;
   S3: if(y) next_state=S4 ;else next_state = S0;
   S4: if(y) next_state=S0 ;else next_state = S5;
   S5: if(y) next_state=S6 ;else next_state = S1;
   S6: if(y) next_state=S0 ;else next_state = S1;

  endcase //end of case block 8026
always @(state,y)//block for obtaining the output 8026
  case(state)
   S0,S1,S2,S3,S4,S5: z=0;
   S6: z=~y;//if the sequence is detected 1 is stored 8026
 endcase//end of case block 8026
endmodule //end of module for sequence detector 8026