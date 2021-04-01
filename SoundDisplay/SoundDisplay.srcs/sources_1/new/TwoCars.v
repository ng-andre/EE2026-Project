`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2021 21:58:12
// Design Name: 
// Module Name: TwoCars
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


module TwoCars(
    input clk6p25m,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden,//output of OLED display
    input btnU, btnD
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    reg reset = 0;
    reg [6:0] offset = 0;
    reg [15:0] new_index = 0;
    reg [12:0] gameover[0:6443];

    wire frame_begin, sending_pixels, sample_pixel, teststate;

    reg lane_car1 = 0;
    reg lane_car2 = 0;
    
    reg [16:0] counter = 0;
    
    initial begin
       $readmemh("gameover.mem", gameover);
    end


    reg gameoverflag = 0;
    //objects
    reg [6:0] x1 = 96;
    reg [6:0] y1 = 4;
    reg [6:0] x2 = 96;
    reg [6:0] y2 = 20;
    reg [6:0] x3 = 96;
    reg [6:0] y3 = 44;
    reg [6:0] x4 = 96;
    reg [6:0] y4 = 59;

    reg [6:0] x1_offset = 0;
    reg [6:0] y1_offset = 0;
    reg [6:0] x2_offset = 0;
    reg [6:0] y2_offset = 0;
    reg [6:0] x3_offset = 0;
    reg [6:0] y3_offset = 0;
    reg [6:0] x4_offset = 0;
    reg [6:0] y4_offset = 0;
    
    //clocks
    



    //switch lanes
    always @ (posedge btnU, posedge btnD) begin
        if (btnU) begin
            lane_car1 <= ~lane_car1;
        end
        if (btnD) begin
            lane_car2 <= ~lane_car2;
        end
    end 

    always @ (posedge clk6p25m) begin
        y = pixel_index / 96;
        x = pixel_index % 96;
        

        counter <= counter + 1;
        if (counter == 0) begin
            x1_offset <= x1_offset + 1;    
            x2_offset <= x2_offset + 1;    
            x3_offset <= x3_offset + 1;    
            x4_offset <= x4_offset + 1;    
        end
        
        //draw background
        if (y < 15)
            oled_data <= 16'h24F7;
        if (y == 15)
            oled_data <= 16'hEF5D;
        if (y > 15 && y < 30)
            oled_data <= 16'h0188;
        if (y == 32 || y == 33)
            oled_data <= 16'hFFDF;
        if (y > 33 && y < 48)
            oled_data <= 16'hFDA0;
        if (y == 48)
            oled_data <= 16'hEF5D;
        if (y > 48) 
            oled_data <= 16'hFC20;

    
        if (lane_car1) begin
            if ((x > 6 && x < 13) && (y > 4 && y < 11))
                oled_data <= 16'hF800;
        end 
        else begin
            if ((x > 6 && x < 13) && (y > 20 && y < 27))
                oled_data <= 16'hF800;
        end
        if (lane_car2) begin
            if ((x > 6 && x < 13) && (y > 37 && y < 44))
                oled_data <= 16'h025F;
        end 
        else begin
            if ((x > 6 && x < 13) && (y > 52 && y < 59))
                oled_data <= 16'h025F;
        end
            
        //obstacles
        if ((x > (x1 - x1_offset) && x < (x1 - x1_offset + 5)) && (y > (y1 + y1_offset) && y < (y1 + y1_offset + 5)))
                oled_data <= 16'h0;
        if ((x > (x3 - x3_offset) && x < (x3 - x3_offset + 5)) && (y > (y3 + y3_offset) && y < (y3 + y3_offset + 5)))
                oled_data <= 16'h0;
//        else begin
//            if ((x > 6 && x < 13) && (y > 20 && y < 27))
//                oled_data <= 16'hF800;
//        end
//        if (lane_car2) begin
//            if ((x > 6 && x < 13) && (y > 37 && y < 44))
//                oled_data <= 16'h025F;
//        end 
        if (x1_offset == 96)
            x1_offset <= 0;
//         || x2_offset == 90 || x3_offset == 90 || x4_offset == 90)
        if (x1_offset == 80 && lane_car1)
            gameoverflag = 1;

        if (gameoverflag)
            oled_data <= gameover[pixel_index];

    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
      pmoden,teststate);
    
endmodule
