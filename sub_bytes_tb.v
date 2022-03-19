`timescale 1ns / 1ps

module sub_bytes_tb ();

  reg clk;
  reg rst;
  reg [127:0] data_in;
  wire [127:0] data_out;
  wire ready;
  
  sub_bytes SB (.data_in (data_in), .data_out (data_out), .ready (ready), .rst (rst), .clk (clk));
  
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
    data_in = 128'hffffffffffffffffffffffffffffffff;
  end
  
endmodule