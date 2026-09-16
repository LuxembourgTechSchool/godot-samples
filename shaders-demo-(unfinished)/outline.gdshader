shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 0.0, 1.0);
uniform float outline_size = 2.0;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    vec2 pixel_size = TEXTURE_PIXEL_SIZE * outline_size;

    float left = texture(TEXTURE, UV - vec2(pixel_size.x, 0.0)).a;
    float right = texture(TEXTURE, UV + vec2(pixel_size.x, 0.0)).a;
    float up = texture(TEXTURE, UV - vec2(0.0, pixel_size.y)).a;
    float down = texture(TEXTURE, UV + vec2(0.0, pixel_size.y)).a;

    float neighbor_alpha = max(
        max(left, right),
        max(up, down)
    );

    if (texture_color.a <= 0.0 && neighbor_alpha > 0.0) {
        COLOR = outline_color;
    } else {
        COLOR = texture_color;
    }
}
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
