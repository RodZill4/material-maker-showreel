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
// Display modes
const bool ASCII_DISPLAY = true;
const bool CUSTOM_DISPLAY = false;

// ASCII Character configurations (31-125)
// 31 reserved to display all segments

const float CHARS[] = {
	float(0xFFFF), float(0x0000), float(0x0202), float(0x0022),
    float(0xE722), float(0xE774), float(0xCF71), float(0xB1E8),
	float(0x0020), float(0x0081), float(0x0808), float(0xCCA9),
	float(0xC420), float(0x0800), float(0x8400), float(0x0000),
	float(0x0801), float(0x3B57), float(0x0203), float(0xB546),
	float(0x2746), float(0x8612), float(0xA1D4), float(0xB754),
	float(0x0246), float(0xB756), float(0xA756), float(0x4020),
	float(0x0820), float(0x8081), float(0xA500), float(0x0C08),
	float(0x4446), float(0x3576), float(0x9656), float(0x6766),
	float(0x3154), float(0x6366), float(0xB154), float(0x9054),
	float(0x3754), float(0x9612), float(0x6164), float(0x3302),
	float(0x9091), float(0x3110), float(0x121B), float(0x129A),
	float(0x3356), float(0x9456), float(0x33D6), float(0x94D6),
	float(0xA754), float(0x4064), float(0x3312), float(0x1811),
	float(0x1A92), float(0x0889), float(0xA712), float(0x2945),
	float(0x4124), float(0x0088), float(0x6060), float(0x0880),
	float(0x2100), float(0x0008), float(0xF100), float(0xF010),
	float(0xB000), float(0x4702), float(0xB800), float(0xC424),
	float(0xE070), float(0xD010), float(0x4000), float(0x7020),
	float(0x40A1), float(0x1010), float(0xD600), float(0xD000),
	float(0xF000), float(0x9070), float(0x0626), float(0x9000),
	float(0xE050), float(0xB010), float(0x7000), float(0x1800),
	float(0x1A80), float(0x0889), float(0x0722), float(0xA800),
	float(0xC124), float(0x4020), float(0x6460)
};

/*
 bit position mapping:
  _10__ __14__
 | \   |   /  |
 12 13 11 16  15
 |    \|/     |
  __1__ __6___
 |    /|\     |
 4  5  2  9   7
 | /   |   \  |
  __3__|__8___

 1  4    8   12    16
 |  |    |    |    |        
 0000 0000 0000 0000

 e.g. M = 0001 0010 0001 1011 (binary) = 4635 (dec) = 0x121B (hex) 
*/

float m(vec4 d) { return max(max(d.x,d.y),max(d.z,d.w)); }

float fs(vec2 p, float st, float sl, vec4 s14, float s5, bool sf, float da)
{
	const vec2 h = vec2(1,-1);
	da *= 0.017453;
	
	sl *= 0.1;
	st *= 0.5;
	sl = clamp(sl, 0,1);

	p = 2.0 * (p - 0.5);
	vec2 p1 = p;
	vec2 p2 = p;
	vec2 _p = p;
	
	p = abs(p) - vec2(0.25,0.4);
	
	float f = -max(p.x, p.y);
	float ism = f - st - (sl*1.625);
	float isg = min(ism, st-abs(dot(normalize(vec2(sin(da),cos(da))),_p*vec2(sf ? 1.0:-1.0 ,1.0))));
	
	float d = min(st - abs(f), min(-dot(p, normalize(h.xx)), abs(dot(p, normalize(h)))) - sl);

	p1.x = abs(p1.x); p2.y = abs(p2.y);
	p1 += vec2(0.15, 0.0); p2 -= vec2(0.0, 0.15);

	float q1 = -dot(p1,h.xx);
	float q2 = min(p2.x, -dot(p2,h.yx));
	float q3 = dot(p1, h.yx);
	float q4 = min(-p2.x, -dot(p2,h.xx));
	
	vec4 qv4 = vec4(q1,q2,q3,q4);
	qv4 = min(qv4,s14);
	
	return max(m(min(vec4(d),qv4)), min(isg,s5));
}

float i(float n, int b) { b = 16 - b; return float(mod(floor(n / exp2(floor(float(b)))), 2.0) != 0.0); }

float xvisd(vec2 uv, float st, float sl, float bevel, float a, float dps, vec2 dpo, float da, bool is_ascii, bool dp)
{
	float d;
	const vec2 b = vec2(1,0);

	int n = int(clamp(a, 31.0, 125.0) - 31.0);

	float ch = is_ascii ? CHARS[n] : a;
	float dpt = is_ascii ? (( n == 0 || n == 15 || n == 32 ) ? 1.0 : 0.0) : float(dp);
	
	st = clamp(st, 0, 1) * 0.5;

	float d1 = fs(uv+vec2(0.125, -0.2), st, sl, vec4(i(ch,1), i(ch,2), i(ch,3), i(ch,4)), i(ch,5) ,true, da );
	float d2 = fs(uv-vec2(0.125,  0.2), st, sl, vec4(i(ch,6), i(ch,7), i(ch,8), 0), i(ch,9) ,false, da);
	float d3 = fs(uv+vec2(0.125,  0.2), st, sl, vec4(i(ch,10), i(ch,11),0, i(ch,12)), i(ch,13) ,false, da);
	float d4 = fs(uv-vec2(0.125, -0.2), st, sl, vec4(i(ch,14), i(ch,15),0,0), i(ch,16), true, da);
	
	d = m(vec4(d1,d2,d3,d4));
	d = max(d,(-distance(uv-0.5,dpo)*3.0)+0.1*dps*dpt);

	return clamp(d/max(bevel, 1e-4), 0, 1);
}

float xvisd_custom(vec2 uv, float st, float sl, float bevel, float a, float dps, vec2 dpo, float da, bool dp)
{
	return xvisd(uv, st, sl, bevel, a, dps, dpo, da, CUSTOM_DISPLAY, dp);
}

float xvisd_ascii(vec2 uv, float st, float sl, float bevel, float a, float dps, vec2 dpo, float da, bool dp)
{
	return xvisd(uv, st, sl, bevel, a, dps, dpo, da, ASCII_DISPLAY, dp);
}

float all_seg(vec2 uv, float st, float sl, float dps, vec2 dpo, float da)
{
	return xvisd(uv, st, sl, 0, 31.0, dps, dpo, da, ASCII_DISPLAY, false);
}
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
const float p_o112475_albedo_color_r = 1.000000000;
const float p_o112475_albedo_color_g = 1.000000000;
const float p_o112475_albedo_color_b = 1.000000000;
const float p_o112475_albedo_color_a = 1.000000000;
const float p_o112475_metallic = 0.000000000;
const float p_o112475_roughness = 1.000000000;
const float p_o112475_emission_energy = 0.000000000;
const float p_o112475_normal = 1.000000000;
const float p_o112475_ao = 1.000000000;
const float p_o112475_depth_scale = 0.500000000;
float o112475_input_depth_tex(vec2 uv, float _seed_variation_) {

return 0.0;
}
const float p_o112513_amount = 1.000000000;
const float p_o112508_amount = 1.000000000;
const float p_o112494_min = -1.410000000;
const float p_o112494_max = 3.350000000;
const float p_o112494_step = 0.000000000;
const float p_o112493_default_in1 = 0.000000000;
const float p_o112493_default_in2 = 0.000000000;
const float p_o112476_a = 0.000000000;
const float p_o112476_sl = 0.000000000;
const float p_o112476_st = 0.240000000;
const float p_o112476_dps = 0.650000000;
const float p_o112476_dpx = 0.196945000;
const float p_o112476_dpy = 0.395530000;
const float p_o112476_da = 60.000000000;
const float p_o112476_b = 0.000000000;
const float p_o112486_min = 32.000000000;
const float p_o112486_max = 105.000000000;
const float p_o112486_step = 0.000000000;
const float p_o112517_default_in1 = 0.000000000;
const float p_o112517_default_in2 = 0.000000000;
const float p_o112514_default_in1 = 0.000000000;
const float p_o112514_default_in2 = 0.000000000;
const float p_o112516_default_in1 = 0.000000000;
const float p_o112516_default_in2 = 0.000000000;
const float p_o112515_min = -10.000000000;
const float p_o112515_max = 1.000000000;
const float p_o112515_step = 0.000000000;
const float p_o112492_default_in1 = 0.000000000;
const float p_o112492_default_in2 = 0.000000000;
const float p_o112491_default_in1 = 0.000000000;
const float p_o112491_default_in2 = 0.000000000;
const float p_o112510_default_in1 = 0.000000000;
const float p_o112510_default_in2 = 80.000000000;
const float p_o112490_default_in1 = 0.000000000;
const float p_o112490_default_in2 = 0.000000000;
const float p_o112489_default_in1 = 0.000000000;
const float p_o112489_default_in2 = 100.000000000;
const float p_o112477_translate_x = 0.000000000;
const float p_o112477_translate_y = 0.000000000;
const float p_o112477_rotate = 0.000000000;
const float p_o112477_scale_x = 1.000000000;
const float p_o112477_scale_y = 1.000000000;
const float p_o112511_default_in1 = 0.000000000;
const float p_o112481_default_in1 = 0.000000000;
const float p_o112481_default_in2 = 14.620000000;
const float seed_o112478 = 0.035656000;
const float p_o112478_edgecolor = 1.000000000;
const float p_o112480_d_in1_x = 0.000000000;
const float p_o112480_d_in1_y = 0.000000000;
const float p_o112480_d_in1_z = 0.000000000;
const float p_o112480_d_in2_x = 0.000000000;
const float p_o112480_d_in2_y = 0.000000000;
const float p_o112480_d_in2_z = 0.000000000;
const float p_o112479_d_in1_x = 0.000000000;
const float p_o112479_d_in1_y = 0.000000000;
const float p_o112479_d_in1_z = 0.000000000;
const float p_o112479_d_in2_x = 100.000000000;
const float p_o112479_d_in2_y = 0.000000000;
const float p_o112479_d_in2_z = 0.000000000;
const float p_o112519_default_in1 = 0.000000000;
const float p_o112519_default_in2 = 0.000000000;
const float p_o112518_default_in1 = 0.000000000;
const float seed_o112485 = 0.822669000;
const float p_o112485_edgecolor = 1.000000000;
const float p_o112487_d_in1_x = 0.000000000;
const float p_o112487_d_in1_y = 0.000000000;
const float p_o112487_d_in1_z = 0.000000000;
const float p_o112487_d_in2_x = 0.180000000;
const float p_o112487_d_in2_y = 0.000000000;
const float p_o112487_d_in2_z = 0.000000000;
const float p_o112484_d_in1_x = 0.000000000;
const float p_o112484_d_in1_y = 0.000000000;
const float p_o112484_d_in1_z = 0.000000000;
const float p_o112484_d_in2_x = 0.000000000;
const float p_o112484_d_in2_y = 0.000000000;
const float p_o112484_d_in2_z = 0.000000000;
const float p_o112482_d_in1_x = 0.000000000;
const float p_o112482_d_in1_y = 0.000000000;
const float p_o112482_d_in1_z = 0.000000000;
const float p_o112482_d_in2_x = 100.000000000;
const float p_o112482_d_in2_y = 100.000000000;
const float p_o112482_d_in2_z = 0.000000000;
const float p_o112483_d_in1_x = 0.000000000;
const float p_o112483_d_in1_y = 0.000000000;
const float p_o112483_d_in1_z = 0.000000000;
const float p_o112483_d_in2_x = 0.000000000;
const float p_o112483_d_in2_y = 0.000000000;
const float p_o112483_d_in2_z = 0.000000000;
const float p_o112495_gradient_0_pos = 0.510099000;
const float p_o112495_gradient_0_r = 0.000000000;
const float p_o112495_gradient_0_g = 0.000000000;
const float p_o112495_gradient_0_b = 0.000000000;
const float p_o112495_gradient_0_a = 1.000000000;
const float p_o112495_gradient_1_pos = 0.972404000;
const float p_o112495_gradient_1_r = 0.211715996;
const float p_o112495_gradient_1_g = 0.949487984;
const float p_o112495_gradient_1_b = 0.137819007;
const float p_o112495_gradient_1_a = 1.000000000;
vec4 o112495_gradient_gradient_fct(float x) {
  if (x < p_o112495_gradient_0_pos) {
    return vec4(p_o112495_gradient_0_r,p_o112495_gradient_0_g,p_o112495_gradient_0_b,p_o112495_gradient_0_a);
  } else if (x < p_o112495_gradient_1_pos) {
    return mix(vec4(p_o112495_gradient_0_r,p_o112495_gradient_0_g,p_o112495_gradient_0_b,p_o112495_gradient_0_a), vec4(p_o112495_gradient_1_r,p_o112495_gradient_1_g,p_o112495_gradient_1_b,p_o112495_gradient_1_a), ((x-p_o112495_gradient_0_pos)/(p_o112495_gradient_1_pos-p_o112495_gradient_0_pos)));
  }
  return vec4(p_o112495_gradient_1_r,p_o112495_gradient_1_g,p_o112495_gradient_1_b,p_o112495_gradient_1_a);
}
const float p_o112522_amount = 1.000000000;
const float p_o112520_amount = 1.000000000;
const float p_o112512_min = -2.390000000;
const float p_o112512_max = 0.450000000;
const float p_o112512_step = 0.000000000;
const float p_o112521_color_r = 0.061085999;
const float p_o112521_color_g = 0.632350981;
const float p_o112521_color_b = 0.140480995;
const float p_o112521_color_a = 1.000000000;
const float p_o112523_color_r = 0.000000000;
const float p_o112523_color_g = 0.000000000;
const float p_o112523_color_b = 0.000000000;
const float p_o112523_color_a = 1.000000000;


void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec4 o112477_0_1_rgba = vec4(((transform2((uv), vec2(p_o112477_translate_x*(2.0*1.0-1.0), p_o112477_translate_y*(2.0*1.0-1.0)), p_o112477_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o112477_scale_x*(2.0*1.0-1.0), p_o112477_scale_y*(2.0*1.0-1.0))))), 0.0, 1.0);
float o112488_1_1_f = o112477_0_1_rgba.g;
float o112489_0_clamp_false = o112488_1_1_f*p_o112489_default_in2;
float o112489_0_clamp_true = clamp(o112489_0_clamp_false, 0.0, 1.0);
float o112489_0_2_f = o112489_0_clamp_false;
float o112490_0_clamp_false = floor(o112489_0_2_f);
float o112490_0_clamp_true = clamp(o112490_0_clamp_false, 0.0, 1.0);
float o112490_0_1_f = o112490_0_clamp_false;
float o112510_0_clamp_false = o112490_0_1_f/p_o112510_default_in2;
float o112510_0_clamp_true = clamp(o112510_0_clamp_false, 0.0, 1.0);
float o112510_0_2_f = o112510_0_clamp_false;
vec3 o112479_0_clamp_false = ((o112477_0_1_rgba).rgb)*vec3(p_o112479_d_in2_x, p_o112479_d_in2_y, p_o112479_d_in2_z);
vec3 o112479_0_clamp_true = clamp(o112479_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112479_0_2_rgb = o112479_0_clamp_false;
vec3 o112480_0_clamp_false = floor(o112479_0_2_rgb);
vec3 o112480_0_clamp_true = clamp(o112480_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112480_0_1_rgb = o112480_0_clamp_false;
vec4 o112478_0_bb = vec4(o112480_0_1_rgb, 1.0);float o112478_0_1_f = mix(p_o112478_edgecolor, rand(vec2(float((seed_o112478+fract(_seed_variation_))), rand(vec2(rand(o112478_0_bb.xy), rand(o112478_0_bb.zw))))), step(0.0000001, dot(o112478_0_bb.zw, vec2(1.0))));
float o112481_0_clamp_false = o112478_0_1_f*p_o112481_default_in2;
float o112481_0_clamp_true = clamp(o112481_0_clamp_false, 0.0, 1.0);
float o112481_0_2_f = o112481_0_clamp_false;
float o112511_0_clamp_false = o112481_0_2_f+(elapsed_time/3.0);
float o112511_0_clamp_true = clamp(o112511_0_clamp_false, 0.0, 1.0);
float o112511_0_2_f = o112511_0_clamp_false;
float o112491_0_clamp_false = o112510_0_2_f-o112511_0_2_f;
float o112491_0_clamp_true = clamp(o112491_0_clamp_false, 0.0, 1.0);
float o112491_0_1_f = o112491_0_clamp_false;
float o112492_0_clamp_false = fract(o112491_0_1_f);
float o112492_0_clamp_true = clamp(o112492_0_clamp_false, 0.0, 1.0);
float o112492_0_1_f = o112492_0_clamp_false;
float o112515_0_x = o112492_0_1_f*(p_o112515_max-p_o112515_min);float o112515_0_1_f = p_o112515_min+o112515_0_x-mod(o112515_0_x, max(p_o112515_step, 0.00000001));
float o112516_0_clamp_false = o112515_0_1_f+p_o112516_default_in2;
float o112516_0_clamp_true = clamp(o112516_0_clamp_false, 0.0, 1.0);
float o112516_0_2_f = o112516_0_clamp_true;
float o112514_0_clamp_false = fract(o112516_0_2_f);
float o112514_0_clamp_true = clamp(o112514_0_clamp_false, 0.0, 1.0);
float o112514_0_1_f = o112514_0_clamp_false;
vec3 o112482_0_clamp_false = ((o112477_0_1_rgba).rgb)*vec3(p_o112482_d_in2_x, p_o112482_d_in2_y, p_o112482_d_in2_z);
vec3 o112482_0_clamp_true = clamp(o112482_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112482_0_2_rgb = o112482_0_clamp_false;
vec3 o112484_0_clamp_false = floor(o112482_0_2_rgb);
vec3 o112484_0_clamp_true = clamp(o112484_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112484_0_1_rgb = o112484_0_clamp_false;
vec3 o112487_0_clamp_false = o112484_0_1_rgb-vec3(p_o112487_d_in2_x, p_o112487_d_in2_y, p_o112487_d_in2_z);
vec3 o112487_0_clamp_true = clamp(o112487_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112487_0_2_rgb = o112487_0_clamp_false;
vec4 o112485_0_bb = vec4(o112487_0_2_rgb, 1.0);float o112485_0_1_f = mix(p_o112485_edgecolor, rand(vec2(float((seed_o112485+fract(_seed_variation_))), rand(vec2(rand(o112485_0_bb.xy), rand(o112485_0_bb.zw))))), step(0.0000001, dot(o112485_0_bb.zw, vec2(1.0))));
float o112518_0_clamp_false = o112485_0_1_f+(elapsed_time/100.0);
float o112518_0_clamp_true = clamp(o112518_0_clamp_false, 0.0, 1.0);
float o112518_0_2_f = o112518_0_clamp_false;
float o112519_0_clamp_false = fract(o112518_0_2_f);
float o112519_0_clamp_true = clamp(o112519_0_clamp_false, 0.0, 1.0);
float o112519_0_1_f = o112519_0_clamp_false;
float o112517_0_clamp_false = o112514_0_1_f+o112519_0_1_f;
float o112517_0_clamp_true = clamp(o112517_0_clamp_false, 0.0, 1.0);
float o112517_0_1_f = o112517_0_clamp_false;
float o112486_0_x = o112517_0_1_f*(p_o112486_max-p_o112486_min);float o112486_0_1_f = p_o112486_min+o112486_0_x-mod(o112486_0_x, max(p_o112486_step, 0.00000001));
vec3 o112483_0_clamp_false = fract(o112482_0_2_rgb);
vec3 o112483_0_clamp_true = clamp(o112483_0_clamp_false, vec3(0.0), vec3(1.0));
vec3 o112483_0_1_rgb = o112483_0_clamp_false;
float o112476_0_1_f = xvisd_ascii(o112483_0_1_rgb.xy, p_o112476_st, p_o112476_sl, p_o112476_b*1.0, (p_o112476_a == 0.0 ? o112486_0_1_f: p_o112476_a), p_o112476_dps, vec2(p_o112476_dpx, p_o112476_dpy), p_o112476_da, true);
float o112493_0_clamp_false = o112476_0_1_f*o112492_0_1_f;
float o112493_0_clamp_true = clamp(o112493_0_clamp_false, 0.0, 1.0);
float o112493_0_1_f = o112493_0_clamp_false;
float o112494_0_x = o112493_0_1_f*(p_o112494_max-p_o112494_min);float o112494_0_1_f = p_o112494_min+o112494_0_x-mod(o112494_0_x, max(p_o112494_step, 0.00000001));
vec4 o112495_0_1_rgba = o112495_gradient_gradient_fct(o112492_0_1_f);
vec4 o112508_0_s1 = vec4(vec3(o112494_0_1_f), 1.0);
vec4 o112508_0_s2 = o112495_0_1_rgba;
float o112508_0_a = p_o112508_amount*1.0;
vec4 o112508_0_2_rgba = vec4(blend_multiply((uv), o112508_0_s1.rgb, o112508_0_s2.rgb, o112508_0_a*o112508_0_s1.a), min(1.0, o112508_0_s2.a+o112508_0_a*o112508_0_s1.a));
float o112512_0_x = o112492_0_1_f*(p_o112512_max-p_o112512_min);float o112512_0_1_f = p_o112512_min+o112512_0_x-mod(o112512_0_x, max(p_o112512_step, 0.00000001));
vec4 o112521_0_1_rgba = vec4(p_o112521_color_r, p_o112521_color_g, p_o112521_color_b, p_o112521_color_a);
vec4 o112520_0_s1 = vec4(vec3(o112512_0_1_f), 1.0);
vec4 o112520_0_s2 = o112521_0_1_rgba;
float o112520_0_a = p_o112520_amount*1.0;
vec4 o112520_0_2_rgba = vec4(blend_hard_light((uv), o112520_0_s1.rgb, o112520_0_s2.rgb, o112520_0_a*o112520_0_s1.a), min(1.0, o112520_0_s2.a+o112520_0_a*o112520_0_s1.a));
vec4 o112523_0_1_rgba = vec4(p_o112523_color_r, p_o112523_color_g, p_o112523_color_b, p_o112523_color_a);
vec4 o112522_0_s1 = o112520_0_2_rgba;
vec4 o112522_0_s2 = o112523_0_1_rgba;
float o112522_0_a = p_o112522_amount*1.0;
vec4 o112522_0_2_rgba = vec4(blend_normal((uv), o112522_0_s1.rgb, o112522_0_s2.rgb, o112522_0_a*o112522_0_s1.a), min(1.0, o112522_0_s2.a+o112522_0_a*o112522_0_s1.a));
vec4 o112513_0_s1 = o112508_0_2_rgba;
vec4 o112513_0_s2 = o112522_0_2_rgba;
float o112513_0_a = p_o112513_amount*1.0;
vec4 o112513_0_2_rgba = vec4(blend_lighten((uv), o112513_0_s1.rgb, o112513_0_s2.rgb, o112513_0_a*o112513_0_s1.a), min(1.0, o112513_0_s2.a+o112513_0_a*o112513_0_s1.a));

	vec3 albedo_tex = ((o112513_0_2_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o112475_albedo_color_r, p_o112475_albedo_color_g, p_o112475_albedo_color_b, p_o112475_albedo_color_a).rgb;
	METALLIC = 1.0*p_o112475_metallic;
	ROUGHNESS = 1.0*p_o112475_roughness;
	NORMAL = vec3(0.5);
	EMISSION = vec3(0.0)*p_o112475_emission_energy;

}



