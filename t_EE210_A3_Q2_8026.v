module t_quo_rem;//test bench for determining the remainder and quotient 8026
reg [15:0] data_in;//input of the number whose remainder and quotient is to be determined 8026
reg clk, start;//variable for clock and start variable 8026
wire done;//variable to indicate the end of operation and printing the final values of reminder and quotient 8026
DIV_datapath DP (less,LdD1,LdD2,LdC,LdP,clrC, incC, data_in, clk);//instantiating the datapath 8026
controller CON (LdD1,LdD2,LdC,LdP,clrC, incC,done,clk,less,start);//instantiating the controller path 8026

initial
  begin
    clk =1'b0;//initialising clock variable 8026 
    #2 start=1'b1;//initialising start variable 8026
  end

always #5 clk =~clk;//setting the clock variable 8026
initial
  begin
    #10 data_in=26;//value whose quotient and remainder with 10 is to be determined is inputed 8026
  end

initial
  begin
    $monitor (" Quotient= %d  Remainder= %d done= %b", DP.ou,DP.W, done);
    //values of quotient and remainder after each cycle is displayed until the final values are obtained 8026
  end
endmodule
