shader_type canvas_item;

uniform float amplitude = 10.0;
uniform float speed = 2.0;
uniform float frequency = 5.0;

void vertex() {
    VERTEX.y += sin(
        VERTEX.x * frequency +
        TIME * speed
    ) * amplitude;
}