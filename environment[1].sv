`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  transaction trans;
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard sb;
  
  //virtual interface
  virtual intf vif;
  
  //mailbox
  mailbox gen2driv;
  mailbox mon2sb;
  
  function new(virtual intf vif);
    this.vif = vif;
    gen2driv = new();
    mon2sb   = new();
    gen      = new(gen2driv);
    driv     = new(gen2driv,vif);
    mon		 = new(mon2sb,vif);
    sb		 = new(mon2sb);
  endfunction
  
  task pre_run;
    driv.run_reset;
  endtask
  
  task mid_run;
    fork
      gen.body;
      driv.body;
      mon.body;
      sb.body;
    join_any
  endtask
  
  task post_run;
    wait(gen.gen_ended.triggered);
    wait(gen.no_pkt_gen == sb.no_pkt_sb);
  endtask
  
  task run;
    pre_run();
    mid_run();
    post_run();
    $finish;
  endtask
  
endclass
  