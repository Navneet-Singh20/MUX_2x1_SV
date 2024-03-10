class transaction;
  rand bit i0;
  rand bit i1;
  rand bit sel;
  bit y;
  
  function display(string str="transaction class");
    $display("Inside the %s class",str);
  endfunction
  
endclass