`timescale 1ns / 1ps

module round_tb ();

  reg clk;
  reg rst;
  reg [127:0] key_in;
  reg [127:0] data_in;
  reg round;
  wire [127:0] out_data;
  wire ready;
  
  round R1 (.in_data (data_in), .in_key (key_in), .round(round), .out_data (out_data), .ready (ready), .rst (rst), .clk (clk));
  
  
  initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end
  
  initial begin
      #100
    rst = 1'b1;
      #10
    rst = 1'b0;
    data_in = 128'h00000000000000000000000000000000;
  end
  
  initial begin
    data_in = 128'h0f0e0d0c0b0a09080706050403020100;
	  key_in =  128'hffffffffffffffffffffffffffffffff;
    round = 1;
  end
  
endmodule