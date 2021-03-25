`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2021 10:07:46
// Design Name: 
// Module Name: volume_display
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


module volume_display(
    input sclk, // 20khz
    input [11:0] mic_in,
    //output reg [3:0] an,
    //output reg [7:0] seg,
    output reg [3:0] levels,
    output reg [15:0] lights
    );
    
    reg [11:0] max;
    reg [9:0] sample_count = 10'b0;
    
    always @(posedge sclk) begin
        sample_count <= sample_count + 1;
        if (mic_in > max) 
            max <= mic_in;
        if (sample_count == 0) begin
           // levels = (max - 2071 ) / 135; // (max - 1984) /132
            //levels = (levels << 1) + 1;
            if (max <= 2071)
                levels = 0;
            else if (max <= 2206)
                levels = 1;
            else if (max <= 2341)
                levels = 2;
            else if (max <= 2476)
                levels = 3;
            else if (max <= 2611)
                levels = 4;
            else if (max <= 2746)
                levels = 5;
            else if (max <= 2881)
                levels = 6;
            else if (max <= 3016)
                levels = 7;
            else if (max <= 3151)
                levels = 8;
            else if (max <= 3286)
                levels = 9;
            else if (max <= 3421)
                levels = 10;
            else if (max <= 3556)
                levels = 11;
            else if (max <= 3691)
                levels = 12;
            else if (max <= 3826)
                levels = 13;
            else if (max <= 3961)
                levels = 14;
            else if (max <= 4096)
                levels = 15;           

            //  
             
            lights <= ((2 ** levels) | ((2 ** levels) -1));
            max = 0;
        end
    
    
    
     end       

                        
endmodule
