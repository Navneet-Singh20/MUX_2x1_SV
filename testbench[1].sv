// Code your testbench here
// or browse Examples

//Interface
`include "interface.sv"
`include "test.sv"
`include "coverage.sv"
`include "assertion.sv"

module tb;
  
  bit clk;
  bit rst;
  
  //instance of interface
  intf inf0(clk,rst);
  
  //program block
  test pb(inf0);
  
  //DUT
  mux2x1 DUT(.i0(inf0.i0),.i1(inf0.i1),.sel(inf0.sel),.clk(inf0.clk),.rst(inf0.rst),.y(inf0.y));
  
  //Coverage instance
  coverage_m cov_c(.i0(inf0.i0),.i1(inf0.i1),.sel(inf0.sel),.clk(inf0.clk),.rst(inf0.rst),.y(inf0.y));
  
  //Assertion instance
  assertion_m ass_c(.i0(inf0.i0),.i1(inf0.i1),.sel(inf0.sel),.clk(inf0.clk),.rst(inf0.rst),.y(inf0.y));
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    rst = 1;
    #9;
    rst = 0;
  end
  
endmodule
  
  
  
  