`timescale 1ns / 1ps

module add_round_key_tb ();

  reg clk;
  reg rst;
  reg [127:0] key_in;
  reg [127:0] data_in;
  wire [127:0] out_data;
  
  add_round_key ARK1 (.in_data (data_in), .in_key (key_in), .out_data (out_data), .rst (rst), .clk (clk));
  
  initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end
  
  initial begin
    rst = 1'b1;
      #10
    rst = 1'b0;
  end
  
  initial begin
    data_in = 128'hf0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0;
	  key_in  = 128'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f;
  end
  
endmodule