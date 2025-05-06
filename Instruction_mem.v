module instr_mem (
     input [31:0] A,
     input reset ,
     output [31:0] RD
);
reg [31:0] mem [1023:0];

assign RD=(reset==1'b1)?32'h00000000: mem[A];
     
endmodule