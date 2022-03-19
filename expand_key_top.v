`include "expand_key.v"
module expand_key_top (in_key, full_expanded_key, ready, rst, clk);

	input clk;
	input rst;
	reg rstk;
	input wire [127:0] in_key;
	output wire [1407:0] full_expanded_key;
  output reg ready;	
 
	reg [1407:0] temp_full_expanded_key;
  reg [1407:0] final_full_expanded_key;
	reg [127:0] temp_key;
	
	reg [7:0] rcon_index;
	wire readyk;
	wire [127:0] expanded_key_out;
	
	reg [127:0] expanded_key_in;
  reg [3:0] cnt;

	
  expand_key EK0 (.key_in (expanded_key_in), .rcon_index (rcon_index), .key_out (expanded_key_out), .ready (readyk), .rst (rstk), .clk (clk));
 
 
 
	always @* begin
	  
  		temp_full_expanded_key[127:0] = in_key;
      if (cnt == 0) begin
        expanded_key_in[127:0] = temp_full_expanded_key[127:0];
        rcon_index = 8'h01;
      end
  		
      if (cnt == 1) begin
        expanded_key_in[127:0] = temp_full_expanded_key[255:128];
        rcon_index = 8'h02;
      end
      	
      if (cnt == 2) begin
        expanded_key_in[127:0] = temp_full_expanded_key[383:256];
        rcon_index = 8'h03;
      end	
     
      if (cnt == 3) begin
        expanded_key_in[127:0] = temp_full_expanded_key[511:384];
        rcon_index = 8'h04;
      end
      
      if (cnt == 4) begin
        expanded_key_in[127:0] = temp_full_expanded_key[639:512];
        rcon_index = 8'h05;
      end
  		
      if (cnt == 5) begin
        expanded_key_in[127:0] = temp_full_expanded_key[767:640];
        rcon_index  = 8'h06;
      end
      	
      if (cnt == 6) begin
        expanded_key_in[127:0] = temp_full_expanded_key[895:768];
        rcon_index = 8'h07;
      end	
     
      if (cnt == 7) begin
        expanded_key_in[127:0] = temp_full_expanded_key[1023:896];
        rcon_index = 8'h08;
      end
      
      if (cnt == 8) begin
        expanded_key_in[127:0] = temp_full_expanded_key[1151:1024];
        rcon_index = 8'h09;
      end
  		
      if (cnt == 9) begin
        expanded_key_in[127:0] = temp_full_expanded_key[1279:1152];
        rcon_index = 8'h0a;
      end
      
      if (cnt == 10) begin
        final_full_expanded_key[1407:0] = temp_full_expanded_key[1407:0];
      end
	 
  end
	
  assign full_expanded_key[1407:0] = final_full_expanded_key[1407:0];
 
 
  always @(posedge clk) begin
    if (rst == 1'h1) begin
      ready <= 0;
      rstk <= 1;
      cnt <= 3'h0;
    end
      else begin
        //$display ("rstk= 0x%0h", rstk);
        if (rstk == 0) begin
          if (ready == 0) begin  
          if (cnt == 0 && readyk == 1) begin
  		      temp_full_expanded_key[255:128] <= expanded_key_out[127:0]; 
            //$display ("Key1= 0x%0h", expanded_key_out[127:0]);         
            rstk <= 1;
            cnt <= cnt + 1;
          end
  		
          if (cnt == 1 && readyk == 1) begin
  		      temp_full_expanded_key[383:256] <= expanded_key_out[127:0];
            //$display ("Key2= 0x%0h", expanded_key_out[127:0]);        
            rstk <= 1;
            cnt <= cnt + 1;
  	      end
      	
          if (cnt == 2 && readyk == 1) begin
  		      temp_full_expanded_key[511:384] <= expanded_key_out[127:0];  
            //$display ("Key3= 0x%0h", expanded_key_out[127:0]);           
            rstk <= 1;
            cnt <= cnt + 1;
  	      end	
     
          if (cnt == 3 && readyk == 1) begin
  		      temp_full_expanded_key[639:512] <= expanded_key_out[127:0];      
            //$display ("Key4= 0x%0h", expanded_key_out[127:0]);    		
            rstk <= 1;
            cnt <= cnt + 1;
          end
          if (cnt == 4 && readyk == 1) begin
  		      temp_full_expanded_key[767:640] <= expanded_key_out[127:0]; 
            //$display ("Key5= 0x%0h", expanded_key_out[127:0]);         
            rstk <= 1;
            cnt <= cnt + 1;
          end
  		
          if (cnt == 5 && readyk == 1) begin
  		      temp_full_expanded_key[895:768] <= expanded_key_out[127:0];
           // $display ("Key6= 0x%0h", expanded_key_out[127:0]);          
            rstk <= 1;
            cnt <= cnt + 1;
  	      end
      	
          if (cnt == 6 && readyk == 1) begin
  		      temp_full_expanded_key[1023:896] <= expanded_key_out[127:0];
           //$display ("Key7= 0x%0h", expanded_key_out[127:0]);   	   
            rstk <= 1;
            cnt <= cnt + 1;
  	      end	
     
          if (cnt == 7 && readyk == 1) begin
  		      temp_full_expanded_key[1151:1024] <= expanded_key_out[127:0];
            //$display ("Key8= 0x%0h", expanded_key_out[127:0]);          
            rstk <= 1;
            cnt <= cnt + 1;
          end
          if (cnt == 8 && readyk == 1) begin
  		      temp_full_expanded_key[1279:1152] <= expanded_key_out[127:0];   
            //$display ("Key9= 0x%0h", expanded_key_out[127:0]);       
            rstk <= 1;
            cnt <= cnt + 1;
          end 
  		
          if (cnt == 9 && readyk == 1) begin
  		      temp_full_expanded_key[1407:1280] <= expanded_key_out[127:0];
            //$display ("Key10= 0x%0h", expanded_key_out[127:0]);
            rstk <= 1;
            cnt <= cnt + 1;
            ready <= 1;
  	      end
        end
        end
        else begin
          rstk <= 0;
        end
    end
  end
endmodule