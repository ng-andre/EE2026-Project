`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2021 14:37:56
// Design Name: 
// Module Name: AudioVisualiser
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


module AudioVisualiser(
    input clk6p25m,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,//output of OLED display
    input [15:0] audio_in, 
    input [5:0] sw
);

    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg reset = 0;
    reg [6:0] offset = 0;
    
    wire frame_begin, sending_pixels, sample_pixel, teststate;
    
    //colour data
    parameter [15:0] green_bar = 16'h47E0;
    parameter [15:0] yellow_bar = 16'hFF60;
    parameter [15:0] red_bar = 16'hF800;
    
    reg [21:0] blink_counter = 0;
    reg [1:0] cursor = 0;


    always @ (posedge clk6p25m) begin    
        
        y = pixel_index / 96;
        x = pixel_index % 96;
    
        oled_data <= 16'b0;
        
        if (sw[3]) 
            offset <= 0;
        else if (sw[4]) 
            offset <= 20;
        else 
            offset <= 10;

        if (sw[1]) begin //3 pixel wide border
            if (y == 0 || y == 1 || y == 2)
                 oled_data <= 16'b1111111111111111;//border_colour;
            else if (y == 63 || y == 62 || y == 61)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if (x == 0 || x == 1 || x == 2)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if (x == 95 || x == 94 || x == 93)
                 oled_data <= 16'b1111111111111111;// border_colour;       
            else 
                oled_data <= 16'b0;
        end
        else if (sw[2]) begin //1 pixel wide border
            if (y == 0)
                 oled_data <= 16'b1111111111111111;//border_colour;
            else if (y == 63)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if (x == 0)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if (x == 95)
                 oled_data <= 16'b1111111111111111;// border_colour;       
            else 
                oled_data <= 16'b0;
        end
        if (sw[0]) begin //switch
            if ((x + offset) > 52 && (x + offset) < 63) begin
                if ((y == 55 || y == 54) && (audio_in[0] == 1))  
                    oled_data <= green_bar;
                else if ((y == 52 || y == 51) && (audio_in[1] == 1))
                    oled_data <= green_bar;
                else if ((y == 49 || y == 48) && (audio_in[2] == 1))
                    oled_data <= green_bar;
                else if ((y == 46 || y == 45) && (audio_in[3] == 1))
                    oled_data <= green_bar; 
                else if ((y == 43 || y == 42) && (audio_in[4] == 1))
                    oled_data <= green_bar; 
                else if ((y == 41 || y == 40) && (audio_in[5] == 1))
                    oled_data <= yellow_bar; 
                else if ((y == 38 || y == 37) && (audio_in[6] == 1))
                    oled_data <= yellow_bar;
                else if ((y == 35 || y == 34) && (audio_in[7] == 1))    
                    oled_data <= yellow_bar;
                else if ((y == 32 || y == 31) && (audio_in[8] == 1))    
                    oled_data <= yellow_bar;
                else if ((y == 29 || y == 28) && (audio_in[9] == 1))    
                    oled_data <= yellow_bar;
                else if ((y == 26 || y == 25) && (audio_in[10] == 1))
                    oled_data <= red_bar;    
                else if ((y == 23 || y == 22) && (audio_in[11] == 1))    
                    oled_data <= red_bar;
                else if ((y == 20 || y == 19) && (audio_in[12] == 1))    
                    oled_data <= red_bar; 
                else if ((y == 17 || y == 16) && (audio_in[13] == 1))
                    oled_data <= red_bar;
                else if ((y == 14 || y == 13) && (audio_in[14] == 1))
                    oled_data <= red_bar;
                else if ((y == 11 || y == 10) && (audio_in[15] == 1))
                    oled_data <= 16'hFFFF;
                end
            end        
            if (sw[5]) begin //need to fix tint
                oled_data <= oled_data + 16'hFF;
            end
            else if (sw[6]) begin
                oled_data <= oled_data + 16'hF;
            end
        end

    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);


endmodule
