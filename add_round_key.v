module add_round_key (in_data, in_key, out_data, rst, clk);
	input clk;
	input rst;
	input wire [127:0] in_data;
	input wire [127:0] in_key;
	output wire [127:0] out_data;
	
	reg [127:0] temp;
 
  assign out_data = temp;
	
	always @* begin
	
		temp = in_data ^ in_key;
	
	end
 
 
endmodule