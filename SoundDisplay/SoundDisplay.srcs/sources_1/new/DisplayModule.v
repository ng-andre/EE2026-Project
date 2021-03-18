`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2021 10:40:29
// Design Name: 
// Module Name: DisplayModule
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


module DisplayModule(
    input clk6p25m,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,//output of OLED display
    input border_switch
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg reset = 0;
    
    wire frame_begin, sending_pixels, sample_pixel, teststate;

    always @ (posedge clk6p25m) begin    
        if (border_switch) begin //3 pixel wide border
        
            if ((pixel_index % 96) == 0 || (pixel_index % 96) == 1 || (pixel_index % 96) == 2)
                 oled_data <= 16'b1111111111111111;//border_colour;
            else if ((pixel_index % 96) == 95 || (pixel_index % 96) == 94 || (pixel_index % 96) == 93)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if ((pixel_index / 96) == 0 || (pixel_index / 96) == 1 || (pixel_index / 96) == 2)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if ((pixel_index / 96) == 63 || (pixel_index / 96) == 62 || (pixel_index / 96) == 61)
                 oled_data <= 16'b1111111111111111;// border_colour;       
            else 
                oled_data <= 16'b0;
        end
        else begin
            if ((pixel_index % 96) == 0)
                 oled_data <= 16'b1111111111111111;//border_colour;
            else if ((pixel_index % 96) == 95)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if ((pixel_index / 96) == 0)
                 oled_data <= 16'b1111111111111111;// border_colour;
            else if ((pixel_index / 96) == 63)
                 oled_data <= 16'b1111111111111111;// border_colour;       
             else 
                oled_data <= 16'b0;
        end
        
    end
        
    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);
      
endmodule
