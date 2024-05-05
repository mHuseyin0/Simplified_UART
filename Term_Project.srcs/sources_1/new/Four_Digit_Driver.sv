`timescale 1ns / 1ps

module Four_Digit_Driver
    (input clk, logic isT, [3:0] regNum, [7:0] dataByte,
    output logic [6:0] segment, [3:0] anode);

logic [24:0] counter = 0;
logic eights, fours, twos, ones, isLetter;

Digit_Logic segments(eights, fours, twos, ones, isLetter, isT,
    segment[0], segment[1], segment[2], segment[3], segment[4], segment[5], segment[6]);

always @(anode[3], anode[2], anode[1], anode[0]) begin;
    if (!anode[3]) begin;
        eights <= 1'b0;
        fours <= 1'b0;
        twos <= 1'b0;
        ones <= 1'b0;
        isLetter <= 1'b1;
    end;
    if (!anode[2]) begin;
        eights <= regNum[3];
        fours <= regNum[2];
        twos <= regNum[1];
        ones <= regNum[0];
        isLetter <= 1'b0;
    end;
    if (!anode[1]) begin;
        eights <= dataByte[7];
        fours <= dataByte[6];
        twos <= dataByte[5];
        ones <= dataByte[4];
        isLetter <= 1'b0;
    end;
    if (!anode[0]) begin;
        eights <= dataByte[3];
        fours <= dataByte[2];
        twos <= dataByte[1];
        ones <= dataByte[0];
        isLetter <= 1'b0;
    end;
end;

always @(posedge clk) begin;
    counter = counter + 1'b1;
    
    if (counter == 499_999) begin;
        if      (anode[3:0] == 4'b0111)    anode[3:0] = 4'b1011;
        else if (anode[3:0] == 4'b1011)    anode[3:0] = 4'b1101;
        else if (anode[3:0] == 4'b1101)    anode[3:0] = 4'b1110;
        else                            anode[3:0] = 4'b0111;
        counter = 0;
    end;
end;

endmodule