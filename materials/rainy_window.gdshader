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

float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
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
	return c2 + c1 * oppacity;
}

vec3 blend_addsub(vec2 uv, vec3 c1, vec3 c2, float oppacity) {
	return c2 + (c1 - .5) * 2.0 * oppacity;
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

const float p_o297361_albedo_color_r = 0.000000000;
const float p_o297361_albedo_color_g = 0.000000000;
const float p_o297361_albedo_color_b = 0.000000000;
const float p_o297361_albedo_color_a = 1.000000000;
const float p_o297361_metallic = 0.000000000;
const float p_o297361_roughness = 0.150000000;
const float p_o297361_emission_energy = 1.000000000;
const float p_o297361_normal = 1.000000000;
const float p_o297361_ao = 1.000000000;
const float p_o297361_depth_scale = 0.500000000;
float o297361_input_depth_tex(vec2 uv, float _seed_variation_) {

return 0.0;
}
const float p_o297930_curve_0_x = 0.000000000;
const float p_o297930_curve_0_y = 1.000000000;
const float p_o297930_curve_0_ls = -0.000000000;
const float p_o297930_curve_0_rs = -5.804174000;
const float p_o297930_curve_1_x = 0.034414999;
const float p_o297930_curve_1_y = 0.000000000;
const float p_o297930_curve_1_ls = -0.000000000;
const float p_o297930_curve_1_rs = 0.000000000;
const float p_o297930_curve_2_x = 1.000000000;
const float p_o297930_curve_2_y = 0.000000000;
const float p_o297930_curve_2_ls = -0.086102000;
const float p_o297930_curve_2_rs = 0.000000000;
float o297930_curve_curve_fct(float x) {
if (x <= p_o297930_curve_1_x) {
float dx = x - p_o297930_curve_0_x;
float d = p_o297930_curve_1_x - p_o297930_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o297930_curve_0_y;
float yac = p_o297930_curve_0_y + d*p_o297930_curve_0_rs;
float ybc = p_o297930_curve_1_y - d*p_o297930_curve_1_ls;
float y2 = p_o297930_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o297930_curve_1_x;
float d = p_o297930_curve_2_x - p_o297930_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o297930_curve_1_y;
float yac = p_o297930_curve_1_y + d*p_o297930_curve_1_rs;
float ybc = p_o297930_curve_2_y - d*p_o297930_curve_2_ls;
float y2 = p_o297930_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o297586_amount = 1.000000000;
const float p_o298030_amount = 1.000000000;
const float p_o298004_gradient_0_pos = 0.000000000;
const float p_o298004_gradient_0_r = 0.000000000;
const float p_o298004_gradient_0_g = 0.000000000;
const float p_o298004_gradient_0_b = 0.000000000;
const float p_o298004_gradient_0_a = 1.000000000;
const float p_o298004_gradient_1_pos = 1.000000000;
const float p_o298004_gradient_1_r = 0.328125000;
const float p_o298004_gradient_1_g = 0.328125000;
const float p_o298004_gradient_1_b = 0.328125000;
const float p_o298004_gradient_1_a = 1.000000000;
vec4 o298004_gradient_gradient_fct(float x) {
  if (x < p_o298004_gradient_0_pos) {
    return vec4(p_o298004_gradient_0_r,p_o298004_gradient_0_g,p_o298004_gradient_0_b,p_o298004_gradient_0_a);
  } else if (x < p_o298004_gradient_1_pos) {
    return mix(vec4(p_o298004_gradient_0_r,p_o298004_gradient_0_g,p_o298004_gradient_0_b,p_o298004_gradient_0_a), vec4(p_o298004_gradient_1_r,p_o298004_gradient_1_g,p_o298004_gradient_1_b,p_o298004_gradient_1_a), 0.5-0.5*cos(3.14159265359*(x-p_o298004_gradient_0_pos)/(p_o298004_gradient_1_pos-p_o298004_gradient_0_pos)));
  }
  return vec4(p_o298004_gradient_1_r,p_o298004_gradient_1_g,p_o298004_gradient_1_b,p_o298004_gradient_1_a);
}
const float p_o298235_amount = 0.015000000;
const float p_o298235_eps = 0.015000000;
float o298235_input_d(vec2 uv, float _seed_variation_) {
vec4 o298258_0 = textureLod(texture_1, uv, 0.0);

return (dot((o298258_0).rgb, vec3(1.0))/3.0);
}
vec2 o298235_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o298235_input_d(fract(uv+vec2(epsilon, 0.0)), _seed_variation_)-o298235_input_d(fract(uv-vec2(epsilon, 0.0)), _seed_variation_), o298235_input_d(fract(uv+vec2(0.0, epsilon)), _seed_variation_)-o298235_input_d(fract(uv-vec2(0.0, epsilon)), _seed_variation_));
}const float seed_o298019 = 0.000000000;
const float p_o298019_tx = 32.000000000;
const float p_o298019_ty = 32.000000000;
const float p_o298019_overlap = 0.000000000;
const float p_o298019_translate_x = 1.000000000;
const float p_o298019_translate_y = 1.000000000;
const float p_o298019_rotate = 0.000000000;
const float p_o298019_scale_x = 0.020000000;
const float p_o298019_scale_y = 0.020000000;
float o298019_input_in(vec2 uv, float _seed_variation_) {
vec4 o298049_0 = textureLod(texture_2, uv, 0.0);

return (dot((o298049_0).rgb, vec3(1.0))/3.0);
}
const float p_o298044_default_in1 = 0.000000000;
const float p_o298044_default_in2 = 0.000000000;
const float p_o297967_curve_0_x = 0.000000000;
const float p_o297967_curve_0_y = 0.503726006;
const float p_o297967_curve_0_ls = 0.000000000;
const float p_o297967_curve_0_rs = 69.719823000;
const float p_o297967_curve_1_x = 0.027532000;
const float p_o297967_curve_1_y = 0.943700016;
const float p_o297967_curve_1_ls = 0.000000000;
const float p_o297967_curve_1_rs = -1.098745000;
const float p_o297967_curve_2_x = 1.000000000;
const float p_o297967_curve_2_y = 0.000000000;
const float p_o297967_curve_2_ls = -0.472544000;
const float p_o297967_curve_2_rs = -0.000000000;
float o297967_curve_curve_fct(float x) {
if (x <= p_o297967_curve_1_x) {
float dx = x - p_o297967_curve_0_x;
float d = p_o297967_curve_1_x - p_o297967_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o297967_curve_0_y;
float yac = p_o297967_curve_0_y + d*p_o297967_curve_0_rs;
float ybc = p_o297967_curve_1_y - d*p_o297967_curve_1_ls;
float y2 = p_o297967_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o297967_curve_1_x;
float d = p_o297967_curve_2_x - p_o297967_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o297967_curve_1_y;
float yac = p_o297967_curve_1_y + d*p_o297967_curve_1_rs;
float ybc = p_o297967_curve_2_y - d*p_o297967_curve_2_ls;
float y2 = p_o297967_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o297966_default_in1 = 0.000000000;
const float p_o297966_default_in2 = 0.000000000;
const float p_o298001_default_in1 = 0.000000000;
const float p_o298001_default_in2 = 10.000000000;
const float p_o297965_default_in2 = 1.000000000;
const float p_o297999_default_in1 = 0.000000000;
const float p_o297999_default_in2 = 20.000000000;
float o298019_input_mask(vec2 uv, float _seed_variation_) {
vec4 o298002_0 = textureLod(texture_3, (uv), 0.0);
float o297999_0_clamp_false = (dot((o298002_0).rgb, vec3(1.0))/3.0)*p_o297999_default_in2;
float o297999_0_clamp_true = clamp(o297999_0_clamp_false, 0.0, 1.0);
float o297999_0_2_f = o297999_0_clamp_false;
float o297965_0_clamp_false = (elapsed_time)+o297999_0_2_f;
float o297965_0_clamp_true = clamp(o297965_0_clamp_false, 0.0, 1.0);
float o297965_0_2_f = o297965_0_clamp_false;
float o298001_0_clamp_false = o297965_0_2_f/p_o298001_default_in2;
float o298001_0_clamp_true = clamp(o298001_0_clamp_false, 0.0, 1.0);
float o298001_0_2_f = o298001_0_clamp_false;
float o297966_0_clamp_false = fract(o298001_0_2_f);
float o297966_0_clamp_true = clamp(o297966_0_clamp_false, 0.0, 1.0);
float o297966_0_1_f = o297966_0_clamp_false;
float o297967_0_1_f = o297967_curve_curve_fct(o297966_0_1_f);
vec4 o297631_0 = textureLod(texture_4, (uv), 0.0);
float o298044_0_clamp_false = o297967_0_1_f*(dot((o297631_0).rgb, vec3(1.0))/3.0);
float o298044_0_clamp_true = clamp(o298044_0_clamp_false, 0.0, 1.0);
float o298044_0_1_f = o298044_0_clamp_false;

return o298044_0_1_f;
}
const float p_o298028_in_min = 0.000000000;
const float p_o298028_in_max = 1.000000000;
const float p_o298028_out_min = -1.000000000;
const float p_o298028_out_max = 1.000000000;
float o298019_input_tr_x(vec2 uv, float _seed_variation_) {
vec4 o298025_0 = textureLod(texture_5, (uv), 0.0);
vec4 o298028_0_1_rgba = vec4(vec3(p_o298028_out_min)+(o298025_0.rgb-vec3(p_o298028_in_min))*vec3((p_o298028_out_max-p_o298028_out_min)/(p_o298028_in_max-p_o298028_in_min)), o298025_0.a);
float o298027_0_1_f = o298028_0_1_rgba.r;

return o298027_0_1_f;
}
float o298019_input_tr_y(vec2 uv, float _seed_variation_) {
vec4 o298025_0 = textureLod(texture_5, (uv), 0.0);
vec4 o298028_0_1_rgba = vec4(vec3(p_o298028_out_min)+(o298025_0.rgb-vec3(p_o298028_in_min))*vec3((p_o298028_out_max-p_o298028_out_min)/(p_o298028_in_max-p_o298028_in_min)), o298025_0.a);
float o298027_1_1_f = o298028_0_1_rgba.g;

return o298027_1_1_f;
}
float o298019_input_r(vec2 uv, float _seed_variation_) {

return 1.0;
}
const float p_o298277_default_in1 = 0.000000000;
const float p_o298277_default_in2 = 0.000000000;
const float p_o298260_curve_0_x = 0.000000000;
const float p_o298260_curve_0_y = 1.000000000;
const float p_o298260_curve_0_ls = 0.000000000;
const float p_o298260_curve_0_rs = 3.847856000;
const float p_o298260_curve_1_x = 0.021632999;
const float p_o298260_curve_1_y = 0.504058003;
const float p_o298260_curve_1_ls = 0.000000000;
const float p_o298260_curve_1_rs = -1.098745000;
const float p_o298260_curve_2_x = 1.000000000;
const float p_o298260_curve_2_y = 0.000000000;
const float p_o298260_curve_2_ls = -0.472544000;
const float p_o298260_curve_2_rs = -0.000000000;
float o298260_curve_curve_fct(float x) {
if (x <= p_o298260_curve_1_x) {
float dx = x - p_o298260_curve_0_x;
float d = p_o298260_curve_1_x - p_o298260_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o298260_curve_0_y;
float yac = p_o298260_curve_0_y + d*p_o298260_curve_0_rs;
float ybc = p_o298260_curve_1_y - d*p_o298260_curve_1_ls;
float y2 = p_o298260_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o298260_curve_1_x;
float d = p_o298260_curve_2_x - p_o298260_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o298260_curve_1_y;
float yac = p_o298260_curve_1_y + d*p_o298260_curve_1_rs;
float ybc = p_o298260_curve_2_y - d*p_o298260_curve_2_ls;
float y2 = p_o298260_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
const float p_o298029_in_min = 0.000000000;
const float p_o298029_in_max = 1.000000000;
const float p_o298029_out_min = 0.550000000;
const float p_o298029_out_max = 1.000000000;
float o298019_input_sc_x(vec2 uv, float _seed_variation_) {
vec4 o298002_0 = textureLod(texture_3, (uv), 0.0);
float o297999_0_clamp_false = (dot((o298002_0).rgb, vec3(1.0))/3.0)*p_o297999_default_in2;
float o297999_0_clamp_true = clamp(o297999_0_clamp_false, 0.0, 1.0);
float o297999_0_2_f = o297999_0_clamp_false;
float o297965_0_clamp_false = (elapsed_time)+o297999_0_2_f;
float o297965_0_clamp_true = clamp(o297965_0_clamp_false, 0.0, 1.0);
float o297965_0_2_f = o297965_0_clamp_false;
float o298001_0_clamp_false = o297965_0_2_f/p_o298001_default_in2;
float o298001_0_clamp_true = clamp(o298001_0_clamp_false, 0.0, 1.0);
float o298001_0_2_f = o298001_0_clamp_false;
float o297966_0_clamp_false = fract(o298001_0_2_f);
float o297966_0_clamp_true = clamp(o297966_0_clamp_false, 0.0, 1.0);
float o297966_0_1_f = o297966_0_clamp_false;
float o298260_0_1_f = o298260_curve_curve_fct(o297966_0_1_f);
vec4 o298025_0 = textureLod(texture_5, (uv), 0.0);
vec4 o298028_0_1_rgba = vec4(vec3(p_o298028_out_min)+(o298025_0.rgb-vec3(p_o298028_in_min))*vec3((p_o298028_out_max-p_o298028_out_min)/(p_o298028_in_max-p_o298028_in_min)), o298025_0.a);
float o298027_2_1_f = o298028_0_1_rgba.b;
vec4 o298029_0_1_rgba = vec4(vec3(p_o298029_out_min)+(vec4(vec3(o298027_2_1_f), 1.0).rgb-vec3(p_o298029_in_min))*vec3((p_o298029_out_max-p_o298029_out_min)/(p_o298029_in_max-p_o298029_in_min)), vec4(vec3(o298027_2_1_f), 1.0).a);
float o298277_0_clamp_false = o298260_0_1_f*(dot((o298029_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298277_0_clamp_true = clamp(o298277_0_clamp_false, 0.0, 1.0);
float o298277_0_1_f = o298277_0_clamp_false;

return o298277_0_1_f;
}
float o298019_input_sc_y(vec2 uv, float _seed_variation_) {
vec4 o298002_0 = textureLod(texture_3, (uv), 0.0);
float o297999_0_clamp_false = (dot((o298002_0).rgb, vec3(1.0))/3.0)*p_o297999_default_in2;
float o297999_0_clamp_true = clamp(o297999_0_clamp_false, 0.0, 1.0);
float o297999_0_2_f = o297999_0_clamp_false;
float o297965_0_clamp_false = (elapsed_time)+o297999_0_2_f;
float o297965_0_clamp_true = clamp(o297965_0_clamp_false, 0.0, 1.0);
float o297965_0_2_f = o297965_0_clamp_false;
float o298001_0_clamp_false = o297965_0_2_f/p_o298001_default_in2;
float o298001_0_clamp_true = clamp(o298001_0_clamp_false, 0.0, 1.0);
float o298001_0_2_f = o298001_0_clamp_false;
float o297966_0_clamp_false = fract(o298001_0_2_f);
float o297966_0_clamp_true = clamp(o297966_0_clamp_false, 0.0, 1.0);
float o297966_0_1_f = o297966_0_clamp_false;
float o298260_0_1_f = o298260_curve_curve_fct(o297966_0_1_f);
vec4 o298025_0 = textureLod(texture_5, (uv), 0.0);
vec4 o298028_0_1_rgba = vec4(vec3(p_o298028_out_min)+(o298025_0.rgb-vec3(p_o298028_in_min))*vec3((p_o298028_out_max-p_o298028_out_min)/(p_o298028_in_max-p_o298028_in_min)), o298025_0.a);
float o298027_2_1_f = o298028_0_1_rgba.b;
vec4 o298029_0_1_rgba = vec4(vec3(p_o298029_out_min)+(vec4(vec3(o298027_2_1_f), 1.0).rgb-vec3(p_o298029_in_min))*vec3((p_o298029_out_max-p_o298029_out_min)/(p_o298029_in_max-p_o298029_in_min)), vec4(vec3(o298027_2_1_f), 1.0).a);
float o298277_0_clamp_false = o298260_0_1_f*(dot((o298029_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298277_0_clamp_true = clamp(o298277_0_clamp_false, 0.0, 1.0);
float o298277_0_1_f = o298277_0_clamp_false;

return o298277_0_1_f;
}
vec4 tiler_o298019(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, float _seed, float _seed_variation_) {
	float c = 0.0;
	vec2 map_uv = vec2(0.0);
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			float mask = o298019_input_mask(fract(pos+vec2(0.5)), _seed_variation_);
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				pos = fract(pos+vec2(0.5));
				pv -= vec2(p_o298019_translate_x*o298019_input_tr_x(pos, _seed_variation_), p_o298019_translate_y*o298019_input_tr_y(pos, _seed_variation_))/tile;
				float angle = o298019_input_r(pos, _seed_variation_) * p_o298019_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv /= vec2(p_o298019_scale_x*o298019_input_sc_x(pos, _seed_variation_), p_o298019_scale_y*o298019_input_sc_y(pos, _seed_variation_));
				pv += vec2(0.5);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 seed = rand2(vec2(_seed)+pos);
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o298019_input_in(pv, false ? seed.x : 0.0)*mask;
				c = max(c, c1);
				map_uv = mix(map_uv, pos, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(map_uv, 0.0, c);
}const float p_o297562_amount = 1.000000000;
const float p_o297951_amount = 1.000000000;
const float p_o297962_translate_x = 0.030000000;
const float p_o297962_translate_y = 0.035000000;
const float p_o297962_rotate = 0.000000000;
const float p_o297962_scale_x = 1.000000000;
const float p_o297962_scale_y = 1.000000000;
const float p_o297955_translate_x = 0.000000000;
const float p_o297955_translate_y = 1.000000000;
const float p_o297955_rotate = 0.000000000;
const float p_o297955_scale_x = 1.000000000;
const float p_o297955_scale_y = 1.000000000;
const float p_o298279_default_in2 = 0.000000000;
const float p_o298280_in_min = 0.000000000;
const float p_o298280_in_max = 1.000000000;
const float p_o298280_out_min = 0.000000000;
const float p_o298280_out_max = 0.065000000;
const float p_o298281_default_in1 = 0.000000000;
const float p_o297565_translate_x = 0.030000000;
const float p_o297565_translate_y = 0.020000000;
const float p_o297565_rotate = 0.000000000;
const float p_o297565_scale_x = 1.000000000;
const float p_o297565_scale_y = 1.000000000;
const float p_o298300_translate_x = 0.000000000;
const float p_o298300_translate_y = 1.000000000;
const float p_o298300_rotate = 0.000000000;
const float p_o298300_scale_x = 1.000000000;
const float p_o298300_scale_y = 1.000000000;
const float p_o298297_default_in2 = 0.000000000;
const float p_o298298_in_min = 0.000000000;
const float p_o298298_in_max = 1.000000000;
const float p_o298298_out_min = 0.000000000;
const float p_o298298_out_max = 0.045000000;
const float p_o298296_default_in1 = 0.000000000;
const float p_o297563_translate_x = 0.030000000;
const float p_o297563_translate_y = 0.075000000;
const float p_o297563_rotate = 0.000000000;
const float p_o297563_scale_x = 1.000000000;
const float p_o297563_scale_y = 1.000000000;
const float p_o297561_translate_x = 0.000000000;
const float p_o297561_rotate = 0.000000000;
const float p_o297561_scale_x = 1.000000000;
const float p_o297561_scale_y = 1.000000000;
const float p_o297402_amount = 0.100000000;
const float p_o297926_amount = 1.000000000;
const float p_o297929_in_min_r = 0.062500000;
const float p_o297929_in_min_g = 0.062500000;
const float p_o297929_in_min_b = 0.062500000;
const float p_o297929_in_min_a = 0.000000000;
const float p_o297929_in_mid_r = 0.500000000;
const float p_o297929_in_mid_g = 0.500000000;
const float p_o297929_in_mid_b = 0.500000000;
const float p_o297929_in_mid_a = 0.500000000;
const float p_o297929_in_max_r = 1.000000000;
const float p_o297929_in_max_g = 1.000000000;
const float p_o297929_in_max_b = 1.000000000;
const float p_o297929_in_max_a = 1.000000000;
const float p_o297929_out_min_r = 0.000000000;
const float p_o297929_out_min_g = 0.000000000;
const float p_o297929_out_min_b = 0.000000000;
const float p_o297929_out_min_a = 0.000000000;
const float p_o297929_out_max_r = 1.000000000;
const float p_o297929_out_max_g = 1.000000000;
const float p_o297929_out_max_b = 1.000000000;
const float p_o297929_out_max_a = 1.000000000;
float o297402_input_in(vec2 uv, float _seed_variation_) {
vec2 o298235_0_slope = o298235_slope((uv), p_o298235_eps, _seed_variation_);
vec2 o298235_0_warp = o298235_0_slope;vec3 o298019_0_instance_uv = vec3(0.0);
vec4 o298019_0_rch = tiler_o298019(((uv)+p_o298235_amount*o298235_0_warp), vec2(p_o298019_tx, p_o298019_ty), int(p_o298019_overlap), o298019_0_instance_uv, float((seed_o298019+fract(_seed_variation_))), _seed_variation_);float o298019_0_1_f = o298019_0_rch.a;
vec4 o298235_0_1_rgba = vec4(vec3(o298019_0_1_f), 1.0);
vec4 o298004_0_1_rgba = o298004_gradient_gradient_fct((dot((o298235_0_1_rgba).rgb, vec3(1.0))/3.0));
vec4 o297618_0 = textureLod(texture_6, (uv), 0.0);
vec4 o298030_0_s1 = o298004_0_1_rgba;
vec4 o298030_0_s2 = o297618_0;
float o298030_0_a = p_o298030_amount*1.0;
vec4 o298030_0_2_rgba = vec4(blend_lighten((uv), o298030_0_s1.rgb, o298030_0_s2.rgb, o298030_0_a*o298030_0_s1.a), min(1.0, o298030_0_s2.a+o298030_0_a*o298030_0_s1.a));
vec4 o297953_0 = textureLod(texture_7, (uv), 0.0);
vec4 o298115_0 = textureLod(texture_8, (uv), 0.0);
vec4 o298303_0 = textureLod(texture_9, (fract(transform2((uv), vec2(p_o297962_translate_x*(2.0*(dot((o297953_0).rgb, vec3(1.0))/3.0)-1.0), p_o297962_translate_y*(2.0*(dot((o298115_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297962_scale_x*(2.0*1.0-1.0), p_o297962_scale_y*(2.0*1.0-1.0))))), 0.0);
float o298281_0_clamp_false = sin((dot((o298303_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o298281_0_clamp_true = clamp(o298281_0_clamp_false, 0.0, 1.0);
float o298281_0_2_f = o298281_0_clamp_false;
vec4 o298280_0_1_rgba = vec4(vec3(p_o298280_out_min)+(vec4(vec3(o298281_0_2_f), 1.0).rgb-vec3(p_o298280_in_min))*vec3((p_o298280_out_max-p_o298280_out_min)/(p_o298280_in_max-p_o298280_in_min)), vec4(vec3(o298281_0_2_f), 1.0).a);
float o298279_0_clamp_false = ((elapsed_time * 0.05))+(dot((o298280_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298279_0_clamp_true = clamp(o298279_0_clamp_false, 0.0, 1.0);
float o298279_0_2_f = o298279_0_clamp_false;
vec4 o297956_0 = textureLod(texture_10, fract(transform2((fract(transform2((uv), vec2(p_o297962_translate_x*(2.0*(dot((o297953_0).rgb, vec3(1.0))/3.0)-1.0), p_o297962_translate_y*(2.0*(dot((o298115_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297962_scale_x*(2.0*1.0-1.0), p_o297962_scale_y*(2.0*1.0-1.0))))), vec2(p_o297955_translate_x*(2.0*1.0-1.0), p_o297955_translate_y*(2.0*o298279_0_2_f-1.0)), p_o297955_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297955_scale_x*(2.0*1.0-1.0), p_o297955_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o297955_0_1_rgba = o297956_0;
vec4 o297962_0_1_rgba = o297955_0_1_rgba;
vec4 o297636_0 = textureLod(texture_11, (uv), 0.0);
vec4 o298173_0 = textureLod(texture_12, (uv), 0.0);
vec4 o298301_0 = textureLod(texture_13, (fract(transform2((uv), vec2(p_o297565_translate_x*(2.0*(dot((o297636_0).rgb, vec3(1.0))/3.0)-1.0), p_o297565_translate_y*(2.0*(dot((o298173_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297565_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297565_scale_x*(2.0*1.0-1.0), p_o297565_scale_y*(2.0*1.0-1.0))))), 0.0);
float o298296_0_clamp_false = sin((dot((o298301_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o298296_0_clamp_true = clamp(o298296_0_clamp_false, 0.0, 1.0);
float o298296_0_2_f = o298296_0_clamp_false;
vec4 o298298_0_1_rgba = vec4(vec3(p_o298298_out_min)+(vec4(vec3(o298296_0_2_f), 1.0).rgb-vec3(p_o298298_in_min))*vec3((p_o298298_out_max-p_o298298_out_min)/(p_o298298_in_max-p_o298298_in_min)), vec4(vec3(o298296_0_2_f), 1.0).a);
float o298297_0_clamp_false = ((elapsed_time * 0.05))+(dot((o298298_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298297_0_clamp_true = clamp(o298297_0_clamp_false, 0.0, 1.0);
float o298297_0_2_f = o298297_0_clamp_false;
vec4 o297640_0 = textureLod(texture_14, fract(transform2((fract(transform2((uv), vec2(p_o297565_translate_x*(2.0*(dot((o297636_0).rgb, vec3(1.0))/3.0)-1.0), p_o297565_translate_y*(2.0*(dot((o298173_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297565_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297565_scale_x*(2.0*1.0-1.0), p_o297565_scale_y*(2.0*1.0-1.0))))), vec2(p_o298300_translate_x*(2.0*1.0-1.0), p_o298300_translate_y*(2.0*o298297_0_2_f-1.0)), p_o298300_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o298300_scale_x*(2.0*1.0-1.0), p_o298300_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o298300_0_1_rgba = o297640_0;
vec4 o297565_0_1_rgba = o298300_0_1_rgba;
vec4 o297951_0_s1 = o297962_0_1_rgba;
vec4 o297951_0_s2 = o297565_0_1_rgba;
float o297951_0_a = p_o297951_amount*1.0;
vec4 o297951_0_2_rgba = vec4(blend_screen((uv), o297951_0_s1.rgb, o297951_0_s2.rgb, o297951_0_a*o297951_0_s1.a), min(1.0, o297951_0_s2.a+o297951_0_a*o297951_0_s1.a));
vec4 o297947_0 = textureLod(texture_15, (uv), 0.0);
vec4 o297949_0 = textureLod(texture_16, (uv), 0.0);
vec4 o297638_0 = textureLod(texture_17, fract(transform2((fract(transform2((uv), vec2(p_o297563_translate_x*(2.0*(dot((o297947_0).rgb, vec3(1.0))/3.0)-1.0), p_o297563_translate_y*(2.0*(dot((o297949_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297563_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297563_scale_x*(2.0*1.0-1.0), p_o297563_scale_y*(2.0*1.0-1.0))))), vec2(p_o297561_translate_x*(2.0*1.0-1.0), ((elapsed_time * 0.2))*(2.0*1.0-1.0)), p_o297561_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297561_scale_x*(2.0*1.0-1.0), p_o297561_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o297561_0_1_rgba = o297638_0;
vec4 o297563_0_1_rgba = o297561_0_1_rgba;
vec4 o297562_0_s1 = o297951_0_2_rgba;
vec4 o297562_0_s2 = o297563_0_1_rgba;
float o297562_0_a = p_o297562_amount*1.0;
vec4 o297562_0_2_rgba = vec4(blend_screen((uv), o297562_0_s1.rgb, o297562_0_s2.rgb, o297562_0_a*o297562_0_s1.a), min(1.0, o297562_0_s2.a+o297562_0_a*o297562_0_s1.a));
vec4 o297929_0_1_rgba = adjust_levels(o297562_0_2_rgba, vec4(p_o297929_in_min_r, p_o297929_in_min_g, p_o297929_in_min_b, p_o297929_in_min_a), vec4(p_o297929_in_mid_r, p_o297929_in_mid_g, p_o297929_in_mid_b, p_o297929_in_mid_a), vec4(p_o297929_in_max_r, p_o297929_in_max_g, p_o297929_in_max_b, p_o297929_in_max_a), vec4(p_o297929_out_min_r, p_o297929_out_min_g, p_o297929_out_min_b, p_o297929_out_min_a), vec4(p_o297929_out_max_r, p_o297929_out_max_g, p_o297929_out_max_b, p_o297929_out_max_a));
vec4 o297926_0_s1 = o298030_0_2_rgba;
vec4 o297926_0_s2 = o297929_0_1_rgba;
float o297926_0_a = p_o297926_amount*1.0;
vec4 o297926_0_2_rgba = vec4(blend_screen((uv), o297926_0_s1.rgb, o297926_0_s2.rgb, o297926_0_a*o297926_0_s1.a), min(1.0, o297926_0_s2.a+o297926_0_a*o297926_0_s1.a));

return (dot((o297926_0_2_rgba).rgb, vec3(1.0))/3.0);
}
vec3 nm_o297402(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o297402_input_in(uv+e.xy, _seed_variation_);
		rv += vec2(-1.0, 1.0)*o297402_input_in(uv-e.xy, _seed_variation_);
		rv += vec2(1.0, 1.0)*o297402_input_in(uv+e.xx, _seed_variation_);
		rv += vec2(-1.0, -1.0)*o297402_input_in(uv-e.xx, _seed_variation_);
		rv += vec2(2.0, 0.0)*o297402_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-2.0, 0.0)*o297402_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 2.0)*o297402_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -2.0)*o297402_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o297402_input_in(uv+e.xy, _seed_variation_);
		rv += vec2(-3.0, 3.0)*o297402_input_in(uv-e.xy, _seed_variation_);
		rv += vec2(3.0, 3.0)*o297402_input_in(uv+e.xx, _seed_variation_);
		rv += vec2(-3.0, -3.0)*o297402_input_in(uv-e.xx, _seed_variation_);
		rv += vec2(10.0, 0.0)*o297402_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-10.0, 0.0)*o297402_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 10.0)*o297402_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -10.0)*o297402_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o297402_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(-2.0, 0.0)*o297402_input_in(uv-e.xz, _seed_variation_);
		rv += vec2(0.0, 2.0)*o297402_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(0.0, -2.0)*o297402_input_in(uv-e.zx, _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o297402_input_in(uv+e.xz, _seed_variation_);
		rv += vec2(0.0, 1.0)*o297402_input_in(uv+e.zx, _seed_variation_);
		rv += vec2(-1.0, -1.0)*o297402_input_in(uv, _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}


void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec2 o298235_0_slope = o298235_slope((uv), p_o298235_eps, _seed_variation_);
vec2 o298235_0_warp = o298235_0_slope;vec3 o298019_0_instance_uv = vec3(0.0);
vec4 o298019_0_rch = tiler_o298019(((uv)+p_o298235_amount*o298235_0_warp), vec2(p_o298019_tx, p_o298019_ty), int(p_o298019_overlap), o298019_0_instance_uv, float((seed_o298019+fract(_seed_variation_))), _seed_variation_);float o298019_0_1_f = o298019_0_rch.a;
vec4 o298235_0_1_rgba = vec4(vec3(o298019_0_1_f), 1.0);
vec4 o298004_0_1_rgba = o298004_gradient_gradient_fct((dot((o298235_0_1_rgba).rgb, vec3(1.0))/3.0));
vec4 o297618_0 = textureLod(texture_6, (uv), 0.0);
vec4 o298030_0_s1 = o298004_0_1_rgba;
vec4 o298030_0_s2 = o297618_0;
float o298030_0_a = p_o298030_amount*1.0;
vec4 o298030_0_2_rgba = vec4(blend_lighten((uv), o298030_0_s1.rgb, o298030_0_s2.rgb, o298030_0_a*o298030_0_s1.a), min(1.0, o298030_0_s2.a+o298030_0_a*o298030_0_s1.a));
vec4 o297953_0 = textureLod(texture_7, (uv), 0.0);
vec4 o298115_0 = textureLod(texture_8, (uv), 0.0);
vec4 o298303_0 = textureLod(texture_9, (fract(transform2((uv), vec2(p_o297962_translate_x*(2.0*(dot((o297953_0).rgb, vec3(1.0))/3.0)-1.0), p_o297962_translate_y*(2.0*(dot((o298115_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297962_scale_x*(2.0*1.0-1.0), p_o297962_scale_y*(2.0*1.0-1.0))))), 0.0);
float o298281_0_clamp_false = sin((dot((o298303_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o298281_0_clamp_true = clamp(o298281_0_clamp_false, 0.0, 1.0);
float o298281_0_2_f = o298281_0_clamp_false;
vec4 o298280_0_1_rgba = vec4(vec3(p_o298280_out_min)+(vec4(vec3(o298281_0_2_f), 1.0).rgb-vec3(p_o298280_in_min))*vec3((p_o298280_out_max-p_o298280_out_min)/(p_o298280_in_max-p_o298280_in_min)), vec4(vec3(o298281_0_2_f), 1.0).a);
float o298279_0_clamp_false = ((elapsed_time * 0.05))+(dot((o298280_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298279_0_clamp_true = clamp(o298279_0_clamp_false, 0.0, 1.0);
float o298279_0_2_f = o298279_0_clamp_false;
vec4 o297956_0 = textureLod(texture_10, fract(transform2((fract(transform2((uv), vec2(p_o297962_translate_x*(2.0*(dot((o297953_0).rgb, vec3(1.0))/3.0)-1.0), p_o297962_translate_y*(2.0*(dot((o298115_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297962_scale_x*(2.0*1.0-1.0), p_o297962_scale_y*(2.0*1.0-1.0))))), vec2(p_o297955_translate_x*(2.0*1.0-1.0), p_o297955_translate_y*(2.0*o298279_0_2_f-1.0)), p_o297955_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297955_scale_x*(2.0*1.0-1.0), p_o297955_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o297955_0_1_rgba = o297956_0;
vec4 o297962_0_1_rgba = o297955_0_1_rgba;
vec4 o297636_0 = textureLod(texture_11, (uv), 0.0);
vec4 o298173_0 = textureLod(texture_12, (uv), 0.0);
vec4 o298301_0 = textureLod(texture_13, (fract(transform2((uv), vec2(p_o297565_translate_x*(2.0*(dot((o297636_0).rgb, vec3(1.0))/3.0)-1.0), p_o297565_translate_y*(2.0*(dot((o298173_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297565_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297565_scale_x*(2.0*1.0-1.0), p_o297565_scale_y*(2.0*1.0-1.0))))), 0.0);
float o298296_0_clamp_false = sin((dot((o298301_0).rgb, vec3(1.0))/3.0)*(elapsed_time));
float o298296_0_clamp_true = clamp(o298296_0_clamp_false, 0.0, 1.0);
float o298296_0_2_f = o298296_0_clamp_false;
vec4 o298298_0_1_rgba = vec4(vec3(p_o298298_out_min)+(vec4(vec3(o298296_0_2_f), 1.0).rgb-vec3(p_o298298_in_min))*vec3((p_o298298_out_max-p_o298298_out_min)/(p_o298298_in_max-p_o298298_in_min)), vec4(vec3(o298296_0_2_f), 1.0).a);
float o298297_0_clamp_false = ((elapsed_time * 0.05))+(dot((o298298_0_1_rgba).rgb, vec3(1.0))/3.0);
float o298297_0_clamp_true = clamp(o298297_0_clamp_false, 0.0, 1.0);
float o298297_0_2_f = o298297_0_clamp_false;
vec4 o297640_0 = textureLod(texture_14, fract(transform2((fract(transform2((uv), vec2(p_o297565_translate_x*(2.0*(dot((o297636_0).rgb, vec3(1.0))/3.0)-1.0), p_o297565_translate_y*(2.0*(dot((o298173_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297565_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297565_scale_x*(2.0*1.0-1.0), p_o297565_scale_y*(2.0*1.0-1.0))))), vec2(p_o298300_translate_x*(2.0*1.0-1.0), p_o298300_translate_y*(2.0*o298297_0_2_f-1.0)), p_o298300_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o298300_scale_x*(2.0*1.0-1.0), p_o298300_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o298300_0_1_rgba = o297640_0;
vec4 o297565_0_1_rgba = o298300_0_1_rgba;
vec4 o297951_0_s1 = o297962_0_1_rgba;
vec4 o297951_0_s2 = o297565_0_1_rgba;
float o297951_0_a = p_o297951_amount*1.0;
vec4 o297951_0_2_rgba = vec4(blend_screen((uv), o297951_0_s1.rgb, o297951_0_s2.rgb, o297951_0_a*o297951_0_s1.a), min(1.0, o297951_0_s2.a+o297951_0_a*o297951_0_s1.a));
vec4 o297947_0 = textureLod(texture_15, (uv), 0.0);
vec4 o297949_0 = textureLod(texture_16, (uv), 0.0);
vec4 o297638_0 = textureLod(texture_17, fract(transform2((fract(transform2((uv), vec2(p_o297563_translate_x*(2.0*(dot((o297947_0).rgb, vec3(1.0))/3.0)-1.0), p_o297563_translate_y*(2.0*(dot((o297949_0).rgb, vec3(1.0))/3.0)-1.0)), p_o297563_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297563_scale_x*(2.0*1.0-1.0), p_o297563_scale_y*(2.0*1.0-1.0))))), vec2(p_o297561_translate_x*(2.0*1.0-1.0), ((elapsed_time * 0.2))*(2.0*1.0-1.0)), p_o297561_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o297561_scale_x*(2.0*1.0-1.0), p_o297561_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o297561_0_1_rgba = o297638_0;
vec4 o297563_0_1_rgba = o297561_0_1_rgba;
vec4 o297562_0_s1 = o297951_0_2_rgba;
vec4 o297562_0_s2 = o297563_0_1_rgba;
float o297562_0_a = p_o297562_amount*1.0;
vec4 o297562_0_2_rgba = vec4(blend_screen((uv), o297562_0_s1.rgb, o297562_0_s2.rgb, o297562_0_a*o297562_0_s1.a), min(1.0, o297562_0_s2.a+o297562_0_a*o297562_0_s1.a));
vec4 o297586_0_s1 = o298030_0_2_rgba;
vec4 o297586_0_s2 = o297562_0_2_rgba;
float o297586_0_a = p_o297586_amount*1.0;
vec4 o297586_0_2_rgba = vec4(blend_screen((uv), o297586_0_s1.rgb, o297586_0_s2.rgb, o297586_0_a*o297586_0_s1.a), min(1.0, o297586_0_s2.a+o297586_0_a*o297586_0_s1.a));
float o297930_0_1_f = o297930_curve_curve_fct((dot((o297586_0_2_rgba).rgb, vec3(1.0))/3.0));
vec3 o297402_0_1_rgb = nm_o297402((uv), p_o297402_amount, 1024.000000000, _seed_variation_);

	vec3 albedo_tex = vec3(1.0).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o297361_albedo_color_r, p_o297361_albedo_color_g, p_o297361_albedo_color_b, p_o297361_albedo_color_a).rgb;
	METALLIC = 1.0*p_o297361_metallic;
	ROUGHNESS = o297930_0_1_f*p_o297361_roughness;
	NORMAL = o297402_0_1_rgb;
	EMISSION = vec3(0.0)*p_o297361_emission_energy;

}



