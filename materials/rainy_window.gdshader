shader_type spatial;
render_mode blend_mix,cull_back,diffuse_burley,specular_schlick_ggx
;
uniform vec3 uv1_offset = vec3(1.0, 1.0, 1.0);
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
float rand(vec2 x) {
    return fract(cos(mod(dot(x, vec2(13.9898, 8.141)), 3.14)) * 43758.5453);
}

vec2 rand2(vec2 x) {
    return fract(cos(mod(vec2(dot(x, vec2(13.9898, 8.141)),
						      dot(x, vec2(3.4562, 17.398))), vec2(3.14))) * 43758.5453);
}

vec3 rand3(vec2 x) {
    return fract(cos(mod(vec3(dot(x, vec2(13.9898, 8.141)),
							  dot(x, vec2(3.4562, 17.398)),
                              dot(x, vec2(13.254, 5.867))), vec3(3.14))) * 43758.5453);
}

float param_rnd(float minimum, float maximum, float seed) {
	return minimum+(maximum-minimum)*rand(vec2(seed));
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


uniform sampler2D texture_1;
const float texture_1_size = 1024.0;

uniform sampler2D texture_2;
const float texture_2_size = 16.0;

uniform sampler2D texture_3;
const float texture_3_size = 512.0;

uniform sampler2D texture_4;
const float texture_4_size = 1024.0;

uniform sampler2D texture_5;
const float texture_5_size = 128.0;

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

uniform sampler2D texture_6;
const float texture_6_size = 2048.0;

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
	return clamp(c2 + c1 * oppacity, vec3(0.0), vec3(1.0));
}

vec3 blend_addsub(vec2 uv, vec3 c1, vec3 c2, float oppacity) {
	return clamp(c2 + (c1 - .5) * 2.0 * oppacity, vec3(0.0), vec3(1.0));
}
uniform sampler2D texture_7;
const float texture_7_size = 128.0;

uniform sampler2D texture_8;
const float texture_8_size = 128.0;

uniform sampler2D texture_10;
const float texture_10_size = 1024.0;

uniform sampler2D texture_9;
const float texture_9_size = 512.0;

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
uniform sampler2D texture_11;
const float texture_11_size = 128.0;

uniform sampler2D texture_12;
const float texture_12_size = 128.0;

uniform sampler2D texture_14;
const float texture_14_size = 1024.0;

uniform sampler2D texture_13;
const float texture_13_size = 512.0;

uniform sampler2D texture_15;
const float texture_15_size = 128.0;

uniform sampler2D texture_16;
const float texture_16_size = 128.0;

uniform sampler2D texture_17;
const float texture_17_size = 1024.0;

vec4 adjust_levels(vec4 input, vec4 in_min, vec4 in_mid, vec4 in_max, vec4 out_min, vec4 out_max) {
	input = clamp((input-in_min)/(in_max-in_min), 0.0, 1.0);
	in_mid = (in_mid-in_min)/(in_max-in_min);
	vec4 dark = step(in_mid, input);
	input = 0.5*mix(input/(in_mid), 1.0+(input-in_mid)/(1.0-in_mid), dark);
	return out_min+input*(out_max-out_min);
}

const float p_o12449_albedo_color_r = 0.000000000;
const float p_o12449_albedo_color_g = 0.000000000;
const float p_o12449_albedo_color_b = 0.000000000;
const float p_o12449_albedo_color_a = 1.000000000;
const float p_o12449_metallic = 0.000000000;
const float p_o12449_roughness = 0.150000000;
const float p_o12449_emission_energy = 1.000000000;
const float p_o12449_normal = 1.000000000;
const float p_o12449_ao = 1.000000000;
const float p_o12449_depth_scale = 0.500000000;
float o12449_input_depth_tex(vec2 uv, float _seed_variation_) {

return 0.0;
}
const float p_o13014_curve_0_x = 0.000000000;
const float p_o13014_curve_0_y = 1.000000000;
const float p_o13014_curve_0_ls = -0.000000000;
const float p_o13014_curve_0_rs = -5.804174000;
const float p_o13014_curve_1_x = 0.034414999;
const float p_o13014_curve_1_y = 0.000000000;
const float p_o13014_curve_1_ls = -0.000000000;
const float p_o13014_curve_1_rs = 0.000000000;
const float p_o13014_curve_2_x = 1.000000000;
const float p_o13014_curve_2_y = 0.000000000;
const float p_o13014_curve_2_ls = -0.086102000;
const float p_o13014_curve_2_rs = 0.000000000;
float o13014_curve_curve_fct(float x) {
if (x <= p_o13014_curve_1_x) {
float dx = x - p_o13014_curve_0_x;
float d = p_o13014_curve_1_x - p_o13014_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13014_curve_0_y;
float yac = p_o13014_curve_0_y + d*p_o13014_curve_0_rs;
float ybc = p_o13014_curve_1_y - d*p_o13014_curve_1_ls;
float y2 = p_o13014_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o13014_curve_1_x;
float d = p_o13014_curve_2_x - p_o13014_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13014_curve_1_y;
float yac = p_o13014_curve_1_y + d*p_o13014_curve_1_rs;
float ybc = p_o13014_curve_2_y - d*p_o13014_curve_2_ls;
float y2 = p_o13014_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o12674_amount = 1.000000000;
const float p_o13114_amount = 1.000000000;
const float p_o13088_gradient_0_pos = 0.000000000;
const float p_o13088_gradient_0_r = 0.000000000;
const float p_o13088_gradient_0_g = 0.000000000;
const float p_o13088_gradient_0_b = 0.000000000;
const float p_o13088_gradient_0_a = 1.000000000;
const float p_o13088_gradient_1_pos = 1.000000000;
const float p_o13088_gradient_1_r = 0.328125000;
const float p_o13088_gradient_1_g = 0.328125000;
const float p_o13088_gradient_1_b = 0.328125000;
const float p_o13088_gradient_1_a = 1.000000000;
vec4 o13088_gradient_gradient_fct(float x) {
  if (x < p_o13088_gradient_0_pos) {
    return vec4(p_o13088_gradient_0_r,p_o13088_gradient_0_g,p_o13088_gradient_0_b,p_o13088_gradient_0_a);
  } else if (x < p_o13088_gradient_1_pos) {
    return mix(vec4(p_o13088_gradient_0_r,p_o13088_gradient_0_g,p_o13088_gradient_0_b,p_o13088_gradient_0_a), vec4(p_o13088_gradient_1_r,p_o13088_gradient_1_g,p_o13088_gradient_1_b,p_o13088_gradient_1_a), 0.5-0.5*cos(3.14159265359*(x-p_o13088_gradient_0_pos)/(p_o13088_gradient_1_pos-p_o13088_gradient_0_pos)));
  }
  return vec4(p_o13088_gradient_1_r,p_o13088_gradient_1_g,p_o13088_gradient_1_b,p_o13088_gradient_1_a);
}
const float p_o13319_amount = 0.015000000;
const float p_o13319_eps = 0.015000000;
float o13319_input_d(vec2 uv, float _seed_variation_) {
vec4 o13342_0 = textureLod(texture_1, uv, 0.0);

return (dot((o13342_0).rgb, vec3(1.0))/3.0);
}
vec2 o13319_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o13319_input_d(fract(uv+vec2(epsilon, 0.0)), _seed_variation_)-o13319_input_d(fract(uv-vec2(epsilon, 0.0)), _seed_variation_), o13319_input_d(fract(uv+vec2(0.0, epsilon)), _seed_variation_)-o13319_input_d(fract(uv-vec2(0.0, epsilon)), _seed_variation_));
}const float seed_o13103 = 0.000000000;
const float p_o13103_tx = 32.000000000;
const float p_o13103_ty = 32.000000000;
const float p_o13103_overlap = 0.000000000;
const float p_o13103_translate_x = 1.000000000;
const float p_o13103_translate_y = 1.000000000;
const float p_o13103_rotate = 0.000000000;
const float p_o13103_scale_x = 0.020000000;
const float p_o13103_scale_y = 0.020000000;
float o13103_input_in(vec2 uv, float _seed_variation_) {
vec4 o13133_0 = textureLod(texture_2, uv, 0.0);

return (dot((o13133_0).rgb, vec3(1.0))/3.0);
}
const float p_o13128_default_in1 = 0.000000000;
const float p_o13128_default_in2 = 0.000000000;
const float p_o13051_curve_0_x = 0.000000000;
const float p_o13051_curve_0_y = 0.503726006;
const float p_o13051_curve_0_ls = 0.000000000;
const float p_o13051_curve_0_rs = 69.719823000;
const float p_o13051_curve_1_x = 0.027532000;
const float p_o13051_curve_1_y = 0.943700016;
const float p_o13051_curve_1_ls = 0.000000000;
const float p_o13051_curve_1_rs = -1.098745000;
const float p_o13051_curve_2_x = 1.000000000;
const float p_o13051_curve_2_y = 0.000000000;
const float p_o13051_curve_2_ls = -0.472544000;
const float p_o13051_curve_2_rs = -0.000000000;
float o13051_curve_curve_fct(float x) {
if (x <= p_o13051_curve_1_x) {
float dx = x - p_o13051_curve_0_x;
float d = p_o13051_curve_1_x - p_o13051_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13051_curve_0_y;
float yac = p_o13051_curve_0_y + d*p_o13051_curve_0_rs;
float ybc = p_o13051_curve_1_y - d*p_o13051_curve_1_ls;
float y2 = p_o13051_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o13051_curve_1_x;
float d = p_o13051_curve_2_x - p_o13051_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13051_curve_1_y;
float yac = p_o13051_curve_1_y + d*p_o13051_curve_1_rs;
float ybc = p_o13051_curve_2_y - d*p_o13051_curve_2_ls;
float y2 = p_o13051_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o13050_default_in1 = 0.000000000;
const float p_o13050_default_in2 = 0.000000000;
const float p_o13085_default_in1 = 0.000000000;
const float p_o13085_default_in2 = 10.000000000;
const float p_o13049_default_in2 = 1.000000000;
const float p_o13083_default_in1 = 0.000000000;
const float p_o13083_default_in2 = 20.000000000;
float o13103_input_mask(vec2 uv, float _seed_variation_) {
vec4 o13086_0 = textureLod(texture_3, (uv), 0.0);
float o13083_0_clamp_false = (dot((o13086_0).rgb, vec3(1.0))/3.0)*p_o13083_default_in2;
float o13083_0_clamp_true = clamp(o13083_0_clamp_false, 0.0, 1.0);
float o13083_0_2_f = o13083_0_clamp_false;
float o13049_0_clamp_false = (elapsed_time)+o13083_0_2_f;
float o13049_0_clamp_true = clamp(o13049_0_clamp_false, 0.0, 1.0);
float o13049_0_2_f = o13049_0_clamp_false;
float o13085_0_clamp_false = o13049_0_2_f/p_o13085_default_in2;
float o13085_0_clamp_true = clamp(o13085_0_clamp_false, 0.0, 1.0);
float o13085_0_2_f = o13085_0_clamp_false;
float o13050_0_clamp_false = fract(o13085_0_2_f);
float o13050_0_clamp_true = clamp(o13050_0_clamp_false, 0.0, 1.0);
float o13050_0_1_f = o13050_0_clamp_false;
float o13051_0_1_f = o13051_curve_curve_fct(o13050_0_1_f);
vec4 o12715_0 = textureLod(texture_4, (uv), 0.0);
float o13128_0_clamp_false = o13051_0_1_f*(dot((o12715_0).rgb, vec3(1.0))/3.0);
float o13128_0_clamp_true = clamp(o13128_0_clamp_false, 0.0, 1.0);
float o13128_0_1_f = o13128_0_clamp_false;

return o13128_0_1_f;
}
const float p_o13112_in_min = 0.000000000;
const float p_o13112_in_max = 1.000000000;
const float p_o13112_out_min = -1.000000000;
const float p_o13112_out_max = 1.000000000;
float o13103_input_tr_x(vec2 uv, float _seed_variation_) {
vec4 o13109_0 = textureLod(texture_5, (uv), 0.0);
vec4 o13112_0_1_rgba = vec4(vec3(p_o13112_out_min)+(o13109_0.rgb-vec3(p_o13112_in_min))*vec3((p_o13112_out_max-p_o13112_out_min)/(p_o13112_in_max-p_o13112_in_min)), o13109_0.a);
float o13111_0_1_f = o13112_0_1_rgba.r;

return o13111_0_1_f;
}
float o13103_input_tr_y(vec2 uv, float _seed_variation_) {
vec4 o13109_0 = textureLod(texture_5, (uv), 0.0);
vec4 o13112_0_1_rgba = vec4(vec3(p_o13112_out_min)+(o13109_0.rgb-vec3(p_o13112_in_min))*vec3((p_o13112_out_max-p_o13112_out_min)/(p_o13112_in_max-p_o13112_in_min)), o13109_0.a);
float o13111_1_1_f = o13112_0_1_rgba.g;

return o13111_1_1_f;
}
float o13103_input_r(vec2 uv, float _seed_variation_) {

return 1.0;
}
const float p_o13361_default_in1 = 0.000000000;
const float p_o13361_default_in2 = 0.000000000;
const float p_o13344_curve_0_x = 0.000000000;
const float p_o13344_curve_0_y = 1.000000000;
const float p_o13344_curve_0_ls = 0.000000000;
const float p_o13344_curve_0_rs = 3.847856000;
const float p_o13344_curve_1_x = 0.021632999;
const float p_o13344_curve_1_y = 0.504058003;
const float p_o13344_curve_1_ls = 0.000000000;
const float p_o13344_curve_1_rs = -1.098745000;
const float p_o13344_curve_2_x = 1.000000000;
const float p_o13344_curve_2_y = 0.000000000;
const float p_o13344_curve_2_ls = -0.472544000;
const float p_o13344_curve_2_rs = -0.000000000;
float o13344_curve_curve_fct(float x) {
if (x <= p_o13344_curve_1_x) {
float dx = x - p_o13344_curve_0_x;
float d = p_o13344_curve_1_x - p_o13344_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13344_curve_0_y;
float yac = p_o13344_curve_0_y + d*p_o13344_curve_0_rs;
float ybc = p_o13344_curve_1_y - d*p_o13344_curve_1_ls;
float y2 = p_o13344_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o13344_curve_1_x;
float d = p_o13344_curve_2_x - p_o13344_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o13344_curve_1_y;
float yac = p_o13344_curve_1_y + d*p_o13344_curve_1_rs;
float ybc = p_o13344_curve_2_y - d*p_o13344_curve_2_ls;
float y2 = p_o13344_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o13113_in_min = 0.000000000;
const float p_o13113_in_max = 1.000000000;
const float p_o13113_out_min = 0.550000000;
const float p_o13113_out_max = 1.000000000;
float o13103_input_sc_x(vec2 uv, float _seed_variation_) {
vec4 o13086_0 = textureLod(texture_3, (uv), 0.0);
float o13083_0_clamp_false = (dot((o13086_0).rgb, vec3(1.0))/3.0)*p_o13083_default_in2;
float o13083_0_clamp_true = clamp(o13083_0_clamp_false, 0.0, 1.0);
float o13083_0_2_f = o13083_0_clamp_false;
float o13049_0_clamp_false = (elapsed_time)+o13083_0_2_f;
float o13049_0_clamp_true = clamp(o13049_0_clamp_false, 0.0, 1.0);
float o13049_0_2_f = o13049_0_clamp_false;
float o13085_0_clamp_false = o13049_0_2_f/p_o13085_default_in2;
float o13085_0_clamp_true = clamp(o13085_0_clamp_false, 0.0, 1.0);
float o13085_0_2_f = o13085_0_clamp_false;
float o13050_0_clamp_false = fract(o13085_0_2_f);
float o13050_0_clamp_true = clamp(o13050_0_clamp_false, 0.0, 1.0);
float o13050_0_1_f = o13050_0_clamp_false;
float o13344_0_1_f = o13344_curve_curve_fct(o13050_0_1_f);
vec4 o13109_0 = textureLod(texture_5, (uv), 0.0);
vec4 o13112_0_1_rgba = vec4(vec3(p_o13112_out_min)+(o13109_0.rgb-vec3(p_o13112_in_min))*vec3((p_o13112_out_max-p_o13112_out_min)/(p_o13112_in_max-p_o13112_in_min)), o13109_0.a);
float o13111_2_1_f = o13112_0_1_rgba.b;
vec4 o13113_0_1_rgba = vec4(vec3(p_o13113_out_min)+(vec4(vec3(o13111_2_1_f), 1.0).rgb-vec3(p_o13113_in_min))*vec3((p_o13113_out_max-p_o13113_out_min)/(p_o13113_in_max-p_o13113_in_min)), vec4(vec3(o13111_2_1_f), 1.0).a);
float o13361_0_clamp_false = o13344_0_1_f*(dot((o13113_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13361_0_clamp_true = clamp(o13361_0_clamp_false, 0.0, 1.0);
float o13361_0_1_f = o13361_0_clamp_false;

return o13361_0_1_f;
}
float o13103_input_sc_y(vec2 uv, float _seed_variation_) {
vec4 o13086_0 = textureLod(texture_3, (uv), 0.0);
float o13083_0_clamp_false = (dot((o13086_0).rgb, vec3(1.0))/3.0)*p_o13083_default_in2;
float o13083_0_clamp_true = clamp(o13083_0_clamp_false, 0.0, 1.0);
float o13083_0_2_f = o13083_0_clamp_false;
float o13049_0_clamp_false = (elapsed_time)+o13083_0_2_f;
float o13049_0_clamp_true = clamp(o13049_0_clamp_false, 0.0, 1.0);
float o13049_0_2_f = o13049_0_clamp_false;
float o13085_0_clamp_false = o13049_0_2_f/p_o13085_default_in2;
float o13085_0_clamp_true = clamp(o13085_0_clamp_false, 0.0, 1.0);
float o13085_0_2_f = o13085_0_clamp_false;
float o13050_0_clamp_false = fract(o13085_0_2_f);
float o13050_0_clamp_true = clamp(o13050_0_clamp_false, 0.0, 1.0);
float o13050_0_1_f = o13050_0_clamp_false;
float o13344_0_1_f = o13344_curve_curve_fct(o13050_0_1_f);
vec4 o13109_0 = textureLod(texture_5, (uv), 0.0);
vec4 o13112_0_1_rgba = vec4(vec3(p_o13112_out_min)+(o13109_0.rgb-vec3(p_o13112_in_min))*vec3((p_o13112_out_max-p_o13112_out_min)/(p_o13112_in_max-p_o13112_in_min)), o13109_0.a);
float o13111_2_1_f = o13112_0_1_rgba.b;
vec4 o13113_0_1_rgba = vec4(vec3(p_o13113_out_min)+(vec4(vec3(o13111_2_1_f), 1.0).rgb-vec3(p_o13113_in_min))*vec3((p_o13113_out_max-p_o13113_out_min)/(p_o13113_in_max-p_o13113_in_min)), vec4(vec3(o13111_2_1_f), 1.0).a);
float o13361_0_clamp_false = o13344_0_1_f*(dot((o13113_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13361_0_clamp_true = clamp(o13361_0_clamp_false, 0.0, 1.0);
float o13361_0_1_f = o13361_0_clamp_false;

return o13361_0_1_f;
}
vec4 tiler_o13103(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, float _seed, float _seed_variation_) {
	float c = 0.0;
	vec2 map_uv = vec2(0.0);
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			float mask = o13103_input_mask(fract(pos+vec2(0.5)), _seed_variation_);
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				pos = fract(pos+vec2(0.5));
				pv -= vec2(p_o13103_translate_x*o13103_input_tr_x(pos, _seed_variation_), p_o13103_translate_y*o13103_input_tr_y(pos, _seed_variation_))/tile;
				float angle = o13103_input_r(pos, _seed_variation_) * p_o13103_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv /= vec2(p_o13103_scale_x*o13103_input_sc_x(pos, _seed_variation_), p_o13103_scale_y*o13103_input_sc_y(pos, _seed_variation_));
				pv += vec2(0.5);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 seed = rand2(vec2(_seed)+pos);
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o13103_input_in(pv, false ? seed.x : 0.0)*mask;
				c = max(c, c1);
				map_uv = mix(map_uv, pos, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(map_uv, 0.0, c);
}const float p_o12650_amount = 1.000000000;
const float p_o13035_amount = 1.000000000;
const float p_o13046_translate_x = 0.030000000;
const float p_o13046_translate_y = 0.035000000;
const float p_o13046_rotate = 0.000000000;
const float p_o13046_scale_x = 1.000000000;
const float p_o13046_scale_y = 1.000000000;
const float p_o13039_translate_x = 0.000000000;
const float p_o13039_translate_y = 1.000000000;
const float p_o13039_rotate = 0.000000000;
const float p_o13039_scale_x = 1.000000000;
const float p_o13039_scale_y = 1.000000000;
const float p_o13363_default_in2 = 0.000000000;
const float p_o13364_in_min = 0.000000000;
const float p_o13364_in_max = 1.000000000;
const float p_o13364_out_min = 0.000000000;
const float p_o13364_out_max = 0.065000000;
const float p_o13365_default_in1 = 0.000000000;
const float p_o12653_translate_x = 0.030000000;
const float p_o12653_translate_y = 0.020000000;
const float p_o12653_rotate = 0.000000000;
const float p_o12653_scale_x = 1.000000000;
const float p_o12653_scale_y = 1.000000000;
const float p_o13384_translate_x = 0.000000000;
const float p_o13384_translate_y = 1.000000000;
const float p_o13384_rotate = 0.000000000;
const float p_o13384_scale_x = 1.000000000;
const float p_o13384_scale_y = 1.000000000;
const float p_o13381_default_in2 = 0.000000000;
const float p_o13382_in_min = 0.000000000;
const float p_o13382_in_max = 1.000000000;
const float p_o13382_out_min = 0.000000000;
const float p_o13382_out_max = 0.045000000;
const float p_o13380_default_in1 = 0.000000000;
const float p_o12651_translate_x = 0.030000000;
const float p_o12651_translate_y = 0.075000000;
const float p_o12651_rotate = 0.000000000;
const float p_o12651_scale_x = 1.000000000;
const float p_o12651_scale_y = 1.000000000;
const float p_o12649_translate_x = 0.000000000;
const float p_o12649_rotate = 0.000000000;
const float p_o12649_scale_x = 1.000000000;
const float p_o12649_scale_y = 1.000000000;
const float p_o12490_amount = 0.100000000;
const float p_o13010_amount = 1.000000000;
const float p_o13013_in_min_r = 0.062500000;
const float p_o13013_in_min_g = 0.062500000;
const float p_o13013_in_min_b = 0.062500000;
const float p_o13013_in_min_a = 0.000000000;
const float p_o13013_in_mid_r = 0.500000000;
const float p_o13013_in_mid_g = 0.500000000;
const float p_o13013_in_mid_b = 0.500000000;
const float p_o13013_in_mid_a = 0.500000000;
const float p_o13013_in_max_r = 1.000000000;
const float p_o13013_in_max_g = 1.000000000;
const float p_o13013_in_max_b = 1.000000000;
const float p_o13013_in_max_a = 1.000000000;
const float p_o13013_out_min_r = 0.000000000;
const float p_o13013_out_min_g = 0.000000000;
const float p_o13013_out_min_b = 0.000000000;
const float p_o13013_out_min_a = 0.000000000;
const float p_o13013_out_max_r = 1.000000000;
const float p_o13013_out_max_g = 1.000000000;
const float p_o13013_out_max_b = 1.000000000;
const float p_o13013_out_max_a = 1.000000000;
float o12490_input_in(vec2 uv, float _seed_variation_) {
vec2 o13319_0_slope = o13319_slope((uv), p_o13319_eps, _seed_variation_);
vec2 o13319_0_warp = o13319_0_slope;vec3 o13103_0_instance_uv = vec3(0.0);
vec4 o13103_0_rch = tiler_o13103(((uv)+p_o13319_amount*o13319_0_warp), vec2(p_o13103_tx, p_o13103_ty), int(p_o13103_overlap), o13103_0_instance_uv, float((seed_o13103+fract(_seed_variation_))), _seed_variation_);float o13103_0_1_f = o13103_0_rch.a;
vec4 o13319_0_1_rgba = vec4(vec3(o13103_0_1_f), 1.0);
vec4 o13088_0_1_rgba = o13088_gradient_gradient_fct((dot((o13319_0_1_rgba).rgb, vec3(1.0))/3.0));
vec4 o12706_0 = textureLod(texture_6, (uv), 0.0);
vec4 o13114_0_s1 = o13088_0_1_rgba;
vec4 o13114_0_s2 = o12706_0;
float o13114_0_a = p_o13114_amount*1.0;
vec4 o13114_0_2_rgba = vec4(blend_lighten((uv), o13114_0_s1.rgb, o13114_0_s2.rgb, o13114_0_a*o13114_0_s1.a), min(1.0, o13114_0_s2.a+o13114_0_a*o13114_0_s1.a));
vec4 o13037_0 = textureLod(texture_7, (uv), 0.0);
vec4 o13199_0 = textureLod(texture_8, (uv), 0.0);
vec4 o13387_0 = textureLod(texture_9, (fract(transform2((uv), vec2(p_o13046_translate_x*(2.0*(dot((o13037_0).rgb, vec3(1.0))/3.0)-1.0), p_o13046_translate_y*(2.0*(dot((o13199_0).rgb, vec3(1.0))/3.0)-1.0)), p_o13046_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13046_scale_x*(2.0*1.0-1.0), p_o13046_scale_y*(2.0*1.0-1.0))))), 0.0);
float o13365_0_clamp_false = sin((dot((o13387_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o13365_0_clamp_true = clamp(o13365_0_clamp_false, 0.0, 1.0);
float o13365_0_2_f = o13365_0_clamp_false;
vec4 o13364_0_1_rgba = vec4(vec3(p_o13364_out_min)+(vec4(vec3(o13365_0_2_f), 1.0).rgb-vec3(p_o13364_in_min))*vec3((p_o13364_out_max-p_o13364_out_min)/(p_o13364_in_max-p_o13364_in_min)), vec4(vec3(o13365_0_2_f), 1.0).a);
float o13363_0_clamp_false = ((elapsed_time * 0.05))+(dot((o13364_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13363_0_clamp_true = clamp(o13363_0_clamp_false, 0.0, 1.0);
float o13363_0_2_f = o13363_0_clamp_false;
vec4 o13040_0 = textureLod(texture_10, fract(transform2((fract(transform2((uv), vec2(p_o13046_translate_x*(2.0*(dot((o13037_0).rgb, vec3(1.0))/3.0)-1.0), p_o13046_translate_y*(2.0*(dot((o13199_0).rgb, vec3(1.0))/3.0)-1.0)), p_o13046_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13046_scale_x*(2.0*1.0-1.0), p_o13046_scale_y*(2.0*1.0-1.0))))), vec2(p_o13039_translate_x*(2.0*1.0-1.0), p_o13039_translate_y*(2.0*o13363_0_2_f-1.0)), p_o13039_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13039_scale_x*(2.0*1.0-1.0), p_o13039_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o13039_0_1_rgba = o13040_0;
vec4 o13046_0_1_rgba = o13039_0_1_rgba;
vec4 o12720_0 = textureLod(texture_11, (uv), 0.0);
vec4 o13257_0 = textureLod(texture_12, (uv), 0.0);
vec4 o13385_0 = textureLod(texture_13, (fract(transform2((uv), vec2(p_o12653_translate_x*(2.0*(dot((o12720_0).rgb, vec3(1.0))/3.0)-1.0), p_o12653_translate_y*(2.0*(dot((o13257_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12653_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12653_scale_x*(2.0*1.0-1.0), p_o12653_scale_y*(2.0*1.0-1.0))))), 0.0);
float o13380_0_clamp_false = sin((dot((o13385_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o13380_0_clamp_true = clamp(o13380_0_clamp_false, 0.0, 1.0);
float o13380_0_2_f = o13380_0_clamp_false;
vec4 o13382_0_1_rgba = vec4(vec3(p_o13382_out_min)+(vec4(vec3(o13380_0_2_f), 1.0).rgb-vec3(p_o13382_in_min))*vec3((p_o13382_out_max-p_o13382_out_min)/(p_o13382_in_max-p_o13382_in_min)), vec4(vec3(o13380_0_2_f), 1.0).a);
float o13381_0_clamp_false = ((elapsed_time * 0.05))+(dot((o13382_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13381_0_clamp_true = clamp(o13381_0_clamp_false, 0.0, 1.0);
float o13381_0_2_f = o13381_0_clamp_false;
vec4 o12724_0 = textureLod(texture_14, fract(transform2((fract(transform2((uv), vec2(p_o12653_translate_x*(2.0*(dot((o12720_0).rgb, vec3(1.0))/3.0)-1.0), p_o12653_translate_y*(2.0*(dot((o13257_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12653_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12653_scale_x*(2.0*1.0-1.0), p_o12653_scale_y*(2.0*1.0-1.0))))), vec2(p_o13384_translate_x*(2.0*1.0-1.0), p_o13384_translate_y*(2.0*o13381_0_2_f-1.0)), p_o13384_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13384_scale_x*(2.0*1.0-1.0), p_o13384_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o13384_0_1_rgba = o12724_0;
vec4 o12653_0_1_rgba = o13384_0_1_rgba;
vec4 o13035_0_s1 = o13046_0_1_rgba;
vec4 o13035_0_s2 = o12653_0_1_rgba;
float o13035_0_a = p_o13035_amount*1.0;
vec4 o13035_0_2_rgba = vec4(blend_screen((uv), o13035_0_s1.rgb, o13035_0_s2.rgb, o13035_0_a*o13035_0_s1.a), min(1.0, o13035_0_s2.a+o13035_0_a*o13035_0_s1.a));
vec4 o13031_0 = textureLod(texture_15, (uv), 0.0);
vec4 o13033_0 = textureLod(texture_16, (uv), 0.0);
vec4 o12722_0 = textureLod(texture_17, fract(transform2((fract(transform2((uv), vec2(p_o12651_translate_x*(2.0*(dot((o13031_0).rgb, vec3(1.0))/3.0)-1.0), p_o12651_translate_y*(2.0*(dot((o13033_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12651_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12651_scale_x*(2.0*1.0-1.0), p_o12651_scale_y*(2.0*1.0-1.0))))), vec2(p_o12649_translate_x*(2.0*1.0-1.0), ((elapsed_time * 0.2))*(2.0*1.0-1.0)), p_o12649_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12649_scale_x*(2.0*1.0-1.0), p_o12649_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o12649_0_1_rgba = o12722_0;
vec4 o12651_0_1_rgba = o12649_0_1_rgba;
vec4 o12650_0_s1 = o13035_0_2_rgba;
vec4 o12650_0_s2 = o12651_0_1_rgba;
float o12650_0_a = p_o12650_amount*1.0;
vec4 o12650_0_2_rgba = vec4(blend_screen((uv), o12650_0_s1.rgb, o12650_0_s2.rgb, o12650_0_a*o12650_0_s1.a), min(1.0, o12650_0_s2.a+o12650_0_a*o12650_0_s1.a));
vec4 o13013_0_1_rgba = adjust_levels(o12650_0_2_rgba, vec4(p_o13013_in_min_r, p_o13013_in_min_g, p_o13013_in_min_b, p_o13013_in_min_a), vec4(p_o13013_in_mid_r, p_o13013_in_mid_g, p_o13013_in_mid_b, p_o13013_in_mid_a), vec4(p_o13013_in_max_r, p_o13013_in_max_g, p_o13013_in_max_b, p_o13013_in_max_a), vec4(p_o13013_out_min_r, p_o13013_out_min_g, p_o13013_out_min_b, p_o13013_out_min_a), vec4(p_o13013_out_max_r, p_o13013_out_max_g, p_o13013_out_max_b, p_o13013_out_max_a));
vec4 o13010_0_s1 = o13114_0_2_rgba;
vec4 o13010_0_s2 = o13013_0_1_rgba;
float o13010_0_a = p_o13010_amount*1.0;
vec4 o13010_0_2_rgba = vec4(blend_screen((uv), o13010_0_s1.rgb, o13010_0_s2.rgb, o13010_0_a*o13010_0_s1.a), min(1.0, o13010_0_s2.a+o13010_0_a*o13010_0_s1.a));

return (dot((o13010_0_2_rgba).rgb, vec3(1.0))/3.0);
}
vec3 nm_o12490(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o12490_input_in(uv+e.xy, _seed_variation_);
		rv += vec2(-1.0, 1.0)*o12490_input_in(uv-e.xy, _seed_variation_);
		rv += vec2(1.0, 1.0)*o12490_input_in(uv+e.xx, _seed_variation_);
		rv += vec2(-1.0, -1.0)*o12490_input_in(uv-e.xx, _seed_variation_);
		rv += vec2(2.0, 0.0)*o12490_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-2.0, 0.0)*o12490_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 2.0)*o12490_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -2.0)*o12490_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o12490_input_in(uv+e.xy, _seed_variation_);
		rv += vec2(-3.0, 3.0)*o12490_input_in(uv-e.xy, _seed_variation_);
		rv += vec2(3.0, 3.0)*o12490_input_in(uv+e.xx, _seed_variation_);
		rv += vec2(-3.0, -3.0)*o12490_input_in(uv-e.xx, _seed_variation_);
		rv += vec2(10.0, 0.0)*o12490_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-10.0, 0.0)*o12490_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 10.0)*o12490_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -10.0)*o12490_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o12490_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-2.0, 0.0)*o12490_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 2.0)*o12490_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -2.0)*o12490_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o12490_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(0.0, 1.0)*o12490_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(-1.0, -1.0)*o12490_input_in(uv, _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}


void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec2 o13319_0_slope = o13319_slope((uv), p_o13319_eps, _seed_variation_);
vec2 o13319_0_warp = o13319_0_slope;vec3 o13103_0_instance_uv = vec3(0.0);
vec4 o13103_0_rch = tiler_o13103(((uv)+p_o13319_amount*o13319_0_warp), vec2(p_o13103_tx, p_o13103_ty), int(p_o13103_overlap), o13103_0_instance_uv, float((seed_o13103+fract(_seed_variation_))), _seed_variation_);float o13103_0_1_f = o13103_0_rch.a;
vec4 o13319_0_1_rgba = vec4(vec3(o13103_0_1_f), 1.0);
vec4 o13088_0_1_rgba = o13088_gradient_gradient_fct((dot((o13319_0_1_rgba).rgb, vec3(1.0))/3.0));
vec4 o12706_0 = textureLod(texture_6, (uv), 0.0);
vec4 o13114_0_s1 = o13088_0_1_rgba;
vec4 o13114_0_s2 = o12706_0;
float o13114_0_a = p_o13114_amount*1.0;
vec4 o13114_0_2_rgba = vec4(blend_lighten((uv), o13114_0_s1.rgb, o13114_0_s2.rgb, o13114_0_a*o13114_0_s1.a), min(1.0, o13114_0_s2.a+o13114_0_a*o13114_0_s1.a));
vec4 o13037_0 = textureLod(texture_7, (uv), 0.0);
vec4 o13199_0 = textureLod(texture_8, (uv), 0.0);
vec4 o13387_0 = textureLod(texture_9, (fract(transform2((uv), vec2(p_o13046_translate_x*(2.0*(dot((o13037_0).rgb, vec3(1.0))/3.0)-1.0), p_o13046_translate_y*(2.0*(dot((o13199_0).rgb, vec3(1.0))/3.0)-1.0)), p_o13046_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13046_scale_x*(2.0*1.0-1.0), p_o13046_scale_y*(2.0*1.0-1.0))))), 0.0);
float o13365_0_clamp_false = sin((dot((o13387_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o13365_0_clamp_true = clamp(o13365_0_clamp_false, 0.0, 1.0);
float o13365_0_2_f = o13365_0_clamp_false;
vec4 o13364_0_1_rgba = vec4(vec3(p_o13364_out_min)+(vec4(vec3(o13365_0_2_f), 1.0).rgb-vec3(p_o13364_in_min))*vec3((p_o13364_out_max-p_o13364_out_min)/(p_o13364_in_max-p_o13364_in_min)), vec4(vec3(o13365_0_2_f), 1.0).a);
float o13363_0_clamp_false = ((elapsed_time * 0.05))+(dot((o13364_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13363_0_clamp_true = clamp(o13363_0_clamp_false, 0.0, 1.0);
float o13363_0_2_f = o13363_0_clamp_false;
vec4 o13040_0 = textureLod(texture_10, fract(transform2((fract(transform2((uv), vec2(p_o13046_translate_x*(2.0*(dot((o13037_0).rgb, vec3(1.0))/3.0)-1.0), p_o13046_translate_y*(2.0*(dot((o13199_0).rgb, vec3(1.0))/3.0)-1.0)), p_o13046_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13046_scale_x*(2.0*1.0-1.0), p_o13046_scale_y*(2.0*1.0-1.0))))), vec2(p_o13039_translate_x*(2.0*1.0-1.0), p_o13039_translate_y*(2.0*o13363_0_2_f-1.0)), p_o13039_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13039_scale_x*(2.0*1.0-1.0), p_o13039_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o13039_0_1_rgba = o13040_0;
vec4 o13046_0_1_rgba = o13039_0_1_rgba;
vec4 o12720_0 = textureLod(texture_11, (uv), 0.0);
vec4 o13257_0 = textureLod(texture_12, (uv), 0.0);
vec4 o13385_0 = textureLod(texture_13, (fract(transform2((uv), vec2(p_o12653_translate_x*(2.0*(dot((o12720_0).rgb, vec3(1.0))/3.0)-1.0), p_o12653_translate_y*(2.0*(dot((o13257_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12653_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12653_scale_x*(2.0*1.0-1.0), p_o12653_scale_y*(2.0*1.0-1.0))))), 0.0);
float o13380_0_clamp_false = sin((dot((o13385_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o13380_0_clamp_true = clamp(o13380_0_clamp_false, 0.0, 1.0);
float o13380_0_2_f = o13380_0_clamp_false;
vec4 o13382_0_1_rgba = vec4(vec3(p_o13382_out_min)+(vec4(vec3(o13380_0_2_f), 1.0).rgb-vec3(p_o13382_in_min))*vec3((p_o13382_out_max-p_o13382_out_min)/(p_o13382_in_max-p_o13382_in_min)), vec4(vec3(o13380_0_2_f), 1.0).a);
float o13381_0_clamp_false = ((elapsed_time * 0.05))+(dot((o13382_0_1_rgba).rgb, vec3(1.0))/3.0);
float o13381_0_clamp_true = clamp(o13381_0_clamp_false, 0.0, 1.0);
float o13381_0_2_f = o13381_0_clamp_false;
vec4 o12724_0 = textureLod(texture_14, fract(transform2((fract(transform2((uv), vec2(p_o12653_translate_x*(2.0*(dot((o12720_0).rgb, vec3(1.0))/3.0)-1.0), p_o12653_translate_y*(2.0*(dot((o13257_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12653_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12653_scale_x*(2.0*1.0-1.0), p_o12653_scale_y*(2.0*1.0-1.0))))), vec2(p_o13384_translate_x*(2.0*1.0-1.0), p_o13384_translate_y*(2.0*o13381_0_2_f-1.0)), p_o13384_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o13384_scale_x*(2.0*1.0-1.0), p_o13384_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o13384_0_1_rgba = o12724_0;
vec4 o12653_0_1_rgba = o13384_0_1_rgba;
vec4 o13035_0_s1 = o13046_0_1_rgba;
vec4 o13035_0_s2 = o12653_0_1_rgba;
float o13035_0_a = p_o13035_amount*1.0;
vec4 o13035_0_2_rgba = vec4(blend_screen((uv), o13035_0_s1.rgb, o13035_0_s2.rgb, o13035_0_a*o13035_0_s1.a), min(1.0, o13035_0_s2.a+o13035_0_a*o13035_0_s1.a));
vec4 o13031_0 = textureLod(texture_15, (uv), 0.0);
vec4 o13033_0 = textureLod(texture_16, (uv), 0.0);
vec4 o12722_0 = textureLod(texture_17, fract(transform2((fract(transform2((uv), vec2(p_o12651_translate_x*(2.0*(dot((o13031_0).rgb, vec3(1.0))/3.0)-1.0), p_o12651_translate_y*(2.0*(dot((o13033_0).rgb, vec3(1.0))/3.0)-1.0)), p_o12651_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12651_scale_x*(2.0*1.0-1.0), p_o12651_scale_y*(2.0*1.0-1.0))))), vec2(p_o12649_translate_x*(2.0*1.0-1.0), ((elapsed_time * 0.2))*(2.0*1.0-1.0)), p_o12649_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o12649_scale_x*(2.0*1.0-1.0), p_o12649_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o12649_0_1_rgba = o12722_0;
vec4 o12651_0_1_rgba = o12649_0_1_rgba;
vec4 o12650_0_s1 = o13035_0_2_rgba;
vec4 o12650_0_s2 = o12651_0_1_rgba;
float o12650_0_a = p_o12650_amount*1.0;
vec4 o12650_0_2_rgba = vec4(blend_screen((uv), o12650_0_s1.rgb, o12650_0_s2.rgb, o12650_0_a*o12650_0_s1.a), min(1.0, o12650_0_s2.a+o12650_0_a*o12650_0_s1.a));
vec4 o12674_0_s1 = o13114_0_2_rgba;
vec4 o12674_0_s2 = o12650_0_2_rgba;
float o12674_0_a = p_o12674_amount*1.0;
vec4 o12674_0_2_rgba = vec4(blend_screen((uv), o12674_0_s1.rgb, o12674_0_s2.rgb, o12674_0_a*o12674_0_s1.a), min(1.0, o12674_0_s2.a+o12674_0_a*o12674_0_s1.a));
float o13014_0_1_f = o13014_curve_curve_fct((dot((o12674_0_2_rgba).rgb, vec3(1.0))/3.0));
vec3 o12490_0_1_rgb = nm_o12490((uv), p_o12490_amount, 1024.000000000, _seed_variation_);

	vec3 albedo_tex = vec3(1.0).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o12449_albedo_color_r, p_o12449_albedo_color_g, p_o12449_albedo_color_b, p_o12449_albedo_color_a).rgb;
	METALLIC = 1.0*p_o12449_metallic;
	ROUGHNESS = o13014_0_1_f*p_o12449_roughness;
	NORMAL = o12490_0_1_rgb;
	EMISSION = vec3(0.0)*p_o12449_emission_energy;

}



