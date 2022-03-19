`timescale 1ns / 1ps

module expand_key_top_tb ();

  reg clk;
  reg rst;
  reg [127:0] key_in;
  wire ready;
  wire [1407:0] full_expanded_key;
  
  expand_key_top EKT1 (.in_key (key_in), .full_expanded_key (full_expanded_key), .ready (ready), .rst (rst), .clk (clk));
  
  initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end
  
  //initial begin
  //  rst = 1'b1;
  //    #10
  //  rst = 1'b0;
  //end
  
  initial begin
    key_in = 128'h0c0d0e0f08090a0b0405060700010203;
  end
  
endmodule