`timescale 1ns / 1ps

module AdderTree
#(
    parameter DATA_WIDTH = 32,
    parameter LAYER = 3
)
(
    input clk,
    input rst,
    input wire [(1<<LAYER)-1:0][DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);

    localparam WIRE_NUM = 2*((1<<(LAYER+1))-1);

    logic [WIRE_NUM-1:0][DATA_WIDTH-1:0] wires;

    genvar j;
    generate
        for (j=0; j < LAYER; j=j+1) begin
            if (j==0) begin
                FlipFlopArray
                #(
                    .DATA_WIDTH (DATA_WIDTH),
                    .NUM (1 << (LAYER-j))
                )
                flipFlopArray_Inst
                (
                    .clk (clk),
                    .rst (rst),
                    .enable (1'b1),
                    .data_in (data_in),
                    .data_out (wires[3*(1<<(LAYER-j))-5 : (1<<(LAYER+1-j))-4])
                );
            end
            else begin
                FlipFlopArray
                #(
                    .DATA_WIDTH (DATA_WIDTH),
                    .NUM (1 << (LAYER-j))
                )
                flipFlopArray_Inst
                (
                    .clk (clk),
                    .rst (rst),
                    .enable (1'b1),
                    .data_in (wires[(1<<(LAYER+2-j))-5 : 3*(1<<(LAYER-j))-4]),
                    .data_out (wires[3*(1<<(LAYER-j))-5 : (1<<(LAYER+1-j))-4])
                );
            end


            if (j==LAYER-1) begin
                AdderArray
                #(
                    .DATA_WIDTH (DATA_WIDTH),
                    .NUM (1<<(LAYER-1-j))
                )
                adderArray_Inst
                (
                    .data_in (wires[3*(1<<(LAYER-j))-5 : (1<<(LAYER+1-j))-4]),
                    .data_out (data_out)
                );
            end
            else begin
                AdderArray
                #(
                    .DATA_WIDTH (DATA_WIDTH),
                    .NUM (1 << (LAYER-1-j))
                )
                adderArray_Inst
                (
                    .data_in (wires[3*(1<<(LAYER-j))-5 : (1<<(LAYER+1-j))-4]),
                    .data_out (wires[(1<<(LAYER+1-j))-5 : 3*(1<<(LAYER-1-j))-4])
                );
            end

            
        end
    endgenerate

endmodule