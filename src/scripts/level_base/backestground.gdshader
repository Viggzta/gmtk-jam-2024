shader_type canvas_item;

uniform sampler2D inTexture;

void fragment() {
	COLOR = texture(inTexture, UV);
}
