
module sub_bytes (data_in, data_out, ready, rst, clk);

  input clk;
  input rst;
  
  input [127:0] data_in;
  output wire [127:0] data_out;
  output reg ready;
  
  reg [127:0] temp_data;
  
  reg [7:0] sbox_s1;
  wire [7:0] sbox_o1;
  reg [7:0] sbox_s2;
  wire [7:0] sbox_o2;
  reg [7:0] sbox_s3;
  wire [7:0] sbox_o3;
  reg [7:0] sbox_s4;
  wire [7:0] sbox_o4;
  
  reg [127:0] temp_o;
  reg [127:0] ready_out;
  reg flag;
  reg [3:0] cnt;
  
  sbox SB1 (.select (sbox_s1), .s_out (sbox_o1), .clk (clk));
  sbox SB2 (.select (sbox_s2), .s_out (sbox_o2), .clk (clk));
  sbox SB3 (.select (sbox_s3), .s_out (sbox_o3), .clk (clk));
  sbox SB4 (.select (sbox_s4), .s_out (sbox_o4), .clk (clk));
  
  always @* begin
  
      temp_data = data_in;
      //$display ("Cnt= 0x%0h", cnt);
      if (cnt == 0) begin
   	    sbox_s1[7:0] = temp_data[7:0];
        sbox_s2[7:0] = temp_data[15:8];
        sbox_s3[7:0] = temp_data[23:16];
        sbox_s4[7:0] = temp_data[31:24];
      end
  		
      if (cnt == 1) begin
    		sbox_s1[7:0] = temp_data[39:32];
       	sbox_s2[7:0] = temp_data[47:40];
        sbox_s3[7:0] = temp_data[55:48];
        sbox_s4[7:0] = temp_data[63:56];
  	  end
      	
      if (cnt == 2) begin
	      sbox_s1[7:0] = temp_data[71:64];
        sbox_s2[7:0] = temp_data[79:72];
        sbox_s3[7:0] = temp_data[87:80];
        sbox_s4[7:0] = temp_data[95:88];
  	  end	
     
      if (cnt == 3) begin
  		  sbox_s1[7:0] = temp_data[103:96];
        sbox_s2[7:0] = temp_data[111:104];
        sbox_s3[7:0] = temp_data[119:112];
        sbox_s4[7:0] = temp_data[127:120];
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
		      temp_o[7:0] <= sbox_o1[7:0];
          temp_o[15:8] <= sbox_o2[7:0];
          temp_o[23:16] <= sbox_o3[7:0];
          temp_o[31:24] <= sbox_o4[7:0];
        end
		
        if (cnt == 1) begin
		      temp_o[39:32] <= sbox_o1[7:0];
          temp_o[47:40] <= sbox_o2[7:0];      
          temp_o[55:48] <= sbox_o3[7:0];      
          temp_o[63:56] <= sbox_o4[7:0];      
	      end
    	
        if (cnt == 2) begin
		      temp_o[71:64] <= sbox_o1[7:0];
          temp_o[79:72] <= sbox_o2[7:0];
          temp_o[87:80] <= sbox_o3[7:0];
          temp_o[95:88] <= sbox_o4[7:0];   
	      end
             
        if (cnt == 3) begin
		      temp_o[103:96] <= sbox_o1[7:0];
          temp_o[111:104] <= sbox_o2[7:0];      
          temp_o[119:112] <= sbox_o3[7:0];      
          temp_o[127:120] <= sbox_o4[7:0];
          flag <= 1'h1;
          ready <= 1'h1;      
        end
      cnt <= cnt + 1;
    end
  end
endmodule