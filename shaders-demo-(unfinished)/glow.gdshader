shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.2, 0.8, 1.0, 1.0);
uniform float intensity = 1.0;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    texture_color.rgb += glow_color.rgb * intensity;

    COLOR = texture_color;
}