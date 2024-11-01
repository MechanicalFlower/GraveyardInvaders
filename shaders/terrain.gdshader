shader_type spatial;

uniform vec4 low_color : source_color = vec4(1.0);
uniform vec4 high_color : source_color = vec4(1.0);

varying vec3 position;

void vertex() { position = VERTEX; }

void fragment() { ALBEDO = mix(low_color.rgb, high_color.rgb, position.y); }
