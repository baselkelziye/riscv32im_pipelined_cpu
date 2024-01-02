`timescale 1ns / 1ps
//TODO

//register file'a yukselen darbeden oku, dusen darbede yazma islemi gerceklestirmemiz gerekebilir.

//27.12.2023
//forwarding unit'in bir priorirty mechanizmasi olabilir. Su an Stall eklenince calismasi lazim.
//TODO: stall ekle
//hazard detection bozuyor isi simdilik
//web_sel ile wb_sel arasinda karisiklik var


module cpu( input clk_i,
            input rst_i,
            input [31:0]instr_mem_read_i,
            input [31:0]data_mem_read_i,
            input data_busy_i,
            input inst_busy_i,
            
            output inst_mem_read_o,
            output data_mem_read_o,
            output data_mem_write_o,
            output [31:0]instr_addr_o,
            output [31:0]data_addr_o,
            output [31:0]data_mem_w_data_o);
    
        
    wire [31:0]PC_last_w;
    
    wire [31:0]PC_w;
    wire [31:0]PC_4_w;
    
    wire [31:0] instruction_if_id_i;
    wire [31:0] data_data_w;
    
    
    //***********IF-ID STAGE VARIABLES************
    wire [31:0] pc_if_id_o; //ID asamasina giren PC olduugu icin PC_ID_O isimlend
    wire [31:0] instruction_if_id_o;     
    
    wire [4:0]rd_if_id_o  =  instruction_if_id_o[11:7]; 
    wire [4:0]rs1_if_id_o = instruction_if_id_o[19:15]; 
    wire [4:0]rs2_if_id_o = instruction_if_id_o[24:20];
    wire [6:0] instruction_opcode_if_id_o = instruction_if_id_o[6:0];
    wire [2:0] instruction_funct3_if_id_o = instruction_if_id_o[14:12];
    wire [6:0] instruction_funct7_if_id_o = instruction_if_id_o[31:25];
    wire [24:0] instruction_payload_if_id_o = instruction_if_id_o[31:7];
    
     //*******************ID-EX STAGE VARIABLES***********   
    wire [31:0] rs1_id_ex_i; // pass rs1 register ID/EX stage
    wire [31:0] rs1_id_ex_o;
     
    wire [31:0] pc_id_ex_o;//pass PC to ID/EX stage
    
    wire [31:0] rs2_id_ex_i;//pass  rs2 to ID/EX stage
    wire [31:0] rs2_id_ex_o;
    
    wire [31:0] imm_id_ex_i; //pass imm to ID/EX stage
    wire [31:0] imm_id_ex_o;
    
    
    wire [2:0] imm_sel_id_ex_i; //control signal for imm
    wire [2:0] imm_sel_id_ex_o;
    
    wire alu_op1_sel_id_ex_i; //alo op1 control signal 
    wire alu_op1_sel_id_ex_o;
    
    wire alu_op2_sel_id_ex_i;//alu op2 control signal
    wire alu_op2_sel_id_ex_o;
    
    wire [4:0] alu_op_id_ex_i; //alu operation selection signal
    wire [4:0] alu_op_id_ex_o;
    
    wire [2:0]branch_sel_id_ex_i;//branch unit selection
    wire [2:0]branch_sel_id_ex_o;
    
    
    wire [3:0]read_write_sel_id_ex_i;//read write to cache
    wire [3:0]read_write_sel_id_ex_o;
    
    wire [1:0]wb_sel_id_ex_i;//which value to write back
    wire [1:0]wb_sel_id_ex_o;
    
    wire reg_wb_en_id_ex_i;//writeback signal
    wire reg_wb_en_id_ex_o;
    
    wire [4:0] rd_id_ex_o;//pass rd label for the writeback
    
    wire [4:0] rs1_label_id_ex_o; //forwarding unit
    wire [4:0] rs2_label_id_ex_o;
    
//*****************EX-MEM******************
    wire [31:0] alu_out_ex_mem_i;// for alu output
    wire [31:0] alu_out_ex_mem_o;
    
    
    wire [1:0] wb_sel_ex_mem_i;
    wire [1:0] wb_sel_ex_mem_o;
    
    wire reg_wb_en_ex_mem_i;
    wire reg_wb_en_ex_mem_o;
    
    
    
    wire [4:0] rd_ex_mem_i;
    wire [4:0] rd_ex_mem_o;
    
    wire [31:0] pc_ex_mem_o;
    
    wire [1:0] wb_sel_ex_mem_o;// control signal to WB 
                                
                                
    wire [31:0] imm_ex_mem_o;
    
    wire [3:0] read_write_sel_ex_mem_o;
    
    
     // forwarding unit                   
    wire [31:0] alu_in1_forwarded_input;
    wire [31:0] alu_in2_forwarded_input;
    wire [1:0] forwardA;
    wire [1:0] forwardB;
    
//    *********** MEM-WB STAGE ***************
    wire reg_wb_en_mem_wb_i;
    wire reg_wb_en_mem_wb_o;
    
    
    wire [4:0] rd_mem_wb_o;
    
    wire [31:0] alu_out_mem_wb_o;
    
    wire [1:0] wb_sel_mem_wb_o; // control signal to write back to reg file (which value)
   
   wire [31:0] rd_data_mem_wb_i;
   wire [31:0] rd_data_mem_wb_o;
   
   
   wire [31:0] imm_mem_wb_o;
   
   wire [31:0] pc_mem_wb_o;
   
   wire [3:0] read_write_sel_mem_wb_o;

    wire [31:0]alu_in1_w;
    wire [31:0]alu_in2_w;
    

    
    wire [31:0]reg_wb_data_w;
    
    
    
    wire  data_busy_w;
    wire  ins_busy_w;
    
    wire busy_w;
    wire write_en_w;
    
    assign busy_w = (data_busy_w | ins_busy_w);
    assign write_en_w = (reg_wb_en_mem_wb_o & !busy_w);//reg i mem_wb_o yapmak laizm en son

    mux_2_32 u_PC_mux ( .in0_i(PC_4_w),//normal PC degeri mi 
                        .in1_i(alu_out_ex_mem_i),//ALU de hesaplanan dallanacak adres degeri
                        .sel_i(PC_sel_w), // secim ucu, (jump biriminde tetiklenir)
                        .out_o(PC_last_w));// secilen degeri cikis verililir
    
    pc_reg r_pc_reg(.clk_i(clk_i),//saat derbesinde PC registerdeki degeri disariya verir
                    .rst_i(rst_i),
                    .busy_i(busy_w),//PC i degistiginde 1 olur, ne zaman okunursa 0'a duser
                    .stall(stall),
                    .PC_i(PC_last_w),// giris PC
                    .PC_o(PC_w)); // cikis PC
                    
    pc_adder u_pc_adder(.in_i(PC_w),//PC i 4 ile toplar
                        .out_o(PC_4_w));
                        
    instr_cache c_instr_cache(  .clk_i(clk_i),
                                .rst_i(rst_i),
                                 .address_i(PC_w),
                                .read_data_o(instruction_if_id_i),
                                .busy_o(ins_busy_w));
                                

   //******* IF-ID PIPELINE MODULE**********                  
     if_id_stage_reg if_id(
                           .clk_i(clk_i                        ),
                           .rst_i(rst_i                        ),
                           .busywait(busy_w                    ),
                           .stall(stall),
                           .instruction_if_id_i(instruction_if_id_i ),
                           .pc_if_id_i(PC_w                         ),
                           .instruction_if_id_o(instruction_if_id_o),
                           .pc_if_id_o(pc_if_id_o                  )
                            );
    



    
    
    regfile u_regfile  (        .clk_i(clk_i                  ),
                                .rst_i(rst_i                  ),
                                .write_en_i(reg_wb_en_mem_wb_o),
                                .rd_i(rd_mem_wb_o             ),//bunu da en son sinyalden alacak
                                .rd_data_i(reg_wb_data_w      ),// secilen mux'un anlik sonucu, PIPELINE a girmez
                                .rs1_i(rs1_if_id_o            ),
                                .rs2_i(rs2_if_id_o            ),
                                .rs1_data_o(rs1_id_ex_i       ),
                                .rs2_data_o(rs2_id_ex_i       ));
                        
                        
    wire is_memory_signal;
    wire is_load_instruction;
    wire stall;
    
    
    hazard_detection_unit hazard_detection_unit(
    .clk_i(clk_i),
    .is_load_instruction(is_load_instruction),
    .rd_label_id_ex_o(rd_id_ex_o),
    .rs1_label_if_id_o(rs1_if_id_o),
    .rs2_label_if_id_o(rs2_if_id_o),
    .stall(stall));
    
    control_unit u_control_unit(
                                .opcode_i(instruction_opcode_if_id_o),
                                .funct3_i(instruction_funct3_if_id_o),
                                .funct7_i(instruction_funct7_if_id_o),
                                .imm_sel_o(imm_sel_id_ex_i          ),
                                .op1_sel_o(alu_op1_sel_id_ex_i      ),
                                .op2_sel_o(alu_op2_sel_id_ex_i      ),
                                .alu_op_o(alu_op_id_ex_i            ),
                                .branch_sel_o(branch_sel_id_ex_i    ),
                                .read_write_o(read_write_sel_id_ex_i),
                                .wb_sel_o(wb_sel_id_ex_i            ),
                                .reg_w_en_o(reg_wb_en_id_ex_i       ),
                                .is_memory_instruction_o(is_memory_signal),
                                .is_load_instruction(is_load_instruction));
                                
    
    imm_gen u_imm_gen(
                                .instr_i(instruction_payload_if_id_o),
                                .imm_sel_i(imm_sel_id_ex_i          ),
                                .imm_o(imm_id_ex_i                  )); // ID-EX yazmacina imm-gen sonucu yaz
                        
                        
                                


    
    branch_jump u_branch_jump(  
                                .in1_i(alu_in1_forwarded_input         ),//alu output yap
                                .in2_i(alu_in2_forwarded_input         ),
                                .bj_sel_i(branch_sel_id_ex_o),//sinyal
                                .PC_sel_o(PC_sel_w          ));//sinyal
        wire [3:0] muxed_data_signal;                      
       mux_2_4 data_signal_selection(
        .in0_i(read_write_sel_id_ex_i),
        .in1_i(4'b0),
        .sel_i(stall),
        .out_o(muxed_data_signal)
        );                                         
                 
                 
        wire muxed_reg_write_en;
        mux_2_1 muxed_reg_en(
        .in0_i(reg_wb_en_id_ex_i),
        .in1_i(1'b0),
        .sel_i(stall),
        .out_o(muxed_reg_write_en));       
       //****************ID-EX PIPELINE REGISTER**************
        wire [6:0] opcode_id_ex_o;
        wire is_memory_instruction_id_ex_o;
       id_ex_stage_reg id_ex(
                         .clk_i(clk_i),
                         .rst_i(rst_i),
                         .busywait(busy_w),
                         .pc_id_ex_i(pc_if_id_o),//passing PC for the Branch UNIT
                         .pc_id_ex_o(pc_id_ex_o),
                         
                         .rs1_id_ex_i(rs1_id_ex_i), // passing rs1 32 bit value
                         .rs1_id_ex_o(rs1_id_ex_o),
                         
                         .rs2_id_ex_i(rs2_id_ex_i),  //passinng rs2 32bit value
                         .rs2_id_ex_o(rs2_id_ex_o),
                         
                         .imm_id_ex_i(imm_id_ex_i), // passing the 32bit imm result
                         .imm_id_ex_o(imm_id_ex_o),
                         
                         .imm_sel_id_ex_i(imm_sel_id_ex_i),//passing 3 bit selection for imm unit
                         .imm_sel_id_ex_o(imm_sel_id_ex_o),
                         
                         .alu_op1_sel_id_ex_i(alu_op1_sel_id_ex_i),//alu op1 1bitsignal
                         .alu_op1_sel_id_ex_o(alu_op1_sel_id_ex_o),
                         
                         .alu_op2_sel_id_ex_i(alu_op2_sel_id_ex_i),//alu op2 1 bit signal
                         .alu_op2_sel_id_ex_o(alu_op2_sel_id_ex_o),
                         
                         .alu_op_id_ex_i(alu_op_id_ex_i), //alu operation signal 5bit
                         .alu_op_id_ex_o(alu_op_id_ex_o),
                         
                         .branch_sel_id_ex_i(branch_sel_id_ex_i), //branch unit select
                         .branch_sel_id_ex_o(branch_sel_id_ex_o),//signal 3 bit
                         
                         .read_write_sel_id_ex_i(muxed_data_signal),//in case of stall, send 0
                         //else send old vbalue
                         .read_write_sel_id_ex_o(read_write_sel_id_ex_o),
                         
                         .wb_sel_id_ex_i(wb_sel_id_ex_i),//
                         .wb_sel_id_ex_o(wb_sel_id_ex_o),
                         
                         .reg_wb_en_id_ex_i(muxed_reg_write_en),
                         .reg_wb_en_id_ex_o(reg_wb_en_id_ex_o),
                         
                         .rd_id_ex_i(rd_if_id_o),
                         .rd_id_ex_o(rd_id_ex_o),
                         .rs1_label_id_ex_i(rs1_if_id_o),
                         .rs1_label_id_ex_o(rs1_label_id_ex_o),
                         .rs2_label_id_ex_i(rs2_if_id_o),
                         .rs2_label_id_ex_o(rs2_label_id_ex_o),
                         .opcode_id_ex_i(instruction_opcode_if_id_o),
                         .opcode_id_ex_o(opcode_id_ex_o),
                         .is_memory_instruction_id_ex_i(is_memory_signal),
                         .is_memory_instruction_id_ex_o(is_memory_instruction_id_ex_o)     
                         );
                         
                                          
   wire is_memory_instruction_mem_wb_o; 
   forwarding_unit forwarding_unit(
                        .rd_label_ex_mem_o(rd_ex_mem_o),
                        .rd_label_mem_wb_o(rd_mem_wb_o),
                        .rs1_label_id_ex_o(rs1_label_id_ex_o),
                        .rs2_label_id_ex_o(rs2_label_id_ex_o),
                        .reg_wb_en_ex_mem_o(reg_wb_en_ex_mem_o),
                        .reg_wb_en_mem_wb_o(reg_wb_en_mem_wb_o),
                        .is_memory_instruction(is_memory_instruction_id_ex_o),
                        .is_memory_instruction_mem_wb_o(is_memory_instruction_mem_wb_o),
                        .forwardA(forwardA),
                        .forwardB(forwardB),
                        .opcode(opcode_id_ex_o)
   );
     wire [1:0] forwardDataCache;
   forwarding_data_mem forwarding_data_unit(
           .rd_label_ex_mem_o(rd_ex_mem_o),
           .rd_label_mem_wb_o(rd_mem_wb_o),
           .rs2_label_id_ex_o(rs2_label_id_ex_o),
           .reg_wb_en_ex_mem_o(reg_wb_en_ex_mem_o),
           .reg_wb_en_mem_wb_o(reg_wb_en_mem_wb_o),
           .forwardDataCache(forwardDataCache));
     
     
    wire [31:0] forwarded_address;
    mux_4_32 data_cache_input_mux(
                .in0_i(rs2_id_ex_o),
                .in1_i(alu_out_mem_wb_o),
                .in2_i(alu_out_ex_mem_o),
                .in3_i(rd_data_mem_wb_o),
                .sel_i(forwardDataCache),
                .out_o(forwarded_address));
                          
    mux_2_32 u_alu_in1_mux(      
                                .in0_i(rs1_id_ex_o        ),
                                .in1_i(pc_id_ex_o         ),
                                .sel_i(alu_op1_sel_id_ex_o),
                                .out_o(alu_in1_w          ));

       mux_4_32 u_alu_in(
                    .in0_i(alu_in1_w), //bir onceki 2x1 muxun cikisi (bagimlilik yok)
                    .in1_i(alu_out_mem_wb_o),//RS1 from mem/wb rd
                    .in2_i(alu_out_ex_mem_o),//RS1 from ex/mem rd
                    .in3_i(rd_data_mem_wb_o),// 
                    .sel_i(forwardA),//forwardA 
                    .out_o(alu_in1_forwarded_input)
                    );
    
    mux_2_32 u_alu_in2_mux(
                                .in0_i(rs2_id_ex_o        ),
                                .in1_i(imm_id_ex_o        ), // ID-EX yazmacindan imm_id_ex_o oku
                                .sel_i(alu_op2_sel_id_ex_o),//sinyal
                                .out_o(alu_in2_w          ));
                                
                                

       mux_4_32 u_alu_in2(
                    .in0_i(alu_in2_w), //bir onceki 2x1 muxun cikisi (bagimlilik yok)
                    .in1_i(alu_out_mem_wb_o),//RS2 from mem/wb rd
                    .in2_i(alu_out_ex_mem_o),//RS2 from ex/mem rd
                    .in3_i(rd_data_mem_wb_o),// 
                    .sel_i(forwardB),//forwardAB
                    .out_o(alu_in2_forwarded_input)
                    );                                      
                                          
    alu u_alu(  .alu1_i(alu_in1_forwarded_input),//bunlar anlik cikis oldugu icin pipeline'a girmelerine gerek yok.
                .alu2_i(alu_in2_forwarded_input),
                .alu_op_i(alu_op_id_ex_o),
                .result_o(alu_out_ex_mem_i));

    wire [31:0] calculated_addres;

                                
  //******************************* EX-MEM                             
                          
                          
     wire [4:0] rs1_label_ex_mem_o;
     wire [4:0] rs2_label_ex_mem_o;   
     wire [31:0] rs2_ex_mem_o; 
     wire is_memory_instruction_ex_mem_o;                  
    ex_mem_stage_reg ex_mem(
                    .clk_i(clk_i),
                    .rst_i(rst_i),
                    .busywait(busy_w),
                    .alu_out_ex_mem_i(alu_out_ex_mem_i),
                    .alu_out_ex_mem_o(alu_out_ex_mem_o),
                    .reg_wb_en_ex_mem_i(reg_wb_en_id_ex_o),
                    .reg_wb_en_ex_mem_o(reg_wb_en_ex_mem_o),
                    .rd_ex_mem_i(rd_id_ex_o),//in_id nin cikisini ver buraya
                    .rd_ex_mem_o(rd_ex_mem_o),
                    .pc_ex_mem_i(pc_id_ex_o),
                    .pc_ex_mem_o(pc_ex_mem_o),
                    .wb_sel_ex_mem_i(wb_sel_id_ex_o),
                    .wb_sel_ex_mem_o(wb_sel_ex_mem_o),
                    .imm_ex_mem_i(imm_id_ex_o),
                    .imm_ex_mem_o(imm_ex_mem_o),
                    .rs1_label_ex_mem_i(rs1_label_id_ex_o),
                    .rs1_label_ex_mem_o(rs1_label_ex_mem_o),
                    .rs2_label_ex_mem_i(rs2_label_id_ex_o),
                    .rs2_label_ex_mem_o(rs2_label_ex_mem_o),
                    .read_write_sel_ex_mem_i(read_write_sel_id_ex_o),
                    .read_write_sel_ex_mem_o(read_write_sel_ex_mem_o),
                    .rs2_ex_mem_i(forwarded_address),
                    .rs2_ex_mem_o(rs2_ex_mem_o),
                    .is_memory_instruction_ex_mem_i(is_memory_instruction_id_ex_o),
                    .is_memory_instruction_ex_mem_o(is_memory_instruction_ex_mem_o)
                    );
                    
                    
                    
                    
    wire [31:0] data_cache_data_out;
    wire [31:0] data_address_forwarded_input;
    
//    mux_2_32 data_cache_mux(
//    .in0_i(rs2_ex_mem_o),
//    .in1_i(alu_out_mem_wb_o),
//    .sel_i(forwardB[0]),
//    .out_o(data_address_forwarded_input));
    
    data_cache c_data_cache( .clk_i(clk_i),
                .rst_i(rst_i),
                .address_i(alu_out_ex_mem_o),
                .write_data_i(rs2_ex_mem_o),//rs2 nýn deðerini taþý yaz oraya
                .read_write_sel_i(read_write_sel_ex_mem_o),
                .read_data_o(data_cache_data_out),
                .busy_o(data_busy_w));
    

                

    wire [31:0] rs2_mem_wb_o;           
    mem_wb_stage_reg mem_wb(
                    .clk_i(clk_i),
                    .rst_i(rst_i),
                    .busywait(busy_w),
                    .reg_wb_en_mem_wb_i(reg_wb_en_ex_mem_o),
                    .reg_wb_en_mem_wb_o(reg_wb_en_mem_wb_o),
                    .rd_mem_wb_i(rd_ex_mem_o),
                    .rd_mem_wb_o(rd_mem_wb_o),
                    .rd_data_mem_wb_i(data_cache_data_out),
                    .rd_data_mem_wb_o(rd_data_mem_wb_o),
                    .alu_out_mem_wb_i(alu_out_ex_mem_o),
                    .alu_out_mem_wb_o(alu_out_mem_wb_o),
                    .wb_sel_mem_wb_i(wb_sel_ex_mem_o),
                    .wb_sel_mem_wb_o(wb_sel_mem_wb_o),
                    .imm_mem_wb_i(imm_ex_mem_o),
                    .imm_mem_wb_o(imm_mem_wb_o),
                    .pc_mem_wb_i(pc_ex_mem_o),
                    .pc_mem_wb_o(pc_mem_wb_o),
                    .is_memory_instruction_mem_wb_i(is_memory_instruction_ex_mem_o),
                    .is_memory_instruction_mem_wb_o(is_memory_instruction_mem_wb_o),
                    .rs2_mem_wb_i(rs2_ex_mem_o),
                    .rs2_mem_wb_o(rs2_mem_wb_o)
    );
    
    wire [31:0] pc_mem_wb_o_4;
        pc_adder u_pc_adder1(.in_i(pc_mem_wb_o),//PC i 4 ile toplar
                        .out_o(pc_mem_wb_o_4)); // cunku son muxta PC+4 var, su ana kadar sadece PC i ilettik biz, 4 ile toplayip yollamamiz lazim.
           
    mux_4_32 u_wb_mux(  .in0_i(alu_out_mem_wb_o),
                        .in1_i(rd_data_mem_wb_o),
                        .in2_i(imm_mem_wb_o),
                        .in3_i(pc_mem_wb_o_4),              
                        .sel_i(wb_sel_mem_wb_o),
                        .out_o(reg_wb_data_w));
    
    
endmodule
