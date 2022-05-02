//`timescale 1ns / 1ps

module AES_top_tb ();

  reg clk;
  reg rst;
  reg [127:0] key_in;
  reg [127:0] data_in;
  reg round;
  wire [127:0] out_data;
  wire ready;
  reg flag = 0;
  AES_top_final AES1 (.data_in (data_in), .key_in (key_in), .out_data (out_data), .ready (ready), .rst (rst), .clk (clk));
  
  
  initial begin
    clk = 1'b0;
    forever #7.5 clk = ~clk;
  end
  
  initial begin
      //#100
    rst = 1'b1;
      #10
    rst = 1'b0;
    
  end
  
  initial begin
    data_in = 128'h0c0d0e0f08090a0b0405060700010203;
 	// key_in =  128'h2b7e1516 28aed2a6 abf71588 09cf4f3c;
    key_in =  128'h0c0d0e0f08090a0b0405060700010203;
    round = 1;
  end
  
  always @(posedge clk) begin
    if (ready == 1 && flag == 0) begin
     $display ("Cipher = 0x%0h", out_data[127:0]);
     flag = 1;
    end
  end
  
endmodule