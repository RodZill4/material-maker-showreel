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
const float p_o25801781156854_amount1 = 1.000000000;
const float seed_o25726887663506 = 0.242626444;
const float p_o25726887663506_count = 46.000000000;
const float p_o25726887663506_scale_x = 0.250000000;
const float p_o25726887663506_scale_y = 0.250000000;
const float p_o25726887663506_rotate = 0.000000000;
const float p_o25726887663506_scale = 0.610000000;
const float p_o25726887663506_value = 0.000000000;
const float o25787017202398_cluster_min;
const float o25787017202398_cluster_max;
const float p_o25787033982980_eps = 0.200000000;
const float p_o25790439754225_amount1 = 1.000000000;
const float p_o25790624305655_default_in1 = 0.000000000;
const float p_o25790624305655_default_in2 = 0.000000000;
const vec4 p_o25790506863782_d = vec4(1.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o25790590752866_d = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float seed_o25790406200383 = 0.659483850;
const float p_o25790406200383_scale_x = 2.000000000;
const float p_o25790406200383_scale_y = 2.000000000;
const float p_o25790406200383_folds = 0.000000000;
const float p_o25790406200383_iterations = 5.000000000;
const float p_o25790406200383_persistence = 0.500000000;
const float p_o25790406200383_offset = 0.000000000;
const float seed_o25786916542411 = 1.244800866;
const float p_o25786916542411_scale_x = 0.140000000;
const float p_o25786916542411_scale = 0.000000000;
const float p_o25786916542411_value = 0.120000000;
const float p_o25786916542411_rnd_scale_x = 0.000000000;
const float p_o25786899766006_translate_x = 0.000000000;
const float p_o25786899766006_translate_y = 0.000000000;
const float p_o25786899766006_rotate = 0.000000000;
const float p_o25786899766006_scale_x = 1.000000000;
const float p_o25786899766006_scale_y = 1.000000000;
const float p_o25787117866043_amount1 = 1.000000000;
const float p_o25787302416906_default_in1 = 0.000000000;
const float p_o25787302416906_default_in2 = 0.000000000;
const vec4 p_o25787184974454_d = vec4(1.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o25787268860202_d = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o25786882985910_sides = 3.000000000;
const float p_o25786882985910_radius = 0.040000000;
const float p_o25786882985910_edge = 0.190000000;
const float p_o25793744869545_amount1 = 1.000000000;
const float p_o25793929415004_default_in1 = 0.000000000;
const float p_o25793929415004_default_in2 = 0.000000000;
const vec4 p_o25793811974479_d = vec4(1.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o25793895865352_d = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o25786866211917_sides = 8.000000000;
const float p_o25786866211917_radius = 0.500000000;
const float p_o25786866211917_edge = 0.000000000;
const float p_o25726954773943_amount1 = 1.000000000;
const float p_o25726954773943_amount2 = 1.000000000;
const float p_o25726954773943_amount3 = 1.000000000;
const float p_o25726954773943_amount4 = 1.000000000;
const float p_o25726954773943_amount5 = 0.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 2048.000000000;
uniform sampler2D texture_2;
const float texture_2_size = 2048.000000000;
uniform sampler2D texture_3;
const float texture_3_size = 2048.000000000;
uniform sampler2D texture_4;
const float texture_4_size = 2048.000000000;
uniform sampler2D texture_5;
const float texture_5_size = 2048.000000000;
// #globals: blend
vec3 blend_normal(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*c1 + (1.0-opacity)*c2;
}
vec3 blend_dissolve(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	if (rand(uv) < opacity) {
		return c1;
	} else {
		return c2;
	}
}
vec3 blend_multiply(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*c1*c2 + (1.0-opacity)*c2;
}
vec3 blend_screen(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*(1.0-(1.0-c1)*(1.0-c2)) + (1.0-opacity)*c2;
}
float blend_overlay_f(float c1, float c2) {
	return (c1 < 0.5) ? (2.0*c1*c2) : (1.0-2.0*(1.0-c1)*(1.0-c2));
}
vec3 blend_overlay(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_overlay_f(c1.x, c2.x), blend_overlay_f(c1.y, c2.y), blend_overlay_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend_hard_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*0.5*(c1*c2+blend_overlay(uv, c1, c2, 1.0)) + (1.0-opacity)*c2;
}
float blend_soft_light_f(float c1, float c2) {
	return (c2 < 0.5) ? (2.0*c1*c2+c1*c1*(1.0-2.0*c2)) : 2.0*c1*(1.0-c2)+sqrt(c1)*(2.0*c2-1.0);
}
vec3 blend_soft_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_soft_light_f(c1.x, c2.x), blend_soft_light_f(c1.y, c2.y), blend_soft_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_burn_f(float c1, float c2) {
	return (c1==0.0)?c1:max((1.0-((1.0-c2)/c1)),0.0);
}
vec3 blend_burn(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_burn_f(c1.x, c2.x), blend_burn_f(c1.y, c2.y), blend_burn_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_dodge_f(float c1, float c2) {
	return (c1==1.0)?c1:min(c2/(1.0-c1),1.0);
}
vec3 blend_dodge(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_dodge_f(c1.x, c2.x), blend_dodge_f(c1.y, c2.y), blend_dodge_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend_lighten(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*max(c1, c2) + (1.0-opacity)*c2;
}
vec3 blend_darken(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*min(c1, c2) + (1.0-opacity)*c2;
}
vec3 blend_difference(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*clamp(c2-c1, vec3(0.0), vec3(1.0)) + (1.0-opacity)*c2;
}
vec3 blend_additive(vec2 uv, vec3 c1, vec3 c2, float oppacity) {
	return c2 + c1 * oppacity;
}
vec3 blend_addsub(vec2 uv, vec3 c1, vec3 c2, float oppacity) {
	return c2 + (c1 - .5) * 2.0 * oppacity;
}
// #globals: adjust_hsv
vec3 rgb_to_hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
	vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
vec3 hsv_to_rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
// #globals: blend2_2 (o25801781156854)
float blend_linear_light_f(float c1, float c2) {
	return (c1 + 2.0 * c2) - 1.0;
}
vec3 blend_linear_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
return opacity*vec3(blend_linear_light_f(c1.x, c2.x), blend_linear_light_f(c1.y, c2.y), blend_linear_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_vivid_light_f(float c1, float c2) {
	return (c1 < 0.5) ? 1.0 - (1.0 - c2) / (2.0 * c1) : c2 / (2.0 * (1.0 - c1));
}
vec3 blend_vivid_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_vivid_light_f(c1.x, c2.x), blend_vivid_light_f(c1.y, c2.y), blend_vivid_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_pin_light_f( float c1, float c2) {
	return (2.0 * c1 - 1.0 > c2) ? 2.0 * c1 - 1.0 : ((c1 < 0.5 * c2) ? 2.0 * c1 : c2);
}
vec3 blend_pin_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_pin_light_f(c1.x, c2.x), blend_pin_light_f(c1.y, c2.y), blend_pin_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_hard_mix_f(float c1, float c2) {
	return floor(c1 + c2);
}
vec3 blend_hard_mix(vec2 uv, vec3 c1, vec3 c2, float opacity) {
		return opacity*vec3(blend_hard_mix_f(c1.x, c2.x), blend_hard_mix_f(c1.y, c2.y), blend_hard_mix_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_exclusion_f(float c1, float c2) {
	return c1 + c2 - 2.0 * c1 * c2;
}
vec3 blend_exclusion(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_exclusion_f(c1.x, c2.x), blend_exclusion_f(c1.y, c2.y), blend_exclusion_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend_hue(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	vec3 outcol = c2;
	vec3 hsv, hsv2, tmp;
	hsv2 = rgb_to_hsv(c1);
	if (hsv2.y != 0.0) {
		hsv = rgb_to_hsv(outcol);
		hsv.x = hsv2.x;
		tmp = hsv_to_rgb(hsv);
		outcol = mix(outcol, tmp, opacity);
	}
	return outcol;
}
vec3 blend_saturation(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 outcol = c2;
	vec3 hsv, hsv2;
	hsv = rgb_to_hsv(outcol);
	if (hsv.y != 0.0) {
		hsv2 = rgb_to_hsv(c1);
		hsv.y = facm * hsv.y + opacity * hsv2.y;
		outcol = hsv_to_rgb(hsv);
	}
	return outcol;
}
vec3 blend_color(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 outcol = c2;
	vec3 hsv, hsv2, tmp;
	hsv2 = rgb_to_hsv(c1);
	if (hsv2.y != 0.0) {
		hsv = rgb_to_hsv(outcol);
		hsv.x = hsv2.x;
		hsv.y = hsv2.y;
		tmp = hsv_to_rgb(hsv);
		outcol = mix(outcol, tmp, opacity);
	}
	return outcol;
}
vec3 blend_value(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 hsv, hsv2;
	hsv = rgb_to_hsv(c2);
	hsv2 = rgb_to_hsv(c1);
	hsv.z = facm * hsv.z + opacity * hsv2.z;
	return hsv_to_rgb(hsv);
}
// #globals: graph_8/graph_2/graph_10/invert (o25790641081650)
// #globals: graph_8/graph_2/graph_10/math (o25790624305655)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: graph_8/fbm2 (o25790406200383)
float old_value_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float p00 = rand(mod(o, size));
	float p01 = rand(mod(o + vec2(0.0, 1.0), size));
	float p10 = rand(mod(o + vec2(1.0, 0.0), size));
	float p11 = rand(mod(o + vec2(1.0, 1.0), size));
	p00 = sin(p00 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p01 = sin(p01 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p10 = sin(p10 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p11 = sin(p11 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	vec2 t =  f * f * f * (f * (f * 6.0 - 15.0) + 10.0);
	return mix(mix(p00, p10, t.x), mix(p01, p11, t.x), t.y);
}
float old_fbm_2d_value(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_value_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_perlin_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float a00 = rand(mod(o, size)) * 6.28318530718 + offset * 6.28318530718;
	float a01 = rand(mod(o + vec2(0.0, 1.0), size)) * 6.28318530718 + offset * 6.28318530718;
	float a10 = rand(mod(o + vec2(1.0, 0.0), size)) * 6.28318530718 + offset * 6.28318530718;
	float a11 = rand(mod(o + vec2(1.0, 1.0), size)) * 6.28318530718 + offset * 6.28318530718;
	vec2 v00 = vec2(cos(a00), sin(a00));
	vec2 v01 = vec2(cos(a01), sin(a01));
	vec2 v10 = vec2(cos(a10), sin(a10));
	vec2 v11 = vec2(cos(a11), sin(a11));
	float p00 = dot(v00, f);
	float p01 = dot(v01, f - vec2(0.0, 1.0));
	float p10 = dot(v10, f - vec2(1.0, 0.0));
	float p11 = dot(v11, f - vec2(1.0, 1.0));
	vec2 t =  f * f * f * (f * (f * 6.0 - 15.0) + 10.0);
	return 0.5 + mix(mix(p00, p10, t.x), mix(p01, p11, t.x), t.y);
}
float old_fbm_2d_perlin(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_perlin_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_perlinabs_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	return abs(2.0*old_perlin_noise_2d(coord, size, offset, seed)-1.0);
}
float old_fbm_2d_perlinabs(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_perlinabs_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_fbm_2d_mod289(float x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}
float old_fbm_2d_permute(float x) {
	return old_fbm_2d_mod289(((x * 34.0) + 1.0) * x);
}
vec2 old_fbm_2d_rgrad2(vec2 p, float rot, float seed) {
	float u = old_fbm_2d_permute(old_fbm_2d_permute(p.x) + p.y) * 0.0243902439 + rot; // Rotate by shift
	u = fract(u) * 6.28318530718; // 2*pi
	return vec2(cos(u), sin(u));
}
float old_simplex_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	coord *= 2.0; // needed for it to tile
	coord += rand2(vec2(seed, 1.0-seed)) + size;
	size *= 2.0; // needed for it to tile
	coord.y += 0.001;
	vec2 uv = vec2(coord.x + coord.y*0.5, coord.y);
	vec2 i0 = floor(uv);
	vec2 f0 = fract(uv);
	vec2 i1 = (f0.x > f0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
	vec2 p0 = vec2(i0.x - i0.y * 0.5, i0.y);
	vec2 p1 = vec2(p0.x + i1.x - i1.y * 0.5, p0.y + i1.y);
	vec2 p2 = vec2(p0.x + 0.5, p0.y + 1.0);
	i1 = i0 + i1;
	vec2 i2 = i0 + vec2(1.0, 1.0);
	vec2 d0 = coord - p0;
	vec2 d1 = coord - p1;
	vec2 d2 = coord - p2;
	vec3 xw = mod(vec3(p0.x, p1.x, p2.x), size.x);
	vec3 yw = mod(vec3(p0.y, p1.y, p2.y), size.y);
	vec3 iuw = xw + 0.5 * yw;
	vec3 ivw = yw;
	vec2 g0 = old_fbm_2d_rgrad2(vec2(iuw.x, ivw.x), offset, seed);
	vec2 g1 = old_fbm_2d_rgrad2(vec2(iuw.y, ivw.y), offset, seed);
	vec2 g2 = old_fbm_2d_rgrad2(vec2(iuw.z, ivw.z), offset, seed);
	vec3 w = vec3(dot(g0, d0), dot(g1, d1), dot(g2, d2));
	vec3 t = 0.8 - vec3(dot(d0, d0), dot(d1, d1), dot(d2, d2));
	t = max(t, vec3(0.0));
	vec3 t2 = t * t;
	vec3 t4 = t2 * t2;
	float n = dot(t4, w);
	return 0.5 + 5.5 * n;
}
float old_fbm_2d_simplex(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_simplex_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node =  0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718 * node);
			vec2 diff = neighbor + node - f;
			float dist = length(diff);
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float old_fbm_2d_cellular(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular2_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = length(diff);
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float old_fbm_2d_cellular2(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular2_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular3_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = abs((diff).x) + abs((diff).y);
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float old_fbm_2d_cellular3(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular3_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular4_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = abs((diff).x) + abs((diff).y);
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float old_fbm_2d_cellular4(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular4_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular5_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.5 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = max(abs((diff).x), abs((diff).y));
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float old_fbm_2d_cellular5(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular5_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float old_cellular6_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = max(abs((diff).x), abs((diff).y));
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float old_fbm_2d_cellular6(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_cellular6_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
// MIT License Inigo Quilez - https://www.shadertoy.com/view/Xd23Dh
float old_voronoise_noise_2d( vec2 coord, vec2 size, float offset, float seed) {
	vec2 i = floor(coord) + rand2(vec2(seed, 1.0-seed)) + size;
	vec2 f = fract(coord);
	
	vec2 a = vec2(0.0);
	
	for( int y=-2; y<=2; y++ ) {
		for( int x=-2; x<=2; x++ ) {
			vec2  g = vec2( float(x), float(y) );
			vec3  o = rand3( mod(i + g, size) + vec2(seed) );
			o.xy += 0.25 * sin(offset * 6.28318530718 + 6.28318530718*o.xy);
			vec2  d = g - f + o.xy;
			float w = pow( 1.0-smoothstep(0.0, 1.414, length(d)), 1.0 );
			a += vec2(o.z*w,w);
		}
	}
	
	return a.x/a.y;
}
float old_fbm_2d_voronoise(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = old_voronoise_noise_2d(coord*size, size, offset, seed);
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
// #globals: graph_8/transform2 (o25786899766006)
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
// #globals: graph_8/shape (o25786882985910)
float shape_circle(vec2 uv, float sides, float size, float edge) {
	uv = 2.0*uv-1.0;
	edge = max(edge, 1.0e-8);
	float distance = length(uv);
	return clamp((1.0-distance/size)/edge, 0.0, 1.0);
}
float shape_polygon(vec2 uv, float sides, float size, float edge) {
	uv = 2.0*uv-1.0;
	edge = max(edge, 1.0e-8);
	float angle = atan(uv.x, uv.y)+3.14159265359;
	float slice = 6.28318530718/sides;
	return clamp((1.0-(cos(floor(0.5+angle/slice)*slice-angle)*length(uv))/size)/edge, 0.0, 1.0);
}
float shape_star(vec2 uv, float sides, float size, float edge) {
	uv = 2.0*uv-1.0;
	edge = max(edge, 1.0e-8);
	float angle = atan(uv.x, uv.y);
	float slice = 6.28318530718/sides;
	return clamp((1.0-(cos(floor(angle*sides/6.28318530718-0.5+2.0*step(fract(angle*sides/6.28318530718), 0.5))*slice-angle)*length(uv))/size)/edge, 0.0, 1.0);
}
float shape_curved_star(vec2 uv, float sides, float size, float edge) {
	uv = 2.0*uv-1.0;
	edge = max(edge, 1.0e-8);
	float angle = 2.0*(atan(uv.x, uv.y)+3.14159265359);
	float slice = 6.28318530718/sides;
	return clamp((1.0-cos(floor(0.5+0.5*angle/slice)*2.0*slice-angle)*length(uv)/size)/edge, 0.0, 1.0);
}
float shape_rays(vec2 uv, float sides, float size, float edge) {
	uv = 2.0*uv-1.0;
	edge = 0.5*max(edge, 1.0e-8)*size;
	float slice = 6.28318530718/sides;
	float angle = mod(atan(uv.x, uv.y)+3.14159265359, slice)/slice;
	return clamp(min((size-angle)/edge, angle/edge), 0.0, 1.0);
}
// #globals: custom_uv
vec2 get_from_tileset(float count, float seed, vec2 uv) {
	return clamp((uv+floor(rand2(vec2(seed))*count))/count, vec2(0.0), vec2(1.0));
}
vec2 old_custom_uv_transform(vec2 uv, vec2 cst_scale, float rnd_rotate, float rnd_scale, vec2 seed) {
	seed = rand2(seed);
	uv -= vec2(0.5);
	float angle = (seed.x * 2.0 - 1.0) * rnd_rotate;
	float ca = cos(angle);
	float sa = sin(angle);
	uv = vec2(ca*uv.x+sa*uv.y, -sa*uv.x+ca*uv.y);
	uv *= (seed.y-0.5)*2.0*rnd_scale+1.0;
	uv /= cst_scale;
	uv += vec2(0.5);
	return uv;
}
float o25787033982980_input_d(vec2 uv, float _seed_variation_) {
// #output0: graph_8/graph_2/graph_10/optional (o25790506863782)
vec4 o25790506863782_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph_2/graph_10/decompose_2 (o25790523643993)
float o25790523643993_3_1_f = o25790506863782_0_1_rgba.a;
// #output0: graph_8/graph_2/graph_10/optional_2 (o25790590752866)
vec4 o25790590752866_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph_2/graph_10/decompose_3 (o25790607526173)
float o25790607526173_3_1_f = o25790590752866_0_1_rgba.a;
// #code: graph_8/graph_2/graph_10/math (o25790624305655)
float o25790624305655_0_clamp_false = (1.0-step(o25790607526173_3_1_f,o25790523643993_3_1_f));
float o25790624305655_0_clamp_true = clamp(o25790624305655_0_clamp_false, 0.0, 1.0);
// #output0: graph_8/graph_2/graph_10/math (o25790624305655)
float o25790624305655_0_1_f = o25790624305655_0_clamp_false;
// #output0: graph_8/graph_2/graph_10/invert (o25790641081650)
vec4 o25790641081650_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o25790624305655_0_1_f), 1.0).rgb, vec4(vec3(o25790624305655_0_1_f), 1.0).a);
// #output0: graph_8/fbm2 (o25790406200383)
float o25790406200383_0_1_f = old_fbm_2d_voronoise((uv), vec2(p_o25790406200383_scale_x, p_o25790406200383_scale_y), int(p_o25790406200383_folds), int(p_o25790406200383_iterations), p_o25790406200383_persistence, p_o25790406200383_offset, (seed_o25790406200383+fract(_seed_variation_)));
// #code: graph_8/graph_2/blend2_2 (o25790439754225)
vec4 o25790439754225_0_b = vec4(vec3(o25790406200383_0_1_f), 1.0);
vec4 o25790439754225_0_l;
float o25790439754225_0_a;
o25790439754225_0_l = vec4(0.0, 0.0, 0.0, 0.0);
o25790439754225_0_a = p_o25790439754225_amount1*(dot((o25790641081650_0_1_rgba).rgb, vec3(1.0))/3.0);
o25790439754225_0_b = vec4(blend_normal(uv, o25790439754225_0_l.rgb, o25790439754225_0_b.rgb, o25790439754225_0_a*o25790439754225_0_l.a), min(1.0, o25790439754225_0_b.a+o25790439754225_0_a*o25790439754225_0_l.a));
// #output0: graph_8/graph_2/blend2_2 (o25790439754225)
vec4 o25790439754225_0_1_rgba = o25790439754225_0_b;
return (dot((o25790439754225_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_8/warp (o25787033982980)
vec2 o25787033982980_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o25787033982980_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o25787033982980_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o25787033982980_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o25787033982980_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
float o25786916542411_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_8/graph/graph_10/optional (o25787184974454)
vec4 o25787184974454_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph/graph_10/decompose_2 (o25787201756302)
float o25787201756302_3_1_f = o25787184974454_0_1_rgba.a;
// #output0: graph_8/graph/graph_10/optional_2 (o25787268860202)
vec4 o25787268860202_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph/graph_10/decompose_3 (o25787285638876)
float o25787285638876_3_1_f = o25787268860202_0_1_rgba.a;
// #code: graph_8/graph/graph_10/math (o25787302416906)
float o25787302416906_0_clamp_false = (1.0-step(o25787285638876_3_1_f,o25787201756302_3_1_f));
float o25787302416906_0_clamp_true = clamp(o25787302416906_0_clamp_false, 0.0, 1.0);
// #output0: graph_8/graph/graph_10/math (o25787302416906)
float o25787302416906_0_1_f = o25787302416906_0_clamp_false;
// #output0: graph_8/graph/graph_10/invert (o25787319196444)
vec4 o25787319196444_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o25787302416906_0_1_f), 1.0).rgb, vec4(vec3(o25787302416906_0_1_f), 1.0).a);
// #output0: graph_8/shape (o25786882985910)
float o25786882985910_0_1_f = shape_circle((transform2(uv, vec2(p_o25786899766006_translate_x*(2.0*1.0-1.0), p_o25786899766006_translate_y*(2.0*1.0-1.0)), p_o25786899766006_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o25786899766006_scale_x*(2.0*1.0-1.0), p_o25786899766006_scale_y*(2.0*1.0-1.0)))), p_o25786882985910_sides, p_o25786882985910_radius*1.0, p_o25786882985910_edge*1.0);
// #code: graph_8/graph/blend2_2 (o25787117866043)
vec4 o25787117866043_0_b = vec4(vec3(o25786882985910_0_1_f), 1.0);
vec4 o25787117866043_0_l;
float o25787117866043_0_a;
o25787117866043_0_l = vec4(0.0, 0.0, 0.0, 0.0);
o25787117866043_0_a = p_o25787117866043_amount1*(dot((o25787319196444_0_1_rgba).rgb, vec3(1.0))/3.0);
o25787117866043_0_b = vec4(blend_normal((transform2(uv, vec2(p_o25786899766006_translate_x*(2.0*1.0-1.0), p_o25786899766006_translate_y*(2.0*1.0-1.0)), p_o25786899766006_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o25786899766006_scale_x*(2.0*1.0-1.0), p_o25786899766006_scale_y*(2.0*1.0-1.0)))), o25787117866043_0_l.rgb, o25787117866043_0_b.rgb, o25787117866043_0_a*o25787117866043_0_l.a), min(1.0, o25787117866043_0_b.a+o25787117866043_0_a*o25787117866043_0_l.a));
// #output0: graph_8/graph/blend2_2 (o25787117866043)
vec4 o25787117866043_0_1_rgba = o25787117866043_0_b;
// #output0: graph_8/transform2 (o25786899766006)
vec4 o25786899766006_0_1_rgba = o25787117866043_0_1_rgba;
return (dot((o25786899766006_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o25786916542411_input_mask(vec2 uv, float _seed_variation_) {
// #output0: graph_8/graph_3/graph_10/optional (o25793811974479)
vec4 o25793811974479_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph_3/graph_10/decompose_2 (o25793828752055)
float o25793828752055_3_1_f = o25793811974479_0_1_rgba.a;
// #output0: graph_8/graph_3/graph_10/optional_2 (o25793895865352)
vec4 o25793895865352_0_1_rgba = vec4(0.0, 0.0, 0.0, 0.0);
// #output3: graph_8/graph_3/graph_10/decompose_3 (o25793912638119)
float o25793912638119_3_1_f = o25793895865352_0_1_rgba.a;
// #code: graph_8/graph_3/graph_10/math (o25793929415004)
float o25793929415004_0_clamp_false = (1.0-step(o25793912638119_3_1_f,o25793828752055_3_1_f));
float o25793929415004_0_clamp_true = clamp(o25793929415004_0_clamp_false, 0.0, 1.0);
// #output0: graph_8/graph_3/graph_10/math (o25793929415004)
float o25793929415004_0_1_f = o25793929415004_0_clamp_false;
// #output0: graph_8/graph_3/graph_10/invert (o25793946192566)
vec4 o25793946192566_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o25793929415004_0_1_f), 1.0).rgb, vec4(vec3(o25793929415004_0_1_f), 1.0).a);
// #output0: graph_8/shape_2 (o25786866211917)
float o25786866211917_0_1_f = shape_circle((uv), p_o25786866211917_sides, p_o25786866211917_radius*1.0, p_o25786866211917_edge*1.0);
// #code: graph_8/graph_3/blend2_2 (o25793744869545)
vec4 o25793744869545_0_b = vec4(vec3(o25786866211917_0_1_f), 1.0);
vec4 o25793744869545_0_l;
float o25793744869545_0_a;
o25793744869545_0_l = vec4(0.0, 0.0, 0.0, 0.0);
o25793744869545_0_a = p_o25793744869545_amount1*(dot((o25793946192566_0_1_rgba).rgb, vec3(1.0))/3.0);
o25793744869545_0_b = vec4(blend_normal(uv, o25793744869545_0_l.rgb, o25793744869545_0_b.rgb, o25793744869545_0_a*o25793744869545_0_l.a), min(1.0, o25793744869545_0_b.a+o25793744869545_0_a*o25793744869545_0_l.a));
// #output0: graph_8/graph_3/blend2_2 (o25793744869545)
vec4 o25793744869545_0_1_rgba = o25793744869545_0_b;
return (dot((o25793744869545_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_8/splatter_4 (o25786916542411)
vec4 splatter_o25786916542411(vec2 uv, int count, inout vec3 instance_uv, vec2 seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int i = 0; i < count; ++i) {
		seed = rand2(seed);
		rc1 = rand3(seed);
		float mask = o25786916542411_input_mask((fract(seed+vec2(0.5))), _seed_variation_);
		if (mask > 0.01) {
			vec2 pv = fract(uv - seed)-vec2(0.5);
			seed = rand2(seed);
			float angle = (seed.x * 2.0 - 1.0) * (mod(elapsed_time / 17.0, 1.0) * 1.5) * 0.01745329251;
			float angle_start = (mod(elapsed_time / 11.0, 1.0) * 360.0) * 0.01745329251;
			float ca = cos(angle + angle_start);
			float sa = sin(angle + angle_start);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv *= (seed.y-0.5)*2.0*p_o25786916542411_scale+1.0;
			seed = rand2(seed);
			pv *= vec2(1,(seed.y-0.5)*1.5*(mod(elapsed_time / 13.0, 1.0) * 2.0)+1.0);
			seed = rand2(seed);
			pv *= vec2((seed.y-0.5)*1.5*p_o25786916542411_rnd_scale_x+1.0, 1);
			pv /= vec2(p_o25786916542411_scale_x, (0.2 + mod(elapsed_time / 7.0, 1.0) * 0.8));
			pv += vec2(0.5);
			seed = rand2(seed);
			vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
			if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
				continue;
			}
			vec2 full_uv = pv;
			pv = get_from_tileset( 1.0, seed.x, pv);
			float c1 = o25786916542411_input_in(pv, true ? seed.x : 0.0)*mask*(1.0-p_o25786916542411_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
			instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
		}
	}
	return vec4(rc, c);
}
float o25726887663506_input_in(vec2 uv, float _seed_variation_) {
// #code: graph_8/warp (o25787033982980)
vec2 o25787033982980_0_slope = o25787033982980_slope(uv, p_o25787033982980_eps, _seed_variation_);
vec2 o25787033982980_0_warp = o25787033982980_0_slope;
// #code: graph_8/splatter_4 (o25786916542411)
vec3 o25786916542411_0_instance_uv = vec3(0.0);
float rnd_add = float((seed_o25786916542411+fract(_seed_variation_)) -0.5) * (o25787017202398_cluster_max-o25787017202398_cluster_min);
vec4 o25786916542411_0_rch = splatter_o25786916542411((uv+(mod(elapsed_time / 19.0, 1.0) * 0.5)*o25787033982980_0_warp), int((o25787017202398_cluster_min) + rnd_add), o25786916542411_0_instance_uv, vec2(float((seed_o25786916542411+fract(_seed_variation_)))), _seed_variation_);
// #output0: graph_8/splatter_4 (o25786916542411)
float o25786916542411_0_1_f = o25786916542411_0_rch.a;
// #output0: graph_8/warp (o25787033982980)
vec4 o25787033982980_0_1_rgba = vec4(vec3(o25786916542411_0_1_f), 1.0);
return (dot((o25787033982980_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: splatter_7 (o25726887663506)
vec4 splatter_o25726887663506(vec2 uv, int count, inout vec3 instance_uv, vec2 seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int i = 0; i < count; ++i) {
		seed = rand2(seed);
		rc1 = rand3(seed);
		float mask = 1.0;
		if (mask > 0.01) {
			vec2 pv = fract(uv - seed)-vec2(0.5);
			seed = rand2(seed);
			float angle = (seed.x * 2.0 - 1.0) * p_o25726887663506_rotate * 0.01745329251;
			float ca = cos(angle);
			float sa = sin(angle);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv *= (seed.y-0.5)*2.0*p_o25726887663506_scale+1.0;
			pv /= vec2(p_o25726887663506_scale_x, p_o25726887663506_scale_y);
			pv += vec2(0.5);
			seed = rand2(seed);
			vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
			if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
				continue;
			}
			vec2 full_uv = pv;
			pv = get_from_tileset( 1.0, seed.x, pv);
			float c1 = o25726887663506_input_in(pv, true ? seed.x : 0.0)*mask*(1.0-p_o25726887663506_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
			instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
		}
	}
	return vec4(rc, c);
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #code: splatter_7 (o25726887663506)
vec3 o25726887663506_0_instance_uv = vec3(0.0);
vec4 o25726887663506_0_rch = splatter_o25726887663506((uv), int(p_o25726887663506_count), o25726887663506_0_instance_uv, vec2(float((seed_o25726887663506+fract(_seed_variation_)))), _seed_variation_);
// #output0: splatter_7 (o25726887663506)
float o25726887663506_0_1_f = o25726887663506_0_rch.a;
float o25786799097871_0 = textureLod(texture_1, fract((uv)), 0.0).r;
float o25726837333395_0 = textureLod(texture_2, fract((uv)), 0.0).r;
float o25726703113394_0 = textureLod(texture_3, fract((uv)), 0.0).r;
float o25726652782697_0 = textureLod(texture_4, fract((uv)), 0.0).r;
float o25726602451196_0 = textureLod(texture_5, fract((uv)), 0.0).r;

// #code: blend2 (o25726954773943)
vec4 o25726954773943_0_b = vec4(vec3(o25726602451196_0), 1.0);
vec4 o25726954773943_0_l;
float o25726954773943_0_a;

o25726954773943_0_l = vec4(vec3(o25726652782697_0), 1.0);
o25726954773943_0_a = p_o25726954773943_amount1*1.0;
o25726954773943_0_b = vec4(blend_lighten((uv), o25726954773943_0_l.rgb, o25726954773943_0_b.rgb, o25726954773943_0_a*o25726954773943_0_l.a), min(1.0, o25726954773943_0_b.a+o25726954773943_0_a*o25726954773943_0_l.a));

o25726954773943_0_l = vec4(vec3(o25726703113394_0), 1.0);
o25726954773943_0_a = p_o25726954773943_amount2*1.0;
o25726954773943_0_b = vec4(blend_lighten((uv), o25726954773943_0_l.rgb, o25726954773943_0_b.rgb, o25726954773943_0_a*o25726954773943_0_l.a), min(1.0, o25726954773943_0_b.a+o25726954773943_0_a*o25726954773943_0_l.a));

o25726954773943_0_l = vec4(vec3(o25726837333395_0), 1.0);
o25726954773943_0_a = p_o25726954773943_amount3*1.0;
o25726954773943_0_b = vec4(blend_lighten((uv), o25726954773943_0_l.rgb, o25726954773943_0_b.rgb, o25726954773943_0_a*o25726954773943_0_l.a), min(1.0, o25726954773943_0_b.a+o25726954773943_0_a*o25726954773943_0_l.a));

o25726954773943_0_l = vec4(vec3(o25786799097871_0), 1.0);
o25726954773943_0_a = p_o25726954773943_amount4*1.0;
o25726954773943_0_b = vec4(blend_lighten((uv), o25726954773943_0_l.rgb, o25726954773943_0_b.rgb, o25726954773943_0_a*o25726954773943_0_l.a), min(1.0, o25726954773943_0_b.a+o25726954773943_0_a*o25726954773943_0_l.a));

o25726954773943_0_l = vec4(1.0, (uv).y, 1.0, 1.0);
o25726954773943_0_a = p_o25726954773943_amount5*1.0;
o25726954773943_0_b = vec4(blend_lighten((uv), o25726954773943_0_l.rgb, o25726954773943_0_b.rgb, o25726954773943_0_a*o25726954773943_0_l.a), min(1.0, o25726954773943_0_b.a+o25726954773943_0_a*o25726954773943_0_l.a));
// #output0: blend2 (o25726954773943)
vec4 o25726954773943_0_1_rgba = o25726954773943_0_b;

// #code: blend2_2 (o25801781156854)
vec4 o25801781156854_0_b = o25726954773943_0_1_rgba;
vec4 o25801781156854_0_l;
float o25801781156854_0_a;

o25801781156854_0_l = vec4(vec3(o25726887663506_0_1_f), 1.0);
o25801781156854_0_a = p_o25801781156854_amount1*1.0;
o25801781156854_0_b = vec4(blend_lighten((uv), o25801781156854_0_l.rgb, o25801781156854_0_b.rgb, o25801781156854_0_a*o25801781156854_0_l.a), min(1.0, o25801781156854_0_b.a+o25801781156854_0_a*o25801781156854_0_l.a));
// #output0: blend2_2 (o25801781156854)
vec4 o25801781156854_0_1_rgba = o25801781156854_0_b;

	vec4 color_tex = o25801781156854_0_1_rgba;
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	COLOR = color_tex;
}



