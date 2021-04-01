`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2021 00:10:07
// Design Name: 
// Module Name: rng_sim
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


module rng_sim(
    );
    
    reg CLOCK = 0;
    reg RESET = 0;
    
    wire [3:0] out;
    
    rng dut(CLOCK, RESET, out);
    
    initial begin
        CLOCK = 0;
        RESET = 0;
    end

    always begin
        #5 CLOCK = ~CLOCK;
    end
    
endmodule
