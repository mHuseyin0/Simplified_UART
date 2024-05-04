`timescale 1ns / 1ps

module UART_Receiver
    (input clock, logic received,
     output logic parityBit, [7:0] out);
        
        
     logic active, ld;
     logic [7:0] currentBits;
     logic [3:0] counter;
     
     
     Shift_Register_8_Bit RX(clock, received, 1'b0, 'd0, shiftOut, currentBits);
     Register_8_Bit RXBUF(clock, ld, currentBits, out);

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
