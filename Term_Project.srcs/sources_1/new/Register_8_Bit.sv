`timescale 1ns / 1ps

module Register_8_Bit
    (input reg_clk, logic ld, [7:0] in,
     output logic [7:0] out);
     
     initial out[7:0] <= 0;
     
    always_ff @(posedge reg_clk)
        begin;
            if (ld) out[7:0] <= in[7:0];
        end;
    
endmodule
