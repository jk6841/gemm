`timescale 1ns / 1ps

module MultiplierArray
#(
    parameter INPUT_DATA_WIDTH = 32,
    parameter OUTPUT_DATA_WIDTH = 32,
    parameter NUM = 4
)
(
    input wire [2*NUM-1:0][INPUT_DATA_WIDTH-1:0] data_in,
    output logic [NUM-1:0][OUTPUT_DATA_WIDTH-1:0] data_out
);

    genvar i;
    generate
        for (i=0; i<NUM; i=i+1) begin : genMultiplier
            Multiplier
            #(
                .INPUT_DATA_WIDTH (INPUT_DATA_WIDTH),
                .OUTPUT_DATA_WIDTH (OUTPUT_DATA_WIDTH)
            )
            multiplier
            (
                .data0_in (data_in[i]),
                .data1_in (data_in[i+NUM]),
                .data_out (data_out[i])
            );
        end
    endgenerate
    
    

endmodule