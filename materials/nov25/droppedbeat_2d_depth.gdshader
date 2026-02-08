shader_type canvas_item;

render_mode unshaded, blend_mix;

uniform vec3 uv1_scale = vec3(1.0, 1.0, 1.0);
uniform vec3 uv1_offset = vec3(0.0, 0.0, 0.0);
uniform float variation = 0.0;
varying float elapsed_time;
void vertex() {
	elapsed_time = TIME;
	UV = UV*uv1_scale.xy+uv1_offset.xy;
}
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
const float p_o753464772365_iter = 256.000000000;
const float p_o753464772365_off = 0.525000000;
const float p_o753548658444_translate_x = 0.000000000;
const float p_o753548658444_translate_y = 0.000000000;
const float p_o753548658444_rotate = 0.000000000;
const float p_o753548658444_scale_x = 2.000000000;
const float p_o753548658444_scale_y = 0.562500000;
const float p_o753632544516_translate_x = 0.000000000;
const float p_o753632544516_translate_y = 0.000000000;
const float p_o753632544516_scale_x = 1.000000000;
const float p_o753632544516_scale_y = 1.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 1024.000000000;
// #globals: transform2 (o753548658444)
vec2 transform2_clamp(vec2 uv) {
	return clamp(uv, vec2(0.0), vec2(1.0));
}
vec2 transform2(vec2 uv, vec2 translate, float rotate, vec2 scale) {
 	vec2 rv;
	uv -= translate;
	uv -= vec2(0.5);
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
	rv /= scale;
	rv += vec2(0.5);
	return rv;	
}
// #globals: shader_1 (o753464772365)
float o753464772365_input_height_map(vec2 uv, float _seed_variation_) {
vec4 o753582212873_0 = textureLod(texture_1, fract((transform2((transform2(uv, vec2(p_o753548658444_translate_x*(2.0*1.0-1.0), p_o753548658444_translate_y*(2.0*1.0-1.0)), p_o753548658444_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o753548658444_scale_x*(2.0*1.0-1.0), p_o753548658444_scale_y*(2.0*1.0-1.0)))), vec2(p_o753632544516_translate_x*(2.0*1.0-1.0), p_o753632544516_translate_y*(2.0*1.0-1.0)), (elapsed_time*3.)*0.01745329251*(2.0*1.0-1.0), vec2(p_o753632544516_scale_x*(2.0*1.0-1.0), p_o753632544516_scale_y*(2.0*1.0-1.0))))), 0.0);
// #output0: transform2_2 (o753632544516)
vec4 o753632544516_0_1_rgba = o753582212873_0;
// #output0: transform2 (o753548658444)
vec4 o753548658444_0_1_rgba = o753632544516_0_1_rgba;
return (dot((o753548658444_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: shader_1 (o753464772365)
float o753464772365_extrude(vec2 uv, float _seed_variation_) {
	float res = 0.0;
	for (int i=0;i < int(p_o753464772365_iter*o753464772365_input_height_map((uv), _seed_variation_));i++) {
		uv.y -= p_o753464772365_off/p_o753464772365_iter;
		res = max(res, float(i)/p_o753464772365_iter);
	}
	return res;
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: shader_1 (o753464772365)
float o753464772365_0_1_f = o753464772365_extrude((uv), _seed_variation_);

	vec4 color_tex = vec4(vec3(o753464772365_0_1_f), 1.0);
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	COLOR = color_tex;
}



