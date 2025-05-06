module sign_extend (
     input [31:0] In,
     output [31:0] Imm_ext
);
     
assign Imm_ext=(In[31])?{{20{1'b1}},In[31:20]}:
                         {{20{1'b0}},In[31:20]};
endmodule