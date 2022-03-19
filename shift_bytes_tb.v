`timescale 1ns / 1ps

module shift_rows_tb ();

  reg clk;
  reg rst;
  reg [127:0] data_in;
  wire [127:0] data_out;
  
  shift_rows SR (.data_in (data_in), .data_out (data_out), .rst (rst), .clk (clk));
  
  
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
    data_in = 128'hffffffff;
  end
  
endmodule