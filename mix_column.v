module mix_column(data_in, data_out, rst, clk);
  input clk;
  input rst;
  
  input wire [127:0] data_in;
  output wire [127:0] data_out;
  
  reg [7:0] temp_f;
  reg [127:0] temp_o;
  
  reg [127:0] data_temp;
  
  assign data_out = data_temp;
  
  always @* begin
    
    data_temp = data_in;
    
    temp_o[7:0] = mult2(data_temp[7:0]) ^ mult3(data_temp[15:8]) ^ data_temp[23:16] ^ data_temp[31:24];
    temp_o[15:8] = data_temp[7:0] ^ mult2(data_temp[15:8]) ^ mult3(data_temp[23:16]) ^ data_temp[31:24];
    temp_o[23:16] = data_temp[7:0] ^ data_temp[15:8] ^ mult2(data_temp[23:16]) ^ mult3(data_temp[31:24]);
    temp_o[31:24] = mult3(data_temp[7:0]) ^ data_temp[15:8] ^ data_temp[23:16] ^ mult2(data_temp[31:24]);
    
    temp_o[39:32] = mult2(data_temp[39:32]) ^ mult3(data_temp[47:40]) ^ data_temp[55:48] ^ data_temp[63:56];
    temp_o[47:40] = data_temp[39:32] ^ mult2(data_temp[47:40]) ^ mult3(data_temp[55:48]) ^ data_temp[63:56];
    temp_o[55:48] = data_temp[39:32] ^ data_temp[47:40] ^ mult2(data_temp[55:48]) ^ mult3(data_temp[63:56]);
    temp_o[63:56] = mult3(data_temp[39:32]) ^ data_temp[47:40] ^ data_temp[55:48] ^ mult2(data_temp[63:56]);
    
    temp_o[71:64] = mult2(data_temp[71:64]) ^ mult3(data_temp[79:72]) ^ data_temp[87:80] ^ data_temp[95:88];
    temp_o[79:72] = data_temp[71:64] ^ mult2(data_temp[79:72]) ^ mult3(data_temp[87:80]) ^ data_temp[95:88];
    temp_o[87:80] = data_temp[71:64] ^ data_temp[79:72] ^ mult2(data_temp[87:80]) ^ mult3(data_temp[95:88]);
    temp_o[95:88] = mult3(data_temp[71:64]) ^ data_temp[79:72] ^ data_temp[87:80] ^ mult2(data_temp[95:88]);
    
    temp_o[103:96] = mult2(data_temp[103:96]) ^ mult3(data_temp[111:104]) ^ data_temp[119:112] ^ data_temp[127:120];
    temp_o[111:104] = data_temp[103:96] ^ mult2(data_temp[111:104]) ^ mult3(data_temp[119:112]) ^ data_temp[127:120];
    temp_o[119:112] = data_temp[103:96] ^ data_temp[111:104] ^ mult2(data_temp[119:112]) ^ mult3(data_temp[127:120]);
    temp_o[127:120] = mult3(data_temp[103:96]) ^ data_temp[111:104] ^ data_temp[119:112] ^ mult2(data_temp[127:120]);
    
    data_temp = temp_o;
    
  end
  
  

  function [7:0] mult2;
    input [7:0] d;
    begin
      temp_f = (d <<1) & 8'hff;
      if (d < 8'h80) begin
        mult2 = temp_f;
      end
      else begin
        mult2 = temp_f ^ 8'h1b;
      end
    end
  endfunction
  
  function [7:0] mult3;
    input [7:0] d;
    begin
      mult3 = (mult2(d) ^ d);
    end
  endfunction
  
endmodule