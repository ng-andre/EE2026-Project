`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 22:51:20
// Design Name: 
// Module Name: clock_3hz
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


module clock_3hz(
    input CLOCK,
    output reg clk
    );

    reg [25:0] counter = 0;
    
    initial begin
        clk = 0;
    end
    
    always @ (posedge CLOCK) begin
        counter <= counter + 1;
        if (counter == 25'd16800000) begin //roll over after 0.336 seconds
            counter <= 0;
            clk <= ~clk;
        end
    end
    
endmodule

