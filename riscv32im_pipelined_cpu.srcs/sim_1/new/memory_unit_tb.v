`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2024 04:30:08
// Design Name: 
// Module Name: main_tb
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


module memory_unit_tb();
    reg [31:0] address;
    reg [31:0] dataIn;
    reg RWMode;
    reg clk;
    reg reset;

    wire [31:0] dataOut;
    wire hit;

    integer count = 0;
    integer fp1;
    integer temp;
    integer instructionCount;
    integer oldInstructionCount;
    reg [31:0] A;
    
    memory_unit uut(
    .clk(clk),
    .address(address),
    .RWMode(RWMode),
    .dataIn(dataIn),
    .dataOut(dataOut),
    .reset(reset),
    .hit(hit)
    );
    initial begin 
        fp1 = $fopen("C:\\Users\\Administrator\\riscv32im_pipelined_cpu\\gcc2.txt", "r");
        dataIn = 1;
        clk = 0;
        count = 0;
        instructionCount = 0;
        oldInstructionCount = 0;
        RWMode = 0;
        reset = 1;
        #0.1;
        reset = 0; 
        #0.4;
        while(!$feof(fp1)) begin
            temp = $fscanf(fp1,"%h\n",A);
            address = A;
            RWMode = 0;
            dataIn <= dataIn + 1;
            instructionCount = instructionCount + 1; #4;
        end
        $fclose(fp1);
        $finish;
    end
    
    integer programStarted = 0;
    
    always begin
        if (programStarted == 0)begin
            #2;
            programStarted = 1;
        end
        else begin
            #1.6;
        end
        clk = ~clk;
        #0.4;
        temp = instructionCount - oldInstructionCount;
        if(temp !=0 && hit == 1)begin
            count = count + 1;
            oldInstructionCount = instructionCount;
        end
        $display("clk = %b hit = %b read = %b address = %h dataout = %h count = %d",clk,hit,uut.RWMode,address,dataOut,count);
        $display("\n inscount:%d count:%d",instructionCount,count);
        address = 32'bX;
        RWMode = 1'bX;
    end
    
endmodule
