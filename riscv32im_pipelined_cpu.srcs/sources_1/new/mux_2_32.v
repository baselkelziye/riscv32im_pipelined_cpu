`timescale 1ns / 1ps



module mux_2_32(
    input [31:0]in0_i,
    input [31:0]in1_i,
    input sel_i,
    output reg [31:0]out_o
    );
        
    always @ (in0_i or in1_i or sel_i) begin 
    case(sel_i)
    1'b0: 
        out_o = in0_i;
    1'b1: 
        out_o = in1_i;
    endcase
    end
    
endmodule
