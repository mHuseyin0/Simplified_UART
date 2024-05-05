`timescale 1ns / 1ps

module Digit_Logic
    (input logic w3, w2, w1, w0, isLetter, isT,
    output logic a, b, c, d, e, f, g);
    
    always @(w3, w2, w1, w0, isLetter, isT) begin;
        if (isLetter) begin
            a <= 1'b1;
            b <= 1'b1;
            c <= 1'b1;
            
            g <= 1'b0;
            e <= 1'b0;
            
            if (~isT) begin
                f <= 1'b1;
                d <= 1'b1;
            end
            else begin
                f <= 1'b0;
                d <= 1'b0;
            end
        end
        else begin
            a <=    (w2 & ~w1 & ~w0)        	| 
                    (w3 & w2 & ~w1)         	| 
                    (~w3 & ~w2 & ~w1 & w0)  	| 
                    (w3 & ~w2 & w1 & w0);
            b <=    (w3 & w1 & w0)          	|
                    (~w3 & w2 & ~w1 & w0)   	|
                    (~w3 & w2 & w1 & ~w0)   	|
                    (w3 & w2 & ~w1 & ~w0);
            c <=    (w3 & w2 & ~w0)         	|
                    (w3 & w2 & w1)          	|
                    (~w3 & ~w2 & w1 & ~w0);
            d <=    (w2 & w1 & w0)          	|
                    (~w3 & ~w2 & ~w1 & w0)  	|
                    (~w3 & w2 & ~w1 & ~w0);
            e <=    (~w3 & w0)              	|
                    (~w2 & ~w1 & w0)        	|
                    (~w3 & w2 & ~w1);
            f <=    (~w3 & ~w2 & w0)        	|
                    (~w2 & w1 & ~w0)        	|
                    (~w3 & w1 & w0)         	|
                    (w3 & w2 & ~w1);
            g <=    (~w3 & ~w2 & ~w1)       	|
                    (~w3 & w2 & w1 & w0);
        end
    end;
endmodule