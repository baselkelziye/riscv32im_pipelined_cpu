`timescale 1ns / 1ps

module mux_4_32(
    input [31:0]in0_i,
    input [31:0]in1_i,
    input [31:0]in2_i,
    input [31:0]in3_i,
    input [1:0]sel_i,
    output reg [31:0]out_o
    );
    
    always @ (in0_i or in1_i or in2_i or in3_i or sel_i) begin
    
    case(sel_i)
        2'b00:
        out_o = in0_i;
        2'b01:
        out_o = in1_i;
        2'b10:
        out_o = in2_i;
        2'b11:
        out_o = in3_i;
    endcase
    
    end
    
    
    
    
endmodule

