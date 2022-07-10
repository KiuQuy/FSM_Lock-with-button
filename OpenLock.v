module Button
  (
  input clk, in,
  output wire out
  );
  reg r1, r2, r3;
  always @ (posedge clk)
  begin
    r1 <= in; // first reg in sync
	r2 <= r1; // second
	r3 <= r2; // nho trang thai truoc cua button
  end
  // rising edge = old value is 0, new value is 1
   assign out = ~r3 & r2;
endmodule 

module OpenLock
  (
  input wire clk,
  input wire reset_in,
  input wire b0_in,
  input wire b1_in,
  output wire out,
  output wire [3:0] hex_display
  );  
  wire reset, b0, b1;
  // sync push buttons, convert level to pulse
  Button b_reset(clk, reset_in, reset);
  Button b_0(clk, b0_in, b0);
  Button b_1(clk, b1_in, b1);
  // state assignment
  parameter S_reset = 0;
  parameter S_0 = 1;
  parameter S_01 = 2;
  parameter S_010 = 3;
  parameter S_0101 = 4;
  parameter S_01011 = 5;
  
  reg [2:0] state, next_state;
 
  //implement state transiton diagram
  always @ (*)
  begin
    if(reset) next_state = S_reset;
	else
	  case(state)
/*
	  1. b0 = 0: khong nhap 0
   b0 = 1: nhap 0
   b1 = 0: khong nhap 1
   b1 = 1: nhap 1
*/
	    S_reset:
          if(b0 == 1 && b1 == 0 )	
		    next_state <= S_0;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_reset;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		S_0: 
		  if(b0 == 1 && b1 == 0 )	
		    next_state <= S_0;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_01;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		S_01:
		  if(b0 == 1 && b1 == 0 )	
		    next_state <= S_010;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_reset;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		S_010: 
		  if(b0 == 1 && b1 == 0 )	
		    next_state <= S_0;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_0101;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		S_0101: 
		  if(b0 == 1 && b1 == 0 )	
		    next_state <= S_010;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_01011;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		S_01011: 
		  if(b0 == 1 && b1 == 0 )	
		    next_state <= S_0;
		  else if(b0 == 0 && b1 == 1)
		    next_state <= S_reset;
		  else if(b0 == 0 && b1 == 0)
		    next_state <= state;
		  else next_state <= S_reset;
		default: next_state = S_reset;
	  endcase
  end
  always @ (posedge clk) state <= next_state;
  
  assign out = (state == S_01011);// tra ve 0/1
  assign hex_display = {1'b0, state};  // ??/
  
endmodule
  