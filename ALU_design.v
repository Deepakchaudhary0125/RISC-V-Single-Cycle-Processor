module ALU_design (
     input [31:0] a,
     input [31:0] b,
     input [2:0] alu_control,
     output [31:0] result
);
//assigning gate wires
wire [31:0] a_and_b;
wire [31:0] a_or_b;
wire [31:0] not_b;
wire cout;
wire carry;
wire  Z,N,V,C;

//assigning muxes
wire [31:0] mux_1;
wire [31:0] mux_2;
wire [31:0] sum;
wire [31:0] xor_1;
wire [31:0] xor_not;
wire [31:0] slt;

assign a_and_b = a & b;
assign a_or_b = a | b;
assign not_b= ~b;

// Finding cout 
assign {cout,sum} = a + mux_1 + alu_control[0];

// zero extension
assign slt={31'b0000000000000000000000000000000, sum[31]};

// Mux 1
assign mux_1 = (alu_control[0]==1'b0)? b: not_b;
// MUX 2
assign mux_2 = (alu_control[2:0]==3'b000)? sum:
               (alu_control[2:0]==3'b001) ? sum:
               (alu_control[2:0]==3'b010) ? a_and_b:
               (alu_control[2:0]==3'b011)? a_or_b:
               (alu_control[2:0]==3'b101)? slt: 32'h0; 

assign carry=(~ alu_control[1]) & cout;
assign xor_1= sum[31] ^ a[31];
assign xor_not= ~(a[31] ^ b[31] ^ alu_control[0]);

// Flags Assignment
assign Z= &(~result);
assign N= result[31];
assign C= cout & alu_control[1];
assign V = xor_not & xor_1 & ~(alu_control[1]); 

assign result = mux_2;

     
endmodule