`timescale 1ns / 1ps

module vga_design_tb();
    reg clk;
    reg reset;
    wire hsync, vsync;
    wire [7:0] R, G, B;

    vga_design uut (
    .clk(clk),
    .reset(reset),
    .hsyncs(hsync),  
    .vsync(vsync),
    .R(R),
    .G(G),
    .B(B)
);


    // Generación del reloj
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz
    end

    // Procedimiento de prueba
    initial begin
        reset = 1;
        #100 reset = 0; // Duración del reset
        #1000; // Simular por un tiempo adicional
        $finish; // Finalizar la simulación
    end
endmodule
