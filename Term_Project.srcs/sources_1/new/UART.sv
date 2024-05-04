`timescale 1ns / 1ps

module UART
    (input clk, logic btnD, btnC, upperRightPmod, [7:0] sw,
     output logic upperLeftPmod, [15:0] led);

     logic [13:0] counter;
     logic sig;
     
     UART_Transmitter transmissionModule(sig, btnC, btnD, sw[7:0], upperLeftPmod);
     UART_Receiver receptionModule(sig, upperRightPmod, parityBit, led[15:8]);

     always_ff @(posedge clk) begin;
        if (counter < 10417) begin
            counter <= counter + 1'b1;
            sig <= 1'b0;
        end
        else begin
            counter <= 10'b0;
            sig <= 1'b1;
        end
        
        if (btnD) led[7:0] <= sw[7:0];

    end;
endmodule
