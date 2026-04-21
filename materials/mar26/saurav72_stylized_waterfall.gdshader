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
const vec4 p_o2624090802372_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o2624090802372_metallic = 0.000000000;
const float p_o2624090802372_roughness = 0.700000000;
const float p_o2624090802372_emission_energy = 1.000000000;
const float p_o2624090802372_normal = 1.000000000;
const float p_o2624090802372_ao = 1.000000000;
const float p_o2624090802372_depth_scale = 0.500000000;
const float p_o2624979995939_gradient_pos[3] = float[]( 0.000000000, 0.687703788, 1.000000000 );
const vec4 p_o2624979995939_gradient_col[3] = vec4[]( vec4(0.178726196, 0.542396069, 0.863281250, 1.000000000), vec4(0.315032959, 0.855684340, 0.867187500, 1.000000000), vec4(0.740203857, 0.902343750, 0.886525273, 1.000000000) );
const float p_o2624963218692_translate_x = 0.000000000;
const float p_o2624963218692_rotate = 0.000000000;
const float p_o2624963218692_scale_x = 1.000000000;
const float p_o2624963218692_scale_y = 1.000000000;
const float p_o2624912887009_angle = 90.000000000;
const float p_o2624912887009_strength = 0.170000000;
const float p_o2624946441524_amount1 = 0.340000000;
const float p_o2624929664324_translate_x = 0.000000000;
const float p_o2624929664324_rotate = 0.000000000;
const float p_o2624929664324_scale_x = 1.000000000;
const float p_o2624929664324_scale_y = 1.000000000;
const float seed_o2624896109829 = 0.000000000;
const float p_o2624896109829_scale_x = 3.000000000;
const float p_o2624896109829_scale_y = 4.000000000;
const float p_o2624896109829_folds = 0.000000000;
const float p_o2624896109829_iterations = 2.000000000;
const float p_o2624896109829_persistence = 0.580000000;
const float p_o2624862555331_amount1 = 0.510000000;
const float seed_o2624879331654 = 0.000000000;
const float p_o2624879331654_scale_x = 12.000000000;
const float p_o2624879331654_scale_y = 5.000000000;
const float p_o2624879331654_smoothness = 1.000000000;
const float p_o2624879331654_interpolation = 1.000000000;
const float p_o2624644451575_repeat = 5.000000000;
const float p_o2624644451575_rotate = 90.000000000;
const float p_o2624644451575_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o2624644451575_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
// #globals: colorize_2 (o2624979995939)
// #globals: transform2_3 (o2624963218692)
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
// #globals: blend2_3 (o2624946441524)
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
// #globals: fbm3_2 (o2624896109829)
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
		float noise = old_value_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_perlin_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_perlinabs_noise_2d(coord*size, size, offset, seed+float(i));
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
	u = fract(u+seed) * 6.28318530718; // 2*pi
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
		float noise = old_simplex_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular2_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular3_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular4_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular5_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_cellular6_noise_2d(coord*size, size, offset, seed+float(i));
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
		float noise = old_voronoise_noise_2d(coord*size, size, offset, seed+float(i));
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
// #globals: noise_anisotropic (o2624879331654)
float anisotropic(vec2 uv, vec2 size, float seed, float smoothness, float interpolation) {
	vec2 seed2 = rand2(vec2(seed, 1.0-seed));
	
	vec2 xy = floor(uv*size);
	vec2 offset = vec2(rand(seed2 + xy.y), 0.0);
	vec2 xy_offset = floor(uv * size + offset );
	float f0 = rand(seed2+mod(xy_offset, size));
	float f1 = rand(seed2+mod(xy_offset+vec2(1.0, 0.0), size));
	float mixer = clamp( (fract(uv.x*size.x+offset.x) -.5) / smoothness + 0.5, 0.0, 1.0 );
	float smooth_mix = smoothstep(0.0, 1.0, mixer);
	float linear = mix(f0, f1, mixer);
	float smoothed = mix(f0, f1, smooth_mix);
	
	return mix(linear, smoothed, interpolation);
}
vec4 o2624979995939_gradient_gradient_fct(float x) {
  if (x < p_o2624979995939_gradient_pos[0]) {
    return p_o2624979995939_gradient_col[0];
  } else if (x < p_o2624979995939_gradient_pos[1]) {
    return mix(p_o2624979995939_gradient_col[0], p_o2624979995939_gradient_col[1], ((x-p_o2624979995939_gradient_pos[0])/(p_o2624979995939_gradient_pos[1]-p_o2624979995939_gradient_pos[0])));
  } else if (x < p_o2624979995939_gradient_pos[2]) {
    return mix(p_o2624979995939_gradient_col[1], p_o2624979995939_gradient_col[2], ((x-p_o2624979995939_gradient_pos[1])/(p_o2624979995939_gradient_pos[2]-p_o2624979995939_gradient_pos[1])));
  }
  return p_o2624979995939_gradient_col[2];
}
vec4 o2624644451575_gradient_gradient_fct(float x) {
  if (x < p_o2624644451575_gradient_pos[0]) {
    return p_o2624644451575_gradient_col[0];
  } else if (x < p_o2624644451575_gradient_pos[1]) {
    return mix(p_o2624644451575_gradient_col[0], p_o2624644451575_gradient_col[1], ((x-p_o2624644451575_gradient_pos[0])/(p_o2624644451575_gradient_pos[1]-p_o2624644451575_gradient_pos[0])));
  }
  return p_o2624644451575_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: fbm3_2 (o2624896109829)
float o2624896109829_0_1_f = old_fbm_2d_perlin((fract(transform2((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))), vec2(p_o2624929664324_translate_x*(2.0*1.0-1.0), (elapsed_time*-0.5)*(2.0*1.0-1.0)), p_o2624929664324_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624929664324_scale_x*(2.0*1.0-1.0), p_o2624929664324_scale_y*(2.0*1.0-1.0))))), vec2(p_o2624896109829_scale_x, p_o2624896109829_scale_y), int(p_o2624896109829_folds), int(p_o2624896109829_iterations), p_o2624896109829_persistence, (elapsed_time), (seed_o2624896109829+fract(_seed_variation_)));

// #output0: transform2_2 (o2624929664324)
vec4 o2624929664324_0_1_rgba = vec4(vec3(o2624896109829_0_1_f), 1.0);

// #output0: fbm3_2 (o2624896109829)
float o2624896109829_0_3_f = old_fbm_2d_perlin((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))), vec2(p_o2624896109829_scale_x, p_o2624896109829_scale_y), int(p_o2624896109829_folds), int(p_o2624896109829_iterations), p_o2624896109829_persistence, (elapsed_time), (seed_o2624896109829+fract(_seed_variation_)));

// #code: blend2_3 (o2624946441524)
vec4 o2624946441524_0_b = vec4(vec3(o2624896109829_0_3_f), 1.0);
vec4 o2624946441524_0_l;
float o2624946441524_0_a;

o2624946441524_0_l = o2624929664324_0_1_rgba;
o2624946441524_0_a = p_o2624946441524_amount1*1.0;
o2624946441524_0_b = vec4(blend_normal((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))), o2624946441524_0_l.rgb, o2624946441524_0_b.rgb, o2624946441524_0_a*o2624946441524_0_l.a), min(1.0, o2624946441524_0_b.a+o2624946441524_0_a*o2624946441524_0_l.a));
// #output0: blend2_3 (o2624946441524)
vec4 o2624946441524_0_1_rgba = o2624946441524_0_b;

// #output0: noise_anisotropic (o2624879331654)
float o2624879331654_0_1_f = anisotropic(((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))) + vec2(cos(p_o2624912887009_angle * 1.0 * 0.01745329251), sin(p_o2624912887009_angle * 1.0 * 0.01745329251)) * ((dot((o2624946441524_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o2624912887009_strength ), vec2(p_o2624879331654_scale_x, p_o2624879331654_scale_y), (seed_o2624879331654+fract(_seed_variation_)), p_o2624879331654_smoothness, p_o2624879331654_interpolation);

// #code: gradient_2 (o2624644451575)
float o2624644451575_0_r = 0.5+(cos(p_o2624644451575_rotate*0.01745329251)*(((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))) + vec2(cos(p_o2624912887009_angle * 1.0 * 0.01745329251), sin(p_o2624912887009_angle * 1.0 * 0.01745329251)) * ((dot((o2624946441524_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o2624912887009_strength ).x-0.5)+sin(p_o2624644451575_rotate*0.01745329251)*(((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))) + vec2(cos(p_o2624912887009_angle * 1.0 * 0.01745329251), sin(p_o2624912887009_angle * 1.0 * 0.01745329251)) * ((dot((o2624946441524_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o2624912887009_strength ).y-0.5))/(cos(abs(mod(p_o2624644451575_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient_2 (o2624644451575)
vec4 o2624644451575_0_1_rgba = o2624644451575_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o2624644451575_0_r*p_o2624644451575_repeat)-0.5)) : fract(o2624644451575_0_r*p_o2624644451575_repeat));

// #code: blend2 (o2624862555331)
vec4 o2624862555331_0_b = o2624644451575_0_1_rgba;
vec4 o2624862555331_0_l;
float o2624862555331_0_a;

o2624862555331_0_l = vec4(vec3(o2624879331654_0_1_f), 1.0);
o2624862555331_0_a = p_o2624862555331_amount1*1.0;
o2624862555331_0_b = vec4(blend_overlay(((transform2((uv), vec2(p_o2624963218692_translate_x*(2.0*1.0-1.0), (elapsed_time*0.65)*(2.0*1.0-1.0)), p_o2624963218692_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o2624963218692_scale_x*(2.0*1.0-1.0), p_o2624963218692_scale_y*(2.0*1.0-1.0)))) + vec2(cos(p_o2624912887009_angle * 1.0 * 0.01745329251), sin(p_o2624912887009_angle * 1.0 * 0.01745329251)) * ((dot((o2624946441524_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o2624912887009_strength ), o2624862555331_0_l.rgb, o2624862555331_0_b.rgb, o2624862555331_0_a*o2624862555331_0_l.a), min(1.0, o2624862555331_0_b.a+o2624862555331_0_a*o2624862555331_0_l.a));
// #output0: blend2 (o2624862555331)
vec4 o2624862555331_0_1_rgba = o2624862555331_0_b;

// #output0: directional_warp_2 (o2624912887009)
vec4 o2624912887009_0_1_rgba = o2624862555331_0_1_rgba;

// #output0: transform2_3 (o2624963218692)
vec4 o2624963218692_0_1_rgba = o2624912887009_0_1_rgba;

// #output0: colorize_2 (o2624979995939)
vec4 o2624979995939_0_1_rgba = o2624979995939_gradient_gradient_fct((dot((o2624963218692_0_1_rgba).rgb, vec3(1.0))/3.0));

	vec3 albedo_tex = ((o2624979995939_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o2624090802372_albedo_color.rgb;
	METALLIC = 1.0*p_o2624090802372_metallic;
	ROUGHNESS = 1.0*p_o2624090802372_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o2624090802372_normal;
	EMISSION = vec3(0.0)*p_o2624090802372_emission_energy;
}



