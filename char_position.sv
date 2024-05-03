module char_position(
    input [9:0] x, y,          // Entradas de posición de píxeles
    output [7:0] charX, scrX,  // Salidas para la posición del carácter X y la posición del píxel en el carácter
    output [6:0] charY, scrY   // Salidas para la posición del carácter Y y la posición del píxel en el carácter
);

    localparam CHAR_WIDTH = 8;
    localparam CHAR_HEIGHT = 8;

    // Calcular las posiciones de carácter y píxel dentro del carácter
    // Usando la división entera y el módulo para determinar las posiciones
    assign charX = x / CHAR_WIDTH;   // Índice de columna del carácter
    assign scrX = x % CHAR_WIDTH;    // Posición X dentro del carácter

    assign charY = y / CHAR_HEIGHT;  // Índice de fila del carácter
    assign scrY = y % CHAR_HEIGHT;   // Posición Y dentro del carácter

endmodule
