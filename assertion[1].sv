//Assertion

module assertion_m(input i0,
              input i1,
              input sel,
              input clk,
              input rst,
              input y);
  
  always@(posedge clk) begin
    //Immediate Assertion
    assert(sel) begin $display("hello"); end else begin $display("fello"); end
    //By default it will throw error
    assert(i0);
  end
  
  //Concurrent Assertion
  always@(posedge clk) begin
    assert property(@(posedge clk) (i0||i1));
    
    //with seq. & property block
      assert property(@(posedge clk) p);
        
    //Implication Operator 
        //->> Overlapping Operator
        assert property(@(posedge clk) (i0 |-> i1));
          
        //->> Non-overlapping Operator
        assert property(@(posedge clk) (i0 |=> i1));
          
     //With DISABLE IFF
          assert property(p1);
  end
      
  //with seq
  sequence s1;
    i0;
  endsequence
      
  sequence s2;
    i1;
  endsequence
      
  property p;
    s1 ##1 s2;
  endproperty
            
  //With DISABLE IFF          
  property p1;
    @(posedge clk)
    disable iff (rst) not (i0 || i1);
  endproperty
  
endmodule