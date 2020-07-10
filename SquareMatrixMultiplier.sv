`timescale 1ns / 1ps

module SquareMatrixMultiplier
#(
    parameter INPUT_DATA_WIDTH = 32,
    parameter OUTPUT_DATA_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter SIZE = 4
)
(
    input wire clk,
    input wire rst,

    input wire [SIZE-1:0][SIZE-1:0][INPUT_DATA_WIDTH-1:0] data0_in,
    input wire [SIZE-1:0][SIZE-1:0][INPUT_DATA_WIDTH-1:0] data1_in,

    output logic [SIZE-1:0][SIZE-1:0][OUTPUT_DATA_WIDTH-1:0] data_out
);
   
    for (genvar i=0; i<SIZE; i++) begin
        InnerProduct1DArray
        #(
            .INPUT_DATA_WIDTH (INPUT_DATA_WIDTH),
            .OUTPUT_DATA_WIDTH (OUTPUT_DATA_WIDTH),
            .DATA_WIDTH (DATA_WIDTH),
            .VECTOR_LEN (SIZE),
            .NUM (SIZE)
        )
        innerProduct1DArray_tb
        (
            .clk (clk),
            .rst (rst),
            .data0_in (data0_in[i]),
            .data1_in (data1_in),
            .data_out (data_out[i])
        );
    end
    
endmodule