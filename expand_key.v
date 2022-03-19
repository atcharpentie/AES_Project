
module expand_key (key_in, rcon_index, key_out, ready, rst, clk);
	input clk;
	input rst;
  output reg ready;
 
	input wire [7:0] rcon_index;
	input wire [127:0] key_in;
	output wire [127:0] key_out;
	
	reg [127:0] temp_key_in;
	reg [127:0] temp_expanded_key;
	reg [31:0] last_word;
	reg [7:0] temp_rcon_index;
	reg [7:0] temp;
  reg [31:0] rotated_word;
  reg [31:0] sub_word;
  reg [31:0] rcon_word;
	reg [7:0] sbox_s2;
	wire [7:0] sbox_o2;
 
  reg flag;
  reg [1:0] cnt;
  
	
	
	sbox SB2 (.select (sbox_s2), .s_out (sbox_o2), .clk (clk));
	
	always @* begin
	
		temp_rcon_index = rcon_index;
		temp_key_in[127:0] = key_in[127:0];
    //$display ("Temp_key= 0x%0h", temp_key_in[127:0]);
		last_word[31:0] = temp_key_in[127:96];
		//$display ("Last_word= 0x%0h", last_word[31:0]);
		
    //Rotate last word left
		rotated_word[31:8] = last_word[23:0];
		rotated_word[7:0] = last_word[31:24];
   
		//$display ("Rotated_word= 0x%0h", rotated_word[31:0]);
   
		//Sbox substitution
	  if (cnt == 0) begin
   	  sbox_s2[7:0] = rotated_word[7:0];
    end
		
    if (cnt == 1) begin
  		sbox_s2[7:0] = rotated_word[15:8];
	  end
    	
    if (cnt == 2) begin
 		 sbox_s2[7:0] = rotated_word[23:16];
	  end	
   
    if (cnt == 3) begin
		  sbox_s2[7:0] = rotated_word[31:24];
    end
    //$display ("cnt= 0x%0h", cnt);
		
		//XOR last_word with Rcon
		rcon_word[31:0] = sub_word[31:0] ^ (rcon_val(temp_rcon_index));
		//$display ("Rcon^= 0x%0h", rcon_word[31:0]);
		//Get expanded key
    if(flag == 1) begin
		  temp_expanded_key[31:0] = temp_key_in[31:0] ^ rcon_word[31:0];
		  temp_expanded_key[63:32] = temp_expanded_key[31:0] ^ temp_key_in[63:32];
		  temp_expanded_key[95:64] = temp_expanded_key[63:32] ^ temp_key_in[95:64];
		  temp_expanded_key[127:96] = temp_expanded_key[95:64] ^ temp_key_in[127:96];
		end
		
	end
	
  always @(posedge clk) begin
    if (rst == 1'h1) begin
      cnt <= 2'h0;
      ready <= 1'h0;
      flag <= 0;
    end
      else begin
        if (cnt == 0) begin
		      sub_word[7:0] <= sbox_o2[7:0];
        end
		
        if (cnt == 1) begin
		      sub_word[15:8] <= sbox_o2[7:0];
	      end
    	
        if (cnt == 2) begin
		      sub_word[23:16] <= sbox_o2[7:0];
	      end	
   
        if (cnt == 3) begin
		      sub_word[31:24] <= sbox_o2[7:0];
          flag <= 1'h1;
          ready <= 1'h1;
        end
      //$display ("sub_word= 0x%0h", sub_word[31:0]);
      cnt <= cnt + 1;
    end
  end
  
	assign key_out = temp_expanded_key;
	
	function [31:0] rcon_val;
		input [7:0] index;
		begin
			case (index)
				8'h01 : rcon_val = 32'h01000000;
				8'h02 : rcon_val = 32'h02000000;
				8'h03 : rcon_val = 32'h04000000;
				8'h04 : rcon_val = 32'h08000000;
				8'h05 : rcon_val = 32'h10000000;
				8'h06 : rcon_val = 32'h20000000;
				8'h07 : rcon_val = 32'h40000000;
				8'h08 : rcon_val = 32'h80000000;
				8'h09 : rcon_val = 32'h1b000000;
				8'h0a : rcon_val = 32'h36000000;
			endcase
		end
	endfunction

endmodule