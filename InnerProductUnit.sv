`timescale 1ns / 1ps

module InnerProductUnit
#(
    parameter INPUT_DATA_WIDTH = 32,
    parameter OUTPUT_DATA_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter VECTOR_LEN = 32
)
(
    input wire clk,
    input wire rst,

    input wire [2*VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] data_in,
    output logic [OUTPUT_DATA_WIDTH-1:0] data_out

);

    logic [VECTOR_LEN-1:0][DATA_WIDTH-1:0] wires;


    MultiplierArray
    #(
        .INPUT_DATA_WIDTH (INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH (OUTPUT_DATA_WIDTH),
        .NUM (VECTOR_LEN)
    )
    multiplierArray
    (
        .data_in (data_in),
        .data_out (wires[VECTOR_LEN-1:0])
    );

    AdderTree
    #(
        .DATA_WIDTH (DATA_WIDTH),
        .LAYER ($clog2(VECTOR_LEN))
    )
    adderTree
    (
        .clk (clk),
        .rst (rst),
        .data_in (wires[VECTOR_LEN-1:0]),
        .data_out (data_out)
    );    

endmodule