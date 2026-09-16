shader_type canvas_item;

uniform float strength = 0.01;
uniform float speed = 2.0;
uniform float frequency = 10.0;

void fragment() {
    vec2 modified_uv = UV;

    modified_uv.x += sin(
        UV.y * frequency +
        TIME * speed
    ) * strength;

    COLOR = texture(TEXTURE, modified_uv);
}
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
