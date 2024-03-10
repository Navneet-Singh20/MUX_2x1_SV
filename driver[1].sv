class driver;
  
  //virtual interface
  virtual intf vif;
  
  //mailbox
  mailbox gen2driv;
  
  function new(mailbox gen2driv, virtual intf vif);
    this.gen2driv = gen2driv;
    this.vif      = vif;
  endfunction
  
  task run_reset;
    $display("running reset task");
    wait(vif.rst);
    vif.i0 <= 0;
    vif.i1 <= 0;
    vif.sel <= 0;
    wait(!vif.rst);
    $display("Completed reset task");
  endtask
  
  task body;
    forever begin
      transaction pkt;
      gen2driv.get(pkt);
      //@(posedge vif.clk);
      pkt.display("Driver");
      vif.i0 <= pkt.i0;
      vif.i1 <= pkt.i1;
      vif.sel <= pkt.sel;
      $display($time," Driver : i0 = %b, i1 = %b, sel = %b",pkt.i0,pkt.i1,pkt.sel);
      @(posedge vif.clk);
    end
  endtask
  
endclass
  
  