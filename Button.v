module Button
  (
  input clk, in,
  output out
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