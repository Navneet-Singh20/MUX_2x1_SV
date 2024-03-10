class monitor;
  
  //virtual interface
  virtual intf vif;
  
  //mailbox
  mailbox mon2sb;
  
  transaction pkt;
  
  function new(mailbox mon2sb,virtual intf vif);
    this.mon2sb = mon2sb;
    this.vif    = vif;
  endfunction
  
  task body;
    forever begin
      pkt = new();
      //pkt.display("Monitor");
      @(posedge vif.clk);
      pkt.display("Monitor");
      pkt.i0 = vif.i0;
      pkt.i1 = vif.i1;
      pkt.sel = vif.sel;
      pkt.y = vif.y;
      $display($time," Monitor : i0 = %b, i1 = %b, sel = %b, y =%b",pkt.i0,pkt.i1,pkt.sel,pkt.y);
      mon2sb.put(pkt);
     // @(posedge vif.clk);
    end
  endtask
  
endclass
      