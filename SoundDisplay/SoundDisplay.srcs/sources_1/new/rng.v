`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 20:46:02
// Design Name: 
// Module Name: rng
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


module rng(
    input CLOCK, RESET, 
    output reg [3:0] Q = 0
    );
    
    always @ (posedge CLOCK, posedge RESET) begin
    
        if (RESET) 
            Q <= 0;
        else 
            Q <= { Q[2:0], ~(Q[2]^Q[3]) };
    end
        
endmodule
