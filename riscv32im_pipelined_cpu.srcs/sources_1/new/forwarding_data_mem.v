`timescale 1ns / 1ps

module forwarding_data_mem(
   input [4:0] rd_label_ex_mem_o,
   input [4:0] rd_label_mem_wb_o,
   input [4:0] rs2_label_id_ex_o,
    
   input reg_wb_en_ex_mem_o,
   input reg_wb_en_mem_wb_o,
   output reg [1:0] forwardDataCache
    );
    
    always @(*) begin    
        if(rd_label_ex_mem_o  && 
           reg_wb_en_ex_mem_o &&
           $signed(rd_label_ex_mem_o) == $signed(rs2_label_id_ex_o))
            begin                               
                    forwardDataCache = 2'b10; // RS2 = EX MEM  RD
            end         
        else if(reg_wb_en_mem_wb_o && (rd_label_mem_wb_o != 0) &&
        !(reg_wb_en_ex_mem_o && (rd_label_ex_mem_o != 0) && (rd_label_ex_mem_o == rs2_label_id_ex_o))) begin  
            forwardDataCache = 2'b01;
        end
        else
            begin
            forwardDataCache = 2'b00; //no forwarding
            end
    end
    
endmodule
