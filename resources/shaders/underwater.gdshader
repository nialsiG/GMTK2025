shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment() {
	vec2 uv = SCREEN_UV;
	
	float frequency = 10.0;
	float amplitude = 0.0005;
	float speed = 20.0 * sin(TIME);
	float wave = sin(uv.y * frequency) * speed * amplitude;
	
	uv.x += wave;
	
	ALBEDO = texture(SCREEN_TEXTURE, uv).rgb;
	//ALPHA = 0.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
