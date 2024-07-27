`timescale 1ns / 1ps

module UART_Receiver
    (input clock, logic received,
     output logic parityBit, [7:0] byte0, byte1, byte2, out);
        
     logic active, ld;
     logic [3:0] counter;
     logic [7:0] currentBits;
          
     Shift_Register_8_Bit RX(clock, received, 1'b0, 'd0, shiftOut, currentBits);
     
     Register_8_Bit RXBUF0(clock, ld, currentBits, byte0);
     Register_8_Bit RXBUF1(clock, ld, byte0, byte1);
     Register_8_Bit RXBUF2(clock, ld, byte1, byte2);
     Register_8_Bit RXBUF3(clock, ld, byte2, out);

     always_ff @(posedge clock) begin;
        if (~active && ~received) begin
            active <= 1'b1;
            counter <= 4'b0;
        end
        else if (active) begin
            counter <= counter + 1'b1;
            if (counter == 4'b0111) ld <= 1'b1;
            if (counter == 4'b1000) ld <= 1'b0;
            if (counter == 4'b1001) begin;
                parityBit <= currentBits[7];
                active <= 1'b0;
                counter <= 4'b0;
            end;
        end
        else begin
            active <= 1'b0;
            counter <= 4'b0;
        end;
     end;
endmodule
