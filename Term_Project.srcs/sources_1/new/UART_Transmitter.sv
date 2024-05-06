`timescale 1ns / 1ps

module UART_Transmitter
    (input clock, logic init, ld, [7:0] dataBits,
     output logic out, [7:0] byte0, byte1, byte2, buffer);
     
     logic active, shiftOut, select, initialize, parityBit;
     logic [3:0] counter;
     logic [7:0] sendByte, currentBits;
     
     bit isOddParity = 0;

     or or1(select, counter[3], counter[2], counter[1]);
     
     MUX_2_To_1 outLogic(~active, shiftOut, select, out);
     
     always_ff @(posedge clock) begin;
        if (~active && init) begin
            active <= 1'b1;
            counter <= 4'b1;
            initialize <= 1'b1;
            sendByte <= buffer;
            parityBit <= ^buffer;
            if (isOddParity) parityBit <= ~parityBit;
        end 
        else if (active) begin
            initialize <= 1'b0;
            if (counter < 4'b1010)  counter <= counter + 1'b1;
            if (counter == 4'b0010) parityBit <= 1'b1; // Already registered parity bit, replace it with stop bit;
            if (counter == 4'b1010 && ~init) begin;
                active <= 1'b0;
                counter <= 4'b0;
            end;
        end
        else begin
            active <= 1'b0;
            counter <= 4'b0;
        end;
     end;
     
     Register_8_Bit TXBUF0(clock, ld, dataBits, byte0);
     Register_8_Bit TXBUF1(clock, initialize  , byte0, byte1);
     Register_8_Bit TXBUF2(clock, initialize  , byte1, byte2);
     Register_8_Bit TXBUF3(clock, initialize  , byte2, buffer);
     Shift_Register_8_Bit TX(clock, parityBit , initialize, sendByte, shiftOut, currentBits);
     
endmodule
