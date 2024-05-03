module textmode(
    input clk,
    input reset,
    input hsI,           // Señal de sincronización horizontal de entrada
    input vsI,           // Señal de sincronización vertical de entrada
    input vOn,           // Señal de video activo
    input [7:0] fg,      // Color de primer plano (Foreground)
    input [7:0] bg,      // Color de fondo (Background)
    input [10:0] char,   // Código ASCII del carácter actual
    output reg hsO,      // Señal de sincronización horizontal de salida
    output reg vsO,      // Señal de sincronización vertical de salida
    output reg [7:0] R,  // Salida de color Rojo
    output reg [7:0] G,  // Salida de color Verde
    output reg [7:0] B   // Salida de color Azul
);

    // Registro de señales de sincronización
    always @(posedge clk) begin
        if (reset) begin
            hsO <= 1'b1;
            vsO <= 1'b1;
        end else begin
            hsO <= hsI;
            vsO <= vsI;
        end
    end

    // Generación de las señales de color basadas en la señal de video on y los colores de primer plano y fondo
    always @(posedge clk) begin
        if (reset) begin
            R <= 0;
            G <= 0;
            B <= 0;
        end else if (vOn) begin
            
            R <= fg;  // Asignar el color de primer plano al Rojo
            G <= bg;  // Asignar el color de fondo al Verde
            B <= 0;   // No usar azul por simplicidad
        end else begin
            R <= 0;   // Poner todos los canales a cero cuando vOn esté inactivo
            G <= 0;
            B <= 0;
        end
    end

endmodule
