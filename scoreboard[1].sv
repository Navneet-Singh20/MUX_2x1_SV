class scoreboard;
  
  int no_pkt_sb;
  
  //mailbox
  mailbox mon2sb;
  
  function new(mailbox mon2sb);
    this.mon2sb = mon2sb;
  endfunction
  
  task body;
    forever begin
      transaction pkt;
      mon2sb.get(pkt);
      if(pkt.y == (pkt.sel?pkt.i0:pkt.i1)) begin
        $display("Data Matched");
        $display($time," SB : i0 = %b, i1 = %b, sel = %b, y =%b",pkt.i0,pkt.i1,pkt.sel,pkt.y);
      end else begin
        $error("Data Mis-Matched");
        $display(" SB : i0 = %b, i1 = %b, sel = %b, y =%b",pkt.i0,pkt.i1,pkt.sel,pkt.y);
      end
      no_pkt_sb++;
    end
  endtask
  
endclass
    
      