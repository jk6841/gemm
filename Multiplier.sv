`timescale 1ns / 1ps

module Multiplier
#(
    parameter INPUT_DATA_WIDTH = 32,
    parameter OUTPUT_DATA_WIDTH = 32
)
(
    input wire [INPUT_DATA_WIDTH-1:0] data0_in,
    input wire [INPUT_DATA_WIDTH-1:0] data1_in,
    output logic [OUTPUT_DATA_WIDTH-1:0] data_out
);

    always_comb begin
        data_out = data0_in * data1_in;
    end

endmodule