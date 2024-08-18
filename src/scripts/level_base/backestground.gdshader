shader_type canvas_item;
render_mode world_vertex_coords;

uniform sampler2D inTexture : filter_nearest, repeat_enable;
uniform float speed_scroll = 1.;
uniform float speed_wave = 1.;
uniform float amplitude = 1.;
uniform float scale = 1.;

void fragment() {
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float aspect_ratio = viewport_size.x / viewport_size.y;
	vec2 bgUV = UV + vec2(TIME * speed_scroll, sin(TIME * speed_wave) * amplitude);
	vec4 bg = texture(inTexture, bgUV * scale);

    vec2 position = (UV - 0.5) * aspect_ratio;

    float circle = 1.0 - step(0.5, length(UV - 0.5));
    
    vec3 circle_coords = vec3(circle);
    COLOR = vec4(bg.rgb * circle_coords, circle);
}