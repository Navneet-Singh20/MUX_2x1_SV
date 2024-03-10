// Code your design here
module mux2x1(input i0,
              input i1,
              input sel,
              input clk,
              input rst,
              output reg y);
  
  always@(posedge clk, posedge rst)
    begin
      if(rst) begin
        y <= 0;
      end else begin
        y <= sel?i0:i1;
      end
    end
  
endmodule