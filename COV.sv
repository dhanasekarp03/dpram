class dram_cov #(type T=dram_seq_item) extends uvm_subscriber #(T);
`uvm_component_utils(dram_cov)

T pkt;
 real i; 

covergroup Cg;	
  address : coverpoint pkt.add {
    bins a[] ={[0:63]};
  }
  data : coverpoint  pkt.data_in {
    bins d[] ={[0:255]};
  }
  
  write : coverpoint  pkt.wr {
    bins w[] ={[0:1]};
  }
  
  enable : coverpoint  pkt.en {
    bins e[] ={[0:1]};
  }
endgroup

function new (string name = "dram_cov", uvm_component parent);
      super.new (name, parent);
	  Cg = new;
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
	  
 function void write (T t);
	`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
	pkt = t;
	Cg.sample();
  $display("data=%d add=%d en=%d wr=%d coverage %%=%0.2f", t.data_in, t.add, t.en, t.wr, Cg.get_inst_coverage());
endfunction
  
  
 function void extract_phase(uvm_phase phase);
super.extract_phase(phase);
i=Cg.get_coverage();
endfunction
  
 function void report_phase(uvm_phase phase);
super.report_phase(phase);
`uvm_info(get_type_name(),$sformatf("Coverage is
%f",i),UVM_MEDIUM)
endfunction

endclass