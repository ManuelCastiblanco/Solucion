module Proof(
    input CLK,
    output reg OE_R
    );
	 
	 reg [3:0] counter;
	 reg [2:0] counter1;
	 wire CLK1;
	 initial begin
	 counter = 0;
	 counter1 = 0;
	 OE_R = 0;
	 end
	 
	 always @(posedge CLK1) begin
		counter = counter + 1;
		if(counter1 < 4)begin
			if (counter == 15) begin
				OE_R = 1;
				counter = 0;
				counter1 = counter1 + 1;
			end
			else begin
				OE_R = 0;
			end
		end
		else begin
				OE_R = 0;
			end
			
	 end

	CLKDIV instance_name (
    .CLK(CLK), 
    .CLK1(CLK1)
    );

endmodule 
