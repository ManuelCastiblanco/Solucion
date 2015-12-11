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
	 //cinput			datain,
	 output        CLK1,
    output	[2:0] add,
	 output 			ALE,
    output 			START, 
	 output 			add0,
	 output			add1,
	 output			add2,
	 output	reg	[7:0]	r1,
	 output	reg	[7:0]	r2,
	 output	reg	[7:0]	r3,
	 output	reg	[7:0]	r4,
	 output	reg		done
    );
	 
	 wire OE;
	 wire[7:0] data;
	 reg [2:0] countA, countD;
	 
	 assign data[0]=data0;
	 assign data[1]=data1;
	 assign data[2]=data2;
	 assign data[3]=data3;
	 assign data[4]=data4;
	 assign data[5]=data5;
	 assign data[6]=data6;
	 assign data[7]=data7;
	 
	 assign add[0]=add0;
	 assign add[1]=add1;
	 assign add[2]=add2;
	 
	 
		
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
	
	 Control_ADCb instance_name (
    .add(add), 
    .ALE(ALE), 
    .START(START), 
    .dataout(dataout), 
    .init(init), 
    .datain(datain), 
    .CLK(CLK), 
    .OE_R(OE_R)
    );
	 
reg [7:0] count;  // clock divider counter

reg CLK1;

always @ (posedge CLK)

  begin

    if (count==8'b10100000)  // divide by 160

       count <= 8'b00000000;  // reset to 0

    else count <= count+1;  // increment counter

    CLK1  <=  (count == 8'b00000000);  // counter decoded, single cycle pulse is generated

  end
  
endmodule 
