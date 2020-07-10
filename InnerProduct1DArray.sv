`timescale 1ns / 1ps

module InnerProduct1DArray
#(
    parameter INPUT_DATA_WIDTH = 32,
    parameter OUTPUT_DATA_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter VECTOR_LEN = 32,
    parameter NUM = 4
)
(
    input wire clk,
    input wire rst,

    input wire [VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] data0_in,
    input wire [NUM-1:0][VECTOR_LEN-1:0][INPUT_DATA_WIDTH-1:0] data1_in,

    output logic [NUM-1:0][OUTPUT_DATA_WIDTH-1:0] data_out

);


    generate
        for (genvar j=0; j<NUM; j=j+1) begin
            InnerProductUnit
            #(
                .INPUT_DATA_WIDTH (INPUT_DATA_WIDTH),
                .OUTPUT_DATA_WIDTH (OUTPUT_DATA_WIDTH),
                .DATA_WIDTH (DATA_WIDTH),
                .VECTOR_LEN (VECTOR_LEN)
            )
            innnerProudctUnit
            (
                .clk (clk),
                .rst (rst),
                .vec0_in (data0_in),
                .vec1_in (data1_in[j]),
                .data_out (data_out[j])
            );
        end
    endgenerate



endmodule