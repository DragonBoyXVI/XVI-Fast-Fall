shader_type canvas_item;

uniform sampler2D crack_texture: filter_nearest;
uniform float crack_tolerance = 0.5;
uniform vec3 crack_color = vec3( 0.0 );

varying vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 base_sample = texture( TEXTURE, UV );
	vec4 crack_sample = texture( crack_texture, UV );
	if ( crack_sample.r > crack_tolerance ) {
		COLOR = vec4( crack_color, COLOR.a );
	}
	else {
		COLOR = base_sample;
	}
	COLOR *= modulate;
}
