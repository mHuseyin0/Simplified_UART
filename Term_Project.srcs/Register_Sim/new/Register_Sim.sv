`timescale 1ns / 1ps

module Register_Sim;

    bit clock;
    logic in, drop, ld;
    logic [7:0] out, loadBits;

    Shift_Register_8_Bit uut(clock, in, ld, loadBits, drop, out);
    
    initial begin
        forever #5 clock = !clock;
    end;

    initial begin;
    
    in = 1'b1;
    loadBits = 8'b00110101;
    
    #15 ld = 1'b1;
    #15 ld = 1'b0;
    #15 ld = 1'b1;
    #15 ld = 1'b0;
    #15 ld = 1'b1;
    #15 ld = 1'b0;
    #15 ld = 1'b1;
    #15 ld = 1'b0;
    
    end;
endmodule
