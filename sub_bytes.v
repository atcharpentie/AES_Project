
module sub_bytes (data_in, data_out, ready, rst, clk);

  input clk;
  input rst;
  
  input [127:0] data_in;
  output wire [127:0] data_out;
  output reg ready;
  
  reg [127:0] temp_data;
  reg [7:0] sbox_s;
  wire [7:0] sbox_o;
  reg [127:0] temp_o;
  reg [127:0] ready_out;
  reg flag;
  reg [3:0] cnt;
  
  sbox SB1 (.select (sbox_s), .s_out (sbox_o), .clk (clk)); 
  
  always @* begin
  
      temp_data = data_in;
      //$display ("Cnt= 0x%0h", cnt);
      if (cnt == 0) begin
   	    sbox_s[7:0] = temp_data[7:0];
      end
  		
      if (cnt == 1) begin
    		sbox_s[7:0] = temp_data[15:8];
  	  end
      	
      if (cnt == 2) begin
	      sbox_s[7:0] = temp_data[23:16];
  	  end	
     
      if (cnt == 3) begin
  		  sbox_s[7:0] = temp_data[31:24];
      end
      
      if (cnt == 4) begin
   	    sbox_s[7:0] = temp_data[39:32];
      end
  		
      if (cnt == 5) begin
    		sbox_s[7:0] = temp_data[47:40];
  	  end
      	
      if (cnt == 6) begin
	      sbox_s[7:0] = temp_data[55:48];
  	  end	
     
      if (cnt == 7) begin
  		  sbox_s[7:0] = temp_data[63:56];
      end
      
      if (cnt == 8) begin
   	    sbox_s[7:0] = temp_data[71:64];
      end
  		
      if (cnt == 9) begin
    		sbox_s[7:0] = temp_data[79:72];
  	  end
      	
      if (cnt == 10) begin
	      sbox_s[7:0] = temp_data[87:80];
  	  end	
     
      if (cnt == 11) begin
  		  sbox_s[7:0] = temp_data[95:88];
      end
      
      if (cnt == 12) begin
   	    sbox_s[7:0] = temp_data[103:96];
      end
  		
      if (cnt == 13) begin
    		sbox_s[7:0] = temp_data[111:104];
  	  end
      	
      if (cnt == 14) begin
	      sbox_s[7:0] = temp_data[119:112];
  	  end	
     
      if (cnt == 15) begin
  		  sbox_s[7:0] = temp_data[127:120];
      end
      
      if(flag == 1) begin
        ready_out = temp_o;
		  end
  end
  
  assign data_out = ready_out;
  
  always @(posedge clk) begin
    if (rst == 1'h1) begin
      cnt <= 2'h0;
      ready <= 1'h0;
      temp_data <= 0;
      flag <= 0;
    end
      else begin
        if (cnt == 0) begin
		      temp_o[7:0] <= sbox_o[7:0];
        end
		
        if (cnt == 1) begin
		      temp_o[15:8] <= sbox_o[7:0];
	      end
    	
        if (cnt == 2) begin
		      temp_o[23:16] <= sbox_o[7:0];
	      end
             
        if (cnt == 3) begin
		      temp_o[31:24] <= sbox_o[7:0];
        end
		
        if (cnt == 4) begin
		      temp_o[39:32] <= sbox_o[7:0];
	      end
    	
        if (cnt == 5) begin
		      temp_o[47:40] <= sbox_o[7:0];
	      end
             
        if (cnt == 6) begin
		      temp_o[55:48] <= sbox_o[7:0];
        end
		
        if (cnt == 7) begin
		      temp_o[63:56] <= sbox_o[7:0];
	      end
    	
        if (cnt == 8) begin
		      temp_o[71:64] <= sbox_o[7:0];
	      end
             
        if (cnt == 9) begin
		      temp_o[79:72] <= sbox_o[7:0];
        end
		
        if (cnt == 10) begin
		      temp_o[87:80] <= sbox_o[7:0];
	      end
    	
        if (cnt == 11) begin
		      temp_o[95:88] <= sbox_o[7:0];
	      end
             
        if (cnt == 12) begin
		      temp_o[103:96] <= sbox_o[7:0];
	      end
             
        if (cnt == 13) begin
		      temp_o[111:104] <= sbox_o[7:0];
        end
		
        if (cnt == 14) begin
		      temp_o[119:112] <= sbox_o[7:0];
	      end
   
        if (cnt == 15) begin
		      temp_o[127:120] <= sbox_o[7:0];
          flag <= 1'h1;
          ready <= 1'h1;
        end
        //$display ("Rdy= 0x%0h", ready);
      cnt <= cnt + 1;
    end
  end
endmodule