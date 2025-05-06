`include "PC.v"
`include "Instruction_mem.v"
`include "reg_file.v"
`include "sign_extend.v"
`include "ALU.v"
`include "Control_unit_top.v"
`include "data_mem.v"
`include "PC_adder.v"
module single_cycle_top (clk,rst);
     input clk,rst
// creating intermediate wires between components

     wire [31:0] PC_top, RD_instruct,RD1_top,Imm_ext_top,ALUControl_top,ALU_result,ReadData,PC_adder,PCplus4;
     wire RegWrite;
     
//instantiating Program counter
     P_C P_C_inst(
          .clk(clk),
          .rst(rst),
          .pc(PC_top),
          .pc_next(PCplus4)
     );
     //instantiating adder mux
     PC_adder PC_adder_inst(
          .a(PC),
          .b(32'd4),
          .c(PCplus4)
     );
// instantiating instruction memory
     Instruction_mem instr_mem(
          .A(PC_top),
          .rst(rst), 
          .RD(RD_instruct) 
     );
// instantiating register file
     reg_file reg_file_inst(
          .clk(clk),
          .rst(rst),
          .WE3(RegWrite),
          .A1(RD_instruct[19:15]),
          .A2(),
          .A3(RD_instruct[11:7]),
          .WD3(ReadData),
          .RD1(RD1_top),
          .RD2()
     );1

     // instantiating sign_extend 

     sign_extend sign_extend_inst(
          .In(RD_instruct),
          .Imm_ext(Imm_ext_top)
     );
     // Instantiating ALU
     ALU ALU_inst(
          .A(RD1_top), 
          .B(Imm_ext_top), 
          .Result(ALU_result),
          .ALUControl(ALUControl_top), 
          .OverFlow(), 
          .Carry(), 
          .Zero(), 
          .Negative()
     );

     // instantiating Control unit top
     Control_unit_top Control_unit_top(
          .Op(RD_instruct[6:0]),
          .funct7(),
          .funct3(RD_instruct[14:12]),
          .RegWrite(RegWrite),
          .PCsrc(),
          .ResultSrc(), 
          .Memwrite(), 
          .ALUSrc(), 
           .Branch(),
          .ImmSrc(),
          .ALUControl(ALUControl_top)
     );
//instantiating data memory

     data_mem data_mem(
          .clk(clk),
          .rst(rst),
          .WE(),
          .WD(),
          .RD(ReadData),
          .A(ALU_result)

     );

     
endmodule

module single_cycle_tb();
reg clk=1'b1,rst;
single_cycle_top uut(
          .rst(rst),
          .clk(clk)
);
     
initial begin
     $dumpfile("single_cycle.vcd");
     $dumpvars(0,single_cycle_tb);
end

always  begin
     #50  clk=~clk;
      
end

initial begin
     rst=1'b0;
     #150;

     rst=1'b1;
     #500;
     $finish;
end
endmodule