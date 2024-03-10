class generator;
  
  int no_pkt_gen;
  
  mailbox gen2driv;
  
  rand transaction pkt;
  
  event gen_ended;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task body;
    repeat(no_pkt_gen) begin
      pkt = new();
      assert(!pkt.randomize());
      pkt.display("Generator");
      $display(" Generator : i0 = %b, i1 = %b, sel = %b",pkt.i0,pkt.i1,pkt.sel);
      gen2driv.put(pkt);
    end
    -> gen_ended;
  endtask
  
endclass
    
      
  