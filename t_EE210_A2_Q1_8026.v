`timescale 1ns/100ps
module t_seq_dect(t_y_out);//test bench for detecting the sequence 8026
 output t_y_out;//output to check if the sequence is detected 8026
 reg t_x_in,t_clock,t_reset;//input for sequence clock and reset 8026
 seq_det m1(t_y_out,t_x_in,t_clock,t_reset);//instantiating the module for checking the sequence 8026
 initial #270 $finish;
 initial begin t_clock = 0;t_reset = 0;t_x_in = 0;forever #(5.0/2.0) t_clock = ~t_clock;end//intialising clock and reset, updating clock's value 8026
 initial begin
 repeat(1) @ (posedge t_clock);//changing the value of reset 8026
 t_reset<=1;//reset set to 1 8026
 end
 initial fork //inputting the sequence 8026
  #5 t_x_in = 0;
  #10 t_x_in = 0;
  #15 t_x_in = 1;
  #20 t_x_in = 1;
  #25 t_x_in = 0;
  #30 t_x_in = 1;
  #35 t_x_in = 0;
  #40 t_x_in = 0;
  #45 t_x_in = 1;
  #50 t_x_in = 1;
  #55 t_x_in = 0;
  #60 t_x_in = 1;
  #65 t_x_in = 0;
  #70 t_x_in = 0;
  #75 t_x_in = 1;
  #80 t_x_in = 1;
  #85 t_x_in = 0;
  #90 t_x_in = 1;
  #95 t_x_in = 0;
  #100 t_x_in = 0;
 join 
endmodule//end of test bench 8026
