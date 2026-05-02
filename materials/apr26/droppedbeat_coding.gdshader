shader_type spatial;

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
const float p_o1178700100114_x = 57.000000000;
const float p_o1178700100114_y = 87.000000000;
const float p_o1178700100114_c = 24.000000000;
const float p_o1178700100114_d = 0.000000000;
const float p_o1178632991247_translate_x = 0.000000000;
const float p_o1178632991247_translate_y = 0.635000000;
const float p_o1178565882378_amount1 = 1.000000000;
const float p_o1178565882378_amount2 = 1.000000000;
const float p_o1178582659596_value = 0.430000000;
const float p_o1178582659596_width = 0.060000000;
const float p_o1178582659596_contrast = 1.000000000;
const float p_o1178414887432_translate_x = 0.000000000;
const float p_o1178414887432_rotate = 0.000000000;
const float p_o1178414887432_scale_x = 1.000000000;
const float p_o1178414887432_scale_y = 1.000000000;
const float p_o1178666545681_amount1 = 1.000000000;
const float p_o1178666545681_amount2 = 1.000000000;
const float p_o1178381332999_translate_x = 0.375600000;
const float p_o1178381332999_translate_y = 0.000000000;
const float p_o1178381332999_rotate = 0.000000000;
const float p_o1178381332999_scale_x = 1.000000000;
const float p_o1178381332999_scale_y = 1.000000000;
const float seed_o1178146451965 = 0.000000000;
const float p_o1178129674748_steps = 14.000000000;
const float p_o1178431664561_translate_x = 0.000000000;
const float p_o1178431664561_translate_y = 0.000000000;
const float p_o1178431664561_rotate = 0.000000000;
const float p_o1178431664561_scale_x = 1.000000000;
const float p_o1178431664561_scale_y = 1.000000000;
const float seed_o1178297446917 = 0.000000000;
const float p_o1178297446917_tx = 1.000000000;
const float p_o1178297446917_ty = 14.000000000;
const float p_o1178297446917_overlap = 1.000000000;
const float p_o1178297446917_scale_x = 0.520600000;
const float p_o1178297446917_scale_y = 0.597100000;
const float p_o1178297446917_fixed_offset = 0.000000000;
const float p_o1178297446917_offset = 0.000000000;
const float p_o1178297446917_rotate = 0.000000000;
const float p_o1178297446917_scale = 0.000000000;
const float p_o1178297446917_value = 0.000000000;
const float p_o1178112897531_cx = 0.000000000;
const float p_o1178112897531_cy = 0.000000000;
const float p_o1178112897531_scale_x = 1.000000000;
const float p_o1178112897531_scale_y = 0.137500000;
const float p_o1178096120312_sides = 4.000000000;
const float p_o1178096120312_radius = 0.850000000;
const float p_o1178096120312_edge = 0.000000000;
const float p_o1178683322831_amount1 = 0.900000000;
const float p_o1178683322831_amount2 = 1.000000000;
const float p_o1178448441516_default_in2 = 0.000000000;
const float p_o1178180006398_default_in1 = 0.000000000;
const float p_o1178180006398_default_in2 = 14.000000000;
const float p_o1178599436813_hue = -0.013808594;
const float p_o1178599436813_saturation = 0.283551025;
const float p_o1178599436813_value = 2.000000000;
const float p_o1178616214030_default_in1 = 0.000000000;
const float p_o1178616214030_default_in2 = 0.000000000;
const float p_o1178549105163_value = 0.500000000;
const float p_o1178549105163_width = 0.000000000;
const float seed_o1178465219081 = 0.000000000;
const float p_o1178465219081_tx = 1.000000000;
const float p_o1178465219081_ty = 14.000000000;
const float p_o1178465219081_overlap = 2.000000000;
const float p_o1178465219081_scale_x = 0.520600000;
const float p_o1178465219081_scale_y = 0.597100000;
const float p_o1178465219081_fixed_offset = 0.000000000;
const float p_o1178465219081_offset = 0.000000000;
const float p_o1178465219081_rotate = 0.000000000;
const float p_o1178465219081_scale = 0.000000000;
const float p_o1178465219081_value = 0.000000000;
const float p_o1178263892483_default_in1 = 0.000000000;
const float p_o1178263892483_default_in2 = 0.000000000;
const float p_o1178280669700_cx = 0.000000000;
const float p_o1178280669700_cy = 0.000000000;
const float p_o1178280669700_scale_x = 1.000000000;
const float p_o1178280669700_scale_y = 0.065300000;
const float p_o1178247115266_sides = 4.000000000;
const float p_o1178247115266_radius = 0.850000000;
const float p_o1178247115266_edge = 0.000000000;
const float p_o1178230338049_value = 0.347000000;
const float p_o1178230338049_width = 0.000000000;
const float seed_o1178213560832 = 0.000000000;
const float p_o1178213560832_scale_x = 23.000000000;
const float p_o1178213560832_scale_y = 1.000000000;
const float p_o1178213560832_smoothness = 1.000000000;
const float p_o1178213560832_interpolation = 1.000000000;
// #globals: pixelize_2 (o1178700100114)
float bayer_matrix(vec2 uv, int rounds) {
	ivec2 iuv = ivec2(uv);
	int b[4] = int[4]( 0, 2, 3, 1 );
	float divisor = 1.0;
	int rv = 0;
	for (int i = 0; i < rounds; ++i) {
		rv *= 4;
		divisor *= 4.0;
		rv += b[(iuv.x%2)+2*(iuv.y%2)];
		iuv >>= 1;
	}
	return float(rv)/divisor;
}
// #globals: translate (o1178632991247)
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
// #globals: blend2 (o1178565882378)
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
// #globals: transform2_3 (o1178414887432)
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
// #globals: scale (o1178112897531)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: shape (o1178096120312)
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
// #globals: math_2 (o1178448441516)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: noise_anisotropic_2 (o1178213560832)
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
float o1178297446917_input_in(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: shape (o1178096120312)
float o1178096120312_0_1_f = shape_polygon((scale(uv, vec2(0.5+p_o1178112897531_cx, 0.5+p_o1178112897531_cy), vec2(p_o1178112897531_scale_x, p_o1178112897531_scale_y))), p_o1178096120312_sides+1.0e-5, p_o1178096120312_radius*1.0, p_o1178096120312_edge*1.0);
// #output0: scale (o1178112897531)
vec4 o1178112897531_0_1_rgba = vec4(vec3(o1178096120312_0_1_f), 1.0);
return (dot((o1178112897531_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: tiler_3 (o1178297446917)
vec4 tiler_o1178297446917(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_, vec4 _controlled_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o1178297446917_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o1178297446917_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o1178297446917_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o1178297446917_scale+1.0;
				pv /= vec2(p_o1178297446917_scale_x, p_o1178297446917_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o1178297446917_input_in(pv, true ? seed.x : 0.0, _controlled_variation_)*mask*(1.0-p_o1178297446917_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
float o1178465219081_input_in(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: shape_2 (o1178247115266)
float o1178247115266_0_1_f = shape_polygon((scale((uv), vec2(0.5+p_o1178280669700_cx, 0.5+p_o1178280669700_cy), vec2(p_o1178280669700_scale_x, p_o1178280669700_scale_y))), p_o1178247115266_sides+1.0e-5, p_o1178247115266_radius*1.0, p_o1178247115266_edge*1.0);
// #output0: scale_2 (o1178280669700)
vec4 o1178280669700_0_1_rgba = vec4(vec3(o1178247115266_0_1_f), 1.0);
// #output0: noise_anisotropic_2 (o1178213560832)
float o1178213560832_0_1_f = anisotropic((uv), vec2(p_o1178213560832_scale_x, p_o1178213560832_scale_y), (seed_o1178213560832+fract(_seed_variation_)), p_o1178213560832_smoothness, p_o1178213560832_interpolation);
// #code: tones_step_5 (o1178230338049)
vec3 o1178230338049_0_false = clamp((vec4(vec3(o1178213560832_0_1_f), 1.0).rgb-vec3(p_o1178230338049_value))/max(0.0001, p_o1178230338049_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o1178230338049_0_true = vec3(1.0)-o1178230338049_0_false;
// #output0: tones_step_5 (o1178230338049)
vec4 o1178230338049_0_1_rgba = vec4(o1178230338049_0_false, vec4(vec3(o1178213560832_0_1_f), 1.0).a);
// #code: math_6 (o1178263892483)
float o1178263892483_0_clamp_false = (dot((o1178230338049_0_1_rgba).rgb, vec3(1.0))/3.0)*(dot((o1178280669700_0_1_rgba).rgb, vec3(1.0))/3.0);
float o1178263892483_0_clamp_true = clamp(o1178263892483_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o1178263892483)
float o1178263892483_0_1_f = o1178263892483_0_clamp_false;
return o1178263892483_0_1_f;
}
// #instance: tiler_4 (o1178465219081)
vec4 tiler_o1178465219081(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_, vec4 _controlled_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o1178465219081_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o1178465219081_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o1178465219081_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o1178465219081_scale+1.0;
				pv /= vec2(p_o1178465219081_scale_x, p_o1178465219081_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o1178465219081_input_in(pv, true ? seed.x : 0.0, _controlled_variation_)*mask*(1.0-p_o1178465219081_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
void fragment() {
	float _seed_variation_ = variation;
	vec4 _controlled_variation_ = vec4(0.0);
	vec2 uv = fract(UV);

// #code: pixelize_2 (o1178700100114)
vec2 o1178700100114_0_uv = floor(((uv)*vec2(p_o1178700100114_x, p_o1178700100114_y)))+vec2(0.5);
vec3 o1178700100114_0_dither = fract(vec3(dot(vec2(171.0, 231.0), o1178700100114_0_uv))/vec3(103.0, 71.0, 97.0));

// #output0: uniform_greyscale (o1178196783615)
float o1178196783615_0_1_f = ((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))).y);

// #output0: quantize (o1178129674748)
vec4 o1178129674748_0_1_rgba = vec4(floor(vec4(vec3(o1178196783615_0_1_f), 1.0).rgb*p_o1178129674748_steps)/p_o1178129674748_steps, vec4(vec3(o1178196783615_0_1_f), 1.0).a);

// #code: randomize (o1178146451965)
vec3 o1178146451965_0_rand = ((o1178129674748_0_1_rgba).rgb);
// #output0: randomize (o1178146451965)
vec3 o1178146451965_0_1_rgb = rand3( vec2( float((seed_o1178146451965+fract(_seed_variation_))) + o1178146451965_0_rand.x, rand( o1178146451965_0_rand.yz ) ) );

// #code: tiler_3 (o1178297446917)
vec3 o1178297446917_0_instance_uv = vec3(0.0);
vec4 o1178297446917_0_rch = tiler_o1178297446917((transform2_clamp(transform2((fract(transform2((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), vec2(p_o1178381332999_translate_x*(2.0*(dot(o1178146451965_0_1_rgb, vec3(1.0))/3.0)-1.0), p_o1178381332999_translate_y*(2.0*1.0-1.0)), p_o1178381332999_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178381332999_scale_x*(2.0*1.0-1.0), p_o1178381332999_scale_y*(2.0*1.0-1.0))))), vec2(p_o1178431664561_translate_x*(2.0*1.0-1.0), p_o1178431664561_translate_y*(2.0*1.0-1.0)), p_o1178431664561_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178431664561_scale_x*(2.0*1.0-1.0), p_o1178431664561_scale_y*(2.0*1.0-1.0))))), vec2(p_o1178297446917_tx, p_o1178297446917_ty), int(p_o1178297446917_overlap), o1178297446917_0_instance_uv, vec2(float((seed_o1178297446917+fract(_seed_variation_)))), _seed_variation_, _controlled_variation_);
// #output0: tiler_3 (o1178297446917)
float o1178297446917_0_1_f = o1178297446917_0_rch.a;

// #output0: transform2 (o1178431664561)
vec4 o1178431664561_0_1_rgba = vec4(vec3(o1178297446917_0_1_f), 1.0);

// #output0: transform2_2 (o1178381332999)
vec4 o1178381332999_0_1_rgba = o1178431664561_0_1_rgba;

// #output0: uniform_greyscale_2 (o1178398110214)
float o1178398110214_0_1_f = (1.0-(fract(transform2((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), vec2(p_o1178381332999_translate_x*(2.0*(dot(o1178146451965_0_1_rgb, vec3(1.0))/3.0)-1.0), p_o1178381332999_translate_y*(2.0*1.0-1.0)), p_o1178381332999_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178381332999_scale_x*(2.0*1.0-1.0), p_o1178381332999_scale_y*(2.0*1.0-1.0))))).x);

// #output1: transform2_2 (o1178381332999)
vec4 o1178381332999_1_2_rgba = vec4(vec3(o1178398110214_0_1_f), 1.0);

// #output0: invert (o1178649768464)
vec4 o1178649768464_0_1_rgba = vec4(vec3(1.0)-o1178381332999_1_2_rgba.rgb, o1178381332999_1_2_rgba.a);

// #code: blend2_3 (o1178683322831)
vec4 o1178683322831_0_b = o1178649768464_0_1_rgba;
vec4 o1178683322831_0_l;
float o1178683322831_0_a;

o1178683322831_0_l = o1178649768464_0_1_rgba;
o1178683322831_0_a = p_o1178683322831_amount1*1.0;
o1178683322831_0_b = vec4(blend_additive((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), o1178683322831_0_l.rgb, o1178683322831_0_b.rgb, o1178683322831_0_a*o1178683322831_0_l.a), min(1.0, o1178683322831_0_b.a+o1178683322831_0_a*o1178683322831_0_l.a));

o1178683322831_0_l = o1178381332999_0_1_rgba;
o1178683322831_0_a = p_o1178683322831_amount2*1.0;
o1178683322831_0_b = vec4(blend_multiply((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), o1178683322831_0_l.rgb, o1178683322831_0_b.rgb, o1178683322831_0_a*o1178683322831_0_l.a), min(1.0, o1178683322831_0_b.a+o1178683322831_0_a*o1178683322831_0_l.a));
// #output0: blend2_3 (o1178683322831)
vec4 o1178683322831_0_1_rgba = o1178683322831_0_b;

// #code: math_3 (o1178180006398)
float o1178180006398_0_clamp_false = (dot((o1178129674748_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o1178180006398_default_in2;
float o1178180006398_0_clamp_true = clamp(o1178180006398_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o1178180006398)
float o1178180006398_0_1_f = o1178180006398_0_clamp_false;

// #code: math_2 (o1178448441516)
float o1178448441516_0_clamp_false = (elapsed_time)-o1178180006398_0_1_f;
float o1178448441516_0_clamp_true = clamp(o1178448441516_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o1178448441516)
float o1178448441516_0_1_f = o1178448441516_0_clamp_false;

// #code: blend2_2 (o1178666545681)
vec4 o1178666545681_0_b = vec4(vec3(o1178448441516_0_1_f), 1.0);
vec4 o1178666545681_0_l;
float o1178666545681_0_a;

o1178666545681_0_l = o1178683322831_0_1_rgba;
o1178666545681_0_a = p_o1178666545681_amount1*1.0;
o1178666545681_0_b = vec4(blend_difference((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), o1178666545681_0_l.rgb, o1178666545681_0_b.rgb, o1178666545681_0_a*o1178666545681_0_l.a), min(1.0, o1178666545681_0_b.a+o1178666545681_0_a*o1178666545681_0_l.a));

o1178666545681_0_l = o1178381332999_0_1_rgba;
o1178666545681_0_a = p_o1178666545681_amount2*1.0;
o1178666545681_0_b = vec4(blend_multiply((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), o1178666545681_0_l.rgb, o1178666545681_0_b.rgb, o1178666545681_0_a*o1178666545681_0_l.a), min(1.0, o1178666545681_0_b.a+o1178666545681_0_a*o1178666545681_0_l.a));
// #output0: blend2_2 (o1178666545681)
vec4 o1178666545681_0_1_rgba = o1178666545681_0_b;

// #output0: transform2_3 (o1178414887432)
vec4 o1178414887432_0_1_rgba = o1178666545681_0_1_rgba;

// #code: tones_range (o1178582659596)
float o1178582659596_0_step = clamp(((dot((o1178414887432_0_1_rgba).rgb, vec3(1.0))/3.0) - (p_o1178582659596_value))/max(0.0001, p_o1178582659596_width)+0.5, 0.0, 1.0);
float o1178582659596_0_false = clamp((min(o1178582659596_0_step, 1.0-o1178582659596_0_step) * 2.0) / (1.0 - p_o1178582659596_contrast), 0.0, 1.0);
float o1178582659596_0_true = 1.0-o1178582659596_0_false;
// #output0: tones_range (o1178582659596)
float o1178582659596_0_1_f = o1178582659596_0_false;

// #code: adjust_hsv (o1178599436813)
vec4 o1178599436813_0_rbga = vec4(o1178146451965_0_1_rgb, 1.0);
vec3 o1178599436813_0_hsv = rgb_to_hsv(o1178599436813_0_rbga.rgb);
o1178599436813_0_hsv.x += p_o1178599436813_hue;
o1178599436813_0_hsv.y = clamp(o1178599436813_0_hsv.y*p_o1178599436813_saturation, 0.0, 1.0);
o1178599436813_0_hsv.z = clamp(o1178599436813_0_hsv.z*p_o1178599436813_value, 0.0, 1.0);
// #output0: adjust_hsv (o1178599436813)
vec4 o1178599436813_0_1_rgba = vec4(hsv_to_rgb(o1178599436813_0_hsv), o1178599436813_0_rbga.a);

// #output2: transform2_3 (o1178414887432)
vec4 o1178414887432_2_2_rgba = o1178599436813_0_1_rgba;

// #code: tones_step (o1178549105163)
vec3 o1178549105163_0_false = clamp((o1178414887432_0_1_rgba.rgb-vec3(p_o1178549105163_value))/max(0.0001, p_o1178549105163_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o1178549105163_0_true = vec3(1.0)-o1178549105163_0_false;
// #output0: tones_step (o1178549105163)
vec4 o1178549105163_0_1_rgba = vec4(o1178549105163_0_false, o1178414887432_0_1_rgba.a);

// #code: tiler_4 (o1178465219081)
vec3 o1178465219081_0_instance_uv = vec3(0.0);
vec4 o1178465219081_0_rch = tiler_o1178465219081((fract(transform2((transform2(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), vec2(p_o1178414887432_translate_x*(2.0*1.0-1.0), (-elapsed_time*.07)*(2.0*1.0-1.0)), p_o1178414887432_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178414887432_scale_x*(2.0*1.0-1.0), p_o1178414887432_scale_y*(2.0*1.0-1.0)))), vec2(p_o1178381332999_translate_x*(2.0*(dot(o1178146451965_0_1_rgb, vec3(1.0))/3.0)-1.0), p_o1178381332999_translate_y*(2.0*1.0-1.0)), p_o1178381332999_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o1178381332999_scale_x*(2.0*1.0-1.0), p_o1178381332999_scale_y*(2.0*1.0-1.0))))), vec2(p_o1178465219081_tx, p_o1178465219081_ty), int(p_o1178465219081_overlap), o1178465219081_0_instance_uv, vec2(float((seed_o1178465219081+fract(_seed_variation_)))), _seed_variation_, _controlled_variation_);
// #output0: tiler_4 (o1178465219081)
float o1178465219081_0_1_f = o1178465219081_0_rch.a;

// #output2: transform2_2 (o1178381332999)
vec4 o1178381332999_2_3_rgba = vec4(vec3(o1178465219081_0_1_f), 1.0);

// #output1: transform2_3 (o1178414887432)
vec4 o1178414887432_1_3_rgba = o1178381332999_2_3_rgba;

// #code: math (o1178616214030)
float o1178616214030_0_clamp_false = (dot((o1178414887432_1_3_rgba).rgb, vec3(1.0))/3.0)*(dot((o1178549105163_0_1_rgba).rgb, vec3(1.0))/3.0);
float o1178616214030_0_clamp_true = clamp(o1178616214030_0_clamp_false, 0.0, 1.0);
// #output0: math (o1178616214030)
float o1178616214030_0_1_f = o1178616214030_0_clamp_false;

// #code: blend2 (o1178565882378)
vec4 o1178565882378_0_b = vec4(vec3(o1178616214030_0_1_f), 1.0);
vec4 o1178565882378_0_l;
float o1178565882378_0_a;

o1178565882378_0_l = o1178414887432_2_2_rgba;
o1178565882378_0_a = p_o1178565882378_amount1*1.0;
o1178565882378_0_b = vec4(blend_multiply(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), o1178565882378_0_l.rgb, o1178565882378_0_b.rgb, o1178565882378_0_a*o1178565882378_0_l.a), min(1.0, o1178565882378_0_b.a+o1178565882378_0_a*o1178565882378_0_l.a));

o1178565882378_0_l = vec4(vec3(o1178582659596_0_1_f), 1.0);
o1178565882378_0_a = p_o1178565882378_amount2*1.0;
o1178565882378_0_b = vec4(blend_lighten(((o1178700100114_0_uv/vec2(p_o1178700100114_x, p_o1178700100114_y))-vec2(p_o1178632991247_translate_x, p_o1178632991247_translate_y)), o1178565882378_0_l.rgb, o1178565882378_0_b.rgb, o1178565882378_0_a*o1178565882378_0_l.a), min(1.0, o1178565882378_0_b.a+o1178565882378_0_a*o1178565882378_0_l.a));
// #output0: blend2 (o1178565882378)
vec4 o1178565882378_0_1_rgba = o1178565882378_0_b;

// #output0: translate (o1178632991247)
vec4 o1178632991247_0_1_rgba = o1178565882378_0_1_rgba;

// #output0: pixelize_2 (o1178700100114)
vec3 o1178700100114_0_1_rgb = floor(((o1178632991247_0_1_rgba).rgb)*p_o1178700100114_c+p_o1178700100114_d*(o1178700100114_0_dither))/p_o1178700100114_c;

	vec4 color_tex = vec4(o1178700100114_0_1_rgb, 1.0);
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	ALBEDO = color_tex.rgb;
	ALPHA = color_tex.a;
}



