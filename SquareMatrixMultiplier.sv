`timescale 1ns / 1ps

module SquareMatrixMultiplier
#(
    parameter INPUT_DATA_WIDTH = 512,
    parameter OUTPUT_DATA_WIDTH = 512,
    parameter DATA_WIDTH = 32,
    parameter SIZE = 4
)
(
    input wire clk,
    input wire rst,

    input wire ce,
    input wire we,

    input wire [INPUT_DATA_WIDTH-1:0] data0_in,
    input wire [INPUT_DATA_WIDTH-1:0] data1_in,

    output logic [OUTPUT_DATA_WIDTH-1:0] data_out
);

    logic we0;
    logic we1;

    logic [INPUT_DATA_WIDTH-1:0] buf_row;
    logic [INPUT_DATA_WIDTH-1:0] buf_column;
    logic [OUTPUT_DATA_WIDTH-1:0] buf_out;

    always_comb begin
        we0 = we;
        we1 = we;
        data_out = buf_out;
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            buf_row <= {INPUT_DATA_WIDTH{1'b0}};
            buf_column <= {INPUT_DATA_WIDTH{1'b0}};
        end
        else begin
            buf_row <= data0_in;
            buf_column <= data1_in;
        end
    end


    /*generate
        for (genvar i=0; i<SIZE; i=i+1) begin : genbuf

            Buffer
            #(
                .BUFFER_WIDTH (INPUT_DATA_WIDTH)
            )
            bufferRow
            (
                .clk (clk),
                .rst (rst),
                .ce (ce),
                .we (we0),
                .data_in (data0_in),
                .data_out (buf_row)
            );
            
            Buffer
            #(
                .BUFFER_WIDTH (INPUT_DATA_WIDTH)
            )
            bufferColumn
            (
                .clk (clk),
                .rst (rst),
                .ce (ce),
                .we (we1),
                .data_in (data1_in),
                .data_out (buf_column)
            );
            
        end
    endgenerate*/

    generate
        for (genvar i=0; i<SIZE; i++) begin : geninnerproduct
            for (genvar j=0; j<SIZE;j=j+1) begin
                InnerProductUnit
                #(
                    .INPUT_DATA_WIDTH (DATA_WIDTH),
                    .OUTPUT_DATA_WIDTH (DATA_WIDTH),
                    .DATA_WIDTH (DATA_WIDTH),
                    .VECTOR_LEN (SIZE)
                )
                innerProudctUnit_inst
                (
                    .clk (clk),
                    .rst (rst),
                    .vec0_in (buf_row[DATA_WIDTH*SIZE*(i+1)-1:DATA_WIDTH*SIZE*i]),
                    .vec1_in (buf_column[DATA_WIDTH*SIZE*(j+1)-1:DATA_WIDTH*SIZE*j]),
                    .data_out (buf_out[DATA_WIDTH*(SIZE*i+j+1)-1 : DATA_WIDTH*(SIZE*i+j)])
                );
            end
        end
    endgenerate

endmodule