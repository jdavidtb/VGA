module screen_ram(
    input clk,                    // Reloj del sistema
    input we,                     // Señal de habilitación de escritura (Write Enable)
    input [10:0] addr,            // Dirección de memoria
    input [7:0] data_in,          // Datos para escribir en memoria
    output reg [7:0] data_out     // Datos leídos de la memoria
);

    // Define el tamaño de la RAM. Ejemplo para una pantalla de 80x60 caracteres.
    localparam DEPTH = 4800;  // 80 columnas x 60 filas
    reg [7:0] ram [DEPTH-1:0];  // Memoria RAM

    // Operaciones de lectura y escritura en memoria
    always @(posedge clk) begin
        if (we) begin
            // Escritura: almacenar `data_in` en la dirección `addr`
            ram[addr] <= data_in;
        end
        // Lectura: actualizar `data_out` con el valor de la dirección `addr`
        data_out <= ram[addr];
    end
endmodule
