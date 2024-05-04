`timescale 1ns / 1ps

module UART_Transmitter
    (input clock, logic init, ld, [7:0] dataBits,
     output logic out
     );
     /*,
     logic active, shiftOut, select, initialize, parityBit,
     logic [3:0] counter,
     logic [7:0] currentBits, buffer);
     */
     logic active, shiftOut, select, initialize, parityBit;
     logic [3:0] counter;
     logic [7:0] currentBits, buffer;
     
     bit isOddParity = 0;

     or or1(select, counter[3], counter[2], counter[1]);
     
     MUX_2_To_1 outLogic(~counter[0], shiftOut, select, out);
     
     always_ff @(posedge clock) begin;
        if (~active && init) begin
            active <= 1'b1;
            counter <= 4'b0;
            initialize <= 1'b1;
            parityBit <= ^buffer;
            if (isOddParity) parityBit <= ~parityBit;
        end 
        else if (active) begin
            counter <= counter + 1'b1;
            if (counter == 4'b0001) initialize <= 1'b0;
            if (counter == 4'b0010) parityBit <= 1'b1; // Already registered parity bit, replace it with stop bit;
            if (counter == 4'b1010) begin;
                active <= 1'b0;
                counter <= 4'b0;
            end;
        end
        else begin
            active <= 1'b0;
            counter <= 4'b0;
        end;
     end;
     
     Register_8_Bit TXBUF(clock, ld, dataBits, buffer);
     Shift_Register_8_Bit TX(clock, parityBit, initialize, buffer, shiftOut, currentBits);
     
endmodule
