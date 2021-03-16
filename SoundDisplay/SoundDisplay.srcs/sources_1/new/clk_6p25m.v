`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2021 11:26:44
// Design Name: 
// Module Name: clk_6p25m
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


module clk_6p25m(
    input CLOCK,
    output reg clock_out
    );
    
    reg [4:0] counter;
    
    always @ (posedge CLOCK) begin 
        counter = counter + 1;
        if (counter == 0) 
            clock_out <= ~clock_out;
    end
    
endmodule
