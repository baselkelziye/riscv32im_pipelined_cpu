`timescale 1ns / 1ps

module id_ex_stage_reg(
    input clk_i,
    input rst_i,
    input busywait,
    
    input [31:0] pc_id_ex_i,
    output reg [31:0] pc_id_ex_o,
    
    input [31:0] rs1_id_ex_i,
    output reg [31:0] rs1_id_ex_o,
    
    input [31:0] rs2_id_ex_i,
    output reg [31:0] rs2_id_ex_o,
    
    input [31:0] imm_id_ex_i,
    output reg [31:0] imm_id_ex_o,
    
    input [2:0] imm_sel_id_ex_i,
    output reg [2:0] imm_sel_id_ex_o,
    
    input alu_op1_sel_id_ex_i,
    output reg alu_op1_sel_id_ex_o,
    
    input alu_op2_sel_id_ex_i,
    output reg alu_op2_sel_id_ex_o,
    
    input [4:0] alu_op_id_ex_i,
    output reg [4:0] alu_op_id_ex_o,
    
    input [2:0] branch_sel_id_ex_i,
    output reg [2:0] branch_sel_id_ex_o,
    
    input [3:0] read_write_sel_id_ex_i,
    output reg [3:0] read_write_sel_id_ex_o,
    
    input [1:0] wb_sel_id_ex_i,
    output reg [1:0] wb_sel_id_ex_o,
    
    input reg_wb_en_id_ex_i,
    output reg reg_wb_en_id_ex_o,
    
    input [4:0] rd_id_ex_i,
    output reg [4:0] rd_id_ex_o,
    
    input [4:0] rs1_label_id_ex_i,
    output reg [4:0] rs1_label_id_ex_o,
    
    input [4:0] rs2_label_id_ex_i,
    output reg [4:0] rs2_label_id_ex_o,
    
    input [6:0] opcode_id_ex_i,
    output reg [6:0] opcode_id_ex_o,
    
    input is_memory_instruction_id_ex_i,
    output reg is_memory_instruction_id_ex_o
    );
    
    always @(*) begin
        if(rst_i) begin
            #0.1;
            pc_id_ex_o = 32'd0;
            rs1_id_ex_o = 32'd0;
            rs2_id_ex_o = 32'd0;
            imm_id_ex_o = 32'd0;
            imm_sel_id_ex_o = 3'd0;
            alu_op1_sel_id_ex_o = 0;
            alu_op2_sel_id_ex_o = 0;
            alu_op_id_ex_o = 5'd0;
            branch_sel_id_ex_o = 3'd0;
            read_write_sel_id_ex_o = 4'd0;
            wb_sel_id_ex_o = 2'd0;
            reg_wb_en_id_ex_o = 0;
            rd_id_ex_o = 5'd0;
            rs1_label_id_ex_o = 5'd0;
            opcode_id_ex_o = 7'd0;
            is_memory_instruction_id_ex_o  = 1'b0;
        end
    
    end
    
    always @(posedge clk_i)begin
            #0;
              if(!busywait)begin
            pc_id_ex_o  <= pc_id_ex_i;
            rs1_id_ex_o <= rs1_id_ex_i;
            rs2_id_ex_o <= rs2_id_ex_i;
            imm_id_ex_o <= imm_id_ex_i; 
            imm_sel_id_ex_o <= imm_sel_id_ex_i;
            alu_op1_sel_id_ex_o <= alu_op1_sel_id_ex_i;
            alu_op2_sel_id_ex_o <= alu_op2_sel_id_ex_i;
            alu_op_id_ex_o <= alu_op_id_ex_i;
            branch_sel_id_ex_o <= branch_sel_id_ex_i;
            read_write_sel_id_ex_o <= read_write_sel_id_ex_i;
            wb_sel_id_ex_o <= wb_sel_id_ex_i;
            reg_wb_en_id_ex_o <= reg_wb_en_id_ex_i;  
            rd_id_ex_o <= rd_id_ex_i;
            rs1_label_id_ex_o <= rs1_label_id_ex_i;
            rs2_label_id_ex_o <= rs2_label_id_ex_i;
            opcode_id_ex_o <= opcode_id_ex_i;
            is_memory_instruction_id_ex_o <= is_memory_instruction_id_ex_i;
            end
 
    end
endmodule
