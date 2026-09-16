shader_type canvas_item;

uniform float speed = 0.2;

void fragment() {
    vec2 modified_uv = UV;

    modified_uv.x += TIME * speed;

    COLOR = texture(TEXTURE, modified_uv);
}
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
