shader_type spatial;
render_mode cull_disabled, depth_draw_opaque;

uniform float speed: hint_range(0.0, 3.0) = 1.25;
uniform float intensity: hint_range(0.0, 0.5) = 0.1;
uniform sampler2D grass_texture : filter_nearest, source_color;

void vertex(){
	NORMAL = vec3(0.0, 1.0, 0.0);
	VERTEX.x += sin(NODE_POSITION_WORLD.x + TIME * speed + UV.y) * ( 1.0 - UV.y) * intensity;
	VERTEX.z += cos(NODE_POSITION_WORLD.z + TIME * 0.45 + UV.y) * ( 1.0 - UV.y) * intensity;
}

void fragment(){
	ALBEDO = texture(grass_texture, UV).rgb;
	ALPHA = texture(grass_texture, UV).a;
}