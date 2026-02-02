module SYNC_FIFO ( data_out, empty, full, clk, reset, data_in, wr_enb, rd_enb);
 parameter addr_size = 4, word_size = 8, mem_size = 16;
 input clk, reset, wr_enb, rd_enb;
 input [word_size - 1 : 0] data_in;
 output reg [word_size -1 : 0 ] data_out;
 output reg full, empty;
 
 reg [addr_size-1 : 0] rptr, wptr;
 reg [word_size-1 : 0] mem [mem_size-1 : 0];

//write logic 
 always @(posedge clk) begin
   if (reset) begin
     wptr <=0;
    end
   else begin
     if(wr_enb & !full) begin 
      mem [wptr] <= data_in;
      wptr <= wptr +1;
     end
    end
  end

//read logic
 always @(posedge clk) begin
   if(reset) begin 
    rptr <= 0;
   end 
   else begin 
    if (rd_enb & !empty) begin
     data_out <= mem [rptr];
     rptr <= rptr +1;
    end
   end
  end

//full and empty logic 
 always @(posedge clk) begin
  if (reset) begin
    full <= 1'b0;
    empty <= 1'b1;
   end
  else begin 
    full <= ((wptr+1) == rptr);
    empty <= (wptr == rptr);
  end 
 end 
endmodule 


