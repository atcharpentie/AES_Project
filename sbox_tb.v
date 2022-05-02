`timescale 1ns / 1ps

module sbox_tb ();

  reg clk;
  reg [7:0] data_in;
  wire [7:0] data_out;
  
  sbox SB (.select (data_in), .s_out (data_out), .clk (clk));
  
  initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
  end
  
  initial begin
    data_in = 8'hff;
  end
  
endmodule