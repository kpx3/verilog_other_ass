module t_mealy_atm; //testbench for mealy atm 8026
reg [15:0] amount_asked, cash; // input amount and available input 8026
reg [3:0] correct_pin, user_pin; //4 bit pin to compare correct and input pin 8026
reg insert_card, defect, card_valid, card_undamaged,clock,reset; //1 bit input registers for signals and messages 8026
wire green_bulb,red_bulb,resubmit, alarm, /*not_enough_cash,*/ success; //outputs signals 8026

mealy_atm va(clock,defect, insert_card, card_valid,card_undamaged,reset,cash,amount_asked,correct_pin, user_pin,green_bulb, red_bulb, resubmit, alarm,not_enough_cash,success); //instantiating the atm
initial #250 $finish; //the testbench will run for 250 ns 8026
initial begin clock = 0; forever #5 clock = ~clock; end //setting up the clock speed 8026
initial begin //input block 8026
 reset = 0; //negedge will set all outputs to 0 8026

 #5 reset = 1; defect = 1; cash = 16'd100; insert_card = 0; card_valid=0;card_undamaged = 0; correct_pin = 4'b0110; user_pin =0; amount_asked = 0; //flashes red light 8026

 #10 defect = 0; cash = 16'd0; insert_card = 0; card_valid=0; card_undamaged = 0;correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //flashes red light 8026

 #10 defect = 0; cash = 16'd100; insert_card = 0; card_valid=0; card_undamaged =0; correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //flashes green light 8026

 #20 defect = 0; cash = 16'd100; insert_card = 1; card_valid=0; card_undamaged =1; correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //asks to resubmit card 8026

 #20 defect = 0; cash = 16'd100; insert_card = 1; card_valid=1; card_undamaged =1; correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //asks to enter the pin 8026

 #10 defect = 0; cash = 16'd100; insert_card = 1; card_valid=1; card_undamaged =1; correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //asks to enter the pin again 8026

 #10 defect = 0; cash = 16'd100; insert_card = 1; card_valid=1; card_undamaged =1; correct_pin = 4'b0110; user_pin = 0;amount_asked = 0; //raises an alarm and go to rest state 8026

 #20 defect = 0; cash = 16'd100; insert_card = 1; card_valid=1; card_undamaged =1; correct_pin = 4'b0110; user_pin = 4'b0110;amount_asked = 16'd110; //not enough cash available signal 8026

 #60 defect = 0; cash = 16'd100; insert_card = 1; card_valid=1; card_undamaged =1; correct_pin = 4'b0110; user_pin = 4'b0110;amount_asked = 16'b010; //successful withdrawal 8026

end
initial begin //to show output 8026
$monitor("CASH :%d MACHINE DEFECT:%b green bulb:%b red bulb:%b\nINSERT CARD:%b CARD VALID:%b CARD UNDAMAGED:%b RESUBMIT:%b \nCORRECT PIN:%b ENTERED PIN: %b ALARM:%b \nAMOUNT_ASKED:%d ||SUCCESS:%b \n\n",cash, defect, green_bulb,red_bulb,insert_card,card_valid,card_undamaged,resubmit,correct_pin,user_pin,alarm,amount_asked,success);
end 
endmodule //end of testbench 8026
