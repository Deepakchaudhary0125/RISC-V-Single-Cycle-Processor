module P_C (
output reg [31:0] pc,
input [31:0] pc_next,
input clk,reset

);

 always @(posedge clk) begin
     if(reset==1)begin
          pc<=32'h00000000;
     end
     else begin
          pc<=pc_next;
     end
 end
     
endmodule