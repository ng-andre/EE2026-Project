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
    input border_switch, input volume_active, input [11:0] audio_in
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg reset = 0;
    
    wire frame_begin, sending_pixels, sample_pixel, teststate;

    //colour data
    parameter [15:0] green_bar = 16'h47E0;
    parameter [15:0] yellow_bar = 16'hFF60;
    parameter [15:0] red_bar = 16'hF800;




    always @ (posedge clk6p25m) begin    
        //border
        y = pixel_index / 96;
        x = pixel_index % 96;
        if (border_switch) begin //3 pixel wide border
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
        else if (~border_switch) begin //1 pixel wide border
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
        //volume bar
        if (volume_active) begin //switch
            if (x > 42 && x < 53) begin
                if ((y == 55 || y == 54) && audio_in[0])  
                    oled_data = green_bar;
                else if ((y == 52 || y == 51) && audio_in[1])
                    oled_data = green_bar;
                else if ((y == 49 || y == 48) && audio_in[2])
                    oled_data = green_bar;
                else if ((y == 46 || y == 45) && audio_in[3])
                    oled_data = green_bar;     
                else 
                    oled_data <= 16'b0;
                end
            
            
        end
    end
        
    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);
      
endmodule
