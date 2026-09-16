shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.2, 0.8, 1.0, 1.0);

void fragment() {
    float pattern = sin(
        UV.x * 20.0 +
        TIME * 3.0
    );

    pattern = pattern * 0.5 + 0.5;

    COLOR = vec4(
        color.rgb * pattern,
        1.0
    );
}
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
