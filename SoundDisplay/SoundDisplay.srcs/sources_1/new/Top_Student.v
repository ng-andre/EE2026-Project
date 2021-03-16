`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input J_MIC_Pin3,   // Connect from this signal to Audio_Capture.v
    input CLK100MHZ,
    input sw,
    input btnC,
    output [7:0] JC,
    output J_MIC_Pin1,
    output J_MIC_Pin4,    // Connect to this signal from Audio_Capture.v
    output [11:0]led
    );
    wire [11:0] mic_in;
    wire clk20;
    wire clk625;
    wire reset_active;
    reg [15:0] colour = 16'h07E0;
    MUX_21 mux_21(sw, mic_in, led);
    clk_20k sample_clk(CLK100MHZ, clk20);
    Audio_Capture ac(CLK100MHZ, clk20, J_MIC_Pin3, J_MIC_Pin1, J_MIC_Pin4, mic_in);
    clk_6p25m oled_clk (CLK100MHZ, clk625);
    resetswitch res (clk625, btnC, reset_active);
//    Oled_Display disp (clk625, reset_active,,,,, {mic_in[11:7], 6'b0, mic_in[11:7]}, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7],);
    DisplayModule DM0 (CLK100MHZ, 1, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7]);
    
    
    

    // Delete this comment and write your codes and instantiations here

endmodule