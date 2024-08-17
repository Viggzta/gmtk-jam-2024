shader_type canvas_item;
render_mode world_vertex_coords;

uniform sampler2D inTexture;

void fragment() {
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float aspect_ratio = viewport_size.x / viewport_size.y;
	vec4 bg = texture(inTexture, UV);

    vec2 position = (UV - 0.5) * aspect_ratio;

    float circle = 1.0 - step(0.5, length(UV - 0.5));
    
    vec3 circle_coords = vec3(circle);
    COLOR = vec4(bg.rgb * circle_coords, circle);
}
