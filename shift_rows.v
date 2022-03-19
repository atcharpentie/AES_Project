module shift_rows (data_in, data_out, rst, clk);
	input clk;
	input rst;
	input [127:0] data_in;
	output [127:0] data_out;
	
	reg [127:0] temp_state;
  reg [127:0] temp_o;
	
	assign data_out = temp_o;
	
	always @* begin
		//Row one
		temp_state[7:0] = data_in[7:0];
		temp_state[39:32] = data_in[39:32];
		temp_state[71:64] = data_in[71:64];
		temp_state[103:96] = data_in[103:96];
		
		//Row two
		temp_state[15:8] = data_in[47:40];
		temp_state[47:40] = data_in[79:72];
		temp_state[79:72] = data_in[111:104];
		temp_state[111:104] = data_in[15:8];
		
		//Row three
		temp_state[23:16] = data_in[87:80];
		temp_state[55:48] = data_in[119:112];
		temp_state[87:80] = data_in[23:16];
		temp_state[119:112] = data_in[55:48];
		
		//Row three
		temp_state[31:24] = data_in[127:120];
		temp_state[63:56] = data_in[31:24];
		temp_state[95:88] = data_in[63:56];
		temp_state[127:120] = data_in[95:88];
   
    temp_o[127:0] = temp_state[127:0];
		
	end
	
	
	
endmodule