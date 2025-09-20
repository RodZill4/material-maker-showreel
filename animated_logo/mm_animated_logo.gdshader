shader_type spatial;

render_mode unshaded, blend_mix, depth_test_disabled;

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
uniform float shader_time = 23.000000000;
const float p_o512376187543_cx = 0.000000000;
const float p_o512376187543_cy = 0.000000000;
const float p_o512376187543_scale_x = 1.100000000;
const float p_o512124529296_amount = 1.000000000;
const float p_o511788984960_default_in1 = 0.000000000;
const float p_o511788984960_default_in2 = 0.000000000;
const float p_o511889648262_default_in1 = 0.000000000;
const float p_o511889648262_default_in2 = 0.000000000;
const float p_o511805762177_sides = 6.000000000;
const float p_o511805762177_radius = 0.820000000;
const float p_o511805762177_edge = 0.002000000;
const float p_o511856093828_default_in1 = 0.000000000;
const float p_o511856093828_default_in2 = 0.000000000;
const float p_o511839316611_sides = 6.000000000;
const float p_o511839316611_radius = 1.480000000;
const float p_o511839316611_edge = 0.020000000;
const float p_o511872871045_color = 1.000000000;
const float p_o509322734173_value = 0.500000000;
const float p_o509322734173_width = 0.002000000;
const float p_o511822539394_default_in1 = 1.000000000;
const float p_o511822539394_default_in2 = 0.000000000;
const float p_o6724727617733_default_in1 = 0.000000000;
const float p_o6724727617733_default_in2 = 0.000000000;
const float p_o511906425479_translate_x = 0.000000000;
const float p_o511906425479_translate_y = -1.170000000;
const float p_o511906425479_rotate = 0.000000000;
const float p_o511906425479_scale_x = 1.000000000;
const float p_o511906425479_scale_y = 1.000000000;
const float p_o512057420428_translate_x = 0.000000000;
const float p_o512007088779_bevel = 0.620000000;
const float p_o512007088779_base = 0.480000000;
const float p_o7411586834527_default_in1 = 0.000000000;
const float p_o7411586834527_default_in2 = 0.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 4096.000000000;
const float p_o7858179549683_default_in1 = 1.000000000;
const float p_o7858179549683_default_in2 = 0.000000000;
const vec4 p_o512359410325_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o512141306513_repeat = 1.000000000;
const float p_o512141306513_rotate = 135.400000000;
const float p_o512141306513_gradient_pos[2] = float[]( 0.119020000, 1.000000000 );
const vec4 p_o512141306513_gradient_col[2] = vec4[]( vec4(0.265625000, 0.655762017, 1.000000000, 1.000000000), vec4(1.000000000, 0.339843988, 0.974213004, 1.000000000) );
// #globals: scale (o512376187543)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: blend (o512124529296)
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
// #globals: math_4 (o511788984960)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: shape_2 (o511805762177)
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
// #globals: uniform_greyscale (o511872871045)
// #globals: transform2 (o511906425479)
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
// #globals: rotate
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
	return rv;
}
// #globals: sdisoscelestriangle
float sd_isosceles_triangle(vec2 uv, vec2 size)
{
	uv.x = abs(uv.x);
	uv.y += size.y; size.y *= 2.0;
	vec2 a = uv - size*clamp(dot(uv,size)/dot(size,size), 0.0, 1.0);
	vec2 b = uv - size*vec2(clamp(uv.x/size.x, 0.0, 1.0), 1.0);
	float s = -sign(size.y);
	vec2 d = min(vec2(dot(a,a), s*(uv.x*size.y-uv.y*size.x)),
				 vec2(dot(b,b), s*(uv.y-size.y)));
	return -sqrt(d.x)*sign(d.y);
}
// #globals: rotate (o510715243120)
vec2 get_animation_frame(vec2 uv, float t) {
 	int it = int(t);
    return (uv+vec2(float(it%8), float(it/8)))*0.125;
}
// #instance: sdf_3 (o511923202696)
float o511923202696_d(vec2 uv, float _seed_variation_) {
vec2 _n325193_p = uv - vec2(0.000000000, 0.000000000);
_n325193_p = rotate(_n325193_p, radians(0.000000000))/1.000000000;
float _n325193 = 0.0;float _n325193_kk = 10.0/0.110000000;vec2 _n325194_p = _n325193_p - vec2(0.000000000, 0.000000000);
_n325194_p = rotate(_n325194_p, radians(0.000000000))/1.000000000;
float _n325194;
_n325194 = length(_n325194_p)-0.070000000;
_n325194 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325194);
vec2 _n325195_p = _n325193_p - vec2(0.001122000, -0.120000000);
_n325195_p = rotate(_n325195_p, radians(0.000000000))/1.000000000;
float _n325195;
_n325195 = sd_isosceles_triangle(_n325195_p, vec2(0.060561000, 0.094206000));
_n325195 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325195);
_n325193 = -log2(_n325193)/_n325193_kk;
_n325193 *= 1.000000000;
float return_value = _n325193;
return return_value;}
float o511923202696_c(vec2 uv, out vec4 albedo, out float metallic, out float roughness, out vec3 emission, float _seed_variation_) {
albedo = vec4(0.0, 0.0, 0.0, 1.0);
metallic = 0.0;
roughness = 1.0;
emission = vec3(0.0);
vec2 _n325193_p = uv - vec2(0.000000000, 0.000000000);
_n325193_p = rotate(_n325193_p, radians(0.000000000))/1.000000000;
float _n325193 = 0.0;float _n325193_kk = 10.0/0.110000000;vec2 _n325194_p = _n325193_p - vec2(0.000000000, 0.000000000);
_n325194_p = rotate(_n325194_p, radians(0.000000000))/1.000000000;
float _n325194;
_n325194 = length(_n325194_p)-0.070000000;
_n325194 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325194);
vec2 _n325195_p = _n325193_p - vec2(0.001122000, -0.120000000);
_n325195_p = rotate(_n325195_p, radians(0.000000000))/1.000000000;
float _n325195;
_n325195 = sd_isosceles_triangle(_n325195_p, vec2(0.060561000, 0.094206000));
_n325195 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325195);
_n325193 = -log2(_n325193)/_n325193_kk;
_n325193 *= 1.000000000;
float return_value = _n325193;
// Albedo
{
if (_n325193 < 0.0) {
vec4 sum_325193 = vec4(0.0);
vec4 tmp_325193;
vec4 current_color_325193 = albedo;
float coef_325193;
float coefsum_325193 = 0.0;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325194, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325195, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
albedo = sum_325193/coefsum_325193;
}
}
// Metallic
{
if (_n325193 < 0.0) {
float sum_325193 = float(0.0);
float tmp_325193;
float current_color_325193 = metallic;
float coef_325193;
float coefsum_325193 = 0.0;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325194, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325195, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
metallic = sum_325193/coefsum_325193;
}
}
// Roughness
{
if (_n325193 < 0.0) {
float sum_325193 = float(0.0);
float tmp_325193;
float current_color_325193 = roughness;
float coef_325193;
float coefsum_325193 = 0.0;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325194, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325195, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
roughness = sum_325193/coefsum_325193;
}
}
// Emission
{
if (_n325193 < 0.0) {
vec3 sum_325193 = vec3(0.0);
vec3 tmp_325193;
vec3 current_color_325193 = emission;
float coef_325193;
float coefsum_325193 = 0.0;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325194, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
tmp_325193 = current_color_325193;
coef_325193 = 1.0/pow(1.0+max(_n325195, 0.0), 10000.0*pow(0.8-0.3*clamp(0.500000000, 0.0, 1.0), 10.0));
sum_325193 += tmp_325193*coef_325193;
coefsum_325193 += coef_325193;
emission = sum_325193/coefsum_325193;
}
}
return return_value;}
vec4 o512141306513_gradient_gradient_fct(float x) {
  if (x < p_o512141306513_gradient_pos[0]) {
    return p_o512141306513_gradient_col[0];
  } else if (x < p_o512141306513_gradient_pos[1]) {
    return mix(p_o512141306513_gradient_col[0], p_o512141306513_gradient_col[1], ((x-p_o512141306513_gradient_pos[0])/(p_o512141306513_gradient_pos[1]-p_o512141306513_gradient_pos[0])));
  }
  return p_o512141306513_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: shape_2 (o511805762177)
float o511805762177_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), p_o511805762177_sides, p_o511805762177_radius*1.0, p_o511805762177_edge*1.0);

// #output0: shape_3 (o511839316611)
float o511839316611_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), p_o511839316611_sides, p_o511839316611_radius*1.0, p_o511839316611_edge*1.0);

// #output0: uniform_greyscale (o511872871045)
float o511872871045_0_1_f = p_o511872871045_color;

// #code: math_6 (o511856093828)
float o511856093828_0_clamp_false = o511872871045_0_1_f-o511839316611_0_1_f;
float o511856093828_0_clamp_true = clamp(o511856093828_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o511856093828)
float o511856093828_0_1_f = o511856093828_0_clamp_false;

// #code: math_7 (o511889648262)
float o511889648262_0_clamp_false = max(o511856093828_0_1_f,o511805762177_0_1_f);
float o511889648262_0_clamp_true = clamp(o511889648262_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o511889648262)
float o511889648262_0_1_f = o511889648262_0_clamp_false;

// #output0: sdf_3 (o511923202696)
float o511923202696_0_0_sdf2d = o511923202696_d(((transform2((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), vec2(p_o511906425479_translate_x*(2.0*1.0-1.0), p_o511906425479_translate_y*(2.0*1.0-1.0)), p_o511906425479_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o511906425479_scale_x*(2.0*1.0-1.0), p_o511906425479_scale_y*(2.0*1.0-1.0))))-vec2(p_o512057420428_translate_x, (shader_time*0.2)))-vec2(0.5), _seed_variation_);

// #output0: sdshow (o512007088779)
float o512007088779_0_1_f = clamp(p_o512007088779_base-o511923202696_0_0_sdf2d/max(p_o512007088779_bevel, 0.00001), 0.0, 1.0);

// #output0: invert (o512023865994)
vec4 o512023865994_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o512007088779_0_1_f), 1.0).rgb, vec4(vec3(o512007088779_0_1_f), 1.0).a);

// #output0: translate (o512057420428)
vec4 o512057420428_0_1_rgba = o512023865994_0_1_rgba;

// #output0: transform2 (o511906425479)
vec4 o511906425479_0_1_rgba = o512057420428_0_1_rgba;

// #output0: uniform_greyscale_2 (o8659073513775)
float o8659073513775_0_1_f = (clamp(7.0-shader_time, 0.0, 1.0));

// #code: math_8 (o6724727617733)
float o6724727617733_0_clamp_false = o8659073513775_0_1_f*(dot((o511906425479_0_1_rgba).rgb, vec3(1.0))/3.0);
float o6724727617733_0_clamp_true = clamp(o6724727617733_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o6724727617733)
float o6724727617733_0_1_f = o6724727617733_0_clamp_false;

// #code: rotate (o510715243120)
float o510715243120_0_t = clamp((shader_time), 0.0, 39.99);vec4 o509675055725_0 = textureLod(texture_1, fract((get_animation_frame((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), o510715243120_0_t+1.0))), 0.0);
vec4 o509675055725_1 = textureLod(texture_1, fract((get_animation_frame((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), o510715243120_0_t))), 0.0);

// #output0: rotate (o510715243120)
vec4 o510715243120_0_1_rgba = mix(o509675055725_1, o509675055725_0, fract(o510715243120_0_t));

// #code: math_11 (o7858179549683)
float o7858179549683_0_clamp_false = p_o7858179549683_default_in1-o8659073513775_0_1_f;
float o7858179549683_0_clamp_true = clamp(o7858179549683_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o7858179549683)
float o7858179549683_0_1_f = o7858179549683_0_clamp_false;

// #code: math_9 (o7411586834527)
float o7411586834527_0_clamp_false = o7858179549683_0_1_f*(dot((o510715243120_0_1_rgba).rgb, vec3(1.0))/3.0);
float o7411586834527_0_clamp_true = clamp(o7411586834527_0_clamp_false, 0.0, 1.0);
// #output0: math_9 (o7411586834527)
float o7411586834527_0_1_f = o7411586834527_0_clamp_false;

// #code: math_5 (o511822539394)
float o511822539394_0_clamp_false = o7411586834527_0_1_f+o6724727617733_0_1_f;
float o511822539394_0_clamp_true = clamp(o511822539394_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o511822539394)
float o511822539394_0_1_f = o511822539394_0_clamp_false;

// #code: tones_step (o509322734173)
vec3 o509322734173_0_false = clamp((vec4(vec3(o511822539394_0_1_f), 1.0).rgb-vec3(p_o509322734173_value))/max(0.0001, p_o509322734173_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o509322734173_0_true = vec3(1.0)-o509322734173_0_false;
// #output0: tones_step (o509322734173)
vec4 o509322734173_0_1_rgba = vec4(o509322734173_0_false, vec4(vec3(o511822539394_0_1_f), 1.0).a);

// #code: math_4 (o511788984960)
float o511788984960_0_clamp_false = min((dot((o509322734173_0_1_rgba).rgb, vec3(1.0))/3.0),o511889648262_0_1_f);
float o511788984960_0_clamp_true = clamp(o511788984960_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o511788984960)
float o511788984960_0_1_f = o511788984960_0_clamp_false;

// #output0: uniform (o512359410325)
vec4 o512359410325_0_1_rgba = p_o512359410325_color;

// #code: gradient (o512141306513)
float o512141306513_0_r = 0.5+(cos(p_o512141306513_rotate*0.01745329251)*((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))).x-0.5)+sin(p_o512141306513_rotate*0.01745329251)*((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))).y-0.5))/(cos(abs(mod(p_o512141306513_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient (o512141306513)
vec4 o512141306513_0_1_rgba = o512141306513_gradient_gradient_fct(fract(o512141306513_0_r*p_o512141306513_repeat));

// #code: blend (o512124529296)
vec4 o512124529296_0_s1 = o512141306513_0_1_rgba;
vec4 o512124529296_0_s2 = o512359410325_0_1_rgba;
float o512124529296_0_a = p_o512124529296_amount*o511788984960_0_1_f;
// #output0: blend (o512124529296)
vec4 o512124529296_0_1_rgba = vec4(blend_normal((scale((uv), vec2(0.5+p_o512376187543_cx, 0.5+p_o512376187543_cy), vec2(p_o512376187543_scale_x, (p_o512376187543_scale_x)))), o512124529296_0_s1.rgb, o512124529296_0_s2.rgb, o512124529296_0_a*o512124529296_0_s1.a), min(1.0, o512124529296_0_s2.a+o512124529296_0_a*o512124529296_0_s1.a));

// #output0: scale (o512376187543)
vec4 o512376187543_0_1_rgba = o512124529296_0_1_rgba;

	vec4 color_tex = o512376187543_0_1_rgba;
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	ALBEDO = color_tex.rgb;
	ALPHA = color_tex.a;
}



