`timescale 1ns / 1ps

module UART_Transmitter_Sim;

    bit clock;
    logic init, ld, out;
    logic [7:0] loadBits, currentBits, buffer;
    
    logic active, shiftOut, select, initialize, parityBit;
    logic [3:0] counter;

    UART_Transmitter uut(clock, init, ld, loadBits, out,
    active, shiftOut, select, initialize, parityBit, counter, currentBits, buffer);
    
    initial begin
        forever #5 clock = !clock;
    end;

    initial begin;
    
    loadBits <= 8'b00110101; ld <= 1'b1;
    #100 init <= 1'b1;
    
    end;
endmodule
