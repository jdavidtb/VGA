module vga_sync(
    input clk,          // Reloj de entrada de 25.175 MHz
    input reset,        // Señal de reset
    output reg hsync,   // Señal de sincronización horizontal
    output reg vsync,   // Señal de sincronización vertical
    output reg [9:0] x, // Coordenada horizontal del pixel (0-639)
    output reg [9:0] y, // Coordenada vertical del pixel (0-479)
    output reg vOn      // Señal de video on (dentro del área visible)
);

    // Constantes para la configuración de sincronización VGA
    localparam H_SYNC_PULSE = 96;   // Duración del pulso horizontal de sincronización
    localparam H_BACK_PORCH = 48;   // Duración del porche trasero horizontal
    localparam H_FRONT_PORCH = 16;  // Duración del porche delantero horizontal
    localparam H_VISIBLE_AREA = 640;// Área visible horizontal
    localparam H_TOTAL = 800;       // Total de ciclos de reloj por línea

    localparam V_SYNC_PULSE = 2;    // Duración del pulso vertical de sincronización
    localparam V_BACK_PORCH = 33;   // Duración del porche trasero vertical
    localparam V_FRONT_PORCH = 10;  // Duración del porche delantero vertical
    localparam V_VISIBLE_AREA = 480;// Área visible vertical
    localparam V_TOTAL = 525;       // Total de líneas por cuadro

    // Contadores para las posiciones de los píxeles
    always @(posedge clk) begin
        if (reset) begin
            x <= 0;
            y <= 0;
        end else begin
            if (x < H_TOTAL - 1) begin
                x <= x + 1;
            end else begin
                x <= 0;
                if (y < V_TOTAL - 1) begin
                    y <= y + 1;
                end else begin
                    y <= 0;
                end
            end
        end
    end

    // Generación de las señales de sincronización horizontal y vertical
    always @(posedge clk) begin
        if (reset) begin
            hsync <= 1'b1;
            vsync <= 1'b1;
            vOn <= 1'b0;
        end else begin
            hsync <= (x < H_SYNC_PULSE) ? 1'b0 : 1'b1;  // Pulso de sincronización negativo
            vsync <= (y < V_SYNC_PULSE) ? 1'b0 : 1'b1;  // Pulso de sincronización negativo
            vOn <= (x < H_VISIBLE_AREA) && (y < V_VISIBLE_AREA);  // Dentro del área visible
        end
    end
endmodule
