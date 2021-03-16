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
    input clk6p25m, active, 
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden//output of OLED display
    );
    
    reg [15:0] colour_data;
    reg [15:0] oled_data = 0;
    wire [12:0] pixel_index; // 0 to 6143, 96x64 pixels
    reg [6:0] x = 0;
    reg [6:0] y = 0;
    
    Oled_Display Oled_Display (clk6p25m, 0, , , , pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
    pmoden,);
              

    always @ (posedge clk6p25m) begin
    
    
        if (active) begin
            if ((pixel_index % 96) == 0)
                 oled_data <= 16'b1111111111111111;//border_colour;
             else if ((pixel_index % 96) == 95)
                 oled_data <= 16'b1111111111111111;// border_colour;
             else if ((pixel_index / 96) == 0)
                 oled_data <= 16'b1111111111111111;// border_colour;
             else if ((pixel_index / 96) == 63)
                 oled_data <= 16'b1111111111111111;// border_colour;
        end
    end
endmodule
