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

    input wire [VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] vec0_in,
    input wire [VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] vec1_in,
    
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
        .data_in ({vec1_in, vec0_in}),
        .data_out (wires)
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
        .data_in (wires),
        .data_out (data_out)
    );    

endmodule