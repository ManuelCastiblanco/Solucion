module CLKDIV(
    input CLK,
    output reg CLK1
    );
	 
	 reg [6:0] counter;
	 
	 initial begin
	 counter = 0;
	 CLK1 = 0;
	 end
	 
	 always @(posedge CLK) begin
		
		counter = counter + 1;
		if (counter == 80) begin
			
			CLK1 = ~CLK1;
			counter = 0;
			
		end
	 
	 end


endmodule
