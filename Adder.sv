`timescale 1ns / 1ps

module Adder
#(
    parameter DATA_WIDTH = 32
)
(
    input wire [DATA_WIDTH-1:0] data0_in,
    input wire [DATA_WIDTH-1:0] data1_in,
    output logic [DATA_WIDTH-1:0] data_out
);

    always_comb begin
        data_out = data0_in + data1_in;
    end

endmodule