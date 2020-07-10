`timescale 1ns / 1ps

module FlipFlop
#(
    parameter DATA_WIDTH = 32
)
(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);

    logic [DATA_WIDTH-1:0] ff_ff;

    always @(posedge clk) begin
        ff_ff <= rst? {DATA_WIDTH{1'b0}} : enable? data_in : ff_ff;
    end
    
    always_comb begin
        data_out = ff_ff;
    end
    
endmodule