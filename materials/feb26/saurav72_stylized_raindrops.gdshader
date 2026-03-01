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
const vec4 p_o30469974400563_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o30469974400563_metallic = 0.150000000;
const float p_o30469974400563_roughness = 0.150000000;
const float p_o30469974400563_emission_energy = 1.000000000;
const float p_o30469974400563_normal = 1.000000000;
const float p_o30469974400563_ao = 1.000000000;
const float p_o30469974400563_depth_scale = 0.500000000;
const float p_o30470175726738_amount1 = 0.750000000;
const float p_o30470226057371_amount1 = 0.330000000;
const vec4 p_o30470209281644_in_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o30470209281644_in_mid = vec4(0.500000000, 0.500000000, 0.500000000, 0.500000000);
const vec4 p_o30470209281644_in_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o30470209281644_out_min = vec4(1.000000000, 1.000000000, 1.000000000, 0.000000000);
const vec4 p_o30470209281644_out_max = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const vec4 p_o30470007956150_in_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o30470007956150_in_mid = vec4(0.500000000, 0.500000000, 0.500000000, 0.500000000);
const vec4 p_o30470007956150_in_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o30470007956150_out_min = vec4(0.304995686, 0.304995686, 0.304995686, 0.000000000);
const vec4 p_o30470007956150_out_max = vec4(0.775439382, 0.775439382, 0.775439382, 1.000000000);
const float seed_o30469991177239 = 0.000000000;
const float p_o30469991177239_scale_x = 4.000000000;
const float p_o30469991177239_scale_y = 4.000000000;
const float p_o30469991177239_folds = 0.000000000;
const float p_o30469991177239_iterations = 3.000000000;
const float p_o30469991177239_persistence = 0.180000000;
const float p_o30470242838919_amount = 0.125000000;
const float p_o30470242838919_eps = 0.100000000;
const float p_o30470125394894_default_in1 = 0.000000000;
const float p_o30470125394894_default_in2 = 0.000000000;
const float p_o30470158948325_default_in1 = 0.000000000;
const float p_o30470158948325_default_in2 = 8.000000000;
const vec4 p_o30470091840824_in_min = vec4(0.030937511, 0.030937511, 0.030937511, 0.000000000);
const vec4 p_o30470091840824_in_mid = vec4(0.288335025, 0.288335025, 0.288335025, 0.500000000);
const vec4 p_o30470091840824_in_max = vec4(0.610767126, 0.610767126, 0.610767126, 1.000000000);
const vec4 p_o30470091840824_out_min = vec4(1.000000000, 1.000000000, 1.000000000, 0.000000000);
const vec4 p_o30470091840824_out_max = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const float seed_o30470075061630 = 0.446016759;
const float p_o30470075061630_scale_x = 9.000000000;
const float p_o30470075061630_scale_y = 9.000000000;
const float p_o30470075061630_stretch_x = 1.000000000;
const float p_o30470075061630_stretch_y = 1.000000000;
const float p_o30470075061630_intensity = 1.000000000;
const float p_o30470075061630_randomness = 1.000000000;
const float p_o30470142175895_default_in1 = 0.000000000;
const float p_o30470142175895_default_in2 = 0.200000000;
const float p_o30470108618472_default_in1 = 0.000000000;
const vec4 p_o30470192505152_color = vec4(0.536880493, 0.886718750, 0.886718750, 1.000000000);
const float p_o30470024730829_amount1 = 1.000000000;
const vec4 p_o30470058285112_color = vec4(0.289184570, 0.570676267, 0.804687500, 1.000000000);
const vec4 p_o30470041512081_color = vec4(0.280761719, 0.873730481, 0.898437500, 1.000000000);
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
// #globals: blend2_2 (o30470175726738)
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
// #globals: tones_3 (o30470209281644)
vec4 adjust_levels(vec4 color, vec4 in_min, vec4 in_mid, vec4 in_max, vec4 out_min, vec4 out_max) {
	color = clamp((color-in_min)/(in_max-in_min), 0.0, 1.0);
	in_mid = (in_mid-in_min)/(in_max-in_min);
	vec4 dark = step(in_mid, color);
	color = 0.5*mix(color/(in_mid), 1.0+(color-in_mid)/(1.0-in_mid), dark);
	return out_min+color*(out_max-out_min);
}
// #globals: fbm3 (o30469991177239)
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
// #globals: warp (o30470242838919)
// #globals: math_2 (o30470125394894)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: voronoi2 (o30470075061630)
// Based on https://www.shadertoy.com/view/ldl3W8
// The MIT License
// Copyright © 2013 Inigo Quilez
vec3 iq_voronoi(vec2 x, vec2 size, vec2 stretch, float randomness, vec2 seed) {
	vec2 n = floor(x);
	vec2 f = fract(x);
	vec2 mg, mr, mc;
	float md = 8.0;
	for (int j=-1; j<=1; j++)
	for (int i=-1; i<=1; i++) {
		vec2 g = vec2(float(i),float(j));
		vec2 o = randomness*rand2(seed + mod(n + g + size, size));
		vec2 c = g + o;
		vec2 r = c - f;
		vec2 rr = r*stretch;
		float d = dot(rr,rr);
		if (d<md) {
			mc = c;
			md = d;
			mr = r;
			mg = g;
		}
	}
	md = 8.0;
	for (int j=-2; j<=2; j++)
	for (int i=-2; i<=2; i++) {
		vec2 g = mg + vec2(float(i),float(j));
		vec2 o = randomness*rand2(seed + mod(n + g + size, size));
		vec2 r = g + o - f;
		vec2 rr = (mr-r)*stretch;
		if (dot(rr,rr)>0.00001)
	   		md = min(md, dot(0.5*(mr+r)*stretch, normalize((r-mr)*stretch)));
	}
	return vec3(md, mc+n);
}
vec4 voronoi(vec2 uv, vec2 size, vec2 stretch, float intensity, float randomness, float seed) {
	uv *= size;
	vec3 v = iq_voronoi(uv, size, stretch, randomness, rand2(vec2(seed, 1.0-seed)));
	return vec4(v.yz, intensity*length((uv-v.yz)*stretch), v.x);
}
float o30470242838919_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3 (o30469991177239)
float o30469991177239_0_1_f = fbm_2d_perlin((uv), vec2(p_o30469991177239_scale_x, p_o30469991177239_scale_y), int(p_o30469991177239_folds), int(p_o30469991177239_iterations), p_o30469991177239_persistence, (elapsed_time*0.25), (seed_o30469991177239+fract(_seed_variation_)));
// #output0: tones (o30470007956150)
vec4 o30470007956150_0_1_rgba = adjust_levels(vec4(vec3(o30469991177239_0_1_f), 1.0), p_o30470007956150_in_min, p_o30470007956150_in_mid, p_o30470007956150_in_max, p_o30470007956150_out_min, p_o30470007956150_out_max);
return (dot((o30470007956150_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp (o30470242838919)
vec2 o30470242838919_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o30470242838919_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o30470242838919_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o30470242838919_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o30470242838919_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: fbm3 (o30469991177239)
float o30469991177239_0_1_f = fbm_2d_perlin((uv), vec2(p_o30469991177239_scale_x, p_o30469991177239_scale_y), int(p_o30469991177239_folds), int(p_o30469991177239_iterations), p_o30469991177239_persistence, (elapsed_time*0.25), (seed_o30469991177239+fract(_seed_variation_)));

// #output0: tones (o30470007956150)
vec4 o30470007956150_0_1_rgba = adjust_levels(vec4(vec3(o30469991177239_0_1_f), 1.0), p_o30470007956150_in_min, p_o30470007956150_in_mid, p_o30470007956150_in_max, p_o30470007956150_out_min, p_o30470007956150_out_max);

// #output0: tones_3 (o30470209281644)
vec4 o30470209281644_0_1_rgba = adjust_levels(o30470007956150_0_1_rgba, p_o30470209281644_in_min, p_o30470209281644_in_mid, p_o30470209281644_in_max, p_o30470209281644_out_min, p_o30470209281644_out_max);

// #code: warp (o30470242838919)
vec2 o30470242838919_0_slope = o30470242838919_slope((uv), p_o30470242838919_eps, _seed_variation_);
vec2 o30470242838919_0_warp = o30470242838919_0_slope;
// #code: voronoi2 (o30470075061630)
vec4 o30470075061630_0_xyzw = voronoi(((uv)+p_o30470242838919_amount*(dot((o30470007956150_0_1_rgba).rgb, vec3(1.0))/3.0)*o30470242838919_0_warp), vec2(p_o30470075061630_scale_x, p_o30470075061630_scale_y), vec2(p_o30470075061630_stretch_y, p_o30470075061630_stretch_x), p_o30470075061630_intensity, p_o30470075061630_randomness, (seed_o30470075061630+fract(_seed_variation_)));
// #output0: voronoi2 (o30470075061630)
float o30470075061630_0_1_f = o30470075061630_0_xyzw.z;

// #output0: tones_2 (o30470091840824)
vec4 o30470091840824_0_1_rgba = adjust_levels(vec4(vec3(o30470075061630_0_1_f), 1.0), p_o30470091840824_in_min, p_o30470091840824_in_mid, p_o30470091840824_in_max, p_o30470091840824_out_min, p_o30470091840824_out_max);

// #code: math_5 (o30470158948325)
float o30470158948325_0_clamp_false = (dot((o30470091840824_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o30470158948325_default_in2;
float o30470158948325_0_clamp_true = clamp(o30470158948325_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o30470158948325)
float o30470158948325_0_1_f = o30470158948325_0_clamp_false;

// #code: math (o30470108618472)
float o30470108618472_0_clamp_false = (dot((o30470091840824_0_1_rgba).rgb, vec3(1.0))/3.0)+(elapsed_time*0.5);
float o30470108618472_0_clamp_true = clamp(o30470108618472_0_clamp_false, 0.0, 1.0);
// #output0: math (o30470108618472)
float o30470108618472_0_1_f = o30470108618472_0_clamp_false;

// #code: math_4 (o30470142175895)
float o30470142175895_0_clamp_false = pingpong(o30470108618472_0_1_f,p_o30470142175895_default_in2);
float o30470142175895_0_clamp_true = clamp(o30470142175895_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o30470142175895)
float o30470142175895_0_1_f = o30470142175895_0_clamp_false;

// #code: math_2 (o30470125394894)
float o30470125394894_0_clamp_false = sin(o30470142175895_0_1_f*o30470158948325_0_1_f);
float o30470125394894_0_clamp_true = clamp(o30470125394894_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o30470125394894)
float o30470125394894_0_1_f = o30470125394894_0_clamp_false;

// #output0: warp (o30470242838919)
vec4 o30470242838919_0_1_rgba = vec4(vec3(o30470125394894_0_1_f), 1.0);

// #code: blend2_3 (o30470226057371)
vec4 o30470226057371_0_b = o30470242838919_0_1_rgba;
vec4 o30470226057371_0_l;
float o30470226057371_0_a;

o30470226057371_0_l = o30470209281644_0_1_rgba;
o30470226057371_0_a = p_o30470226057371_amount1*1.0;
o30470226057371_0_b = vec4(blend_multiply((uv), o30470226057371_0_l.rgb, o30470226057371_0_b.rgb, o30470226057371_0_a*o30470226057371_0_l.a), min(1.0, o30470226057371_0_b.a+o30470226057371_0_a*o30470226057371_0_l.a));
// #output0: blend2_3 (o30470226057371)
vec4 o30470226057371_0_1_rgba = o30470226057371_0_b;

// #output0: uniform_3 (o30470192505152)
vec4 o30470192505152_0_1_rgba = p_o30470192505152_color;

// #output0: uniform_2 (o30470058285112)
vec4 o30470058285112_0_1_rgba = p_o30470058285112_color;

// #output0: uniform (o30470041512081)
vec4 o30470041512081_0_1_rgba = p_o30470041512081_color;

// #code: blend2 (o30470024730829)
vec4 o30470024730829_0_b = o30470041512081_0_1_rgba;
vec4 o30470024730829_0_l;
float o30470024730829_0_a;

o30470024730829_0_l = o30470058285112_0_1_rgba;
o30470024730829_0_a = p_o30470024730829_amount1*(dot((o30470007956150_0_1_rgba).rgb, vec3(1.0))/3.0);
o30470024730829_0_b = vec4(blend_normal((uv), o30470024730829_0_l.rgb, o30470024730829_0_b.rgb, o30470024730829_0_a*o30470024730829_0_l.a), min(1.0, o30470024730829_0_b.a+o30470024730829_0_a*o30470024730829_0_l.a));
// #output0: blend2 (o30470024730829)
vec4 o30470024730829_0_1_rgba = o30470024730829_0_b;

// #code: blend2_2 (o30470175726738)
vec4 o30470175726738_0_b = o30470024730829_0_1_rgba;
vec4 o30470175726738_0_l;
float o30470175726738_0_a;

o30470175726738_0_l = o30470192505152_0_1_rgba;
o30470175726738_0_a = p_o30470175726738_amount1*(dot((o30470226057371_0_1_rgba).rgb, vec3(1.0))/3.0);
o30470175726738_0_b = vec4(blend_normal((uv), o30470175726738_0_l.rgb, o30470175726738_0_b.rgb, o30470175726738_0_a*o30470175726738_0_l.a), min(1.0, o30470175726738_0_b.a+o30470175726738_0_a*o30470175726738_0_l.a));
// #output0: blend2_2 (o30470175726738)
vec4 o30470175726738_0_1_rgba = o30470175726738_0_b;

	vec3 albedo_tex = ((o30470175726738_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o30469974400563_albedo_color.rgb;
	METALLIC = 1.0*p_o30469974400563_metallic;
	ROUGHNESS = 1.0*p_o30469974400563_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o30469974400563_normal;
	EMISSION = vec3(0.0)*p_o30469974400563_emission_energy;
}



