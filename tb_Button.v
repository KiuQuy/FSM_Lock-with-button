module tb_Button;
  reg clk;
  reg in;
  wire out;
  Button uut
  (
  .clk(clk),
  .in(in),
  .out(out)
  );
  initial 
    begin
	clk = 1'b0;
	end
  always #5 clk = ~clk;
  always #5 in = $random;
  endmodule
  
  