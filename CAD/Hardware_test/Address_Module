`timescale 1ns / 1ps

module AddressModule(
    output reg [2:0] add_o,
    input CLK,
	 //input OE,
	 input OE_R,
	 input init
    );
	 
		reg initAux;
		wire OE;
		
		initial begin
			add_o = 0;
			initAux = 0;
		end
		
		always @(posedge CLK) begin
			
			if(init == 1) begin
				initAux = 1;
			end
			else begin
				initAux = initAux;
			end
			
			if (OE == 1 && initAux ==1) begin
				add_o = add_o + 3'b001;
				
				if (add_o == 3'b100) begin
					add_o = 0;
					initAux = 0;
				end
				
			end
			else add_o = add_o;
			
		end
		
endmodule 
