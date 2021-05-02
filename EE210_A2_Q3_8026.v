module mealy_atm( input clock, defect, insert_card, card_legal,undamaged, reset,
input [15:0] cash_available,amt_need, //16 bit input to store asked amount and cash available 8026
input [3:0] correct_pin, given_pin, //4 bit input for comparing the guven and correct pins 8026
output reg green_light, red_light, resubmit, alarm_on, not_enough_cash,success);//output signals and messages 8026
reg [2:0] state; //3 bit number for the current state of machine 8026

parameter rest = 3'b000, green_bulb = 3'b001, red_bulb = 3'b110, card = 3'b010, pin1 = 3'b011,pin2 = 3'b100, amount_dispensed =3'b101; //

always @(posedge clock, negedge reset) //runs when a posedge of clock or negedge of reset occurs 8026
begin // always block begins 8026
if(reset==0) begin //resets all outputs if reset is 0 8026
state <= rest; green_light = 0; red_light = 0; resubmit = 0; alarm_on = 0; not_enough_cash= 0; success = 0; //all the outputs are reseted 8026
end 
else begin 
case(state) //check current state 8026
rest: begin //rest state 8026
if((cash_available>0)&(defect==0)) begin state <= green_bulb; green_light <= 1'b1;not_enough_cash = 0; alarm_on = 0; end//going to rest state according to state diagram 8026
else begin state <= red_bulb; red_light <= 1'b1; end //else block 8026
end 
red_bulb: begin //machine not ready 8026
if((cash_available>0)&(defect==0)) begin state <= rest; red_light <= 0; end //red is turned off or on according to state 8026
else begin state <= red_bulb; red_light <= 1; end //else block 8026
end //case block ends 8026
green_bulb: begin //machine ready state 8026
if(insert_card==1) begin state<=card; green_light <= 0; end //green is turned off or on according to state 8026
else state <= green_bulb; //else block 8026
end //case block ends 8026
card: begin //card insertion 8026
if((card_legal&undamaged) == 1) begin state <= pin1; resubmit <=0; end//card accepted or rejected according to state 8026
else begin state <= green_bulb; resubmit <= 1'b1; green_light <= 1; end //else block 8026
end //case block ends 8026
pin1: begin //pin input for the first time 8026
if(given_pin==correct_pin) state <= amount_dispensed; //pin is checked and we move to next state according to state diagram 8026
else state <= pin2; //else block 8026
end //case block ends 8026
pin2: begin //pin is re-entered if wrong pin is given initially 8026
if(given_pin==correct_pin) state <= amount_dispensed;
else begin state <= rest; alarm_on <= 1; end //else block 8026
end //case block ends 8026
amount_dispensed: begin //enter the amount needed 8026
if(amt_need<= cash_available) begin state <= rest; success = 1; end //checks if enough cash is available and goes to rest state 8026
else begin success = 0; state <= rest; not_enough_cash = 1; end 
end 
endcase //caseblock ends here 8026
end 
end 
endmodule //module declaration ends here 8026
