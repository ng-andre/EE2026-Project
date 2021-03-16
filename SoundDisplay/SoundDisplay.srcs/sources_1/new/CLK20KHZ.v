`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2021 09:53:39
// Design Name: 
// Module Name: CLK20KHZ
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


module CLK20KHZ(
    input CLK100MHZ,
    output reg new_clk
    );
    reg [11:0] counter = 12'b0;
    
    initial begin
        new_clk = 0;
    end
    
    always @ (posedge CLK100MHZ) begin
        counter <= counter + 1;
        if (counter == 12'b1001_1100_0100) begin
            new_clk <= ~new_clk;
            counter <= 12'b0;
        end
    end
    
endmodule
