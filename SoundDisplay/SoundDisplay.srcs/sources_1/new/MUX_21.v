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
    input [15:0] lights,
    input [11:0] mic_in,
    output [15:0] led
    );
//    wire levels, peak_vol;
//    volume_display vol_d(sclk, mic_in, levels, peak_vol);
    assign led = sw ? lights : mic_in;
endmodule
