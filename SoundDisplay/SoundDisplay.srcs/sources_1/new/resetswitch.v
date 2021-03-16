`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2021 11:27:17
// Design Name: 
// Module Name: resetswitch
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


module resetswitch(
    input clk,
    input button,
    output active
    );
    
    wire C1;
    wire C2;
    
    d_flipflop dff1 (clk, button, C1);
    d_flipflop dff2 (clk, C1, C2);
    
    assign active = C1 & C2;
    
endmodule
