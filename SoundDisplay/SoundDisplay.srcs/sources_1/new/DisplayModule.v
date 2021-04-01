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
    input border_switch, input volume_active, input [15:0] audio_in, input switch_left, input switch_right, input picture_switch,
    input btnU, btnC, btnL, btnR, btnD
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg [6:0] x_pos = 50;
    reg [6:0] y_pos = 50;
    reg reset = 0;
    reg [6:0] offset = 0;
    reg [15:0] new_index = 0;
    reg [6:0] y_temp = 0;
    
    wire frame_begin, sending_pixels, sample_pixel, teststate;

    //colour data
    parameter [15:0] green_bar = 16'h47E0;
    parameter [15:0] yellow_bar = 16'hFF60;
    parameter [15:0] red_bar = 16'hF800;
    reg startstate = 0;
    

    reg [14:0] picture[0:24576];
    reg [12:0] menu[0:6443];
//    reg [15:0] square2[0:6443];
//    reg [15:0] square3[0:6443];
//    reg [15:0] square4[0:6443];
//    reg [15:0] square5[0:6443];
//    reg [15:0] square6[0:6443];
//    reg [15:0] square7[0:6443];
//    reg [15:0] square8[0:6443];
//    reg [15:0] square9[0:6443];

    initial begin
        $readmemh("image.mem", picture);
        $readmemh("mainmenu.mem", menu);
//        $readmemh("square2.mem", square2);
//        $readmemh("square3.mem", square3);
//        $readmemh("square4.mem", square4);
//        $readmemh("square5.mem", square5);
//        $readmemh("square6.mem", square6);
//        $readmemh("square7.mem", square7);
//        $readmemh("square8.mem", square8);
//        $readmemh("square9.mem", square9);
//        $readmemh("square1.mem", square1);


    end

    always @ (*) begin
        if (btnU) begin 
            if (y_pos > 0) 
            y_pos = y_pos - 1;
        end
        if (btnD) begin 
            if (y_pos < 64)
            y_pos = y_pos + 1;
        end        
        if (btnR) begin 
            if (x_pos < 96)
            x_pos = x_pos + 1;
        end        
        if (btnL) begin 
            if (x_pos > 0)
            x_pos = x_pos - 1;
        end        
    end

    always @ (posedge clk6p25m) begin    
//        case (position) 
        if (startstate == 0) 
            oled_data <= menu[pixel_index];
       
        
        y = pixel_index / 96;
        x = pixel_index % 96;
        new_index <= (x + x_pos) + (192*(y + y_pos));
        


    end
        
    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);
      
endmodule
