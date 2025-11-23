shader_type spatial;
render_mode blend_mix,cull_back,diffuse_burley,specular_schlick_ggx
;
uniform sampler2D texture_albedo; // $output(0)
uniform sampler2D texture_emission : hint_default_black; // $output(2)
uniform sampler2D texture_normal : hint_normal; // $output(3)
uniform sampler2D texture_orm : hint_default_white; // $output(1)
uniform sampler2D texture_parallax; // $output(5)
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
float dot2(vec2 x) {
	return dot(x, x);
}

float rand(vec2 x) {
    return fract(cos(mod(dot(x, vec2(13.9898, 8.141)), 3.14)) * 43758.5);
}

vec2 rand2(vec2 x) {
    return fract(cos(mod(vec2(dot(x, vec2(13.9898, 8.141)),
						      dot(x, vec2(3.4562, 17.398))), vec2(3.14))) * 43758.5);
}

vec3 rand3(vec2 x) {
    return fract(cos(mod(vec3(dot(x, vec2(13.9898, 8.141)),
							  dot(x, vec2(3.4562, 17.398)),
                              dot(x, vec2(13.254, 5.867))), vec3(3.14))) * 43758.5);
}

float param_rnd(float minimum, float maximum, float seed) {
	return minimum+(maximum-minimum)*rand(vec2(seed));
}

float param_rndi(float minimum, float maximum, float seed) {
	return floor(param_rnd(minimum, maximum + 1.0, seed));
}

vec3 rgb2hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
	vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);

	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
const vec4 p_o26234650106655_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o26234650106655_metallic = 0.000000000;
const float p_o26234650106655_roughness = 1.000000000;
const float p_o26234650106655_emission_energy = 0.000000000;
const float p_o26234650106655_normal = 1.340000000;
const float p_o26234650106655_ao = 0.000000000;
const float p_o26234650106655_offset_scale = 0.260000000;
const float p_o26234650106655_iter = 24.000000000;
void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}
void fragment() {
	vec2 base_uv = UV;
	int texture_size = textureSize(texture_albedo, 0).x;
	if (texture_size < 256) {
		base_uv = floor(float(texture_size)*base_uv+0.5)/float(texture_size);
	}
	vec3 parallax = vec3(0.0);
	{

		int p_iter = int(p_o26234650106655_iter);

		vec3 view_dir = inverse(mat3(TANGENT, -BINORMAL, NORMAL))*VIEW;
		for (int j = 0; j < p_iter; j++) {
			float ratio = float(j) / float(p_iter);

			parallax += texture(texture_parallax, base_uv - mix(0.0, p_o26234650106655_offset_scale, ratio) * view_dir.xy).rgb * mix(1.0, 0.0, ratio);

		}
		parallax /= float(p_iter);
	}

	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = p_o26234650106655_albedo_color.rgb * mix(pow((albedo_tex + vec4(0.055))/vec4(1.055), vec4(2.4)), albedo_tex/vec4(12.92), lessThan(albedo_tex, vec4(0.04045))).rgb;
	ALBEDO += parallax;
	vec4 orm_tex = texture(texture_orm, base_uv);
	METALLIC = p_o26234650106655_metallic*orm_tex.b;
	ROUGHNESS = p_o26234650106655_roughness*orm_tex.g;
	SPECULAR = 0.5;
	NORMAL_MAP = texture(texture_normal, base_uv).rgb;
	NORMAL_MAP_DEPTH = p_o26234650106655_normal;
	vec3 emission_tex = texture(texture_emission, base_uv).rgb;
	EMISSION = emission_tex*p_o26234650106655_emission_energy;
	AO = orm_tex.r;
	AO_LIGHT_AFFECT = p_o26234650106655_ao;

}



