module tb_OpenLock;
  reg clk;
  reg reset_in;
  reg b0_in;
  reg b1_in;
  wire out;
  wire [3:0] hex_display;
   OpenLock uut
   (
   .clk(clk),
   .reset_in(reset_in),
   .b0_in(b0_in),
   .b1_in(b1_in),
   .out(out),
   .hex_display(hex_display)
   );
  initial 
    begin
	  clk = 1'b0;
	  b0_in = 1'b0;
      reset_in = 0;
      #3 reset_in = 1'b1;
	  #2 reset_in = 1'b0;
	  #2 b1_in = 1'b0; 
	  #2 b1_in = 1;
      #2 b1_in = 0;
	  #2 b0_in = 1;
      #2 b0_in = 0;
	  #2 b1_in = 1;
      #2 b1_in = 0;
	  #2 b0_in = 1;
      #2 b0_in = 0;
	  #2 b1_in = 1;
      #2 b1_in = 0;
	  #2 b1_in = 1;
      #2 b1_in = 0;
	end
  always #1 clk = ~ clk;
endmodule
   
  
