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
const vec4 p_o317861136254_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o317861136254_metallic = 0.000000000;
const float p_o317861136254_roughness = 1.000000000;
const float p_o317861136254_emission_energy = 1.000000000;
const float p_o317861136254_normal = 1.000000000;
const float p_o317861136254_ao = 1.000000000;
const float p_o317861136254_depth_scale = 0.500000000;
const float p_o319303977027_amount1 = 1.000000000;
const float p_o319320754145_default_in1 = 0.000000000;
const float p_o319320754145_default_in2 = 0.000000000;
const float p_o319438194522_default_in1 = 0.000000000;
const float p_o319438194522_default_in2 = 0.000000000;
const float p_o319404640112_value = 0.505000000;
const float p_o319404640112_width = 1.000000000;
const float p_o319404640112_contrast = 1.000000000;
const float seed_o319220090753 = 0.000000000;
const float p_o319220090753_tx = 6.000000000;
const float p_o319220090753_ty = 6.000000000;
const float p_o319220090753_overlap = 2.000000000;
const float p_o319220090753_scale_x = 0.080000000;
const float p_o319220090753_scale_y = 0.080000000;
const float p_o319220090753_fixed_offset = 0.200000000;
const float p_o319220090753_offset = 1.000000000;
const float p_o319220090753_rotate = 0.000000000;
const float p_o319220090753_scale = 0.430000000;
const float p_o319220090753_value = 0.800000000;
const float p_o319203313692_sides = 5.000000000;
const float p_o319203313692_radius = 0.160000000;
const float p_o319203313692_edge = 0.000000000;
const float p_o319371085655_default_in1 = 0.000000000;
const float p_o319371085655_default_in2 = 0.400000000;
const float p_o319387863077_default_in1 = 0.000000000;
const float p_o319387863077_default_in2 = 0.000000000;
const float p_o319354308757_default_in1 = 0.000000000;
const float p_o319354308757_default_in2 = 1.000000000;
const float p_o319421417547_default_in2 = 0.150000000;
const float p_o317961799718_translate_x = 0.000000000;
const float p_o317961799718_translate_y = 0.210000000;
const float p_o317961799718_rotate = 45.000000000;
const float p_o317961799718_scale_x = 1.000000000;
const float p_o317961799718_scale_y = 1.000000000;
const float p_o318632888361_amount = 0.025000000;
const float p_o318632888361_eps = 0.100000000;
const float seed_o318699997176 = 0.000000000;
const float p_o318699997176_scale_x = 3.000000000;
const float p_o318699997176_scale_y = 3.000000000;
const float p_o318699997176_folds = 0.000000000;
const float p_o318699997176_iterations = 6.000000000;
const float p_o318699997176_persistence = 0.750000000;
const float p_o318699997176_offset = 0.000000000;
const float p_o317978576931_translate_x = 0.000000000;
const float p_o317978576931_translate_y = 0.930000000;
const float p_o317978576931_rotate = 0.000000000;
const float p_o317978576931_scale_x = 1.000000000;
const float p_o317978576931_scale_y = 1.000000000;
const float p_o317995354283_default_in2 = 0.250000000;
const float seed_o317894690849 = 0.000000000;
const float p_o317894690849_tx = 5.000000000;
const float p_o317894690849_ty = 4.000000000;
const float p_o317894690849_overlap = 2.000000000;
const float p_o317894690849_scale_x = 0.100000000;
const float p_o317894690849_scale_y = 0.135000000;
const float p_o317894690849_fixed_offset = 0.200000000;
const float p_o317894690849_offset = 1.000000000;
const float p_o317894690849_rotate = 0.000000000;
const float p_o317894690849_scale = 0.340000000;
const float p_o317894690849_value = 0.300000000;
const float p_o318968432776_translate_x = 0.000000000;
const float p_o318968432776_translate_y = 0.000000000;
const float p_o318968432776_rotate = 0.000000000;
const float p_o318968432776_scale_x = 1.000000000;
const float p_o318968432776_scale_y = 1.000000000;
const float p_o318985209969_repeat = 1.000000000;
const float p_o318985209969_rotate = 90.000000000;
const float p_o318985209969_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o318985209969_gradient_col[2] = vec4[]( vec4(0.574218750, 0.574218750, 0.574218750, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
uniform sampler2D texture_1;
const float texture_1_size = 1024.000000000;
const vec4 p_o319337531370_color = vec4(0.884395182, 0.933593750, 0.273513794, 1.000000000);
const float p_o318716774477_gradient_pos[4] = float[]( 0.315750480, 0.511683524, 0.647179782, 0.904912591 );
const vec4 p_o318716774477_gradient_col[4] = vec4[]( vec4(0.068237305, 0.289885521, 0.671875000, 1.000000000), vec4(0.164062500, 0.071777344, 0.074853510, 1.000000000), vec4(0.710937500, 0.077758789, 0.077758789, 1.000000000), vec4(0.862745106, 0.761703432, 0.101960793, 1.000000000) );
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
// #globals: blend2 (o319303977027)
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
// #globals: math_2 (o319320754145)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: tones_range (o319404640112)
// #globals: shape_2 (o319203313692)
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
// #globals: transform2 (o317961799718)
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
// #globals: fbm3 (o318699997176)
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
float o319220090753_input_in(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: shape_2 (o319203313692)
float o319203313692_0_1_f = shape_star(uv, p_o319203313692_sides+1.0e-5, p_o319203313692_radius*1.0, p_o319203313692_edge*1.0);
return o319203313692_0_1_f;
}
// #instance: tiler_2 (o319220090753)
vec4 tiler_o319220090753(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_, vec4 _controlled_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o319220090753_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o319220090753_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o319220090753_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o319220090753_scale+1.0;
				pv /= vec2(p_o319220090753_scale_x, p_o319220090753_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o319220090753_input_in(pv, false ? seed.x : 0.0, _controlled_variation_)*mask*(1.0-p_o319220090753_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
float o318632888361_input_d(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: fbm3 (o318699997176)
float o318699997176_0_1_f = old_fbm_2d_simplex(uv, vec2(p_o318699997176_scale_x, p_o318699997176_scale_y), int(p_o318699997176_folds), int(p_o318699997176_iterations), p_o318699997176_persistence, p_o318699997176_offset, (seed_o318699997176+fract(_seed_variation_)));
return o318699997176_0_1_f;
}
// #instance: warp (o318632888361)
vec2 o318632888361_slope(vec2 uv, float epsilon, float _seed_variation_, vec4 _controlled_variation_) {
	return vec2(o318632888361_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_, _controlled_variation_)-o318632888361_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_, _controlled_variation_), o318632888361_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_, _controlled_variation_)-o318632888361_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_, _controlled_variation_));
}
vec4 o318985209969_gradient_gradient_fct(float x) {
  if (x < p_o318985209969_gradient_pos[0]) {
    return p_o318985209969_gradient_col[0];
  } else if (x < p_o318985209969_gradient_pos[1]) {
    return mix(p_o318985209969_gradient_col[0], p_o318985209969_gradient_col[1], ((x-p_o318985209969_gradient_pos[0])/(p_o318985209969_gradient_pos[1]-p_o318985209969_gradient_pos[0])));
  }
  return p_o318985209969_gradient_col[1];
}
float o317894690849_input_in(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #code: gradient (o318985209969)
float o318985209969_0_r = 0.5+(cos(p_o318985209969_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o318985209969_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o318985209969_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient (o318985209969)
vec4 o318985209969_0_1_rgba = o318985209969_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o318985209969_0_r*p_o318985209969_repeat)-0.5)) : fract(o318985209969_0_r*p_o318985209969_repeat));
vec4 o318196680512_0 = textureLod(texture_1, fract((transform2_clamp(transform2(uv, vec2(p_o318968432776_translate_x*(2.0*1.0-1.0), p_o318968432776_translate_y*(2.0*1.0-1.0)), p_o318968432776_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o318968432776_scale_x*(2.0*(dot((o318985209969_0_1_rgba).rgb, vec3(1.0))/3.0)-1.0), p_o318968432776_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_4 (o318968432776)
vec4 o318968432776_0_1_rgba = o318196680512_0;
return (dot((o318968432776_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: tiler (o317894690849)
vec4 tiler_o317894690849(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_, vec4 _controlled_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o317894690849_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o317894690849_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o317894690849_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o317894690849_scale+1.0;
				pv /= vec2(p_o317894690849_scale_x, p_o317894690849_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o317894690849_input_in(pv, false ? seed.x : 0.0, _controlled_variation_)*mask*(1.0-p_o317894690849_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
vec4 o318716774477_gradient_gradient_fct(float x) {
  if (x < p_o318716774477_gradient_pos[0]) {
    return p_o318716774477_gradient_col[0];
  } else if (x < p_o318716774477_gradient_pos[1]) {
    return mix(p_o318716774477_gradient_col[0], p_o318716774477_gradient_col[1], ((x-p_o318716774477_gradient_pos[0])/(p_o318716774477_gradient_pos[1]-p_o318716774477_gradient_pos[0])));
  } else if (x < p_o318716774477_gradient_pos[2]) {
    return mix(p_o318716774477_gradient_col[1], p_o318716774477_gradient_col[2], ((x-p_o318716774477_gradient_pos[1])/(p_o318716774477_gradient_pos[2]-p_o318716774477_gradient_pos[1])));
  } else if (x < p_o318716774477_gradient_pos[3]) {
    return mix(p_o318716774477_gradient_col[2], p_o318716774477_gradient_col[3], ((x-p_o318716774477_gradient_pos[2])/(p_o318716774477_gradient_pos[3]-p_o318716774477_gradient_pos[2])));
  }
  return p_o318716774477_gradient_col[3];
}
void fragment() {
	float _seed_variation_ = variation;
	vec4 _controlled_variation_ = vec4(0.0);
	vec2 uv = fract(UV);

// #code: tiler_2 (o319220090753)
vec3 o319220090753_0_instance_uv = vec3(0.0);
vec4 o319220090753_0_rch = tiler_o319220090753((uv), vec2(p_o319220090753_tx, p_o319220090753_ty), int(p_o319220090753_overlap), o319220090753_0_instance_uv, vec2(float((seed_o319220090753+fract(_seed_variation_)))), _seed_variation_, _controlled_variation_);
// #output0: tiler_2 (o319220090753)
float o319220090753_0_1_f = o319220090753_0_rch.a;

// #code: tones_range (o319404640112)
float o319404640112_0_step = clamp((o319220090753_0_1_f - (p_o319404640112_value))/max(0.0001, p_o319404640112_width)+0.5, 0.0, 1.0);
float o319404640112_0_false = clamp((min(o319404640112_0_step, 1.0-o319404640112_0_step) * 2.0) / (1.0 - p_o319404640112_contrast), 0.0, 1.0);
float o319404640112_0_true = 1.0-o319404640112_0_false;
// #output0: tones_range (o319404640112)
float o319404640112_0_1_f = o319404640112_0_false;

// #code: math_6 (o319421417547)
float o319421417547_0_clamp_false = (elapsed_time)*p_o319421417547_default_in2;
float o319421417547_0_clamp_true = clamp(o319421417547_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o319421417547)
float o319421417547_0_1_f = o319421417547_0_clamp_false;

// #code: math_3 (o319354308757)
float o319354308757_0_clamp_false = o319220090753_0_1_f+o319421417547_0_1_f;
float o319354308757_0_clamp_true = clamp(o319354308757_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o319354308757)
float o319354308757_0_1_f = o319354308757_0_clamp_false;

// #code: math_5 (o319387863077)
float o319387863077_0_clamp_false = fract(o319354308757_0_1_f);
float o319387863077_0_clamp_true = clamp(o319387863077_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o319387863077)
float o319387863077_0_1_f = o319387863077_0_clamp_false;

// #code: math_4 (o319371085655)
float o319371085655_0_clamp_false = (1.0-step(p_o319371085655_default_in2,o319387863077_0_1_f));
float o319371085655_0_clamp_true = clamp(o319371085655_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o319371085655)
float o319371085655_0_1_f = o319371085655_0_clamp_false;

// #code: math_7 (o319438194522)
float o319438194522_0_clamp_false = o319371085655_0_1_f*o319404640112_0_1_f;
float o319438194522_0_clamp_true = clamp(o319438194522_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o319438194522)
float o319438194522_0_1_f = o319438194522_0_clamp_false;

// #code: warp (o318632888361)
vec2 o318632888361_0_slope = o318632888361_slope((fract(transform2((uv), vec2(p_o317961799718_translate_x*(2.0*1.0-1.0), p_o317961799718_translate_y*(2.0*1.0-1.0)), p_o317961799718_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o317961799718_scale_x*(2.0*1.0-1.0), p_o317961799718_scale_y*(2.0*1.0-1.0))))), p_o318632888361_eps, _seed_variation_, _controlled_variation_);
vec2 o318632888361_0_warp = o318632888361_0_slope;
// #code: math (o317995354283)
float o317995354283_0_clamp_false = (elapsed_time)*p_o317995354283_default_in2;
float o317995354283_0_clamp_true = clamp(o317995354283_0_clamp_false, 0.0, 1.0);
// #output0: math (o317995354283)
float o317995354283_0_1_f = o317995354283_0_clamp_false;

// #code: tiler (o317894690849)
vec3 o317894690849_0_instance_uv = vec3(0.0);
vec4 o317894690849_0_rch = tiler_o317894690849((fract(transform2(((fract(transform2((uv), vec2(p_o317961799718_translate_x*(2.0*1.0-1.0), p_o317961799718_translate_y*(2.0*1.0-1.0)), p_o317961799718_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o317961799718_scale_x*(2.0*1.0-1.0), p_o317961799718_scale_y*(2.0*1.0-1.0)))))+p_o318632888361_amount*1.0*o318632888361_0_warp), vec2(p_o317978576931_translate_x*(2.0*1.0-1.0), p_o317978576931_translate_y*(2.0*o317995354283_0_1_f-1.0)), p_o317978576931_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o317978576931_scale_x*(2.0*1.0-1.0), p_o317978576931_scale_y*(2.0*1.0-1.0))))), vec2(p_o317894690849_tx, p_o317894690849_ty), int(p_o317894690849_overlap), o317894690849_0_instance_uv, vec2(float((seed_o317894690849+fract(_seed_variation_)))), _seed_variation_, _controlled_variation_);
// #output0: tiler (o317894690849)
float o317894690849_0_1_f = o317894690849_0_rch.a;

// #output0: transform2_2 (o317978576931)
vec4 o317978576931_0_1_rgba = vec4(vec3(o317894690849_0_1_f), 1.0);

// #output0: warp (o318632888361)
vec4 o318632888361_0_1_rgba = o317978576931_0_1_rgba;

// #output0: transform2 (o317961799718)
vec4 o317961799718_0_1_rgba = o318632888361_0_1_rgba;

// #output0: invert (o319287199799)
vec4 o319287199799_0_1_rgba = vec4(vec3(1.0)-o317961799718_0_1_rgba.rgb, o317961799718_0_1_rgba.a);

// #code: math_2 (o319320754145)
float o319320754145_0_clamp_false = (dot((o319287199799_0_1_rgba).rgb, vec3(1.0))/3.0)*o319438194522_0_1_f;
float o319320754145_0_clamp_true = clamp(o319320754145_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o319320754145)
float o319320754145_0_1_f = o319320754145_0_clamp_false;

// #output0: uniform (o319337531370)
vec4 o319337531370_0_1_rgba = p_o319337531370_color;

// #output0: colorize (o318716774477)
vec4 o318716774477_0_1_rgba = o318716774477_gradient_gradient_fct((dot((o317961799718_0_1_rgba).rgb, vec3(1.0))/3.0));

// #code: blend2 (o319303977027)
vec4 o319303977027_0_b = o318716774477_0_1_rgba;
vec4 o319303977027_0_l;
float o319303977027_0_a;

o319303977027_0_l = o319337531370_0_1_rgba;
o319303977027_0_a = p_o319303977027_amount1*o319320754145_0_1_f;
o319303977027_0_b = vec4(blend_normal((uv), o319303977027_0_l.rgb, o319303977027_0_b.rgb, o319303977027_0_a*o319303977027_0_l.a), min(1.0, o319303977027_0_b.a+o319303977027_0_a*o319303977027_0_l.a));
// #output0: blend2 (o319303977027)
vec4 o319303977027_0_1_rgba = o319303977027_0_b;

	vec3 albedo_tex = ((o319303977027_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o317861136254_albedo_color.rgb;
	METALLIC = 1.0*p_o317861136254_metallic;
	ROUGHNESS = 1.0*p_o317861136254_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o317861136254_normal;
	EMISSION = vec3(0.0)*p_o317861136254_emission_energy;
}



