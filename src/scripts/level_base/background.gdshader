shader_type canvas_item;

uniform sampler2D inTexture;
uniform vec2 scale = vec2(1., 1.);

void fragment() {
    vec2 viewport_size = 1.0 / SCREEN_PIXEL_SIZE;
    float aspect_ratio = viewport_size.x / viewport_size.y;
	vec2 backgroundUV = VERTEX / 1000.0 / scale;
	vec4 bg = texture(inTexture, backgroundUV);

    vec2 position = (UV  - 0.5) * aspect_ratio;

    float circle = 1.0 - step(0.5, length(UV - 0.5));
    
    vec3 circle_coords = vec3(circle);
    COLOR = vec4(bg.rgb * circle_coords, circle);
}
