`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2023 21:15:46
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input [4:0] rd_label_ex_mem_o,
    input [4:0] rd_label_mem_wb_o,
    input [4:0] rs1_label_id_ex_o,
    input [4:0] rs2_label_id_ex_o,
    
    input reg_wb_en_ex_mem_o,
    input reg_wb_en_mem_wb_o,
    input is_memory_instruction,
    input is_memory_instruction_mem_wb_o,
    input [6:0] opcode,
    output reg [1:0]  forwardA,
    output reg  [1:0]  forwardB
    );
    
    
    always @(rs1_label_id_ex_o, reg_wb_en_ex_mem_o, reg_wb_en_mem_wb_o, rd_label_ex_mem_o, rd_label_mem_wb_o,is_memory_instruction_mem_wb_o) begin
    
    if (reg_wb_en_mem_wb_o && (rd_label_mem_wb_o != 0) &&
            !(reg_wb_en_ex_mem_o && (rd_label_ex_mem_o != 0) && (rd_label_ex_mem_o == rs1_label_id_ex_o)) &&
            (rd_label_mem_wb_o == rs1_label_id_ex_o) &&
           !is_memory_instruction &&
           !is_memory_instruction_mem_wb_o ) begin
            forwardA = 2'b01;
        end
    

        

        else  if(rd_label_mem_wb_o != 0  && 
                reg_wb_en_mem_wb_o &&
                is_memory_instruction_mem_wb_o &&  // bir onceki islem memory islemi
                !is_memory_instruction &&//su an memory islemi yok
                $signed(rd_label_mem_wb_o) == $signed(rs1_label_id_ex_o))
                begin
                 forwardA = 2'b11;
                end
        
        else if(rd_label_ex_mem_o  &&
           reg_wb_en_ex_mem_o &&
           $signed(rd_label_ex_mem_o) == $signed(rs1_label_id_ex_o) &&
           !is_memory_instruction)
           begin
            forwardA = 2'b10;//RS1 = EX/MEM RD
           end
                
        else 
            begin
            forwardA = 2'b00; //no forwarding
            end 
    end
    
    
    
    
        always @(rs2_label_id_ex_o, reg_wb_en_ex_mem_o, reg_wb_en_mem_wb_o, rd_label_ex_mem_o, rd_label_mem_wb_o,is_memory_instruction_mem_wb_o) begin    

        if(rd_label_ex_mem_o  && 
           reg_wb_en_ex_mem_o &&
           $signed(rd_label_ex_mem_o) == $signed(rs2_label_id_ex_o) &&
           !is_memory_instruction && 
           !is_memory_instruction_mem_wb_o)
            begin                               
                    forwardB = 2'b10; // RS2 = EX MEM  RD
            end         
                 
        else if(reg_wb_en_mem_wb_o && (rd_label_mem_wb_o != 0) &&
        !(reg_wb_en_ex_mem_o && (rd_label_ex_mem_o != 0) && (rd_label_ex_mem_o == rs2_label_id_ex_o)) &&
        (rd_label_mem_wb_o == rs2_label_id_ex_o) &&
           !is_memory_instruction && !is_memory_instruction_mem_wb_o) begin  
            forwardB = 2'b01;
        end
     else  if(rd_label_mem_wb_o != 0  && 
                reg_wb_en_mem_wb_o &&
                is_memory_instruction_mem_wb_o &&  // bir onceki islem memory islemi
                !is_memory_instruction &&//su an memory islemi yok
                $signed(rd_label_mem_wb_o) == $signed(rs2_label_id_ex_o))
                begin
                 forwardB = 2'b11;
                end
        else
            begin
            forwardB = 2'b00; //no forwarding
            end
    end
    endmodule
    

//endmodule


