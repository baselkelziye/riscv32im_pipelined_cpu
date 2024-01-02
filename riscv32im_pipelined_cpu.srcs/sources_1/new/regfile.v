//module regfile(input clk_i,
//                    input rst_i, //butun yazmaclara 0 degeri atar, baslangic durumu icin kullanilir
//                    input write_en_i,// yaz sinyali, 
//                    input [4:0] rd_i,// sonuc yazmacin numarasi, ornek: x4 icin rd_i = 00100. 
//                    input [31:0] rd_data_i,//sonuc yazmaca yazilacak deger, burasi her zaman deger barindir
//                    //ancak yazmak istemedigimiz durumlarda write_en_i sinyalini 0 veririz.
//                    input [4:0] rs1_i,//rs1 yazmacin numarasi
//                    input [4:0] rs2_i,//rs2 yazmacin numarasi.
//                    output [31:0] rs1_data_o,//rs1 yazmacin degeri
//                    output [31:0] rs2_data_o);//rs2 yazmacin degeri

//    reg [31:0] reg_r1_r;
//    reg [31:0] reg_r2_r;
//    reg [31:0] reg_r3_r;
//    reg [31:0] reg_r4_r;
//    reg [31:0] reg_r5_r;
//    reg [31:0] reg_r6_r;
//    reg [31:0] reg_r7_r;
//    reg [31:0] reg_r8_r;
//    reg [31:0] reg_r9_r;
//    reg [31:0] reg_r10_r;
//    reg [31:0] reg_r11_r;
//    reg [31:0] reg_r12_r;
//    reg [31:0] reg_r13_r;
//    reg [31:0] reg_r14_r;
//    reg [31:0] reg_r15_r;
//    reg [31:0] reg_r16_r;
//    reg [31:0] reg_r17_r;
//    reg [31:0] reg_r18_r;
//    reg [31:0] reg_r19_r;
//    reg [31:0] reg_r20_r;
//    reg [31:0] reg_r21_r;
//    reg [31:0] reg_r22_r;
//    reg [31:0] reg_r23_r;
//    reg [31:0] reg_r24_r;
//    reg [31:0] reg_r25_r;
//    reg [31:0] reg_r26_r;
//    reg [31:0] reg_r27_r;
//    reg [31:0] reg_r28_r;
//    reg [31:0] reg_r29_r;
//    reg [31:0] reg_r30_r;
//    reg [31:0] reg_r31_r;

    
//    // Synchronous register write back
//    always @ (* )
//    if (rst_i)
//    begin
//        reg_r1_r       <= 32'h00000000;
//        reg_r2_r       <= 32'h00000000;
//        reg_r3_r       <= 32'h00000000;
//        reg_r4_r       <= 32'h00000000;
//        reg_r5_r       <= 32'h00000000;
//        reg_r6_r       <= 32'h00000000;
//        reg_r7_r       <= 32'h00000000;
//        reg_r8_r       <= 32'h00000000;
//        reg_r9_r       <= 32'h00000000;
//        reg_r10_r      <= 32'h00000000;
//        reg_r11_r      <= 32'h00000000;
//        reg_r12_r      <= 32'h00000000;
//        reg_r13_r      <= 32'h00000000;
//        reg_r14_r      <= 32'h00000000;
//        reg_r15_r      <= 32'h00000000;
//        reg_r16_r      <= 32'h00000000;
//        reg_r17_r      <= 32'h00000000;
//        reg_r18_r      <= 32'h00000000;
//        reg_r19_r      <= 32'h00000000;
//        reg_r20_r      <= 32'h00000000;
//        reg_r21_r      <= 32'h00000000;
//        reg_r22_r      <= 32'h00000000;
//        reg_r23_r      <= 32'h00000000;
//        reg_r24_r      <= 32'h00000000;
//        reg_r25_r      <= 32'h00000000;
//        reg_r26_r      <= 32'h00000000;
//        reg_r27_r      <= 32'h00000000;
//        reg_r28_r      <= 32'h00000000;
//        reg_r29_r      <= 32'h00000000;
//        reg_r30_r      <= 32'h00000000;
//        reg_r31_r      <= 32'h00000000;
//    end
//    else
//    begin
//        if(write_en_i)
//        begin 
//            if(rd_i == 5'd1) reg_r1_r <= rd_data_i;
//            if(rd_i == 5'd2) reg_r2_r <= rd_data_i;
//            if(rd_i == 5'd3) reg_r3_r <= rd_data_i;
//            if(rd_i == 5'd4) reg_r4_r <= rd_data_i;
//            if(rd_i == 5'd5) reg_r5_r <= rd_data_i;
//            if(rd_i == 5'd6) reg_r6_r <= rd_data_i;
//            if(rd_i == 5'd7) reg_r7_r <= rd_data_i;
//            if(rd_i == 5'd8) reg_r8_r <= rd_data_i;
//            if(rd_i == 5'd9) reg_r9_r <= rd_data_i;
//            if(rd_i == 5'd10) reg_r10_r <= rd_data_i;
//            if(rd_i == 5'd11) reg_r11_r <= rd_data_i;
//            if(rd_i == 5'd12) reg_r12_r <= rd_data_i;
//            if(rd_i == 5'd13) reg_r13_r <= rd_data_i;
//            if(rd_i == 5'd14) reg_r14_r <= rd_data_i;
//            if(rd_i == 5'd15) reg_r15_r <= rd_data_i;
//            if(rd_i == 5'd16) reg_r16_r <= rd_data_i;
//            if(rd_i == 5'd17) reg_r17_r <= rd_data_i;
//            if(rd_i == 5'd18) reg_r18_r <= rd_data_i;
//            if(rd_i == 5'd19) reg_r19_r <= rd_data_i;
//            if(rd_i == 5'd20) reg_r20_r <= rd_data_i;
//            if(rd_i == 5'd21) reg_r21_r <= rd_data_i;
//            if(rd_i == 5'd22) reg_r22_r <= rd_data_i;
//            if(rd_i == 5'd23) reg_r23_r <= rd_data_i;
//            if(rd_i == 5'd24) reg_r24_r <= rd_data_i;
//            if(rd_i == 5'd25) reg_r25_r <= rd_data_i;
//            if(rd_i == 5'd26) reg_r26_r <= rd_data_i;
//            if(rd_i == 5'd27) reg_r27_r <= rd_data_i;
//            if(rd_i == 5'd28) reg_r28_r <= rd_data_i;
//            if(rd_i == 5'd29) reg_r29_r <= rd_data_i;
//            if(rd_i == 5'd30) reg_r30_r <= rd_data_i;
//            if(rd_i == 5'd31) reg_r31_r <= rd_data_i;
//        end
//    end

//    reg [31:0] rs1_value_r;
//    reg [31:0] rs2_value_r;
//    always @ *
//    begin
//        case (rs1_i)
//        5'd1: rs1_value_r = reg_r1_r;
//        5'd2: rs1_value_r = reg_r2_r;
//        5'd3: rs1_value_r = reg_r3_r;
//        5'd4: rs1_value_r = reg_r4_r;
//        5'd5: rs1_value_r = reg_r5_r;
//        5'd6: rs1_value_r = reg_r6_r;
//        5'd7: rs1_value_r = reg_r7_r;
//        5'd8: rs1_value_r = reg_r8_r;
//        5'd9: rs1_value_r = reg_r9_r;
//        5'd10: rs1_value_r = reg_r10_r;
//        5'd11: rs1_value_r = reg_r11_r;
//        5'd12: rs1_value_r = reg_r12_r;
//        5'd13: rs1_value_r = reg_r13_r;
//        5'd14: rs1_value_r = reg_r14_r;
//        5'd15: rs1_value_r = reg_r15_r;
//        5'd16: rs1_value_r = reg_r16_r;
//        5'd17: rs1_value_r = reg_r17_r;
//        5'd18: rs1_value_r = reg_r18_r;
//        5'd19: rs1_value_r = reg_r19_r;
//        5'd20: rs1_value_r = reg_r20_r;
//        5'd21: rs1_value_r = reg_r21_r;
//        5'd22: rs1_value_r = reg_r22_r;
//        5'd23: rs1_value_r = reg_r23_r;
//        5'd24: rs1_value_r = reg_r24_r;
//        5'd25: rs1_value_r = reg_r25_r;
//        5'd26: rs1_value_r = reg_r26_r;
//        5'd27: rs1_value_r = reg_r27_r;
//        5'd28: rs1_value_r = reg_r28_r;
//        5'd29: rs1_value_r = reg_r29_r;
//        5'd30: rs1_value_r = reg_r30_r;
//        5'd31: rs1_value_r = reg_r31_r;
//        default : rs1_value_r = 32'h00000000;
//        endcase

//        case (rs2_i)
//        5'd1: rs2_value_r = reg_r1_r;
//        5'd2: rs2_value_r = reg_r2_r;
//        5'd3: rs2_value_r = reg_r3_r;
//        5'd4: rs2_value_r = reg_r4_r;
//        5'd5: rs2_value_r = reg_r5_r;
//        5'd6: rs2_value_r = reg_r6_r;
//        5'd7: rs2_value_r = reg_r7_r;
//        5'd8: rs2_value_r = reg_r8_r;
//        5'd9: rs2_value_r = reg_r9_r;
//        5'd10: rs2_value_r = reg_r10_r;
//        5'd11: rs2_value_r = reg_r11_r;
//        5'd12: rs2_value_r = reg_r12_r;
//        5'd13: rs2_value_r = reg_r13_r;
//        5'd14: rs2_value_r = reg_r14_r;
//        5'd15: rs2_value_r = reg_r15_r;
//        5'd16: rs2_value_r = reg_r16_r;
//        5'd17: rs2_value_r = reg_r17_r;
//        5'd18: rs2_value_r = reg_r18_r;
//        5'd19: rs2_value_r = reg_r19_r;
//        5'd20: rs2_value_r = reg_r20_r;
//        5'd21: rs2_value_r = reg_r21_r;
//        5'd22: rs2_value_r = reg_r22_r;
//        5'd23: rs2_value_r = reg_r23_r;
//        5'd24: rs2_value_r = reg_r24_r;
//        5'd25: rs2_value_r = reg_r25_r;
//        5'd26: rs2_value_r = reg_r26_r;
//        5'd27: rs2_value_r = reg_r27_r;
//        5'd28: rs2_value_r = reg_r28_r;
//        5'd29: rs2_value_r = reg_r29_r;
//        5'd30: rs2_value_r = reg_r30_r;
//        5'd31: rs2_value_r = reg_r31_r;
//        default : rs2_value_r = 32'h00000000;
//        endcase
//    end

//    assign rs1_data_o = rs1_value_r;
//    assign rs2_data_o = rs2_value_r;


//endmodule


//*************************************************\\
module regfile(
    input clk_i,
    input rst_i,
    input write_en_i,
    input [4:0] rd_i,
    input [31:0] rd_data_i,
    input [4:0] rs1_i,
    input [4:0] rs2_i,
    output [31:0] rs1_data_o,
    output [31:0] rs2_data_o
);

    reg [31:0] registers [31:1]; // Array of 31 registers (register 0 is always 0)
    integer i;
    // Synchronous register write on the positive edge of the clock
    always @(*)//make this * solved the problem?
    begin
        if (rst_i)
        begin
            // Reset all registers to 0
          
            for (i = 1; i < 32; i = i + 1)
                registers[i] <= 32'h00000000;
        end
        else if (write_en_i && rd_i != 0) // Ensure rd_i is not 0, as x0 is always 0
        begin #0
            registers[rd_i] <= rd_data_i;
        end
    end

    reg [31:0] rs1_value_r, rs2_value_r;

    // Asynchronous read on the negative edge of the clock
    always @(negedge clk_i)
    begin
        rs1_value_r <= (rs1_i == 0) ? 32'h00000000 : registers[rs1_i];
        rs2_value_r <= (rs2_i == 0) ? 32'h00000000 : registers[rs2_i];
    end

    assign  rs1_data_o = rs1_value_r;
    assign  rs2_data_o = rs2_value_r;

endmodule

