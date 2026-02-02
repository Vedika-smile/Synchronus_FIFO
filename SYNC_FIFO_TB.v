module SYNC_FIFO_TB;
 
 parameter addr_size = 4, word_size = 8, mem_size = 16;
 reg clk;
 reg reset;
 reg [word_size-1:0] data_in;
 reg wr_enb;
 reg rd_enb;
 wire [word_size-1 : 0] data_out;
 wire empty;
 wire full;
 

SYNC_FIFO fifo ( data_out, empty, full, clk, reset, data_in, wr_enb, rd_enb);
 
initial 
 begin
  $dumpfile("fifo.vcd");
  $dumpvars(0, SYNC_FIFO_TB);
 
  clk = 1'b0;
  reset = 1'b1;
  wr_enb = 1'b0;
  rd_enb = 1'b0;
  #10 reset = 1'b0;
  #200 $finish;

 end 

 always #5 clk = ~clk;

 initial 
  begin
   #12 wr_enb = 1'b1;
   data_in = 8'b00001111;
   #10 data_in = 8'b00011110;
   #10 data_in = 8'b01001100;
   #10 data_in = 8'b10001100;
   #10 rd_enb = 1'b1;

   
  end 

endmodule 
   


 
