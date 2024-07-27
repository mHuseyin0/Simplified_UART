`timescale 1ns / 1ps

module UART_Sim;

    bit clock;
    logic btnD, btnC, upLeftPMod, upRightPMod;
    logic [7:0] sw;
    logic [15:0] led;
    
    UART uut(clock, btnD, btnC, upRightPMod, sw, upLeftPMod, led);
    
    initial begin
        forever #5 clock = !clock;
    end;

    initial begin;
    
    sw = 8'b00110101;
    btnD = 1'b1;
    
    #100 btnD = 1'b0; btnC = 1'b1;
    #300 btnC = 1'b0;
    
    end;
endmodule
