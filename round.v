`include "sub_bytes.v"
`include "shift_rows.v"
`include "mix_column.v"
`include "add_round_key.v"
module round (in_data, in_key, round, out_data, ready, rst, clk);
	input clk;
	input rst;
	
	input wire [127:0] in_data;
	input wire [127:0] in_key;
  input wire round;
	output wire [127:0] out_data;
	output reg ready;
 
  reg [127:0] temp_data;
  
	
	reg [3:0] cnt;
	
	//Sub bytes stuff
	reg [127:0] sub_in_data;
	wire [127:0] sub_data;
	reg [127:0] temp_sub_data;
	wire readySB;
	reg rstSB;
 
  //Shift rows stuff
  reg [127:0] shift_in_data;
  wire [127:0] shift_data;
  reg rstSR;
  reg [127:0] temp_shift_data;
  
  //Mix data stuff
  reg [127:0] mix_in_data;
  wire [127:0] mix_data;
  reg rstMC;
  reg [127:0] temp_mix_data;
  reg temp_round;
  
  //Add round stuff
  reg [127:0] add_in_data;
  wire [127:0] add_data;
  reg rstARK;
  reg [127:0] temp_add_data;
  reg [127:0] temp_key;
  reg [127:0] add_key_in;
	
	assign out_data = temp_add_data;
	
	sub_bytes SB (.data_in (sub_in_data), .data_out (sub_data), .ready (readySB), .rst (rstSB), .clk (clk));
  shift_rows SR (.data_in (shift_in_data), .data_out (shift_data), .rst (rstSR), .clk (clk));
  mix_column MC1 (.data_in (mix_in_data), .data_out (mix_data), .rst (rstMC), .clk (clk));
  add_round_key ARK1 (.in_data (add_in_data), .in_key (add_key_in), .out_data (add_data), .rst (rstARK), .clk (clk));
 
	always @* begin
	 if(ready == 0) begin
    temp_round = round;
		temp_data[127:0] = in_data[127:0];
    temp_key[127:0] = in_key[127:0];
		  
		if(cnt == 0) begin
      //$display ("In Data= 0x%0h", temp_data);
			sub_in_data[127:0] = temp_data[127:0];
		end
    if(cnt == 1) begin
      shift_in_data = temp_sub_data;
      //$display ("Sub Data= 0x%0h", temp_sub_data);
      //temp_shift_data = shift_data;
	  end
    if(cnt == 2 && round == 0) begin
      //$display ("Shift Data= 0x%0h", temp_shift_data);
      mix_in_data = temp_shift_data;
    end
    if(cnt == 3) begin
      //$display ("Mix Data= 0x%0h", temp_mix_data);
      add_in_data = temp_mix_data;
      add_key_in = temp_key;
    end
    end
  end
	
	
	
	always @(posedge clk) begin
		if (rst == 1'h1) begin
			cnt <= 3'h0;
      ready <= 0;
      rstSB <= 1;
      rstSR <= 0;
      rstMC <= 0;
      rstARK <= 0;
		end
		else begin
      if(rstSB == 0) begin
         //$display ("ready= 0x%0h", readySB);
         //$display ("cnt= 0x%0h", cnt);
         
  			if(cnt == 0 && readySB == 1) begin
  				temp_sub_data <= sub_data;
          //$display ("Sub= 0x%0h", temp_sub_data);
  				cnt <= cnt + 1;
  				rstSB <= 1;
  			end
        if(cnt == 1) begin
          temp_shift_data <= shift_data;
          cnt <= cnt + 1;
        end
        if(cnt == 2 && temp_round == 0) begin
          temp_mix_data <= mix_data;
          cnt <= cnt + 1;
        end
        if(cnt == 2 && temp_round == 1) begin
          temp_mix_data <= temp_shift_data;
          cnt <= cnt + 1;
        end
        if(cnt == 3) begin
          temp_add_data <= add_data;
          ready <= 1;
          cnt <= cnt + 1;
        end
			end
      else begin
        rstSB <= 0;
      end
		end
  end
endmodule