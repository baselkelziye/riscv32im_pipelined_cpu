`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2023 14:37:14
// Design Name: 
// Module Name: mux_2_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_2_1(
    input in0_i,
    input in1_i,
    input sel_i,
    output reg out_o);
    
    always @(*) begin
        case(sel_i)
            1'b0: out_o = in0_i;
            1'b1: out_o = in1_i;
        endcase
    
    
    end
    
    
    endmodule;