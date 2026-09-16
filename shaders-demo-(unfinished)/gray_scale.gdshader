shader_type canvas_item;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    float grayscale = (
        texture_color.r +
        texture_color.g +
        texture_color.b
    ) / 3.0;

    COLOR = vec4(
        grayscale,
        grayscale,
        grayscale,
        texture_color.a
    );
}