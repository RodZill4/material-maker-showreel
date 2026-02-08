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
const float p_o904543616288_translate_x = 0.000000000;
const float p_o904543616288_translate_y = 0.000000000;
const float p_o904543616288_rotate = 0.000000000;
const float p_o904543616288_scale_x = 0.800000000;
const float p_o904543616288_scale_y = 0.800000000;
const float p_o901037178079_amount1 = 0.460000000;
const float p_o902496795894_amount1 = 1.000000000;
const float p_o902496795894_amount2 = 1.000000000;
const float p_o902480018677_cx = 0.000000000;
const float p_o902480018677_cy = 0.000000000;
const float p_o902480018677_scale_x = 2.000000000;
const float p_o902480018677_scale_y = 2.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 512.000000000;
const float p_o904560393505_d_in1_x = 0.000000000;
const float p_o904560393505_d_in1_y = 0.000000000;
const float p_o904560393505_d_in1_z = 0.000000000;
const float p_o904560393505_d_in2_x = 0.100000000;
const float p_o904560393505_d_in2_y = 0.323000000;
const float p_o904560393505_d_in2_z = 0.791000000;
uniform sampler2D texture_2;
const float texture_2_size = 512.000000000;
const float p_o908184272204_amount1 = 1.000000000;
const float p_o897698512041_r = 1.000000000;
const float p_o897698512041_a = 1.340000000;
const float p_o897698512041_cx = 0.000000000;
const float p_o897698512041_cy = 0.000000000;
const float p_o897715289267_amount1 = 1.000000000;
const float p_o897715289267_amount2 = 0.883300000;
const float p_o897715289267_amount3 = 5.620000000;
const float p_o897715289267_amount4 = 0.630000000;
const float p_o901070732514_translate_x = -0.310000000;
const float p_o901070732514_translate_y = -0.028700000;
const float p_o901070732514_rotate = 0.000000000;
const float p_o901070732514_scale_x = 1.000000000;
const float p_o901070732514_scale_y = 1.000000000;
const float p_o901053955296_sides = 6.000000000;
const float p_o901053955296_radius = 0.491400000;
const float p_o901053955296_edge = 1.770000000;
const float p_o904593947939_d_in1_x = 0.000000000;
const float p_o904593947939_d_in1_y = 0.000000000;
const float p_o904593947939_d_in1_z = 0.000000000;
const float p_o904593947939_d_in2_x = 0.370000000;
const float p_o904593947939_d_in2_y = 0.448000000;
const float p_o904593947939_d_in2_z = 0.677000000;
const float p_o899443342542_default_in1 = 0.000000000;
const float p_o899443342542_default_in2 = 0.000000000;
uniform sampler2D texture_3;
const float texture_3_size = 512.000000000;
const float p_o897883061434_default_in1 = 0.000000000;
const float p_o897883061434_default_in2 = 0.000000000;
uniform sampler2D texture_4;
const float texture_4_size = 512.000000000;
const float p_o904577170722_d_in1_x = 0.000000000;
const float p_o904577170722_d_in1_y = 0.000000000;
const float p_o904577170722_d_in1_z = 0.000000000;
const float p_o904577170722_d_in2_x = 0.000000000;
const float p_o904577170722_d_in2_y = 0.093000000;
const float p_o904577170722_d_in2_z = 0.769000000;
const float p_o897849507000_default_in1 = 0.000000000;
const float p_o897849507000_default_in2 = 0.000000000;
const float p_o897832729783_translate_x = 0.855000000;
const float p_o897832729783_translate_y = 0.200000000;
const float p_o897832729783_rotate = 0.000000000;
const float p_o897832729783_scale_x = 1.000000000;
const float p_o897832729783_scale_y = 1.000000000;
const float p_o897815952565_sides = 6.000000000;
const float p_o897815952565_radius = 2.220000000;
const float p_o897815952565_edge = 0.350000000;
const float p_o904610725156_color = 0.000000000;
const float p_o897681734826_translate_y = 0.000000000;
const float p_o897681734826_rotate = 0.000000000;
const float p_o897681734826_scale_x = 1.000000000;
const float p_o897681734826_scale_y = 1.000000000;
uniform sampler2D texture_5;
const float texture_5_size = 1024.000000000;
uniform sampler2D texture_6;
const float texture_6_size = 2048.000000000;
const float p_o904459730203_cx = -0.185000000;
const float p_o904459730203_cy = 0.000000000;
const float p_o904459730203_scale_x = 1.010000000;
const float p_o904459730203_scale_y = 1.005000000;
// #globals: transform2_3 (o904543616288)
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
// #globals: combine (o904476507420)
// #globals: shader_3 (o901020400865)
vec3 aces_tonemap(vec3 color){	
	mat3 m1 = mat3(
        vec3(0.59719, 0.07600, 0.02840),
        vec3(0.35458, 0.90834, 0.13383),
        vec3(0.04823, 0.01566, 0.83777)
	);
	mat3 m2 = mat3(
        vec3(1.60475, -0.10208, -0.00327),
        vec3(-0.53108,  1.10813, -0.07276),
        vec3(-0.07367, -0.00605,  1.07602)
	);
	vec3 v = m1 * color;    
	vec3 a = v * (v + 0.0245786) - 0.000090537;
	vec3 b = v * (0.983729 * v + 0.4329510) + 0.238081;
	return pow(clamp(m2 * (a / b), 0.0, 1.0), vec3(1.0 / 2.2));	
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
// #globals: blend2_3 (o901037178079)
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
// #globals: scale_2 (o902480018677)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: sdf3d_rotate
vec3 rotate3d(vec3 p, vec3 a) {
	vec3 rv;
	float c;
	float s;
	c = cos(a.x);
	s = sin(a.x);
	rv.x = p.x;
	rv.y = p.y*c+p.z*s;
	rv.z = -p.y*s+p.z*c;
	c = cos(a.y);
	s = sin(a.y);
	p.x = rv.x*c+rv.z*s;
	p.y = rv.y;
	p.z = -rv.x*s+rv.z*c;
	c = cos(a.z);
	s = sin(a.z);
	rv.x = p.x*c+p.y*s;
	rv.y = -p.x*s+p.y*c;
	rv.z = p.z;
	return rv;
}
// #globals: shape_2 (o901053955296)
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
// #globals: math_3 (o899443342542)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
void fragment() {
	float _seed_variation_ = variation;
	vec4 _controlled_variation_ = vec4(0.0);
	vec2 uv = fract(UV);
vec4 o902865894662_0 = textureLod(texture_1, ((floor(fract((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o902480018677_cx, 0.5+p_o902480018677_cy), vec2(p_o902480018677_scale_x, p_o902480018677_scale_y)))) * texture_1_size)+vec2(0.5))/texture_1_size), 0.0);

// #output1: scale_2 (o902480018677)
vec4 o902480018677_1_1_rgba = o902865894662_0;

// #code: math_v3 (o904560393505)
vec3 o904560393505_0_clamp_false = vec3(p_o904560393505_d_in1_x, p_o904560393505_d_in1_y, p_o904560393505_d_in1_z)+vec3(p_o904560393505_d_in2_x, p_o904560393505_d_in2_y, p_o904560393505_d_in2_z);
vec3 o904560393505_0_clamp_true = clamp(o904560393505_0_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3 (o904560393505)
vec3 o904560393505_0_1_rgb = o904560393505_0_clamp_false;
vec4 o901423054065_0 = textureLod(texture_2, ((floor(fract((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o902480018677_cx, 0.5+p_o902480018677_cy), vec2(p_o902480018677_scale_x, p_o902480018677_scale_y)))) * texture_2_size)+vec2(0.5))/texture_2_size), 0.0);

// #output0: scale_2 (o902480018677)
vec4 o902480018677_0_2_rgba = o901423054065_0;

// #code: spherize (o897698512041)
vec2 o897698512041_0_co = vec2(p_o897698512041_cx+0.5,p_o897698512041_cy+0.5);
float o897698512041_0_f = dot(2.0*((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))) - o897698512041_0_co),2.0*((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))) - o897698512041_0_co));
// #output2: spherize (o897698512041)
float o897698512041_2_1_f = step(o897698512041_0_f,p_o897698512041_r);

// #output0: shape_2 (o901053955296)
float o901053955296_0_1_f = shape_circle((transform2((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(p_o901070732514_translate_x*(2.0*1.0-1.0), p_o901070732514_translate_y*(2.0*1.0-1.0)), p_o901070732514_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o901070732514_scale_x*(2.0*1.0-1.0), p_o901070732514_scale_y*(2.0*1.0-1.0)))), p_o901053955296_sides+1.0e-5, p_o901053955296_radius*1.0, p_o901053955296_edge*1.0);

// #output0: transform2_4 (o901070732514)
vec4 o901070732514_0_1_rgba = vec4(vec3(o901053955296_0_1_f), 1.0);

// #output0: shape_2 (o901053955296)
float o901053955296_0_3_f = shape_circle((transform2((o897698512041_0_co-(o897698512041_0_co-(transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))))/(sqrt(abs(p_o897698512041_r-o897698512041_0_f))*max(p_o897698512041_a,0.0)+1.0)), vec2(p_o901070732514_translate_x*(2.0*1.0-1.0), p_o901070732514_translate_y*(2.0*1.0-1.0)), p_o901070732514_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o901070732514_scale_x*(2.0*1.0-1.0), p_o901070732514_scale_y*(2.0*1.0-1.0)))), p_o901053955296_sides+1.0e-5, p_o901053955296_radius*1.0, p_o901053955296_edge*1.0);

// #output0: transform2_4 (o901070732514)
vec4 o901070732514_0_3_rgba = vec4(vec3(o901053955296_0_3_f), 1.0);

// #output1: spherize (o897698512041)
vec4 o897698512041_1_2_rgba = mix(o901070732514_0_3_rgba,o901070732514_0_1_rgba,step(p_o897698512041_r,o897698512041_0_f));

// #code: math_v3_3 (o904593947939)
vec3 o904593947939_0_clamp_false = vec3(p_o904593947939_d_in1_x, p_o904593947939_d_in1_y, p_o904593947939_d_in1_z)+vec3(p_o904593947939_d_in2_x, p_o904593947939_d_in2_y, p_o904593947939_d_in2_z);
vec3 o904593947939_0_clamp_true = clamp(o904593947939_0_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3_3 (o904593947939)
vec3 o904593947939_0_1_rgb = o904593947939_0_clamp_false;
vec4 o899812441309_0 = textureLod(texture_3, fract((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0))))), 0.0);
vec4 o898235382986_0 = textureLod(texture_4, fract((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0))))), 0.0);

// #code: math_2 (o897883061434)
float o897883061434_0_clamp_false = (dot((o898235382986_0).rgb, vec3(1.0))/3.0)*o897698512041_2_1_f;
float o897883061434_0_clamp_true = clamp(o897883061434_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o897883061434)
float o897883061434_0_1_f = o897883061434_0_clamp_true;

// #code: math_3 (o899443342542)
float o899443342542_0_clamp_false = o897883061434_0_1_f*(dot((o899812441309_0).rgb, vec3(1.0))/3.0);
float o899443342542_0_clamp_true = clamp(o899443342542_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o899443342542)
float o899443342542_0_1_f = o899443342542_0_clamp_true;

// #code: math_v3_2 (o904577170722)
vec3 o904577170722_0_clamp_false = vec3(p_o904577170722_d_in1_x, p_o904577170722_d_in1_y, p_o904577170722_d_in1_z)+vec3(p_o904577170722_d_in2_x, p_o904577170722_d_in2_y, p_o904577170722_d_in2_z);
vec3 o904577170722_0_clamp_true = clamp(o904577170722_0_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3_2 (o904577170722)
vec3 o904577170722_0_1_rgb = o904577170722_0_clamp_false;

// #output0: shape (o897815952565)
float o897815952565_0_1_f = shape_circle((transform2((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(p_o897832729783_translate_x*(2.0*1.0-1.0), p_o897832729783_translate_y*(2.0*1.0-1.0)), p_o897832729783_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897832729783_scale_x*(2.0*1.0-1.0), p_o897832729783_scale_y*(2.0*1.0-1.0)))), p_o897815952565_sides+1.0e-5, p_o897815952565_radius*1.0, p_o897815952565_edge*1.0);

// #output0: transform2_2 (o897832729783)
vec4 o897832729783_0_1_rgba = vec4(vec3(o897815952565_0_1_f), 1.0);

// #code: math (o897849507000)
float o897849507000_0_clamp_false = (dot((o897832729783_0_1_rgba).rgb, vec3(1.0))/3.0)*o897698512041_2_1_f;
float o897849507000_0_clamp_true = clamp(o897849507000_0_clamp_false, 0.0, 1.0);
// #output0: math (o897849507000)
float o897849507000_0_1_f = o897849507000_0_clamp_true;

// #output0: uniform_greyscale (o904610725156)
float o904610725156_0_1_f = p_o904610725156_color;
vec4 o904493284637_0 = textureLod(texture_5, fract((fract(transform2((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2((elapsed_time*0.01)*(2.0*1.0-1.0), p_o897681734826_translate_y*(2.0*1.0-1.0)), p_o897681734826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897681734826_scale_x*(2.0*1.0-1.0), p_o897681734826_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o897681734826)
vec4 o897681734826_0_1_rgba = o904493284637_0;
vec4 o904493284637_1 = textureLod(texture_5, fract((fract(transform2((o897698512041_0_co-(o897698512041_0_co-(transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))))/(sqrt(abs(p_o897698512041_r-o897698512041_0_f))*max(p_o897698512041_a,0.0)+1.0)), vec2((elapsed_time*0.01)*(2.0*1.0-1.0), p_o897681734826_translate_y*(2.0*1.0-1.0)), p_o897681734826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897681734826_scale_x*(2.0*1.0-1.0), p_o897681734826_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o897681734826)
vec4 o897681734826_0_3_rgba = o904493284637_1;

// #output0: spherize (o897698512041)
vec4 o897698512041_0_3_rgba = mix(o897681734826_0_3_rgba,o897681734826_0_1_rgba,step(p_o897698512041_r,o897698512041_0_f));

// #code: blend2 (o897715289267)
vec4 o897715289267_0_b = o897698512041_0_3_rgba;
vec4 o897715289267_0_l;
float o897715289267_0_a;

o897715289267_0_l = vec4(vec3(o897698512041_2_1_f), 1.0);
o897715289267_0_a = p_o897715289267_amount1*1.0;
o897715289267_0_b = vec4(blend_multiply((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o897715289267_0_l.rgb, o897715289267_0_b.rgb, o897715289267_0_a*o897715289267_0_l.a), min(1.0, o897715289267_0_b.a+o897715289267_0_a*o897715289267_0_l.a));

o897715289267_0_l = vec4(vec3(o904610725156_0_1_f), 1.0);
o897715289267_0_a = p_o897715289267_amount2*o897849507000_0_1_f;
o897715289267_0_b = vec4(blend_normal((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o897715289267_0_l.rgb, o897715289267_0_b.rgb, o897715289267_0_a*o897715289267_0_l.a), min(1.0, o897715289267_0_b.a+o897715289267_0_a*o897715289267_0_l.a));

o897715289267_0_l = vec4(o904577170722_0_1_rgb, 1.0);
o897715289267_0_a = p_o897715289267_amount3*o899443342542_0_1_f;
o897715289267_0_b = vec4(blend_additive((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o897715289267_0_l.rgb, o897715289267_0_b.rgb, o897715289267_0_a*o897715289267_0_l.a), min(1.0, o897715289267_0_b.a+o897715289267_0_a*o897715289267_0_l.a));

o897715289267_0_l = vec4(o904593947939_0_1_rgb, 1.0);
o897715289267_0_a = p_o897715289267_amount4*(dot((o897698512041_1_2_rgba).rgb, vec3(1.0))/3.0);
o897715289267_0_b = vec4(blend_additive((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o897715289267_0_l.rgb, o897715289267_0_b.rgb, o897715289267_0_a*o897715289267_0_l.a), min(1.0, o897715289267_0_b.a+o897715289267_0_a*o897715289267_0_l.a));
// #output0: blend2 (o897715289267)
vec4 o897715289267_0_1_rgba = o897715289267_0_b;
vec4 o905365699903_0 = textureLod(texture_6, ((floor(fract((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0))))) * texture_6_size)+vec2(0.5))/texture_6_size), 0.0);

// #code: blend2_6 (o908184272204)
vec4 o908184272204_0_b = o905365699903_0;
vec4 o908184272204_0_l;
float o908184272204_0_a;

o908184272204_0_l = o897715289267_0_1_rgba;
o908184272204_0_a = p_o908184272204_amount1*o897698512041_2_1_f;
o908184272204_0_b = vec4(blend_normal((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o908184272204_0_l.rgb, o908184272204_0_b.rgb, o908184272204_0_a*o908184272204_0_l.a), min(1.0, o908184272204_0_b.a+o908184272204_0_a*o908184272204_0_l.a));
// #output0: blend2_6 (o908184272204)
vec4 o908184272204_0_1_rgba = o908184272204_0_b;

// #code: blend2_2 (o902496795894)
vec4 o902496795894_0_b = o908184272204_0_1_rgba;
vec4 o902496795894_0_l;
float o902496795894_0_a;

o902496795894_0_l = vec4(o904560393505_0_1_rgb, 1.0);
o902496795894_0_a = p_o902496795894_amount1*(dot((o902480018677_0_2_rgba).rgb, vec3(1.0))/3.0);
o902496795894_0_b = vec4(blend_additive((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o902496795894_0_l.rgb, o902496795894_0_b.rgb, o902496795894_0_a*o902496795894_0_l.a), min(1.0, o902496795894_0_b.a+o902496795894_0_a*o902496795894_0_l.a));

o902496795894_0_l = vec4(o904560393505_0_1_rgb, 1.0);
o902496795894_0_a = p_o902496795894_amount2*(dot((o902480018677_1_1_rgba).rgb, vec3(1.0))/3.0);
o902496795894_0_b = vec4(blend_additive((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o902496795894_0_l.rgb, o902496795894_0_b.rgb, o902496795894_0_a*o902496795894_0_l.a), min(1.0, o902496795894_0_b.a+o902496795894_0_a*o902496795894_0_l.a));
// #output0: blend2_2 (o902496795894)
vec4 o902496795894_0_1_rgba = o902496795894_0_b;

// #code: blend2_3 (o901037178079)
vec4 o901037178079_0_b = o902496795894_0_1_rgba;
vec4 o901037178079_0_l;
float o901037178079_0_a;

o901037178079_0_l = o902496795894_0_1_rgba;
o901037178079_0_a = p_o901037178079_amount1*1.0;
o901037178079_0_b = vec4(blend_multiply((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), o901037178079_0_l.rgb, o901037178079_0_b.rgb, o901037178079_0_a*o901037178079_0_l.a), min(1.0, o901037178079_0_b.a+o901037178079_0_a*o901037178079_0_l.a));
// #output0: blend2_3 (o901037178079)
vec4 o901037178079_0_1_rgba = o901037178079_0_b;

// #output0: shader_3 (o901020400865)
vec3 o901020400865_0_1_rgb = aces_tonemap(((o901037178079_0_1_rgba).rgb));

// #output2: decompose (o904442952986)
float o904442952986_2_1_f = vec4(o901020400865_0_1_rgb, 1.0).b;

// #output1: decompose (o904442952986)
float o904442952986_1_2_f = vec4(o901020400865_0_1_rgb, 1.0).g;
vec4 o902865894662_1 = textureLod(texture_1, ((floor(fract((scale((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), vec2(0.5+p_o902480018677_cx, 0.5+p_o902480018677_cy), vec2(p_o902480018677_scale_x, p_o902480018677_scale_y)))) * texture_1_size)+vec2(0.5))/texture_1_size), 0.0);

// #output1: scale_2 (o902480018677)
vec4 o902480018677_1_4_rgba = o902865894662_1;

// #code: math_v3 (o904560393505)
vec3 o904560393505_2_clamp_false = vec3(p_o904560393505_d_in1_x, p_o904560393505_d_in1_y, p_o904560393505_d_in1_z)+vec3(p_o904560393505_d_in2_x, p_o904560393505_d_in2_y, p_o904560393505_d_in2_z);
vec3 o904560393505_2_clamp_true = clamp(o904560393505_2_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3 (o904560393505)
vec3 o904560393505_0_3_rgb = o904560393505_2_clamp_false;
vec4 o901423054065_1 = textureLod(texture_2, ((floor(fract((scale((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), vec2(0.5+p_o902480018677_cx, 0.5+p_o902480018677_cy), vec2(p_o902480018677_scale_x, p_o902480018677_scale_y)))) * texture_2_size)+vec2(0.5))/texture_2_size), 0.0);

// #output0: scale_2 (o902480018677)
vec4 o902480018677_0_5_rgba = o901423054065_1;

// #code: spherize (o897698512041)
vec2 o897698512041_4_co = vec2(p_o897698512041_cx+0.5,p_o897698512041_cy+0.5);
float o897698512041_4_f = dot(2.0*((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))) - o897698512041_4_co),2.0*((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))) - o897698512041_4_co));
// #output2: spherize (o897698512041)
float o897698512041_2_5_f = step(o897698512041_4_f,p_o897698512041_r);

// #output0: shape_2 (o901053955296)
float o901053955296_0_5_f = shape_circle((transform2((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), vec2(p_o901070732514_translate_x*(2.0*1.0-1.0), p_o901070732514_translate_y*(2.0*1.0-1.0)), p_o901070732514_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o901070732514_scale_x*(2.0*1.0-1.0), p_o901070732514_scale_y*(2.0*1.0-1.0)))), p_o901053955296_sides+1.0e-5, p_o901053955296_radius*1.0, p_o901053955296_edge*1.0);

// #output0: transform2_4 (o901070732514)
vec4 o901070732514_0_5_rgba = vec4(vec3(o901053955296_0_5_f), 1.0);

// #output0: shape_2 (o901053955296)
float o901053955296_0_7_f = shape_circle((transform2((o897698512041_4_co-(o897698512041_4_co-(scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))))/(sqrt(abs(p_o897698512041_r-o897698512041_4_f))*max(p_o897698512041_a,0.0)+1.0)), vec2(p_o901070732514_translate_x*(2.0*1.0-1.0), p_o901070732514_translate_y*(2.0*1.0-1.0)), p_o901070732514_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o901070732514_scale_x*(2.0*1.0-1.0), p_o901070732514_scale_y*(2.0*1.0-1.0)))), p_o901053955296_sides+1.0e-5, p_o901053955296_radius*1.0, p_o901053955296_edge*1.0);

// #output0: transform2_4 (o901070732514)
vec4 o901070732514_0_7_rgba = vec4(vec3(o901053955296_0_7_f), 1.0);

// #output1: spherize (o897698512041)
vec4 o897698512041_1_6_rgba = mix(o901070732514_0_7_rgba,o901070732514_0_5_rgba,step(p_o897698512041_r,o897698512041_4_f));

// #code: math_v3_3 (o904593947939)
vec3 o904593947939_2_clamp_false = vec3(p_o904593947939_d_in1_x, p_o904593947939_d_in1_y, p_o904593947939_d_in1_z)+vec3(p_o904593947939_d_in2_x, p_o904593947939_d_in2_y, p_o904593947939_d_in2_z);
vec3 o904593947939_2_clamp_true = clamp(o904593947939_2_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3_3 (o904593947939)
vec3 o904593947939_0_3_rgb = o904593947939_2_clamp_false;
vec4 o899812441309_1 = textureLod(texture_3, fract((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y)))), 0.0);
vec4 o898235382986_1 = textureLod(texture_4, fract((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y)))), 0.0);

// #code: math_2 (o897883061434)
float o897883061434_2_clamp_false = (dot((o898235382986_1).rgb, vec3(1.0))/3.0)*o897698512041_2_5_f;
float o897883061434_2_clamp_true = clamp(o897883061434_2_clamp_false, 0.0, 1.0);
// #output0: math_2 (o897883061434)
float o897883061434_0_3_f = o897883061434_2_clamp_true;

// #code: math_3 (o899443342542)
float o899443342542_2_clamp_false = o897883061434_0_3_f*(dot((o899812441309_1).rgb, vec3(1.0))/3.0);
float o899443342542_2_clamp_true = clamp(o899443342542_2_clamp_false, 0.0, 1.0);
// #output0: math_3 (o899443342542)
float o899443342542_0_3_f = o899443342542_2_clamp_true;

// #code: math_v3_2 (o904577170722)
vec3 o904577170722_2_clamp_false = vec3(p_o904577170722_d_in1_x, p_o904577170722_d_in1_y, p_o904577170722_d_in1_z)+vec3(p_o904577170722_d_in2_x, p_o904577170722_d_in2_y, p_o904577170722_d_in2_z);
vec3 o904577170722_2_clamp_true = clamp(o904577170722_2_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3_2 (o904577170722)
vec3 o904577170722_0_3_rgb = o904577170722_2_clamp_false;

// #output0: shape (o897815952565)
float o897815952565_0_3_f = shape_circle((transform2((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), vec2(p_o897832729783_translate_x*(2.0*1.0-1.0), p_o897832729783_translate_y*(2.0*1.0-1.0)), p_o897832729783_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897832729783_scale_x*(2.0*1.0-1.0), p_o897832729783_scale_y*(2.0*1.0-1.0)))), p_o897815952565_sides+1.0e-5, p_o897815952565_radius*1.0, p_o897815952565_edge*1.0);

// #output0: transform2_2 (o897832729783)
vec4 o897832729783_0_3_rgba = vec4(vec3(o897815952565_0_3_f), 1.0);

// #code: math (o897849507000)
float o897849507000_2_clamp_false = (dot((o897832729783_0_3_rgba).rgb, vec3(1.0))/3.0)*o897698512041_2_5_f;
float o897849507000_2_clamp_true = clamp(o897849507000_2_clamp_false, 0.0, 1.0);
// #output0: math (o897849507000)
float o897849507000_0_3_f = o897849507000_2_clamp_true;

// #output0: uniform_greyscale (o904610725156)
float o904610725156_0_3_f = p_o904610725156_color;
vec4 o904493284637_2 = textureLod(texture_5, fract((fract(transform2((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), vec2((elapsed_time*0.01)*(2.0*1.0-1.0), p_o897681734826_translate_y*(2.0*1.0-1.0)), p_o897681734826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897681734826_scale_x*(2.0*1.0-1.0), p_o897681734826_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o897681734826)
vec4 o897681734826_0_5_rgba = o904493284637_2;
vec4 o904493284637_3 = textureLod(texture_5, fract((fract(transform2((o897698512041_4_co-(o897698512041_4_co-(scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))))/(sqrt(abs(p_o897698512041_r-o897698512041_4_f))*max(p_o897698512041_a,0.0)+1.0)), vec2((elapsed_time*0.01)*(2.0*1.0-1.0), p_o897681734826_translate_y*(2.0*1.0-1.0)), p_o897681734826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o897681734826_scale_x*(2.0*1.0-1.0), p_o897681734826_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o897681734826)
vec4 o897681734826_0_7_rgba = o904493284637_3;

// #output0: spherize (o897698512041)
vec4 o897698512041_0_7_rgba = mix(o897681734826_0_7_rgba,o897681734826_0_5_rgba,step(p_o897698512041_r,o897698512041_4_f));

// #code: blend2 (o897715289267)
vec4 o897715289267_2_b = o897698512041_0_7_rgba;
vec4 o897715289267_2_l;
float o897715289267_2_a;

o897715289267_2_l = vec4(vec3(o897698512041_2_5_f), 1.0);
o897715289267_2_a = p_o897715289267_amount1*1.0;
o897715289267_2_b = vec4(blend_multiply((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o897715289267_2_l.rgb, o897715289267_2_b.rgb, o897715289267_2_a*o897715289267_2_l.a), min(1.0, o897715289267_2_b.a+o897715289267_2_a*o897715289267_2_l.a));

o897715289267_2_l = vec4(vec3(o904610725156_0_3_f), 1.0);
o897715289267_2_a = p_o897715289267_amount2*o897849507000_0_3_f;
o897715289267_2_b = vec4(blend_normal((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o897715289267_2_l.rgb, o897715289267_2_b.rgb, o897715289267_2_a*o897715289267_2_l.a), min(1.0, o897715289267_2_b.a+o897715289267_2_a*o897715289267_2_l.a));

o897715289267_2_l = vec4(o904577170722_0_3_rgb, 1.0);
o897715289267_2_a = p_o897715289267_amount3*o899443342542_0_3_f;
o897715289267_2_b = vec4(blend_additive((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o897715289267_2_l.rgb, o897715289267_2_b.rgb, o897715289267_2_a*o897715289267_2_l.a), min(1.0, o897715289267_2_b.a+o897715289267_2_a*o897715289267_2_l.a));

o897715289267_2_l = vec4(o904593947939_0_3_rgb, 1.0);
o897715289267_2_a = p_o897715289267_amount4*(dot((o897698512041_1_6_rgba).rgb, vec3(1.0))/3.0);
o897715289267_2_b = vec4(blend_additive((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o897715289267_2_l.rgb, o897715289267_2_b.rgb, o897715289267_2_a*o897715289267_2_l.a), min(1.0, o897715289267_2_b.a+o897715289267_2_a*o897715289267_2_l.a));
// #output0: blend2 (o897715289267)
vec4 o897715289267_0_3_rgba = o897715289267_2_b;
vec4 o905365699903_1 = textureLod(texture_6, ((floor(fract((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y)))) * texture_6_size)+vec2(0.5))/texture_6_size), 0.0);

// #code: blend2_6 (o908184272204)
vec4 o908184272204_2_b = o905365699903_1;
vec4 o908184272204_2_l;
float o908184272204_2_a;

o908184272204_2_l = o897715289267_0_3_rgba;
o908184272204_2_a = p_o908184272204_amount1*o897698512041_2_5_f;
o908184272204_2_b = vec4(blend_normal((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o908184272204_2_l.rgb, o908184272204_2_b.rgb, o908184272204_2_a*o908184272204_2_l.a), min(1.0, o908184272204_2_b.a+o908184272204_2_a*o908184272204_2_l.a));
// #output0: blend2_6 (o908184272204)
vec4 o908184272204_0_3_rgba = o908184272204_2_b;

// #code: blend2_2 (o902496795894)
vec4 o902496795894_2_b = o908184272204_0_3_rgba;
vec4 o902496795894_2_l;
float o902496795894_2_a;

o902496795894_2_l = vec4(o904560393505_0_3_rgb, 1.0);
o902496795894_2_a = p_o902496795894_amount1*(dot((o902480018677_0_5_rgba).rgb, vec3(1.0))/3.0);
o902496795894_2_b = vec4(blend_additive((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o902496795894_2_l.rgb, o902496795894_2_b.rgb, o902496795894_2_a*o902496795894_2_l.a), min(1.0, o902496795894_2_b.a+o902496795894_2_a*o902496795894_2_l.a));

o902496795894_2_l = vec4(o904560393505_0_3_rgb, 1.0);
o902496795894_2_a = p_o902496795894_amount2*(dot((o902480018677_1_4_rgba).rgb, vec3(1.0))/3.0);
o902496795894_2_b = vec4(blend_additive((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o902496795894_2_l.rgb, o902496795894_2_b.rgb, o902496795894_2_a*o902496795894_2_l.a), min(1.0, o902496795894_2_b.a+o902496795894_2_a*o902496795894_2_l.a));
// #output0: blend2_2 (o902496795894)
vec4 o902496795894_0_3_rgba = o902496795894_2_b;

// #code: blend2_3 (o901037178079)
vec4 o901037178079_2_b = o902496795894_0_3_rgba;
vec4 o901037178079_2_l;
float o901037178079_2_a;

o901037178079_2_l = o902496795894_0_3_rgba;
o901037178079_2_a = p_o901037178079_amount1*1.0;
o901037178079_2_b = vec4(blend_multiply((scale((transform2((uv), vec2(p_o904543616288_translate_x*(2.0*1.0-1.0), p_o904543616288_translate_y*(2.0*1.0-1.0)), p_o904543616288_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o904543616288_scale_x*(2.0*1.0-1.0), p_o904543616288_scale_y*(2.0*1.0-1.0)))), vec2(0.5+p_o904459730203_cx, 0.5+p_o904459730203_cy), vec2(p_o904459730203_scale_x, p_o904459730203_scale_y))), o901037178079_2_l.rgb, o901037178079_2_b.rgb, o901037178079_2_a*o901037178079_2_l.a), min(1.0, o901037178079_2_b.a+o901037178079_2_a*o901037178079_2_l.a));
// #output0: blend2_3 (o901037178079)
vec4 o901037178079_0_3_rgba = o901037178079_2_b;

// #output0: shader_3 (o901020400865)
vec3 o901020400865_0_3_rgb = aces_tonemap(((o901037178079_0_3_rgba).rgb));

// #output0: decompose (o904442952986)
float o904442952986_0_4_f = vec4(o901020400865_0_3_rgb, 1.0).r;

// #output0: scale_3 (o904459730203)
vec4 o904459730203_0_1_rgba = vec4(vec3(o904442952986_0_4_f), 1.0);

// #output0: combine (o904476507420)
vec4 o904476507420_0_1_rgba = vec4((dot((o904459730203_0_1_rgba).rgb, vec3(1.0))/3.0), o904442952986_1_2_f, o904442952986_2_1_f, 1.0);

// #output0: transform2_3 (o904543616288)
vec4 o904543616288_0_1_rgba = o904476507420_0_1_rgba;

	vec4 color_tex = o904543616288_0_1_rgba;
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	ALBEDO = color_tex.rgb;
	ALPHA = color_tex.a;
}



