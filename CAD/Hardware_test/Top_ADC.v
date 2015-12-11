`timescale 1ns / 1ps

module Top_ADC(
	 input 			data0,
	 input			data1,
	 input 			data2,
	 input			data3,
	 input 			data4,
	 input			data5,
	 input 			data6,
	 input			data7,
    input		   CLK,
	 input 			OE_R,
	 input 			init,

	 output        CLK1,
	 output 			ALE,
    output 			START, 
	 output 			add0,
	 output			add1,
	 output			add2,
	 output r1a,
	 output r1b,
	 output r1c,
	 output r1d,
	 output r1e,
	 output r1f,
	 output r1g,
	 output r1h,
	 // output	reg	[7:0]	r1,
	 output	reg	[7:0]	r2,
	 output	reg	[7:0]	r3,
	 output	reg	[7:0]	r4,
	 output	reg done
    );
	 
	 wire[7:0] data;
	 wire [2:0] add;
	 wire	[7:0]	datain;
	 reg [2:0] countA, countD;
	 reg	[7:0]	r1;
	 
	 assign datain[0]=data0;
	 assign datain[1]=data1;
	 assign datain[2]=data2;
	 assign datain[3]=data3;
	 assign datain[4]=data4;
	 assign datain[5]=data5;
	 assign datain[6]=data6;
	 assign datain[7]=data7;
	 
//	 assign r1[0] = r1a;
//	 assign r1[1] = r1b;
//	 assign r1[2] = r1c;
//	 assign r1[3] = r1d;
//	 assign r1[4] = r1e;
//	 assign r1[5] = r1f;
//	 assign r1[6] = r1g;
//	 assign r1[7] = r1h;
	 
	 
	 assign add0 =add[0];
	 assign add1 =add[1];
	 assign add2 =add[2];
	 
	 
		
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
	
	always @(posedge CLK1) begin
		
		if (done == 1)	begin
			countD = countD + 1;
		end
		if (countD == 2) begin
			done = 1'b0;
			countD = 0;
		end
		
	end
	
	 Control_ADCb instance_name (
    .add(add), 
    .ALE(ALE), 
    .START(START), 
    .dataout(data), 
    .init(init), 
    .datain(datain), 
    .CLK(CLK),
	 .CLK1(CLK1),
    .OE_R(OE_R)
    );
	 
  
endmodule 
