`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2021 23:56:25
// Design Name: 
// Module Name: MainMenu
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


module MainMenu(
    input clk6p25m,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,//output of OLED display
    input btnU, btnD, clk3hz
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg reset = 0;
    reg [6:0] offset = 0;
    reg [15:0] new_index = 0;
    reg [12:0] mainmenu[0:6443];

    wire frame_begin, sending_pixels, sample_pixel, teststate;

    
    reg [21:0] blink_counter = 0;
    reg [1:0] cursor = 0;
    
    initial begin
           $readmemh("mainmenu.mem", mainmenu);
    end
    
    always @ (posedge btnU, posedge btnD) begin
        if (btnU) begin
//            if (cursor > 0)
                cursor <= cursor - 1;
        end
        if (btnD) begin
//            if (cursor < 3)
                cursor <= cursor + 1;
        end
    end 
    
    always @ (posedge clk6p25m) begin
        y = pixel_index / 96;
        x = pixel_index % 96;
        
        oled_data <= mainmenu[pixel_index];

        if (cursor == 0) begin
            if (y == 22 && x == 19)
                oled_data <= 16'h67ed;
            if (y == 23 && (x == 19 || x == 20))
                oled_data <= 16'h67ed;
            if (y == 24 && (x == 19 || x == 20 || x == 21))
                oled_data <= 16'h67ed;
            if (y == 25 && (x == 19 || x == 20 || x == 21 || x == 22))
                oled_data <= 16'h67ed;
            if (y == 26 && (x == 19 || x == 20 || x == 21 || x == 22))
                oled_data <= 16'h67ed;
            if (y == 27 && (x == 19 || x == 20 || x == 21))
                oled_data <= 16'h67ed;
            if (y == 28 && (x == 19 || x == 20))
                oled_data <= 16'h67ed;
            if (y == 29 && x == 19)
                oled_data <= 16'h67ed;
        end
        if (cursor == 1) begin
            if (y == 38 && x == 19)
                oled_data <= 16'h67ed;
            if (y == 39 && (x == 19 || x == 20))
                oled_data <= 16'h67ed;
            if (y == 40 && (x == 19 || x == 20 || x == 21))
                    oled_data <= 16'h67ed;
            if (y == 41 && (x == 19 || x == 20 || x == 21 || x == 22))
                    oled_data <= 16'h67ed;
            if (y == 42 && (x == 19 || x == 20 || x == 21 || x == 22))
                    oled_data <= 16'h67ed;
            if (y == 43 && (x == 19 || x == 20 || x == 21))
                    oled_data <= 16'h67ed;
            if (y == 44 && (x == 19 || x == 20))
                    oled_data <= 16'h67ed;
            if (y == 45 && x == 19)
                    oled_data <= 16'h67ed;
        end
        if (cursor == 2) begin
            if (y == 52 && x == 19)
                oled_data <= 16'h67ed;
            if (y == 53 && (x == 19 || x == 20))
                oled_data <= 16'h67ed;
            if (y == 54 && (x == 19 || x == 20 || x == 21))
                    oled_data <= 16'h67ed;
            if (y == 55 && (x == 19 || x == 20 || x == 21 || x == 22))
                    oled_data <= 16'h67ed;
            if (y == 56 && (x == 19 || x == 20 || x == 21 || x == 22))
                    oled_data <= 16'h67ed;
            if (y == 57 && (x == 19 || x == 20 || x == 21))
                    oled_data <= 16'h67ed;
            if (y == 58 && (x == 19 || x == 20))
                    oled_data <= 16'h67ed;
            if (y == 59 && x == 19)
                    oled_data <= 16'h67ed;
            end

    end
    
    
    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);

    
endmodule
