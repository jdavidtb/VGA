module vga_design(
     input clk,           // Reloj del sistema
    input reset,         // Reset global
    output hsync,        // Salida de sincronización horizontal
    output vsync,        // Salida de sincronización vertical
    output [7:0] R, G, B // Salidas de color
);
    // Señales internas
    wire [9:0] pixel_x, pixel_y;
    wire [7:0] char_x, scr_x, char_y, scr_y;
    wire hsync_internal, vsync_internal, video_on;
    wire [7:0] data_from_ram, color_fg, color_bg;

    // Instancias de los módulos
    vga_sync vga_controller (
        .clk(clk),
        .reset(reset),
        .hsync(hsync_internal),
        .vsync(vsync_internal),
        .x(pixel_x),
        .y(pixel_y),
        .vOn(video_on)
    );

    char_position char_pos (
        .x(pixel_x),
        .y(pixel_y),
        .charX(char_x),
        .scrX(scr_x),
        .charY(char_y),
        .scrY(scr_y)
    );

    screen_ram video_memory (
        .clk(clk),
        .we(1'b0), // Ejemplo sin escritura
        .addr(pixel_y * 80 + pixel_x / 8), // Ajustar según dimensiones
        .data_in(8'b0), 
        .data_out(data_from_ram)
    );

    assign color_fg = data_from_ram[7:4]; 
    assign color_bg = data_from_ram[3:0];

    textmode text_mode (
        .clk(clk),
        .reset(reset),
        .hsI(hsync_internal),
        .vsI(vsync_internal),
        .vOn(video_on),
        .fg(color_fg),
        .bg(color_bg),
        .char(char_x),  
        .hsO(hsync),
        .vsO(vsync),
        .R(R),
        .G(G),
        .B(B)
    );

endmodule
