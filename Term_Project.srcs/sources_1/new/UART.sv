`timescale 1ns / 1ps

module UART
    (input clk, logic btnU, btnD, btnC, btnL, btnR, upperRightPmod, mode, [7:0] sw,
     output logic upperLeftPmod, [15:0] led, [6:0] seg, [3:0] an);

     logic [26:0] cooldownCounter;
     logic [13:0] counter;
     logic sig, isT, active, initSig, sendAll, sendingAll;
     logic [7:0] t0, t1, t2, t3, r0, r1, r2, r3, dataByte;
     logic [3:0] regNum;
     logic [6:0]sendAllCounter;
     
     MUX_2_To_1 switchMode(btnC, sendAll, mode, initSig);
     
     UART_Transmitter transmissionModule(sig, initSig, btnD, sw[7:0], upperLeftPmod, t0, t1, t2, t3);
     UART_Receiver receptionModule(sig, upperRightPmod, parityBit, r0, r1, r2, r3);

     Four_Digit_Driver(clk, isT, regNum, dataByte, seg, an);
     
     always @(r3) begin;
        led[15:8] <= r3;
     end;
     
     initial begin
        isT <= 1'b1;
        sendAll <= 1'b0;
        sendingAll <= 1'b0;
     end
     
     // 7-seg display 
     always @(regNum, isT) begin;
        if (~isT) begin
            case (regNum)
                3: dataByte <= r3;
                2: dataByte <= r2;
                1: dataByte <= r1;
                default: dataByte <= r0;
            endcase
        end
        else begin
            case (regNum)
                3: dataByte <= t3;
                2: dataByte <= t2;
                1: dataByte <= t1;
                default: dataByte <= t0;
            endcase
        end
     end;

     always_ff @(posedge clk) begin;
        // Baud rate logic
        if (counter < 10417) begin
            counter <= counter + 1'b1;
            sig <= 1'b0;
        end
        else begin
            counter <= 10'b0;
            sig <= 1'b1;
            
            if(mode && btnC && ~sendingAll) begin
                sendingAll <= 1'b1;
                sendAllCounter <= 0;
            end
            else if (sendingAll) begin
                if (sendAllCounter < 63) sendAllCounter <= sendAllCounter + 1'b1;
                
                case (sendAllCounter)
                    15: sendAll <= 1'b1;
                    31: sendAll <= 1'b1;
                    47: sendAll <= 1'b1;
                    63: begin
                        sendAll <= 1'b1;
                        if (~btnC) begin
                            sendAllCounter <= 1'b0;
                            sendingAll <= 0;
                        end
                    end
                    default: sendAll <= 1'b0;
                endcase
            end 
        end
        
        // Display the last entered value to transmitter registers on righmtmost 8 leds
        if (btnD) led[7:0] <= sw[7:0];
        
        if (~active) begin
            
            // Set initial value
            if (~(regNum < 4'b0100)) regNum <= 4'b0000;
            
            // Start cooldown
            if (btnL || btnR || btnU) begin
                active <= 1'b1;
                cooldownCounter <= 0;
            end
            
            // 7-seg display shift left
            if (btnL && regNum > 4'b0000) regNum <= regNum - 1'b1;
            else if (btnL) regNum <= 4'b0011;
            
            // 7-seg display shift right
            if (btnR && regNum < 4'b0011) regNum <= regNum + 1'b1;
            else if (btnR) regNum <= 4'b0000;
            
            // 7-seg display switch displayed registers between transmit and receipt
            if (btnU) isT <= ~isT;
        end
        // .25 seconds cooldown logic
        else if (cooldownCounter < 25_000_000) cooldownCounter <= cooldownCounter + 1'b1;
        else begin
            cooldownCounter <= 0;
            active <= 1'b0;
        end
        
    end;
endmodule