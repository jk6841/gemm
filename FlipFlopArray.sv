`timescale 1ns / 1ps

module FlipFlopArray
#(
    parameter DATA_WIDTH = 32,
    parameter NUM = 4
)
(
    input wire clk,
    input wire rst,
    input wire enable,
    input wire [NUM-1:0][DATA_WIDTH-1:0] data_in,
    output logic [NUM-1:0][DATA_WIDTH-1:0] data_out
);

    genvar i;
    generate
        for (i=0; i<NUM; i=i+1) begin : genFlipFlop
            FlipFlop
            #(
                .DATA_WIDTH (DATA_WIDTH)
            )
            flipFlop
            (
                .clk (clk),
                .rst (rst),
                .enable (enable),
                .data_in (data_in[i]),
                .data_out (data_out[i])
            );
        end
    endgenerate
    
endmodule