shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    COLOR = texture_color * tint_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
