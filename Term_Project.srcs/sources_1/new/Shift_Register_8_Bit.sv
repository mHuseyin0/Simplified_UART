`timescale 1ns / 1ps

module Shift_Register_8_Bit
    (input reg_clk, logic in, ld, [7:0] loadBits,
     output logic drop, [7:0] out);

     always @(out[0]) begin;
        drop <= out[0];
     end;
     
     MUX_2_To_1 logic7(in,     loadBits[7], ld, load7);
     MUX_2_To_1 logic6(out[7], loadBits[6], ld, load6);
     MUX_2_To_1 logic5(out[6], loadBits[5], ld, load5);
     MUX_2_To_1 logic4(out[5], loadBits[4], ld, load4);
     MUX_2_To_1 logic3(out[4], loadBits[3], ld, load3);
     MUX_2_To_1 logic2(out[3], loadBits[2], ld, load2);
     MUX_2_To_1 logic1(out[2], loadBits[1], ld, load1);
     MUX_2_To_1 logic0(out[1], loadBits[0], ld, load0);
     
     Flip_Flop bit7(reg_clk, load7, 1'b1, out[7]);
     Flip_Flop bit6(reg_clk, load6, 1'b1, out[6]);
     Flip_Flop bit5(reg_clk, load5, 1'b1, out[5]);
     Flip_Flop bit4(reg_clk, load4, 1'b1, out[4]);
     Flip_Flop bit3(reg_clk, load3, 1'b1, out[3]);
     Flip_Flop bit2(reg_clk, load2, 1'b1, out[2]);
     Flip_Flop bit1(reg_clk, load1, 1'b1, out[1]);
     Flip_Flop bit0(reg_clk, load0, 1'b1, out[0]);
        
endmodule
