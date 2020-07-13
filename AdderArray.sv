`timescale 1ns / 1ps

module AdderArray
#(
    parameter DATA_WIDTH = 32,
    parameter NUM = 4
)
(
    input wire [2*NUM-1:0][DATA_WIDTH-1:0] data_in,
    output logic [NUM-1:0][DATA_WIDTH-1:0] data_out
);

    genvar i;
    generate
        for (i=0; i<NUM; i=i+1) begin : genAdder
            Adder
            #(
                .DATA_WIDTH (DATA_WIDTH)
            )
            adder
            (
                .data0_in (data_in[i]),
                .data1_in (data_in[i+NUM]),
                .data_out (data_out[i])
            );
        end
    endgenerate
    
    

endmodule