`timescale 1ns / 1ps

module expand_key_tb ();

  reg clk;
  reg rst;
  wire ready; 
  reg [127:0] key_in;
  wire [7:0] rcon_index = 8'h01;
  wire [127:0] key_out;
  
  expand_key EK1 (.key_in (key_in), .rcon_index (rcon_index), .key_out (key_out), .ready (ready), .rst (rst), .clk (clk));
  
  initial begin
    clk = 1'b0;
    forever #2 clk = ~clk;
  end
  
  initial begin
      #40
    rst = 1'b1;
      #10
    rst = 1'b0;
  end
  
  initial begin
    key_in = 128'h0c0d0e0f08090a0b0405060700010203;
  end
  
endmodule