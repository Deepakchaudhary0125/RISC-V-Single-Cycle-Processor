`include "AlU_decoder.v"
`include "main_decoder.v"

module Control_unit_top (
     input [6:0] Op,funct7,
     input[2:0]funct3,
     output RegWrite,PCsrc,ResultSrc, Memwrite, ALUSrc, Branch,
     output[1:0]ImmSrc,
     output[2:0] ALUControl

);
wire [1:0] ALUOp;
main_decoder main_decoder(
          .OP(OP),
          .RegWrite(RegWrite),
          .ImmSrc(ImmSrc),
          .MemWrite(MemWrite),
          .ResultSrc(ResultSrc),
          .Branch(Branch),
          .ALUSrc(ALUSrc),
          .ALUOp(ALUOp)
);
ALU_decode ALU_decoder(
          .funct3(funct3),
          .ALUOp(ALUOp),
          .funct7(funct7),
          .Op(Op)
          .ALUControl(ALUControl)

);
     
endmodule