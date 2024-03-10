///Here you can also try coverage class, program block etc but verify it first
module coverage_m(input i0,
              input i1,
              input sel,
              input clk,
              input rst,
              input reg y);

//coverage
  covergroup cov @(posedge clk);
    coverpoint i0 { illegal_bins a1={0};} //it will throw error and ignore
    coverpoint i1 { ignore_bins a2={1};}  //it will not throw any error
    coverpoint sel;
    coverpoint y;
  endgroup
  
  initial begin
    cov cv = new();
    forever begin
      @(posedge clk);
    $display ("*** Functional Coverage = %.2f%% ***", cv.get_coverage());
    end
  end
  
endmodule