`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2021 10:37:53
// Design Name: 
// Module Name: MUX_21
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


module MUX_21(
    input sw,
    input [11:0] mic_in,
    output [11:0] led
    );
    assign led = sw ? 0 : mic_in;
endmodule
