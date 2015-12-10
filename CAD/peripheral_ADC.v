`timescale 1ns / 1ps

module peripheral_ADC(clk , rst , d_in , cs , addr , rd , wr, d_out, init, OE_R, datain, add, ALE, START );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;
  
	///////////////////////// Entradas y salidas del ADC - Externas al J1
  reg init;
  input 			OE_R;
  input 	[7:0]	datain;
  output	[2:0]	add;
  output 		ALE;
  output			START;  
  

//------------------------------------ regs and wires-------------------------------

reg [5:0] s; 	//selector mux_4  and write registers
reg init = 0;

reg	[7:0]	r1;
reg	[7:0]	r2;
reg	[7:0]	r3;
reg	[7:0]	r4;

wire done;

//------------------------------------ regs and wires-------------------------------




always @(*) begin//------address_decoder------------------------------
case (addr)
4'h0:begin s = (cs && rd) ? 6'b000001 : 6'b000000 ;end //r1
4'h2:begin s = (cs && rd) ? 6'b000010 : 6'b000000 ;end //r2
4'h4:begin s = (cs && rd) ? 6'b000100 : 6'b000000 ;end //r3
4'h6:begin s = (cs && rd) ? 6'b001000 : 6'b000000 ;end //r4
4'h8:begin s = (cs && rd) ? 6'b010000 : 6'b000000 ;end //done

4'hA:begin s = (cs && wr) ? 6'b100000 : 6'b000000 ;end //init
default:begin s = 6'b000000 ; end
endcase
end//------------------address_decoder--------------------------------




always @(negedge clk) begin//-------------------- escritura de registros 

init = s[6] ; // (s[2]) ? d_in : init;	//Write Registers

end//------------------------------------------- escritura de registros


always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s[4:0])
5'b00001: d_out [7:0] = r1 ;
5'b00010: d_out [7:0] = r2 ;
5'b00100: d_out [7:0] = r3 ;
5'b01000: d_out [7:0] = r4 ;
5'b10000: d_out [0]   = done ;

default: d_out   = 0 ;
endcase
end//-----------------------------------------------mux_4

	 
	 Control_ADC instance_name (
    .CLK(clk), 
    .OE_R(OE_R), 
    .init(init), 
    .datain(datain), 
    .add(add), 
    .ALE(ALE), 
    .START(START), 
    .r1(r1), 
    .r2(r2), 
    .r3(r3), 
    .r4(r4), 
    .done(done)
    );



endmodule 
