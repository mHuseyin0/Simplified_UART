`timescale 1ns / 1ps

module MUX_2_To_1
    (input logic a, b, s,
     output logic out);

    always @(a,b,s) begin;
        out <= (b & s) | (a & ~s);
    end;
    
endmodule
