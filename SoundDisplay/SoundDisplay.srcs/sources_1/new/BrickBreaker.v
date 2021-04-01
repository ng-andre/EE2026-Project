`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 23:00:09
// Design Name: 
// Module Name: BrickBreaker
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


module BrickBreaker(
    input clk6p25m,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,//output of OLED display
    input //buttons
    input 
    );
    
    reg start = 1;
    reg [5:0] bat_position = 25; //pegged to bottom left of bat
    reg [6:0] ball_x;
    reg [6:0] ball_y;
    
    //always @ button
    if (btnL && bat_position > 0) begin
        bat_position <= bat_position - 1;
    end
    if (btnR && bat_position < 53) begin
        bat_position <= bat_position + 1;
    end
    
    
    
    
    
endmodule
