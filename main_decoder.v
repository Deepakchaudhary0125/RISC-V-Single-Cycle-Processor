module main_decoder (
     input Zero,
     input [6:0] Op,
     output PCsrc,ResultSrc, Memwrite, ALUSrc,RegWrite,
     output [2:0]ImmSrc,ALUOp
     
);
wire [6:0]Branch;
     
assign RegWrite=(Op==7'b0000011 ||Op==7'b0110011 ) ? 1'b1: 1'b0;

assign ImmSrc= (Op==7'b0100011)? 2'b01:
               (Op==7'b1100011)? 2'b10: 2'b00;

assign ALUSrc=(Op==7'b0000011 || Op==7'b0100011)? 1'b1: 1'b0;

assign MemWrite=(Op==7'b0100011)?1'b1: 1'b0;

assign ResultSrc=(Op==7'b0000011)? 1'b1:1'b0;

assign Branch=(Op==7'b1100011)?1'b1:1'b0;

assign ALUOp=(Op==7'b0110011)?2'b10: (Op==7'b1100011)? 2'b01: 2'b00;

assign PCSrc= Zero & Branch;

// assign ALU Decoder
endmodule