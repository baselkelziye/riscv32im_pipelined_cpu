`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2023 18:13:29
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit(
    input is_load_instruction,
    input [4:0] rd_label_id_ex_o,
    input [4:0] rs1_label_if_id_o,
    input [4:0] rs2_label_if_id_o,
    
    output reg stall

    );
    
    always @(*) begin
    
        if(is_load_instruction)begin
            if(rs1_label_if_id_o == rd_label_id_ex_o || rs2_label_if_id_o == rd_label_id_ex_o)
                begin
                   stall = 1'b1;
                end
        
        end
        else begin
                stall = 1'b0;
         end
    
    
    end
endmodule
