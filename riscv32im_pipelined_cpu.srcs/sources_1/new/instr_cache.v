`timescale 1ns / 1ps

module instr_cache(input clk_i,//saat girisi
    input rst_i,// reset ucunun girisi
    input [31:0]address_i,//Komutun adresi, bu ya doðrudan program sayacý + 4 ve ya Dallanacak adresin deðerini tutar.
    output reg [31:0]read_data_o,//okudugumuz komut
    output reg busy_o);//PC degistiginde 1 olur, ne zaman cekilip read_data_o'ya yazilirsa 0 olur
    
    
    reg[31:0] cache_r[0:8191];// instruction cache'in boyutu
    

    
    always @ (address_i) begin
        if(address_i != -32'd4) busy_o = 1;
        //program yazmaci degistiginde okunana kdr busy yap
    end
    
     
    always @ (*) begin
        #1;
        read_data_o = cache_r[address_i[31:2]];
        busy_o = 1'b0;
    end
    
    integer i;
//    always @ (rst_i) begin
//        if(rst_i) begin
//            for(i = 0 ; i<8192 ; i = i+1) begin
//                cache_r[0] = 32'b0;            
//            end
//        end
//    end

    
    initial begin 

//  ALU-TEST

//	cache_r[0] = 32'h06400093;
//	cache_r[1] = 32'h00108133;
//	cache_r[2] = 32'h402081b3;
//	cache_r[3] = 32'h0010c233;
//	cache_r[4] = 32'h0ff1f293;
//	cache_r[5] = 32'h0030e333;
//	cache_r[6] = 32'h003133b3;
//	cache_r[7] = 32'h00312433;
//	cache_r[8] = 32'h00341493;
//	cache_r[9] = 32'h4021d513;
//	cache_r[10] = 32'h0021d593;
//	cache_r[11] = 32'h02108633;
//	cache_r[12] = 32'h021336b3;
//	cache_r[13] = 32'h0211c733;
//	cache_r[14] = 32'h021357b3;
//	cache_r[15] = 32'h02d16833;
/*
	cache_r[0] = 32'h00a00093;
	cache_r[1] = 32'h001000a3;
	cache_r[2] = 32'h00100103;
	cache_r[3] = 32'h00101183;
	cache_r[4] = 32'h00310233;
	cache_r[5] = 32'h401202b3;
	cache_r[6] = 32'h0ff00f93;
	cache_r[7] = 32'h02428333;
	cache_r[8] = 32'h025313b3;
	cache_r[9] = 32'h00100f13;
	cache_r[10] = 32'h41e18433;
	cache_r[11] = 32'h028354b3;
	cache_r[12] = 32'h02837533;
	cache_r[13] = 32'h00844eb3;
	cache_r[14] = 32'h03d35e33;
	cache_r[15] = 32'hf0100d93;
	cache_r[16] = 32'h03b34d33;
	cache_r[17] = 32'h000015b7;
	cache_r[18] = 32'h00001617;
	cache_r[19] = 32'h00100c33;
	cache_r[20] = 32'h00100cb3;
	cache_r[21] = 32'h00c0006f;
	cache_r[22] = 32'h00309c93;
	cache_r[23] = 32'h4020dc13;
	cache_r[24] = 32'hff9c0ce3;
	cache_r[25] = 32'h018ca6b3;
	cache_r[26] = 32'h019c2733;
	cache_r[27] = 32'h00e6e7b3;
	cache_r[28] = 32'h0ff77813;*/

//  CPU-TEST

//cache_r[0] = 32'h00a00093;// – addi x1, x0, 10 works nice
//cache_r[1] = 32'h001000a3;// – sb x1, 0(x2)
//cache_r[2] = 32'h00100103;// – lb x2, 0(x2)
//cache_r[3] = 32'h00101183; //– lh x3, 0(x2)
//cache_r[4] = 32'h00310233; //– sltu x4, x2, x3
//cache_r[5] = 32'h401202b3; //– sub x5, x4, x1
//cache_r[6] = 32'h0ff00f93; //– addi x31, x0, 255
//cache_r[7] = 32'h02428333; //– add x6, x4, x36
//cache_r[8] = 32'h025313b3; //– add x7, x6, x37
//cache_r[9] = 32'h00100f13; //– slli x30, x0, 1
//cache_r[10] = 32'h41e18433;// – sub x8, x3, x30
//cache_r[11] = 32'h028354b3;// – add x9, x6, x40
//cache_r[12] = 32'h02837533; //– add x10, x6, x40
//cache_r[13] = 32'h00844eb3; //– slli x29, x8, 8
//cache_r[14] = 32'h03d35e33; //– sub x28, x6, x61
//cache_r[15] = 32'hf0100d93; //– andi x27, x0, -256
//cache_r[16] = 32'h03b34d33; //– add x26, x6, x59
//cache_r[17] = 32'h000015b7; //– lui x11, 0
//cache_r[18] = 32'h00001617; //– auipc x12, 0
//cache_r[19] = 32'h00100c33; //– slli x24, x0, 1
//cache_r[20] = 32'h00100cb3;// – slli x25, x0, 1
//cache_r[21] = 32'h00c0006f; //– jal x0, 12
//cache_r[22] = 32'h00309c93; //– slli x25, x1,3
//cache_r[23] = 32'h4020dc13; //– srai x24, x1,2
//cache_r[24] = 32'hff9c0ce3; //– bne x24, x31, -4
//cache_r[25] = 32'h018ca6b3; //– ori x13, x25, 24
//cache_r[26] = 32'h019c2733; //– andi x14, x24, 25
//cache_r[27] = 32'h00e6e7b3; //– ori x15, x13, 14
//cache_r[28] = 32'h0ff77813; //– andi x16, x14, 255




//ASSIGN EACH REGISTER TO ITS VALUE

//cache_r[0] = 32'b00000000111100000000000010010011;//addi x1 x0 15. x1 = 15
//cache_r[1] = 32'b00000000101000001000000110010011;//addi x3 x1 10. x3 = 25
//cache_r[2] = 32'b00000000000100011000001010110011;//add x5 x3 x1. x5= 40
//cache_r[3] = 32'b00000000100100101000001100010011;//addi x6 x5 9. x6 = 49
//cache_r[4] = 32'b01000000001100001000000100110011;//sub x2 x1 x3. x2 = -10
//cache_r[5] = 32'b00000000010100010111011000110011;//and x12 x2 x5. ? :D
//cache_r[6] = 32'b00000000001000110110011010110011;//or x13 x6 x2
//cache_r[7] = 32'b00000000001000010000011100110011;//add x14 x2 x2. -20




//    cache_r[0] = 32'b00000000010100000000000010010011;
//    cache_r[1] = 32'b00000000101000001000000100010011;
//    cache_r[2] = 32'b00000000001000001000000110110011;
//    cache_r[3] = 32'b00000000000000000010001000110111;
//    cache_r[4] = 32'b00000000000000000000001010010111;
//    cache_r[5] = 32'b00000000000000000000000011101111;
//    cache_r[6] = 32'b00000001111000011010001100010011;
//    cache_r[7] = 32'b00000000001000001010001110110011;
//    cache_r[8] = 32'b11111111111100000100010000010011;
//    cache_r[9] = 32'b00000000000101000100010010110011;
//    cache_r[10] = 32'b00000000100100000110010100010011;
//    cache_r[11] = 32'b00000000100101010110010110110011;
//    cache_r[12] = 32'b00000000000001011111011000010011;
//    cache_r[13] = 32'b00000000101101100111011010110011;
//    cache_r[14] = 32'b01000000001000001000011100110011;
//    cache_r[15] = 32'b00000000000100001001000100010011;
//    cache_r[16] = 32'b00000000101000001001000110110011;
//    cache_r[17] = 32'b00000000010001011101001000010011;
//    cache_r[18] = 32'b00000000101001011101001010110011;
//    cache_r[19] = 32'b01000000010001011101001100010011;
//    cache_r[20] = 32'b01000000101001011101001110110011;
//    cache_r[21] = 32'b00000000010100000000000010010011;
//    cache_r[22] = 32'b00000000101000000000000100010011;
//    cache_r[23] = 32'b00000010001000001000000110110011;
//    cache_r[24] = 32'b00000000000000010011000010110111;
//    cache_r[25] = 32'b00011111100100000000000100010011;
//    cache_r[26] = 32'b00000000001000001010000000100011;




//*********************** DALLANMA TESTI
//cache_r[0] = 32'h00a00093; //addi x1,x0,10
//cache_r[1] = 32'h00a00113; //addi x2,x0, 10
//cache_r[2] = 32'h00208863; // beq x1,x2, cikis
////cache_r[3] = 32'h010002ef; // jal x2, cikis1
//cache_r[3] = 32'h00100313; // x6 = 1 // x6 and x7 should never be = 1
//cache_r[4] = 32'h00100393; // x7 = 1
//cache_r[5] = 32'h001101b3; // add x3,x2,x1 if they are equal x3 should be x1+x2.
//cache_r[6] = 32'h00000013; //NOP // if not equal x3 should be X

//************************* BUBBLE SORT

//cache_r[0] = 32'h00000093;  // addi x1 x0 0
//cache_r[1] = 32'h10000113;  // addi x2 x0 256
//cache_r[2] = 32'h00a00193;  // addi x3 x0 10
//cache_r[3] = 32'h00900213;  // addi x4 x0 9
//cache_r[4] = 32'h00200313;  // addi x6 x0 2
//cache_r[5] = 32'h00610023;  // sb x6 0 x2
//cache_r[6] = 32'h00100313;  // addi x6 x0 1
//cache_r[7] = 32'h006100a3;  // sb x6 1 x2
//cache_r[8] = 32'h00300313;  // addi x6 x0 3
//cache_r[9] = 32'h00610123;  // sb x6 2 x2
//cache_r[10] = 32'h00500313; // addi x6 x0 5
//cache_r[11] = 32'h006101a3; // sb x6 3 x2
//cache_r[12] = 32'h00400313; // addi x6 x0 4
//cache_r[13] = 32'h00610223; // sb x6 4 x2
//cache_r[14] = 32'h00700313; // addi x6 x0 7
//cache_r[15] = 32'h006102a3; // sb x6 5 x2
//cache_r[16] = 32'h00600313; // addi x6 x0 6
//cache_r[17] = 32'h00610323; // sb x6 6 x2
//cache_r[18] = 32'h00b00313; // addi x6 x0 11
//cache_r[19] = 32'h006103a3; // sb x6 7 x2
//cache_r[20] = 32'h00900313; // addi x6 x0 9
//cache_r[21] = 32'h00610423; // sb x6 8 x2
//cache_r[22] = 32'h00800313; // addi x6 x0 8
//cache_r[23] = 32'h006104a3; // sb x6 9 x2
//cache_r[24] = 32'h04328463; // beq x5 x3 72 <exit_start>
//cache_r[25] = 32'h00000093; // addi x1 x0 0
//cache_r[26] = 32'h02408c63; // beq x1 x4 56 <exit_loop>
//cache_r[27] = 32'h002083b3; // add x7 x1 x2
//cache_r[28] = 32'h00038403; // lb x8 0 x7
//cache_r[29] = 32'h00138713; // addi x14 x7 1
//cache_r[30] = 32'h00070483; // lb x9 0 x14
//cache_r[31] = 32'h00945863; // bge x8 x9 16 <do_swap>
//cache_r[32] = 32'h00838023; // sb x8 0 x7
//cache_r[33] = 32'h00970023; // sb x9 0 x14
//cache_r[34] = 32'h00000863; // beq x0 x0 16 <exit_swap>
//cache_r[35] = 32'h00900533; // add x10 x0 x9
//cache_r[36] = 32'h00870023; // sb x8 0 x14
//cache_r[37] = 32'h00a38023; // sb x10 0 x7
//cache_r[38] = 32'h00108093; // addi x1 x1 1
//cache_r[39] = 32'hfc0006e3; // beq x0 x0 -52 <loop>
//cache_r[40] = 32'h00128293; // addi x5 x5 1
//cache_r[41] = 32'hfa000ee3; // beq x0 x0 -68 <start>
//cache_r[42] = 32'h00000013; // NOP
//cache_r[43] = 32'h00000013; // NOP
//cache_r[44] = 32'h00000013;//NOP
//cache_r[45] = 32'h00000013;//NOP



//*****************FORWARDING BUG FIX\\
//cache_r[0]  = 32'h00000093; // addi x1 x0 0
//cache_r[1]  = 32'h10000113; // addi x2 x0 256
//cache_r[2]  = 32'h00a00193; // addi x3 x0 10
//cache_r[3]  = 32'h00900213; // addi x4 x0 9
//cache_r[4]  = 32'h00200313; // addi x6 x0 2
//cache_r[5]  = 32'h00610023; // sb x6 0 x2
//cache_r[6]  = 32'h00100313; // addi x6 x0 1
//cache_r[7]  = 32'h006100a3; // sb x6 1 x2
//cache_r[8]  = 32'h00300313; // addi x6 x0 3
//cache_r[9]  = 32'h00610123; // sb x6 2 x2
//cache_r[10] = 32'h00500313; // addi x6 x0 5
//cache_r[11] = 32'h006101a3; // sb x6 3 x2
//cache_r[12] = 32'h00400313; // addi x6 x0 4
//cache_r[13] = 32'h00610223; // sb x6 4 x2
//cache_r[14] = 32'h00700313; // addi x6 x0 7
//cache_r[15] = 32'h006102a3; // sb x6 5 x2
//cache_r[16] = 32'h00600313; // addi x6 x0 6
//cache_r[17] = 32'h00610323; // sb x6 6 x2
//cache_r[18] = 32'h00b00313; // addi x6 x0 11
//cache_r[19] = 32'h006103a3; // sb x6 7 x2
//cache_r[20] = 32'h00900313; // addi x6 x0 9
//cache_r[21] = 32'h00610423; // sb x6 8 x2
//cache_r[22] = 32'h00800313; // addi x6 x0 8
//cache_r[23] = 32'h006104a3; // sb x6 9 x2

//cache_r[24] = 32'h002083b3; // add x7 x1 x2
//cache_r[25] = 32'h00038403; // lb x8 0 x7
//cache_r[26] = 32'h00138713; // addi x14 x7 1
//cache_r[27] = 32'h00070483; // lb x9 0 x14



//cache_r[24] = 32'h00000013; // addi x0 x0 0
//cache_r[25] = 32'h00000013; // addi x0 x0 0
//cache_r[26] = 32'h00000013; // addi x0 x0 0
//cache_r[27] = 32'h00000013; // addi x0 x0 0
//cache_r[28] = 32'h00000013; // addi x0 x0 0
//cache_r[29] = 32'h00000013; // addi x0 x0 0
//cache_r[30] = 32'h04328463; // beq x5 x3 72 <exit_start>
//cache_r[31] = 32'h00000093; // addi x1 x0 0
//cache_r[32] = 32'h02408c63; // beq x1 x4 56 <exit_loop>
//cache_r[33] = 32'h002083b3; // add x7 x1 x2
//cache_r[34] = 32'h00038403; // lb x8 0 x7
//cache_r[35] = 32'h00138713; // addi x14 x7 1
//cache_r[36] = 32'h00070483; // lb x9 0 x14
//cache_r[37] = 32'h00945863; // bge x8 x9 16 <do_swap>
//cache_r[38] = 32'h00838023; // sb x8 0 x7
//cache_r[39] = 32'h00970023; // sb x9 0 x14
//cache_r[40] = 32'h00000863; // beq x0 x0 16 <exit_swap>
//cache_r[41] = 32'h00900533; // add x10 x0 x9
//cache_r[42] = 32'h00870023; // sb x8 0 x14
//cache_r[43] = 32'h00a38023; // sb x10 0 x7
//cache_r[44] = 32'h00108093; // addi x1 x1 1
//cache_r[45] = 32'hfc0006e3; // beq x0 x0 -52 <loop>
//cache_r[46] = 32'h00128293; // addi x5 x5 1
//cache_r[47] = 32'hfa000ee3; // beq x0 x0 -68 <start>
//cache_r[48] = 32'h00000013; // addi x0 x0 0
//cache_r[49] = 32'h00000013; // addi x0 x0 0
//cache_r[50] = 32'h00000013; // addi x0 x0 0
//cache_r[51] = 32'h00000013; // addi x0 x0 0


//********************** MANIPULATED BUBBLE SORT
    cache_r[0]  = 32'h00000093; // addi x1 x0 0
    cache_r[1]  = 32'h10000113; // addi x2 x0 256
    cache_r[2]  = 32'h00a00193; // addi x3 x0 10
    cache_r[3]  = 32'h00900213; // addi x4 x0 9
    
    cache_r[4]  = 32'h03200313; // addi x6 x0 50
    cache_r[5]  = 32'h00610023; // sb x6 0 x2
    cache_r[6]  = 32'h02800313; // addi x6 x0 40
    cache_r[7]  = 32'h006100a3; // sb x6 1 x2
    cache_r[8]  = 32'h01e00313; // addi x6 x0 30
    cache_r[9]  = 32'h00610123; // sb x6 2 x2
    cache_r[10] = 32'h01900313; // addi x6 x0 25
    cache_r[11] = 32'h006101a3; // sb x6 3 x2
    cache_r[12] = 32'h01400313; // addi x6 x0 20
    cache_r[13] = 32'h00610223; // sb x6 4 x2
    cache_r[14] = 32'h00f00313; // addi x6 x0 15
    cache_r[15] = 32'h006102a3; // sb x6 5 x2
    cache_r[16] = 32'h00a00313; // addi x6 x0 10
    cache_r[17] = 32'h00610323; // sb x6 6 x2
    cache_r[18] = 32'h00500313; // addi x6 x0 5
    cache_r[19] = 32'h006103a3; // sb x6 7 x2
    cache_r[20] = 32'h00400313; // addi x6 x0 4
    cache_r[21] = 32'h00610423; // sb x6 8 x2
    cache_r[22] = 32'h00300313; // addi x6 x0 3
    cache_r[23] = 32'h006104a3; // sb x6 9 x2   
    cache_r[24] = 32'h00000013; // addi x0 x0 0
    cache_r[25] = 32'h00000013; // addi x0 x0 0
    cache_r[26] = 32'h00000013; // addi x0 x0 0
    cache_r[27] = 32'h00000013; // addi x0 x0 0
    cache_r[28] = 32'h00000013; // addi x0 x0 0
    cache_r[29] = 32'h00000013; // addi x0 x0 0
    cache_r[30] = 32'h04328e63; // beq x5 x3 92 <exit_start>
    cache_r[31] = 32'h00000093; // addi x1 x0 0
    cache_r[32] = 32'h04408663; // beq x1 x4 76 <exit_loop>
    cache_r[33] = 32'h002083b3; // add x7 x1 x2
    cache_r[34] = 32'h00038403; // lb x8 0 x7
    cache_r[35] = 32'h00138713; // addi x14 x7 1
    cache_r[36] = 32'h00070483; // lb x9 0 x14
    cache_r[37] = 32'h00945e63; // bge x8 x9 28 <do_swap>
    cache_r[38] = 32'h00838023; // sb x8 0 x7
    cache_r[39] = 32'h00970023; // sb x9 0 x14
    cache_r[40] = 32'h00000013; // addi x0 x0 0
    cache_r[41] = 32'h00000c63; // beq x0 x0 24 <exit_swap>
    cache_r[42] = 32'h00000013; // addi x0 x0 0
    cache_r[43] = 32'h00000013; // addi x0 x0 0
    cache_r[44] = 32'h00900533; // add x10 x0 x9
    cache_r[45] = 32'h00870023; // sb x8 0 x14
    cache_r[46] = 32'h00a38023; // sb x10 0 x7
    cache_r[47] = 32'h00108093; // addi x1 x1 1
    cache_r[48] = 32'hfc0000e3; // beq x0 x0 -64 <loop>
    cache_r[49] = 32'h00000013; // addi x0 x0 0
    cache_r[50] = 32'h00000013; // addi x0 x0 0
    cache_r[51] = 32'h00128293; // addi x5 x5 1
    cache_r[52] = 32'hfa0004e3; // beq x0 x0 -88 <start>
    cache_r[53] = 32'h00000013; // addi x0 x0 0
    cache_r[54] = 32'h00000013; // addi x0 x0 0
    cache_r[55] = 32'h00000013; // addi x0 x0 0
    cache_r[56] = 32'h00000013; // addi x0 x0 0
end



    
    
endmodule
