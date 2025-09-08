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
const vec4 p_o4353737896676_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o4353737896676_metallic = 0.000000000;
const float p_o4353737896676_roughness = 0.110000000;
const float p_o4353737896676_emission_energy = 0.000000000;
const float p_o4353737896676_normal = 1.000000000;
const float p_o4353737896676_ao = 1.000000000;
const float p_o4353737896676_depth_scale = 1.000000000;
const float p_o4354341876473_amount = 1.000000000;
const float seed_o4354106995438 = 0.389765739;
const float p_o4354106995438_count = 25.000000000;
const float p_o4354106995438_scale_x = 0.700000000;
const float p_o4354106995438_scale_y = 0.700000000;
const float p_o4354106995438_rotate = 0.000000000;
const float p_o4354106995438_scale = 0.000000000;
const float p_o4354106995438_value = 0.800000000;
const float p_o4354190881520_default_in1 = 0.000000000;
const float p_o4354190881520_default_in2 = 0.000000000;
const float p_o4354174104303_sides = 6.000000000;
const float p_o4354174104303_radius = 1.000000000;
const float p_o4354174104303_edge = 2.000000000;
const float p_o4354224435954_value = 0.500000000;
const float p_o4354224435954_width = 0.113600000;
const float p_o4354224435954_contrast = 0.000000000;
const float p_o4354073441005_default_in1 = 0.000000000;
const float p_o4354073441005_default_in2 = 0.000000000;
const float seed_o4354056663787 = 0.042548649;
const float p_o4354056663787_default_in1 = 0.000000000;
const float p_o4353838559974_repeat = 1.000000000;
const float p_o4353838559974_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o4353838559974_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o4353821782759_amount1 = 1.720000000;
const float p_o4353821782759_amount2 = 1.000000000;
const float p_o4354207658737_sides = 6.000000000;
const float p_o4354207658737_radius = 2.340000000;
const float p_o4354207658737_edge = 0.720000000;
const float p_o4354090218220_color = 0.160000000;
const float p_o4353754673893_amount = 0.200000000;
const float p_o4353754673893_eps = 0.010000000;
const float p_o4354241213171_cx = 0.000000000;
const float p_o4354241213171_cy = 0.000000000;
const float p_o4354241213171_scale_x = 1.000000000;
const float p_o4354241213171_scale_y = 1.000000000;
const float p_o4355130408751_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o4355130408751_gradient_col[2] = vec4[]( vec4(0.546875000, 0.546875000, 0.546875000, 1.000000000), vec4(0.375000000, 0.375000000, 0.375000000, 1.000000000) );
const float p_o4355113631775_x_scale = 8.000000000;
const float p_o4355113631775_y_scale = 8.000000000;
// #globals: math (o4354190881520)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: shape_2 (o4354174104303)
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
// #globals: tones_range (o4354224435954)
// #globals: custom_uv
vec2 get_from_tileset(float count, float seed, vec2 uv) {
	return clamp((uv+floor(rand2(vec2(seed))*count))/count, vec2(0.0), vec2(1.0));
}
vec2 custom_uv_transform(vec2 uv, vec2 cst_scale, float rnd_rotate, float rnd_scale, vec2 seed) {
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
// #globals: blend2 (o4353821782759)
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
// #globals: scale (o4354241213171)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: pattern (o4355113631775)
float wave_constant(float x) {
	return 1.0;
}
float wave_sine(float x) {
	return 0.5-0.5*cos(3.14159265359*2.0*x);
}
float wave_triangle(float x) {
	x = fract(x);
	return min(2.0*x, 2.0-2.0*x);
}
float wave_sawtooth(float x) {
	return fract(x);
}
float wave_square(float x) {
	return (fract(x) < 0.5) ? 0.0 : 1.0;
}
float wave_bounce(float x) {
	x = 2.0*(fract(x)-0.5);
	return sqrt(1.0-x*x);
}
float mix_mul(float x, float y) {
	return x*y;
}
float mix_add(float x, float y) {
	return min(x+y, 1.0);
}
float mix_max(float x, float y) {
	return max(x, y);
}
float mix_min(float x, float y) {
	return min(x, y);
}
float mix_xor(float x, float y) {
	return min(x+y, 2.0-x-y);
}
float mix_pow(float x, float y) {
	return pow(x, y);
}
vec4 o4353838559974_gradient_gradient_fct(float x) {
  if (x < p_o4353838559974_gradient_pos[0]) {
    return p_o4353838559974_gradient_col[0];
  } else if (x < p_o4353838559974_gradient_pos[1]) {
    return mix(p_o4353838559974_gradient_col[0], p_o4353838559974_gradient_col[1], ((x-p_o4353838559974_gradient_pos[0])/(p_o4353838559974_gradient_pos[1]-p_o4353838559974_gradient_pos[0])));
  }
  return p_o4353838559974_gradient_col[1];
}
float o4354106995438_input_in(vec2 uv, float _seed_variation_) {
// #output0: shape_2 (o4354174104303)
float o4354174104303_0_1_f = shape_circle((uv), p_o4354174104303_sides, p_o4354174104303_radius*1.0, p_o4354174104303_edge*1.0);
// #output0: radial_gradient (o4353838559974)
vec4 o4353838559974_0_1_rgba = o4353838559974_gradient_gradient_fct(fract(p_o4353838559974_repeat*1.41421356237*length(fract((uv))-vec2(0.5, 0.5))));
// #code: math_2 (o4354056663787)
float o4354056663787_0_clamp_false = (dot((o4353838559974_0_1_rgba).rgb, vec3(1.0))/3.0)-(elapsed_time*.6-param_rnd(0,1, (seed_o4354056663787+fract(_seed_variation_))+0.881279));
float o4354056663787_0_clamp_true = clamp(o4354056663787_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o4354056663787)
float o4354056663787_0_1_f = o4354056663787_0_clamp_false;
// #code: math_3 (o4354073441005)
float o4354073441005_0_clamp_false = fract(o4354056663787_0_1_f);
float o4354073441005_0_clamp_true = clamp(o4354073441005_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o4354073441005)
float o4354073441005_0_1_f = o4354073441005_0_clamp_false;
// #code: tones_range (o4354224435954)
float o4354224435954_0_step = clamp((o4354073441005_0_1_f - (p_o4354224435954_value))/max(0.0001, p_o4354224435954_width)+0.5, 0.0, 1.0);
float o4354224435954_0_false = clamp((min(o4354224435954_0_step, 1.0-o4354224435954_0_step) * 2.0) / (1.0 - p_o4354224435954_contrast), 0.0, 1.0);
float o4354224435954_0_true = 1.0-o4354224435954_0_false;
// #output0: tones_range (o4354224435954)
float o4354224435954_0_1_f = o4354224435954_0_false;
// #code: math (o4354190881520)
float o4354190881520_0_clamp_false = o4354224435954_0_1_f*o4354174104303_0_1_f;
float o4354190881520_0_clamp_true = clamp(o4354190881520_0_clamp_false, 0.0, 1.0);
// #output0: math (o4354190881520)
float o4354190881520_0_1_f = o4354190881520_0_clamp_false;
return o4354190881520_0_1_f;
}
// #instance: splatter (o4354106995438)
vec4 splatter_o4354106995438(vec2 uv, int count, inout vec3 instance_uv, vec2 seed, float _seed_variation_) {
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
			float angle = (seed.x * 2.0 - 1.0) * p_o4354106995438_rotate * 0.01745329251;
			float ca = cos(angle);
			float sa = sin(angle);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv *= (seed.y-0.5)*2.0*p_o4354106995438_scale+1.0;
			pv /= vec2(p_o4354106995438_scale_x, p_o4354106995438_scale_y);
			pv += vec2(0.5);
			seed = rand2(seed);
			vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
			if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
				continue;
			}
			vec2 full_uv = pv;
			pv = get_from_tileset( 1.0, seed.x, pv);
			float c1 = o4354106995438_input_in(pv, true ? seed.x : 0.0)*mask*(1.0-p_o4354106995438_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
			instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
		}
	}
	return vec4(rc, c);
}
float o4354341876473_input_in(vec2 uv, float _seed_variation_) {
// #code: splatter (o4354106995438)
vec3 o4354106995438_0_instance_uv = vec3(0.0);
vec4 o4354106995438_0_rch = splatter_o4354106995438(uv, int(p_o4354106995438_count), o4354106995438_0_instance_uv, vec2(float((seed_o4354106995438+fract(_seed_variation_)))), _seed_variation_);
// #output0: splatter (o4354106995438)
float o4354106995438_0_1_f = o4354106995438_0_rch.a;
return o4354106995438_0_1_f;
}
// #instance: normal_map2/edge_detect_1 (o4354341876473)
vec3 nm_o4354341876473(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (2 == 0) {
		rv = vec2(1.0, -1.0)*o4354341876473_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o4354341876473_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o4354341876473_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o4354341876473_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o4354341876473_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o4354341876473_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o4354341876473_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o4354341876473_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (2 == 1) {
		rv = vec2(3.0, -3.0)*o4354341876473_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o4354341876473_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o4354341876473_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o4354341876473_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o4354341876473_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o4354341876473_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o4354341876473_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o4354341876473_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (2 == 2) {
		rv = vec2(2.0, 0.0)*o4354341876473_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o4354341876473_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o4354341876473_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o4354341876473_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o4354341876473_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o4354341876473_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o4354341876473_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o4353754673893_input_d(vec2 uv, float _seed_variation_) {
// #code: splatter (o4354106995438)
vec3 o4354106995438_0_instance_uv = vec3(0.0);
vec4 o4354106995438_0_rch = splatter_o4354106995438(uv, int(p_o4354106995438_count), o4354106995438_0_instance_uv, vec2(float((seed_o4354106995438+fract(_seed_variation_)))), _seed_variation_);
// #output0: splatter (o4354106995438)
float o4354106995438_0_1_f = o4354106995438_0_rch.a;
return o4354106995438_0_1_f;
}
// #instance: warp (o4353754673893)
vec2 o4353754673893_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o4353754673893_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o4353754673893_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o4353754673893_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o4353754673893_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec4 o4355130408751_gradient_gradient_fct(float x) {
  if (x < p_o4355130408751_gradient_pos[0]) {
    return p_o4355130408751_gradient_col[0];
  } else if (x < p_o4355130408751_gradient_pos[1]) {
    return mix(p_o4355130408751_gradient_col[0], p_o4355130408751_gradient_col[1], ((x-p_o4355130408751_gradient_pos[0])/(p_o4355130408751_gradient_pos[1]-p_o4355130408751_gradient_pos[0])));
  }
  return p_o4355130408751_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: normal_map2/edge_detect_1 (o4354341876473)
vec3 o4354341876473_0_1_rgb = nm_o4354341876473((uv), p_o4354341876473_amount, 32.0, _seed_variation_);

// #output0: shape (o4354207658737)
float o4354207658737_0_1_f = shape_circle((uv), p_o4354207658737_sides, p_o4354207658737_radius*1.0, p_o4354207658737_edge*1.0);

// #code: splatter (o4354106995438)
vec3 o4354106995438_0_instance_uv = vec3(0.0);
vec4 o4354106995438_0_rch = splatter_o4354106995438((uv), int(p_o4354106995438_count), o4354106995438_0_instance_uv, vec2(float((seed_o4354106995438+fract(_seed_variation_)))), _seed_variation_);
// #output0: splatter (o4354106995438)
float o4354106995438_0_1_f = o4354106995438_0_rch.a;

// #output0: uniform_greyscale (o4354090218220)
float o4354090218220_0_1_f = p_o4354090218220_color;

// #code: warp (o4353754673893)
vec2 o4353754673893_0_slope = o4353754673893_slope((uv), p_o4353754673893_eps, _seed_variation_);
vec2 o4353754673893_0_warp = o4353754673893_0_slope;
// #output0: pattern (o4355113631775)
float o4355113631775_0_1_f = mix_xor(wave_square(p_o4355113631775_x_scale*(scale(((uv)+p_o4353754673893_amount*o4353754673893_0_warp), vec2(0.5+p_o4354241213171_cx, 0.5+p_o4354241213171_cy), vec2(p_o4354241213171_scale_x, p_o4354241213171_scale_y))).x), wave_square(p_o4355113631775_y_scale*(scale(((uv)+p_o4353754673893_amount*o4353754673893_0_warp), vec2(0.5+p_o4354241213171_cx, 0.5+p_o4354241213171_cy), vec2(p_o4354241213171_scale_x, p_o4354241213171_scale_y))).y));

// #output0: colorize_2 (o4355130408751)
vec4 o4355130408751_0_1_rgba = o4355130408751_gradient_gradient_fct(o4355113631775_0_1_f);

// #output0: scale (o4354241213171)
vec4 o4354241213171_0_1_rgba = o4355130408751_0_1_rgba;

// #output0: warp (o4353754673893)
vec4 o4353754673893_0_1_rgba = o4354241213171_0_1_rgba;

// #code: blend2 (o4353821782759)
vec4 o4353821782759_0_b = o4353754673893_0_1_rgba;
vec4 o4353821782759_0_l;
float o4353821782759_0_a;

o4353821782759_0_l = vec4(vec3(o4354090218220_0_1_f), 1.0);
o4353821782759_0_a = p_o4353821782759_amount1*o4354106995438_0_1_f;
o4353821782759_0_b = vec4(blend_normal((uv), o4353821782759_0_l.rgb, o4353821782759_0_b.rgb, o4353821782759_0_a*o4353821782759_0_l.a), min(1.0, o4353821782759_0_b.a+o4353821782759_0_a*o4353821782759_0_l.a));

o4353821782759_0_l = vec4(vec3(o4354207658737_0_1_f), 1.0);
o4353821782759_0_a = p_o4353821782759_amount2*1.0;
o4353821782759_0_b = vec4(blend_multiply((uv), o4353821782759_0_l.rgb, o4353821782759_0_b.rgb, o4353821782759_0_a*o4353821782759_0_l.a), min(1.0, o4353821782759_0_b.a+o4353821782759_0_a*o4353821782759_0_l.a));
// #output0: blend2 (o4353821782759)
vec4 o4353821782759_0_1_rgba = o4353821782759_0_b;

	vec3 albedo_tex = ((o4353821782759_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o4353737896676_albedo_color.rgb;
	METALLIC = 1.0*p_o4353737896676_metallic;
	ROUGHNESS = 1.0*p_o4353737896676_roughness;
	NORMAL = o4354341876473_0_1_rgb;
	EMISSION = vec3(0.0)*p_o4353737896676_emission_energy;
}



