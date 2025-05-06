module reg_file (
     input [4:0] A1, A2, A3,
     input clk, rst,
     input WE3,
     input [31:0] WD3,
     output [31:0] RD1, RD2
);

    // Creating register file (32 registers of 32-bit each)
    reg [31:0] Register [31:0];

    // Read operations
    assign RD1 = (rst == 1'b0) ? Register[A1] : 32'h00000000;
    assign RD2 = (rst == 1'b0) ? Register[A2] : 32'h00000000;

    // Write operation on rising edge
    always @(posedge clk) begin
        if (WE3 && rst == 1'b0) begin
            Register[A3] <= WD3;
        end
    end

endmodule
