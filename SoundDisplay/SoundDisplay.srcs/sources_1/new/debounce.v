`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2021 22:34:17
// Design Name: 
// Module Name: debounce
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


module debounce(
    input CLOCK, button,
    output signal
    );
    
    wire dff1_output;
    wire dff2_output;
    
    d_flipflop dff1 (CLOCK, button, dff1_output);
    d_flipflop dff2 (CLOCK, dff1_output, dff2_output);

    assign signal = dff1_output && ~dff2_output;

endmodule
