`timescale 1ns / 1ps

module Flip_Flop
    (input ffclk, logic in, en,
    output logic out);
    
    always_ff @(posedge ffclk)
    begin;
        if (en) out <= in;
    end;
    
endmodule