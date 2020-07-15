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
    input wire enable,

    input wire [VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] vec0_in,
    input wire [VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] vec1_in,
    
    output logic [OUTPUT_DATA_WIDTH-1:0] data_out

);
    
    localparam LAYER = $clog2(VECTOR_LEN);
    logic [1:0][VECTOR_LEN-1:0][DATA_WIDTH-1:0] wires;
   
    MultiplierArray
    #(
        .INPUT_DATA_WIDTH (INPUT_DATA_WIDTH),
        .OUTPUT_DATA_WIDTH (OUTPUT_DATA_WIDTH),
        .NUM (VECTOR_LEN)
    )
    multiplierArray
    (
        .data_in ({vec1_in, vec0_in}),
        .data_out (wires[0])
    );

    FlipFlopArray
    #(
        .DATA_WIDTH (DATA_WIDTH),
        .NUM (VECTOR_LEN)
    )
    flipFlopArray
    (
        .clk (clk),
        .rst (rst),
        .enable (enable),
        .data_in (wires[0]),
        .data_out (wires[1])
    );

    AdderTree
    #(
        .DATA_WIDTH (DATA_WIDTH),
        .LAYER (LAYER)
    )
    adderTree
    (
        .clk (clk),
        .rst (rst),
        .enable (enable),
        .data_in ({{(((1<<LAYER)-VECTOR_LEN)*DATA_WIDTH){1'b0}}, wires[1]}),
        .data_out (data_out)
    );    

endmodule