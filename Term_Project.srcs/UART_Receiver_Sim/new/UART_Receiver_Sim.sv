`timescale 1ns / 1ps

module UART_Receiver_Sim;

    bit clock;
    logic received, active, ld, parityBit;
    logic [7:0] out, currentBits;
    logic [3:0] counter;

    UART_Receiver uut(clock, received, active, ld, parityBit, out, currentBits, counter);
    
    initial begin
        forever #5 clock = !clock;
    end;

    initial begin;
    
    received = 1'b1;
    
    #100 received = 1'b0;
    
    #10 received = 1'b1;
    #10 received = 1'b0;
    #10 received = 1'b1;
    #10 received = 1'b0;
    #10 received = 1'b1;
    #10 received = 1'b1;
    #10 received = 1'b0;
    #10 received = 1'b0;

    #10 received = 1'b1; // Parity bit
    #10 received = 1'b1;

    end;
endmodule
