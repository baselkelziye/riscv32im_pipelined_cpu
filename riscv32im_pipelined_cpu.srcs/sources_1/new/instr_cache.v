`timescale 1ns / 1ps

module instr_cache(input clk_i,//saat girisi
    input rst_i,// reset ucunun girisi
    input [31:0]address_i,//Komutun adresi, bu ya do�rudan program sayac� + 4 ve ya Dallanacak adresin de�erini tutar.
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

cache_r[0] = 32'h00a00093;// � addi x1, x0, 10 works nice
cache_r[1] = 32'h001000a3;// � sb x1, 0(x2)
cache_r[2] = 32'h00100103;// � lb x2, 0(x2)
cache_r[3] = 32'h00101183; //� lh x3, 0(x2)
cache_r[4] = 32'h00310233; //� sltu x4, x2, x3
cache_r[5] = 32'h401202b3; //� sub x5, x4, x1
cache_r[6] = 32'h0ff00f93; //� addi x31, x0, 255
cache_r[7] = 32'h02428333; //� add x6, x4, x36
cache_r[8] = 32'h025313b3; //� add x7, x6, x37
cache_r[9] = 32'h00100f13; //� slli x30, x0, 1
cache_r[10] = 32'h41e18433;// � sub x8, x3, x30
cache_r[11] = 32'h028354b3;// � add x9, x6, x40
cache_r[12] = 32'h02837533; //� add x10, x6, x40
cache_r[13] = 32'h00844eb3; //� slli x29, x8, 8
cache_r[14] = 32'h03d35e33; //� sub x28, x6, x61
cache_r[15] = 32'hf0100d93; //� andi x27, x0, -256
cache_r[16] = 32'h03b34d33; //� add x26, x6, x59
cache_r[17] = 32'h000015b7; //� lui x11, 0
cache_r[18] = 32'h00001617; //� auipc x12, 0
cache_r[19] = 32'h00100c33; //� slli x24, x0, 1
cache_r[20] = 32'h00100cb3;// � slli x25, x0, 1
cache_r[21] = 32'h00c0006f; //� jal x0, 12
cache_r[22] = 32'h00309c93; //� andi x25, x19, 3
cache_r[23] = 32'h4020dc13; //� subi x24, x1, -1024
cache_r[24] = 32'hff9c0ce3; //� bne x24, x31, -4
cache_r[25] = 32'h018ca6b3; //� ori x13, x25, 24
cache_r[26] = 32'h019c2733; //� andi x14, x24, 25
cache_r[27] = 32'h00e6e7b3; //� ori x15, x13, 14
cache_r[28] = 32'h0ff77813; //� andi x16, x14, 255




//ASSIGN EACH REGISTER TO ITS VALUE

//cache_r[0] = 32'h00100093;
//cache_r[1] = 32'h00200113;
//cache_r[2] = 32'h00300193;
//cache_r[3] = 32'h00400213;
//cache_r[4] = 32'h00500293;
//cache_r[5] = 32'h00600313;
//cache_r[6] = 32'h00700393;
//cache_r[7] = 32'h00800413;
//cache_r[8] = 32'h00900493;
//cache_r[9] = 32'h00a00513;
//cache_r[10] = 32'h00b00593;
//cache_r[11] = 32'h00c00613;
//cache_r[12] = 32'h00d00693;
//cache_r[13] = 32'h00e00713;
//cache_r[14] = 32'h00f00793;
//cache_r[15] = 32'h01000813;
//cache_r[16] = 32'h01100893;
//cache_r[17] = 32'h01200913;
//cache_r[18] = 32'h01300993;
//cache_r[19] = 32'h01400a13;
//cache_r[20] = 32'h01500a93;
//cache_r[21] = 32'h01600b13;
//cache_r[22] = 32'h01700b93;
//cache_r[23] = 32'h01800c13;
//cache_r[24] = 32'h01900c93;
//cache_r[25] = 32'h01a00d13;
//cache_r[26] = 32'h01b00d93;
//cache_r[27] = 32'h01c00e13;
//cache_r[28] = 32'h01d00e93;
//cache_r[29] = 32'h01e00f13;
//cache_r[30] = 32'h01f00f93;





//cache_r[0] = 32'b00000110010000000000000010010011;// addi x1, x0, 100
//cache_r[1] = 32'b00000110010000000000000100010011;// addi x2, x0, 100
//cache_r[2] = 32'b00000110010000000000000110010011;// addi x3, x0, 100
//cache_r[3] = 32'b00000110010000000000001000010011;// addi x4, x0, 100
//cache_r[4] = 32'b00000110010000000000001010010011;// addi x5, x0, 100
//cache_r[5] = 32'b00000110010000000000001100010011;// addi x6, x0, 100
//cache_r[6] = 32'b00000110010000000000001110010011;// addi x7, x0, 100
//cache_r[7] = 32'b00000000000100001000010000110011;// add x8,x1,x1
//cache_r[8] = 32'b00000000000100001000010010110011;// add x9,x1,x1
//cache_r[9] = 32'b00000000001000010000010100110011;// add x10,x2,x2

    end
    
    
endmodule