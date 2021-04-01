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
    input [5:0] sw,
    input btnC, btnU, btnL, btnR, btnD,
    output [7:0] JC,
    output J_MIC_Pin1,
    output J_MIC_Pin4,    // Connect to this signal from Audio_Capture.v
    output [15:0]led,
    output [6:0] seg,
    output [3:0] an
    );
    wire [11:0] mic_in;    
    wire [3:0] levels;
    wire [15:0] lights;
    wire clock_3Hz;
    wire U_out;
    wire L_out;
    wire D_out;
    wire R_out;
    wire C_out;

    wire clk20;
    wire clk625;
    wire reset_active;
    reg [15:0] colour = 16'h07E0;
    MUX_21 mux_21(sw[0], lights , mic_in, led);
    volume_display vdisp(clk20, mic_in, levels, lights);
    volume_display_seg vdispseg(levels, CLK100MHZ, an, seg);
    clk_20k sample_clk(CLK100MHZ, clk20);
    Audio_Capture ac(CLK100MHZ, clk20, J_MIC_Pin3, J_MIC_Pin1, J_MIC_Pin4, mic_in);
    
    //clocks
    clk_6p25m oled_clk (CLK100MHZ, clk625);
    clock_3hz clock_3hz (CLK100MHZ, clock_3Hz);
    
    
    
    
    //buttons
    debounce up (clock_3Hz, btnU, U_out);
    debounce down (clock_3Hz, btnD, D_out);
    debounce left (clock_3Hz, btnL, L_out);
    debounce right (clock_3Hz, btnR, R_out);
    debounce center (clock_3Hz, btnC, C_out);

    
    
//    Oled_Display disp (clk625, reset_active,,,,, {mic_in[11:7], 6'b0, mic_in[11:7]}, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7],);
//    DisplayModule DM2 (clk625, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], sw[1], sw[0], led, sw[2], sw[3], sw[4], U_out, C_out, L_out, R_out, D_out);
//    MainMenu DM1 (clk625, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], U_out, D_out, clock_3Hz); 
//    AudioVisualiser DM0 (clk625, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], led, sw[5:0]);
    TwoCars DM3 (clk625, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], U_out, D_out);

    // Delete this comment and write your codes and instantiations here

endmodule