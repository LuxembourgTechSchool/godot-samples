shader_type canvas_item;

uniform sampler2D noise_texture;
uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);

    float noise = texture(noise_texture, UV).r;

    if (noise < dissolve_amount) {
        discard;
    }

    COLOR = texture_color;
}
