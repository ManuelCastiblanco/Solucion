`timescale 1ns / 1ps

module Control_ADCb(
    output 	reg 	[2:0]	add,
    output 	reg			ALE,
    output 	reg			START,
	 output 	reg	[7:0]	dataout,
	 output 					CLK1,
	 input 					init,
    input 			[7:0]	datain,
    input 					CLK,
	 input 					OE_R
    );
	 
	localparam Iddle		= 0;
	localparam LoadAdd 	= 1;
	localparam AddLatch 	= 2;
	localparam Run 		= 3;
	localparam Receive 	= 4;

//	wire OE;
	wire [2:0] add_o;
	
	reg [3:0] stateS, stateA;	

	initial begin
		stateS = Iddle;
		stateA = 0;
		add = 0;
		ALE = 0;
		START =0;
		dataout = 8;
		
	end
	
	//assign add = add_o;
	
	always @(*) begin
		add = add_o;
	end

	always @(posedge CLK1) begin
		stateA = stateS;

		case(stateA)
			
			Iddle :  
				if(init == 1) begin
					stateS = LoadAdd;
					ALE = 0;
					START = 0;
					end
				else begin
				stateS = stateS;
				end
			
			LoadAdd : begin
				stateS = AddLatch;
				ALE = 1;
				START = 0;
				end
			AddLatch : begin
				stateS = Run;
				START = 1;
				end
			Run : begin
				stateS = Receive;
				ALE = 0;
				end
			Receive : begin
				START = 0;
				
				
					if (add == 3) begin
						stateS = Iddle;
					end
					if (OE_R == 1)begin
						stateS = LoadAdd;
						dataout = datain;
					end
					else begin
						stateS = stateS;
					end
									
				end
				
			default: stateS = Iddle;
		
		endcase
		
	end
AddressModule instance_name (
    .add_o(add_o), 
    .CLK(CLK),
	 .CLK1(CLK1),
    .OE_R(OE_R), 
    .init(init)
    );	
endmodule 
