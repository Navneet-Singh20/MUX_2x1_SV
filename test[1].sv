`include "environment.sv"

program test(intf intf0);
  
  environment env;
  
  initial begin
    env = new(intf0);
    env.gen.no_pkt_gen = 10;
    env.run();
  end
  
endprogram