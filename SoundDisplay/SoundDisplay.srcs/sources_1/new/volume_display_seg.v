`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 17:42:01
// Design Name: 
// Module Name: volume_display_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module volume_display_seg(
    input [3:0] levels,
    input CLOCK,
    output reg [3:0] an,
    output reg [6:0] seg
    );
        
    reg [17:0] counter = 18'b0;
    reg [3:0] lights = 4'b0;
    
    always @(posedge CLOCK) begin
        counter <= counter + 1;
        
        if (lights == 4'b0) begin
            an = 4'b1110;
            case (levels)
                0: seg = 7'b100_0000;
                1: seg = 7'b111_1001;
                2: seg = 7'b010_0100;
                3: seg = 7'b011_0000;
                4: seg = 7'b001_1001;
                5: seg = 7'b001_0010;
                6: seg = 7'b000_0010;
                7: seg = 7'b111_1000;
                8: seg = 7'b000_0000;
                9: seg = 7'b001_0000;
                10: seg = 7'b100_0100;
                11: seg = 7'b111_1001;
                12: seg = 7'b010_0100;
                13: seg = 7'b011_0000;
                14: seg = 7'b001_1001;
                default: seg = 7'b001_0010;
           endcase
           if (counter == 0)
            lights <= 4'b0001;
        end
        
        else if (lights == 4'b0001) begin
            an = 4'b1101;
            if (levels > 9)
                seg = 7'b111_1001;
            else 
                seg = 7'b100_0000;
            
            if (counter == 0)
                lights <= 4'b0011;
        end
        
        else if (lights == 4'b0011) begin
            an = 4'b0111;
            if (levels > 10) //H
                seg = 7'b000_1001;
            else if (levels > 4) //M
                seg = 7'b110_1010;
            else  // L
                seg = 7'b100_0111;
            if (counter == 0)
                lights <= 4'b0000;
        end
        
    end     
                           
endmodule
