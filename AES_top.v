`include "round.v"
`include "expand_key_top.v"
`include "sbox.v"
module AES_top (data_in, key_in, out_data, ready, rst, clk);
	input clk;
	input rst;
	
	input wire [127:0] data_in;
	input wire [127:0] key_in;
	output wire [127:0] out_data;
	output reg ready;
	
	reg [3:0] cnt;
	reg [127:0] temp_initial_step;
	reg [127:0] temp_key;
	reg [127:0] cipher_text;
	
	//Round stuff
	reg [127:0] round_in_data;
	reg [127:0] round_in_key;
	reg round;
	wire [127:0] round_data;
	reg [127:0] temp_round_data;
	wire readyR;
	reg rstR;
	
	//Expand key stuff
	reg [127:0] expanded_key_in;
	reg [1407:0] expanded_key;
	wire [1407:0] expanded_key_out;
	wire readyk;
	reg rstk;
	
	
	round R2 (.in_data (round_in_data), .in_key (round_in_key), .round(round), .out_data (round_data), .ready (readyR), .rst (rstR), .clk (clk));
	expand_key_top EK1 (.in_key (expanded_key_in), .full_expanded_key (expanded_key_out), .ready (readyk), .rst (rstk), .clk (clk));
	
	assign out_data = cipher_text;
	
	always @* begin
		
		if (ready == 0) begin
			temp_initial_step = data_in[127:0] ^ key_in[127:0];
			temp_key = key_in;
      
			if (cnt == 0) begin
				expanded_key_in = temp_key;
			end
			if (cnt == 1) begin
				round_in_data[127:0] = temp_initial_step[127:0];
				round_in_key[127:0] = expanded_key[255:128];
				round = 0;
			end
			if (cnt == 2 && rstR == 0) begin
        //$display ("R1= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[383:256];
        //$display ("Key2 = 0x%0h", expanded_key[383:256]);
				round = 0;
			end
			if (cnt == 3) begin
        //$display ("R2= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[511:384];
				round = 0;
			end
			if (cnt == 4) begin
        //$display ("R3= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[639:512];
				round = 0;
			end
			if (cnt == 5) begin
        //$display ("R4= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[767:640];
				round = 0;
			end
			if (cnt == 6) begin
        //$display ("R5= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[895:768];
				round = 0;
			end
			if (cnt == 7) begin
        //$display ("R6= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[1023:896];
				round = 0;
			end
			if (cnt == 8) begin
        //$display ("R7= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[1151:1024];
				round = 0;
			end
			if (cnt == 9) begin
        //$display ("R8= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[1279:1152];
				round = 0;
			end
			if (cnt == 10) begin
        //$display ("R9= 0x%0h", temp_round_data);
				round_in_data[127:0] = temp_round_data[127:0];
				round_in_key[127:0] = expanded_key[1407:1280];
				round = 1;
			end
		end
	end
	
	always @(posedge clk) begin
		if (rst == 1) begin
			cnt <= 0;
			ready <= 0;
			rstR <= 1;
			rstk <= 1;
		end
		else begin
			if (rstR == 0 && rstk == 0) begin
				
				if(cnt == 0 && readyk == 1) begin
					expanded_key[1407:0] <= expanded_key_out[1407:0];
					cnt <= cnt +1;
          rstR <= 1;
				end
				if(cnt == 1 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 2 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 3 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 4 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 5 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 6 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 7 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 8 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 9 && readyR == 1) begin
					temp_round_data[127:0] <= round_data[127:0];
					cnt <= cnt + 1;
					rstR <= 1;
				end
				if(cnt == 10 && readyR == 1) begin
					cipher_text[127:0] <= round_data[127:0];
          ready <= 1;
					cnt <= cnt + 1;
					rstR <= 1;
				end
			end
			else begin
				rstk <= 0;
				rstR <= 0;
			end
		end
	end
endmodule