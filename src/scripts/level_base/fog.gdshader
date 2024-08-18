shader_type canvas_item;
render_mode world_vertex_coords;

uniform vec4 inColor : source_color = vec4(1.0);

void fragment() {
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float aspect_ratio = viewport_size.x / viewport_size.y;

    vec2 position = (UV - 0.5) * aspect_ratio;

    float circle = step(0.49, length(UV - 0.5));
	float circle2 = step(0.46, length(UV - 0.5)) * 0.5;
	float circle3 = step(0.43, length(UV - 0.5)) * 0.25;
	float circle99 = circle + circle2 + circle3;
    
    COLOR = vec4(inColor.rgb, inColor.a * circle99);
}
