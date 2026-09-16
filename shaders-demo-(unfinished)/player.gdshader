shader_type canvas_item;

void fragment() {
    vec2 uv = UV;

    // Background transparency
    COLOR = vec4(0.0);

    // Head
    if (
        uv.x > 0.35 && uv.x < 0.65 &&
        uv.y > 0.10 && uv.y < 0.40
    ) {
        COLOR = vec4(1.0, 0.8, 0.6, 1.0);
    }

    // Body
    if (
        uv.x > 0.30 && uv.x < 0.70 &&
        uv.y > 0.40 && uv.y < 0.75
    ) {
        COLOR = vec4(0.2, 0.4, 1.0, 1.0);
    }

    // Left leg
    if (
        uv.x > 0.32 && uv.x < 0.47 &&
        uv.y > 0.75
    ) {
        COLOR = vec4(0.1, 0.1, 0.2, 1.0);
    }

    // Right leg
    if (
        uv.x > 0.53 && uv.x < 0.68 &&
        uv.y > 0.75
    ) {
        COLOR = vec4(0.1, 0.1, 0.2, 1.0);
    }
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
