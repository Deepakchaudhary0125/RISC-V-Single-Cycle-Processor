module data_memo (
     input rst,clk,WE,
     input [31:0] A,WD,
     output [31:0] RD
);
// Memory creation 
reg[31:0] data_memory[31:0];
// Read Operation
assign RD=(WE==1'b0)? data_memory[A]: 32'h00000000;

// Write Operation
always @(posedge clk) begin
     if(WE) begin
          data_memory[A]<=WD;
     end
end
     
endmodule