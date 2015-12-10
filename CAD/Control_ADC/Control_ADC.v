`timescale 1ns / 1ps

module Control_ADC(
    input				CLK,
	 //input 	[7:0] 	data,
	 input 				OE_R,
	 input 				init,
	 input				datain,
    output	 [2:0]		add,
	 output 			ALE,
    output 			START,
	 output	reg	[7:0]	r1,
	 output	reg	[7:0]	r2,
	 output	reg	[7:0]	r3,
	 output	reg	[7:0]	r4,
	 output	reg		done
    );
	 
	 wire OE;
	 wire [7:0] data;
	 reg [2:0] countA, countD;
	 
	 initial begin
		r1 = 8'b00000000;
		r2 = 8'b00000000;
		r3 = 8'b00000000;
		r4 = 8'b00000000;
		countA = 0;
		countD = 0;
		done = 0;
	 end
	 
	 
	always @(*) begin
		case (add)
		3'b000 : begin
		
			 if (OE_R == 1) begin
				r1 = data;
				countA = countA +1;
			 end
			 else begin
				r1 = r1;
			 end
			
		end
		3'b001 : begin
		 
			if (OE_R == 1) begin
				r2 = data;
				countA = countA +1;
			 end
			 else begin
				r2 = r2;
			 end
			
		end
		3'b010 : begin
		
			if (OE_R == 1) begin
				r3 = data;
				countA = countA +1;
			 end
			 else begin
				r3 = r3;
			 end
			
		end
		3'b011 : begin
		
			if (OE_R == 1) begin
				r4 = data;
				countA = countA +1;
			 end
			 else begin
				r4 = r4;
			 end
			
		end
		endcase
		
		if (countA == 4) begin
			done = 1;
			countA = 0;
		end			
	end
	
	always @(posedge CLK) begin
		
		if (done == 1)	begin
			countD = countD + 1;
		end
		if (countD == 2) begin
			done = 1'b0;
			countD = 0;
		end
		
	end
	 
	 Control_CAD instance_name (
    .add(add), 
    .ALE(ALE), 
    .START(START), 
    .dataout(data), 
    .init(init), 
    .datain(datain), 
    .CLK(CLK), 
    .OE_R(OE_R)
    );

endmodule 
