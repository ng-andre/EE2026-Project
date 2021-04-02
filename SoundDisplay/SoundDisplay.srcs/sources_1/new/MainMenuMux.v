`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2021 10:16:08 PM
// Design Name: 
// Module Name: MainMenuMux
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


module MainMenuMux(
    input [2:0] cursor,
    //menu
    input cs_m, sdin_m, sclk_m, d_cn_m, resn_m, vccen_m, pmoden_m,//output of OLED display
    //audio
    input cs_a, sdin_a, sclk_a, d_cn_a, resn_a, vccen_a, pmoden_a,//output of OLED display
    //game 1
    input cs_1, sdin_1, sclk_1, d_cn_1, resn_1, vccen_1, pmoden_1,//output of OLED display
    //game 2
    input cs_2, sdin_2, sclk_2, d_cn_2, resn_2, vccen_2, pmoden_2,//output of OLED display
    //output
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden//output of OLED display
    );
    
    case(cursor)
        2'b00: begin
            assign cs = cs_m;
            assign sdin = sdin_m;
            assign sclk = sclk_m;
            assign d_cn = d_cn_m;
            assign resn = resn_m;
            assign vccen = vccen_m;
            assign pmoden = pmoden_m;
        end
        2'b01: begin
            assign cs = cs_a;
            assign sdin = sdin_a;
            assign sclk = sclk_a;
            assign d_cn = d_cn_a;
            assign resn = resn_a;
            assign vccen = vccen_a;
            assign pmoden = pmoden_a;
        end
        2'b10: begin
            assign cs = cs_1;
            assign sdin = sdin_1;
            assign sclk = sclk_1;
            assign d_cn = d_cn_1;
            assign resn = resn_1;
            assign vccen = vccen_1;
            assign pmoden = pmoden_1;
        end
        2'b11: begin
            assign cs = cs_2;
            assign sdin = sdin_2;
            assign sclk = sclk_2;
            assign d_cn = d_cn_2;
            assign resn = resn_2;
            assign vccen = vccen_2;
            assign pmoden = pmoden_2;
        end
    endcase
endmodule
