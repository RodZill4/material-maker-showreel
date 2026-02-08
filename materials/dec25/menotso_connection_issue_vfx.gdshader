shader_type spatial;
render_mode blend_mix,cull_back,diffuse_burley,specular_schlick_ggx
;
uniform vec3 uv1_offset = vec3(0.0, 0.0, 0.0);
uniform vec3 uv1_scale = vec3(1.0, 1.0, 1.0);
uniform int depth_min_layers = 8;
uniform int depth_max_layers = 16;
uniform vec2 depth_flip = vec2(1.0);
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
const vec4 p_o762407028529_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o762407028529_metallic = 0.000000000;
const float p_o762407028529_roughness = 1.000000000;
const float p_o762407028529_emission_energy = 1.000000000;
const float p_o762407028529_normal = 1.000000000;
const float p_o762407028529_ao = 1.000000000;
const float p_o762407028529_depth_scale = 0.500000000;
const float p_o763463993489_amount1 = 1.000000000;
const float p_o763564656416_translate_x = 0.000000000;
const float p_o763564656416_translate_y = 0.000000000;
const float p_o763564656416_rotate = 0.000000000;
const float p_o763564656416_scale_x = 1.200000000;
const float p_o763564656416_scale_y = 1.200000000;
const float p_o762558025008_amount1 = 1.000000000;
const float p_o762558025008_amount2 = 1.000000000;
const float p_o762558025008_amount3 = 1.000000000;
const float p_o762541246203_amount1 = 0.210000000;
const float seed_o762507691786 = 0.372215956;
const float p_o762507691786_scale_x = 2.500000000;
const float p_o762507691786_folds = 1.000000000;
const float p_o762507691786_iterations = 4.000000000;
const float p_o762507691786_persistence = 1.000000000;
const float p_o762507691786_offset = 0.000000000;
const float p_o763396884280_amplitude = 0.140000000;
const float p_o763396884280_frequency = 2.000000000;
const float p_o762524469001_default_in1 = 0.000000000;
const float p_o762524469001_default_in2 = 0.000000000;
const float p_o762490914572_cx = 0.000000000;
const float p_o762490914572_cy = 0.000000000;
const float p_o762490914572_rotate = -45.000000000;
const float p_o762474137355_sides = 2.000000000;
const float p_o762474137355_radius = 0.100000000;
const float p_o762474137355_edge = 1.000000000;
const float p_o762457360141_sides = 6.000000000;
const float p_o762457360141_radius = 0.660000000;
const float p_o762457360141_edge = 0.250000000;
const float p_o763078117135_count = 5.000000000;
const float p_o763078117135_width = 4.000000000;
const float p_o763598210868_amount1 = 0.800000000;
const float p_o763598210868_amount2 = 1.000000000;
const float p_o763598210868_amount3 = 1.000000000;
const float p_o763631766320_default_in1 = 1.000000000;
const float p_o762910344964_default_in1 = 0.000000000;
const float p_o762910344964_default_in2 = 0.000000000;
const float p_o762893567802_default_in1 = 0.000000000;
const float p_o762893567802_default_in2 = 0.000000000;
const float p_o762876790534_value = 1.000000000;
const float p_o762876790534_width = 0.070000000;
const float p_o763279443749_amplitude = 0.140000000;
const float p_o763279443749_frequency = 2.000000000;
const float p_o762977454792_sides = 6.000000000;
const float p_o762977454792_radius = 0.660000000;
const float p_o762977454792_edge = 0.250000000;
const float p_o763833091891_repeat = 1.000000000;
const float p_o763833091891_rotate = 0.000000000;
const float p_o763833091891_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o763833091891_gradient_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 0.000000000, 1.000000000), vec4(0.300781250, 0.300781250, 0.000000000, 1.000000000) );
const float p_o763581433616_default_in1 = 1.000000000;
const float p_o763614988052_default_in1 = 1.000000000;
const vec4 p_o763648543489_color = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const float p_o763145226026_count = 5.000000000;
const float p_o763145226026_width = 4.000000000;
const float p_o763682097966_amount1 = 0.800000000;
const float p_o763682097966_amount2 = 1.000000000;
const float p_o763682097966_amount3 = 1.000000000;
const float p_o763044563725_default_in1 = 0.000000000;
const float p_o763044563725_default_in2 = 0.000000000;
const float p_o763027786513_default_in1 = 0.000000000;
const float p_o763027786513_default_in2 = 0.000000000;
const float p_o763011009300_value = 1.000000000;
const float p_o763011009300_width = 0.070000000;
const float p_o762440582938_default_in1 = 0.000000000;
const float p_o762440582938_default_in2 = 0.000000000;
const float p_o762423805704_sides = 6.000000000;
const float p_o762423805704_radius = 0.810000000;
const float p_o762423805704_edge = 0.510000000;
const vec4 p_o763480770352_color = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
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
// #globals: blend2_3 (o763463993489)
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
// #globals: transform2 (o763564656416)
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
// #globals: combine (o762927122178)
// #globals: fbm3 (o762507691786)
float value_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_value(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = value_noise_2d(coord*size, size, offset, seed+float(i));
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
float perlin_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_perlin(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = perlin_noise_2d(coord*size, size, offset, seed+float(i));
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
float perlinabs_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	return abs(2.0*perlin_noise_2d(coord, size, offset, seed)-1.0);
}
float fbm_2d_perlinabs(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = perlinabs_noise_2d(coord*size, size, offset, seed+float(i));
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
float fbm_2d_mod289(float x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}
float fbm_2d_permute(float x) {
	return fbm_2d_mod289(((x * 34.0) + 1.0) * x);
}
vec2 fbm_2d_rgrad2(vec2 p, float rot, float seed) {
	float u = fbm_2d_permute(fbm_2d_permute(p.x) + p.y) * 0.0243902439 + rot; // Rotate by shift
	u = fract(u+seed) * 6.28318530718; // 2*pi
	return vec2(cos(u), sin(u));
}
float simplex_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
	vec2 g0 = fbm_2d_rgrad2(vec2(iuw.x, ivw.x), offset, seed);
	vec2 g1 = fbm_2d_rgrad2(vec2(iuw.y, ivw.y), offset, seed);
	vec2 g2 = fbm_2d_rgrad2(vec2(iuw.z, ivw.z), offset, seed);
	vec3 w = vec3(dot(g0, d0), dot(g1, d1), dot(g2, d2));
	vec3 t = 0.8 - vec3(dot(d0, d0), dot(d1, d1), dot(d2, d2));
	t = max(t, vec3(0.0));
	vec3 t2 = t * t;
	vec3 t4 = t2 * t2;
	float n = dot(t4, w);
	return 0.5 + 5.5 * n;
}
float fbm_2d_simplex(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = simplex_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular2_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular2(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular2_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular3_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular3(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular3_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular4_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular4(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular4_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular5_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular5(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular5_noise_2d(coord*size, size, offset, seed+float(i));
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
float cellular6_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_cellular6(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular6_noise_2d(coord*size, size, offset, seed+float(i));
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
float voronoise_noise_2d( vec2 coord, vec2 size, float offset, float seed) {
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
float fbm_2d_voronoise(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = voronoise_noise_2d(coord*size, size, offset, seed+float(i));
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
// #globals: math_4 (o762524469001)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: rotate (o762490914572)
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
	return rv;	
}
// #globals: shape_3 (o762474137355)
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
vec4 o763833091891_gradient_gradient_fct(float x) {
  if (x < p_o763833091891_gradient_pos[0]) {
    return p_o763833091891_gradient_col[0];
  } else if (x < p_o763833091891_gradient_pos[1]) {
    return mix(p_o763833091891_gradient_col[0], p_o763833091891_gradient_col[1], ((x-p_o763833091891_gradient_pos[0])/(p_o763833091891_gradient_pos[1]-p_o763833091891_gradient_pos[0])));
  }
  return p_o763833091891_gradient_col[1];
}
vec4 o763078117135_input_in(vec2 uv, float _seed_variation_) {
// #code: math_11 (o763631766320)
float o763631766320_0_clamp_false = p_o763631766320_default_in1*(((sin(elapsed_time*3.1415)+1.0)*0.5));
float o763631766320_0_clamp_true = clamp(o763631766320_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o763631766320)
float o763631766320_0_1_f = o763631766320_0_clamp_false;
// #output0: sine_wave_3 (o763279443749)
float o763279443749_0_1_f = 1.0-abs(2.0*((uv).y-0.5)-p_o763279443749_amplitude*sin((p_o763279443749_frequency*(uv).x+(elapsed_time*0.5))*6.28318530718));
// #code: tones_step_2 (o762876790534)
vec3 o762876790534_0_false = clamp((vec4(vec3(o763279443749_0_1_f), 1.0).rgb-vec3(p_o762876790534_value))/max(0.0001, p_o762876790534_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o762876790534_0_true = vec3(1.0)-o762876790534_0_false;
// #output0: tones_step_2 (o762876790534)
vec4 o762876790534_0_1_rgba = vec4(o762876790534_0_true, vec4(vec3(o763279443749_0_1_f), 1.0).a);
// #code: math_10 (o762893567802)
float o762893567802_0_clamp_false = sqrt(1.0-(dot((o762876790534_0_1_rgba).rgb, vec3(1.0))/3.0)*(dot((o762876790534_0_1_rgba).rgb, vec3(1.0))/3.0));
float o762893567802_0_clamp_true = clamp(o762893567802_0_clamp_false, 0.0, 1.0);
// #output0: math_10 (o762893567802)
float o762893567802_0_1_f = o762893567802_0_clamp_false;
// #output0: shape_6 (o762977454792)
float o762977454792_0_1_f = shape_circle((uv), p_o762977454792_sides+1.0e-5, p_o762977454792_radius*1.0, p_o762977454792_edge*1.0);
// #code: math_12 (o762910344964)
float o762910344964_0_clamp_false = (1.0-step(o762977454792_0_1_f,o762893567802_0_1_f));
float o762910344964_0_clamp_true = clamp(o762910344964_0_clamp_false, 0.0, 1.0);
// #output0: math_12 (o762910344964)
float o762910344964_0_1_f = o762910344964_0_clamp_false;
// #code: gradient_2 (o763833091891)
float o763833091891_0_r = 0.5+(cos(p_o763833091891_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o763833091891_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o763833091891_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient_2 (o763833091891)
vec4 o763833091891_0_1_rgba = o763833091891_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o763833091891_0_r*p_o763833091891_repeat)-0.5)) : fract(o763833091891_0_r*p_o763833091891_repeat));
// #output0: combine_3 (o762960676625)
vec4 o762960676625_0_1_rgba = vec4(o762910344964_0_1_f, o762910344964_0_1_f, (dot((o763833091891_0_1_rgba).rgb, vec3(1.0))/3.0), o762910344964_0_1_f);
// #code: math_6 (o763581433616)
float o763581433616_0_clamp_false = p_o763581433616_default_in1*(((sin(elapsed_time*2.0*3.1415)+1.0)*0.5));
float o763581433616_0_clamp_true = clamp(o763581433616_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o763581433616)
float o763581433616_0_1_f = o763581433616_0_clamp_false;
// #code: math_8 (o763614988052)
float o763614988052_0_clamp_false = p_o763614988052_default_in1*(step((sin(elapsed_time*40.0*3.1415)+1.0)*0.5,0.5));
float o763614988052_0_clamp_true = clamp(o763614988052_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o763614988052)
float o763614988052_0_1_f = o763614988052_0_clamp_false;
// #output0: uniform_2 (o763648543489)
vec4 o763648543489_0_1_rgba = p_o763648543489_color;
// #code: blend2_4 (o763598210868)
vec4 o763598210868_0_b = o763648543489_0_1_rgba;
vec4 o763598210868_0_l;
float o763598210868_0_a;
o763598210868_0_l = o762960676625_0_1_rgba;
o763598210868_0_a = p_o763598210868_amount1*o763614988052_0_1_f;
o763598210868_0_b = vec4(blend_normal((uv), o763598210868_0_l.rgb, o763598210868_0_b.rgb, o763598210868_0_a*o763598210868_0_l.a), min(1.0, o763598210868_0_b.a+o763598210868_0_a*o763598210868_0_l.a));
o763598210868_0_l = o762960676625_0_1_rgba;
o763598210868_0_a = p_o763598210868_amount2*o763581433616_0_1_f;
o763598210868_0_b = vec4(blend_normal((uv), o763598210868_0_l.rgb, o763598210868_0_b.rgb, o763598210868_0_a*o763598210868_0_l.a), min(1.0, o763598210868_0_b.a+o763598210868_0_a*o763598210868_0_l.a));
o763598210868_0_l = o762960676625_0_1_rgba;
o763598210868_0_a = p_o763598210868_amount3*o763631766320_0_1_f;
o763598210868_0_b = vec4(blend_normal((uv), o763598210868_0_l.rgb, o763598210868_0_b.rgb, o763598210868_0_a*o763598210868_0_l.a), min(1.0, o763598210868_0_b.a+o763598210868_0_a*o763598210868_0_l.a));
// #output0: blend2_4 (o763598210868)
vec4 o763598210868_0_1_rgba = o763598210868_0_b;
// #output0: combine_6 (o763665320751)
vec4 o763665320751_0_1_rgba = vec4((dot((o763598210868_0_1_rgba).rgb, vec3(1.0))/3.0), (dot((o763598210868_0_1_rgba).rgb, vec3(1.0))/3.0), 0.0, (dot((o763598210868_0_1_rgba).rgb, vec3(1.0))/3.0));
return o763665320751_0_1_rgba;
}
// #instance: supersample (o763078117135)
vec4 supersample_o763078117135(vec2 uv, float size, int count, float width, float _seed_variation_) {
	vec4 rv = vec4(0.0);
	vec2 step_size = vec2(width)/size/float(count);
	uv -= vec2(0.5)/size;
	for (int x = 0; x < count; ++x) {
		for (int y = 0; y < count; ++y) {
			rv += o763078117135_input_in((uv+(vec2(float(x), float(y))+vec2(0.5))*step_size), _seed_variation_);
		}
	}
	return rv/float(count*count);
}
vec4 o763145226026_input_in(vec2 uv, float _seed_variation_) {
// #code: math_11 (o763631766320)
float o763631766320_0_clamp_false = p_o763631766320_default_in1*(((sin(elapsed_time*3.1415)+1.0)*0.5));
float o763631766320_0_clamp_true = clamp(o763631766320_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o763631766320)
float o763631766320_0_1_f = o763631766320_0_clamp_false;
// #output0: sine_wave_2 (o763396884280)
float o763396884280_0_1_f = 1.0-abs(2.0*((uv).y-0.5)-p_o763396884280_amplitude*sin((p_o763396884280_frequency*(uv).x+(elapsed_time))*6.28318530718));
// #code: tones_step (o763011009300)
vec3 o763011009300_0_false = clamp((vec4(vec3(o763396884280_0_1_f), 1.0).rgb-vec3(p_o763011009300_value))/max(0.0001, p_o763011009300_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o763011009300_0_true = vec3(1.0)-o763011009300_0_false;
// #output0: tones_step (o763011009300)
vec4 o763011009300_0_1_rgba = vec4(o763011009300_0_true, vec4(vec3(o763396884280_0_1_f), 1.0).a);
// #code: math_2 (o763027786513)
float o763027786513_0_clamp_false = sqrt(1.0-(dot((o763011009300_0_1_rgba).rgb, vec3(1.0))/3.0)*(dot((o763011009300_0_1_rgba).rgb, vec3(1.0))/3.0));
float o763027786513_0_clamp_true = clamp(o763027786513_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o763027786513)
float o763027786513_0_1_f = o763027786513_0_clamp_false;
// #output0: shape_6 (o762977454792)
float o762977454792_0_1_f = shape_circle((uv), p_o762977454792_sides+1.0e-5, p_o762977454792_radius*1.0, p_o762977454792_edge*1.0);
// #code: math_9 (o763044563725)
float o763044563725_0_clamp_false = (1.0-step(o762977454792_0_1_f,o763027786513_0_1_f));
float o763044563725_0_clamp_true = clamp(o763044563725_0_clamp_false, 0.0, 1.0);
// #output0: math_9 (o763044563725)
float o763044563725_0_1_f = o763044563725_0_clamp_false;
// #code: gradient_2 (o763833091891)
float o763833091891_0_r = 0.5+(cos(p_o763833091891_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o763833091891_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o763833091891_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient_2 (o763833091891)
vec4 o763833091891_0_1_rgba = o763833091891_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o763833091891_0_r*p_o763833091891_repeat)-0.5)) : fract(o763833091891_0_r*p_o763833091891_repeat));
// #output0: combine_4 (o763061339942)
vec4 o763061339942_0_1_rgba = vec4(o763044563725_0_1_f, o763044563725_0_1_f, (dot((o763833091891_0_1_rgba).rgb, vec3(1.0))/3.0), o763044563725_0_1_f);
// #code: math_6 (o763581433616)
float o763581433616_0_clamp_false = p_o763581433616_default_in1*(((sin(elapsed_time*2.0*3.1415)+1.0)*0.5));
float o763581433616_0_clamp_true = clamp(o763581433616_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o763581433616)
float o763581433616_0_1_f = o763581433616_0_clamp_false;
// #code: math_8 (o763614988052)
float o763614988052_0_clamp_false = p_o763614988052_default_in1*(step((sin(elapsed_time*40.0*3.1415)+1.0)*0.5,0.5));
float o763614988052_0_clamp_true = clamp(o763614988052_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o763614988052)
float o763614988052_0_1_f = o763614988052_0_clamp_false;
// #output0: uniform_2 (o763648543489)
vec4 o763648543489_0_1_rgba = p_o763648543489_color;
// #code: blend2_5 (o763682097966)
vec4 o763682097966_0_b = o763648543489_0_1_rgba;
vec4 o763682097966_0_l;
float o763682097966_0_a;
o763682097966_0_l = o763061339942_0_1_rgba;
o763682097966_0_a = p_o763682097966_amount1*o763614988052_0_1_f;
o763682097966_0_b = vec4(blend_normal((uv), o763682097966_0_l.rgb, o763682097966_0_b.rgb, o763682097966_0_a*o763682097966_0_l.a), min(1.0, o763682097966_0_b.a+o763682097966_0_a*o763682097966_0_l.a));
o763682097966_0_l = o763061339942_0_1_rgba;
o763682097966_0_a = p_o763682097966_amount2*o763581433616_0_1_f;
o763682097966_0_b = vec4(blend_normal((uv), o763682097966_0_l.rgb, o763682097966_0_b.rgb, o763682097966_0_a*o763682097966_0_l.a), min(1.0, o763682097966_0_b.a+o763682097966_0_a*o763682097966_0_l.a));
o763682097966_0_l = o763061339942_0_1_rgba;
o763682097966_0_a = p_o763682097966_amount3*o763631766320_0_1_f;
o763682097966_0_b = vec4(blend_normal((uv), o763682097966_0_l.rgb, o763682097966_0_b.rgb, o763682097966_0_a*o763682097966_0_l.a), min(1.0, o763682097966_0_b.a+o763682097966_0_a*o763682097966_0_l.a));
// #output0: blend2_5 (o763682097966)
vec4 o763682097966_0_1_rgba = o763682097966_0_b;
// #output0: combine_7 (o763698875171)
vec4 o763698875171_0_1_rgba = vec4((dot((o763682097966_0_1_rgba).rgb, vec3(1.0))/3.0), (dot((o763682097966_0_1_rgba).rgb, vec3(1.0))/3.0), 0.0, (dot((o763682097966_0_1_rgba).rgb, vec3(1.0))/3.0));
return o763698875171_0_1_rgba;
}
// #instance: supersample_2 (o763145226026)
vec4 supersample_o763145226026(vec2 uv, float size, int count, float width, float _seed_variation_) {
	vec4 rv = vec4(0.0);
	vec2 step_size = vec2(width)/size/float(count);
	uv -= vec2(0.5)/size;
	for (int x = 0; x < count; ++x) {
		for (int y = 0; y < count; ++y) {
			rv += o763145226026_input_in((uv+(vec2(float(x), float(y))+vec2(0.5))*step_size), _seed_variation_);
		}
	}
	return rv/float(count*count);
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: sine_wave_2 (o763396884280)
float o763396884280_0_1_f = 1.0-abs(2.0*((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))).y-0.5)-p_o763396884280_amplitude*sin((p_o763396884280_frequency*(fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))).x+(elapsed_time))*6.28318530718));

// #output0: fbm3 (o762507691786)
float o762507691786_0_1_f = fbm_2d_perlin((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), vec2(p_o762507691786_scale_x, (p_o762507691786_scale_x)), int(p_o762507691786_folds), int(p_o762507691786_iterations), p_o762507691786_persistence, o763396884280_0_1_f, (seed_o762507691786+fract(_seed_variation_)));

// #code: rotate (o762490914572)
vec2 o762490914572_0_c = vec2(0.5+p_o762490914572_cx, 0.5+p_o762490914572_cy);
// #output0: sine_wave_2 (o763396884280)
float o763396884280_0_3_f = 1.0-abs(2.0*((rotate((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0)))))-o762490914572_0_c, p_o762490914572_rotate*0.01745329251)+o762490914572_0_c).y-0.5)-p_o763396884280_amplitude*sin((p_o763396884280_frequency*(rotate((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0)))))-o762490914572_0_c, p_o762490914572_rotate*0.01745329251)+o762490914572_0_c).x+(elapsed_time))*6.28318530718));

// #output0: fbm3 (o762507691786)
float o762507691786_0_3_f = fbm_2d_perlin((rotate((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0)))))-o762490914572_0_c, p_o762490914572_rotate*0.01745329251)+o762490914572_0_c), vec2(p_o762507691786_scale_x, (p_o762507691786_scale_x)), int(p_o762507691786_folds), int(p_o762507691786_iterations), p_o762507691786_persistence, o763396884280_0_3_f, (seed_o762507691786+fract(_seed_variation_)));

// #output0: shape_3 (o762474137355)
float o762474137355_0_1_f = shape_polygon((rotate((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0)))))-o762490914572_0_c, p_o762490914572_rotate*0.01745329251)+o762490914572_0_c), p_o762474137355_sides+1.0e-5, p_o762474137355_radius*1.0, p_o762474137355_edge*o762507691786_0_3_f);

// #output0: rotate (o762490914572)
vec4 o762490914572_0_1_rgba = vec4(vec3(o762474137355_0_1_f), 1.0);

// #output0: shape_2 (o762457360141)
float o762457360141_0_1_f = shape_circle((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), p_o762457360141_sides+1.0e-5, p_o762457360141_radius*1.0, p_o762457360141_edge*o762507691786_0_1_f);

// #code: math_4 (o762524469001)
float o762524469001_0_clamp_false = min(o762457360141_0_1_f,(dot((o762490914572_0_1_rgba).rgb, vec3(1.0))/3.0));
float o762524469001_0_clamp_true = clamp(o762524469001_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o762524469001)
float o762524469001_0_1_f = o762524469001_0_clamp_false;

// #code: blend2 (o762541246203)
vec4 o762541246203_0_b = vec4(vec3(o762524469001_0_1_f), 1.0);
vec4 o762541246203_0_l;
float o762541246203_0_a;

o762541246203_0_l = vec4(vec3(o762507691786_0_1_f), 1.0);
o762541246203_0_a = p_o762541246203_amount1*1.0;
o762541246203_0_b = vec4(blend_multiply((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), o762541246203_0_l.rgb, o762541246203_0_b.rgb, o762541246203_0_a*o762541246203_0_l.a), min(1.0, o762541246203_0_b.a+o762541246203_0_a*o762541246203_0_l.a));
// #output0: blend2 (o762541246203)
vec4 o762541246203_0_1_rgba = o762541246203_0_b;

// #output0: combine (o762927122178)
vec4 o762927122178_0_1_rgba = vec4((dot((o762541246203_0_1_rgba).rgb, vec3(1.0))/3.0), 0.0, 0.0, (dot((o762541246203_0_1_rgba).rgb, vec3(1.0))/3.0));

// #output0: supersample (o763078117135)
vec4 o763078117135_0_1_rgba = supersample_o763078117135((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), 512.0, int(p_o763078117135_count), p_o763078117135_width, _seed_variation_);

// #output0: supersample_2 (o763145226026)
vec4 o763145226026_0_1_rgba = supersample_o763145226026((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), 512.0, int(p_o763145226026_count), p_o763145226026_width, _seed_variation_);

// #output0: shape (o762423805704)
float o762423805704_0_1_f = shape_circle((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), p_o762423805704_sides+1.0e-5, p_o762423805704_radius*1.0, p_o762423805704_edge*o762507691786_0_1_f);

// #code: math (o762440582938)
float o762440582938_0_clamp_false = o762423805704_0_1_f-o762457360141_0_1_f;
float o762440582938_0_clamp_true = clamp(o762440582938_0_clamp_false, 0.0, 1.0);
// #output0: math (o762440582938)
float o762440582938_0_1_f = o762440582938_0_clamp_false;

// #output0: combine_2 (o762943899411)
vec4 o762943899411_0_1_rgba = vec4(o762440582938_0_1_f, 0.0, 0.0, o762440582938_0_1_f);

// #code: blend2_2 (o762558025008)
vec4 o762558025008_0_b = o762943899411_0_1_rgba;
vec4 o762558025008_0_l;
float o762558025008_0_a;

o762558025008_0_l = o763145226026_0_1_rgba;
o762558025008_0_a = p_o762558025008_amount1*1.0;
o762558025008_0_b = vec4(blend_normal((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), o762558025008_0_l.rgb, o762558025008_0_b.rgb, o762558025008_0_a*o762558025008_0_l.a), min(1.0, o762558025008_0_b.a+o762558025008_0_a*o762558025008_0_l.a));

o762558025008_0_l = o763078117135_0_1_rgba;
o762558025008_0_a = p_o762558025008_amount2*1.0;
o762558025008_0_b = vec4(blend_normal((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), o762558025008_0_l.rgb, o762558025008_0_b.rgb, o762558025008_0_a*o762558025008_0_l.a), min(1.0, o762558025008_0_b.a+o762558025008_0_a*o762558025008_0_l.a));

o762558025008_0_l = o762927122178_0_1_rgba;
o762558025008_0_a = p_o762558025008_amount3*1.0;
o762558025008_0_b = vec4(blend_normal((fract(transform2((uv), vec2(p_o763564656416_translate_x*(2.0*1.0-1.0), p_o763564656416_translate_y*(2.0*1.0-1.0)), p_o763564656416_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o763564656416_scale_x*(2.0*1.0-1.0), p_o763564656416_scale_y*(2.0*1.0-1.0))))), o762558025008_0_l.rgb, o762558025008_0_b.rgb, o762558025008_0_a*o762558025008_0_l.a), min(1.0, o762558025008_0_b.a+o762558025008_0_a*o762558025008_0_l.a));
// #output0: blend2_2 (o762558025008)
vec4 o762558025008_0_1_rgba = o762558025008_0_b;

// #output0: transform2 (o763564656416)
vec4 o763564656416_0_1_rgba = o762558025008_0_1_rgba;

// #output0: uniform (o763480770352)
vec4 o763480770352_0_1_rgba = p_o763480770352_color;

// #code: blend2_3 (o763463993489)
vec4 o763463993489_0_b = o763480770352_0_1_rgba;
vec4 o763463993489_0_l;
float o763463993489_0_a;

o763463993489_0_l = o763564656416_0_1_rgba;
o763463993489_0_a = p_o763463993489_amount1*1.0;
o763463993489_0_b = vec4(blend_normal((uv), o763463993489_0_l.rgb, o763463993489_0_b.rgb, o763463993489_0_a*o763463993489_0_l.a), min(1.0, o763463993489_0_b.a+o763463993489_0_a*o763463993489_0_l.a));
// #output0: blend2_3 (o763463993489)
vec4 o763463993489_0_1_rgba = o763463993489_0_b;

	vec3 albedo_tex = ((o763463993489_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o762407028529_albedo_color.rgb;
	METALLIC = 1.0*p_o762407028529_metallic;
	ROUGHNESS = 1.0*p_o762407028529_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o762407028529_normal;
	EMISSION = vec3(0.0)*p_o762407028529_emission_energy;
}



