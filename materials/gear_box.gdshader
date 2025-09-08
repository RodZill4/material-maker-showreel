shader_type spatial;
uniform float seed_variation = 0.0;

uniform bool ambient_occlusion = true;
uniform bool shadow = true;
uniform float ao_samples : hint_range(16,256,1) = 32.0;
uniform float ao_spread = 0.07;
uniform float ao_strength = 2.34;
uniform float shadow_samples : hint_range(16,256,1) = 32.0;
uniform float shadow_mix = 0.71;
uniform float shadow_min_dist = 0.0;
uniform float shadow_max_dist = 8.0;
uniform float light_size : hint_range(0.0,1.0,0.001) = 0.0;
uniform vec3 light_direction = vec3(0.03,4.0,-0.74);
varying float elapsed_time;
varying vec3 world_camera;
varying vec3 world_position;

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
const float o642382835712_height = 0.030000000;
const float p_o642080845806_sha_iter = 32.000000000;
const float p_o642080845806_sha_mint = 0.000000000;
const float p_o642080845806_sha_maxt = 8.000000000;
const float p_o642080845806_sha_mix = 0.710000000;
const float p_o642080845806_ao_iter = 32.000000000;
const float p_o642080845806_ao_max_dist = 0.070000000;
const float p_o642080845806_ao_falloff = 2.340000000;
const float p_o642080845806_ldx = 0.030000000;
const float p_o642080845806_ldy = 4.000000000;
const float p_o642080845806_ldz = -0.740000000;
const float p_o642080845806_lw = 0.000000000;
const float p_o643305582632_c1 = 0.250000000;
const float p_o643288805415_x = 0.000000000;
const float p_o643288805415_y = -0.340900000;
const float p_o643288805415_z = 0.000000000;
const float p_o643389468717_l = 0.013300000;
const float p_o643389468717_r = 0.489000000;
const float p_o642701602828_ax = 90.000000000;
const float p_o642701602828_ay = 0.000000000;
const float p_o642701602828_az = 0.000000000;
const float p_o642768711697_ax = 0.000000000;
const float p_o642768711697_ay = 0.000000000;
const float p_o642768711697_az = 180.000000000;
const float p_o642735157263_default_in1 = 0.000000000;
const float p_o642735157263_default_in2 = 0.000000000;
const float p_o642684825608_default_in1 = 0.000000000;
const float p_o642684825608_default_in2 = -1.000000000;
const float p_o642785488914_default_in1 = 0.000000000;
const float p_o642785488914_default_in2 = -1.000000000;
const float p_o643255250980_min = 0.510000000;
const float p_o643255250980_max = 0.621000000;
const float p_o643255250980_step = 0.000000000;
const float p_o642483499014_g_pos[2] = float[]( 0.000000000, 0.461261570 );
const vec4 p_o642483499014_g_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o642751934480_default_in1 = 0.000000000;
const float p_o643238473760_min = -1.000000000;
const float p_o643238473760_max = 1.000000000;
const float p_o643238473760_step = 0.000000000;
const float p_o642819043348_l = 0.300000000;
const float p_o642819043348_r = 0.025300000;
const float p_o642449944580_x = 0.000000000;
const float p_o642449944580_y = 0.000000000;
const float p_o642449944580_z = 0.280000000;
const float p_o642399612929_s = 0.675000000;
const float p_o642181509108_r = 0.001800000;
const float p_o642282172410_k1 = 0.000000000;
const float p_o642282172410_k2 = 0.000000000;
const float p_o642282172410_k3 = 0.000000000;
const float p_o642282172410_k4 = 0.005000000;
const float p_o642282172410_k5 = 0.005000000;
const float p_o642298949627_d = 0.144400000;
const float p_o642315726844_w = 0.023300000;
const float p_o642315726844_cx = 0.000000000;
const float p_o642315726844_cy = 0.000000000;
const float p_o642265395193_x = 0.000000000;
const float p_o642265395193_y = 0.000000000;
const float p_o642265395193_z = 0.113900000;
const float p_o642248617976_R = 0.331300000;
const float p_o642248617976_r = 0.037200000;
const float seed_o642231840759 = 0.000000000;
const float p_o642231840759_c = 3.000000000;
const float p_o642869374999_sx = 0.015900000;
const float p_o642869374999_sy = 0.344400000;
const float p_o642869374999_sz = 0.020200000;
const float p_o642869374999_r = 0.004500000;
const float p_o642215063542_d = 0.143200000;
const float p_o642198286325_w = 0.050000000;
const float p_o642198286325_cx = 0.000000000;
const float p_o642198286325_cy = 0.000000000;
const float p_o642131177457_d = 0.319600000;
const float seed_o642097623023 = 0.000000000;
const float p_o642097623023_c = 15.000000000;
const float p_o642114400240_x = 0.000000000;
const float p_o642114400240_y = 0.372900000;
const float p_o642114400240_z = 0.000000000;
const float p_o642147954674_width = 0.044200000;
const float p_o642147954674_height = 0.065700000;
const float p_o642147954674_top_left = 0.000000000;
const float p_o642147954674_top_right = 0.000000000;
const float p_o642147954674_bottom_left = 0.012500000;
const float p_o642147954674_bottom_right = 0.012500000;
const float p_o642147954674_center_x = 0.000000000;
const float p_o642147954674_center_y = 0.000000000;
const float p_o642986815514_c1 = 0.500000000;
const float p_o642466721797_ax = 0.000000000;
const float p_o642466721797_ay = 0.000000000;
const float p_o642466721797_az = 180.000000000;
const float p_o642718380046_default_in1 = 0.000000000;
const float p_o642718380046_default_in2 = 0.000000000;
const float p_o642651271175_default_in1 = 0.000000000;
const float p_o642651271175_default_in2 = 1.000000000;
const vec4 p_o642416390146_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o643272028198_d_in1_x = 0.000000000;
const float p_o643272028198_d_in1_y = 0.000000000;
const float p_o643272028198_d_in1_z = 0.000000000;
const float p_o643272028198_d_in2_x = 3.000000000;
const float p_o643272028198_d_in2_y = 3.000000000;
const float p_o643272028198_d_in2_z = 3.000000000;
const float p_o643003592732_v1 = 0.500000000;
const float p_o643003592732_t1 = 0.010000000;
const float p_o643003592732_v2 = 0.250000000;
const float p_o643003592732_t2 = 0.010000000;
const float p_o643355914283_ax = 90.000000000;
const float p_o643355914283_ay = 0.000000000;
const float p_o643355914283_az = 0.000000000;
const float p_o643372691500_min = 0.058500000;
const float p_o643372691500_max = 0.100000000;
const float p_o643372691500_step = 0.000000000;
const float p_o643339137066_x_scale = 8.000000000;
const float p_o643339137066_y_scale = 8.000000000;
const float p_o642970038299_ax = 0.000000000;
const float p_o642970038299_ay = 0.000000000;
const float p_o642970038299_az = 180.000000000;
const float seed_o643674681400 = 0.000000000;
const float p_o643674681400_sx = 1.000000000;
const float p_o643674681400_sy = 1.000000000;
const float p_o643674681400_rotate = 0.000000000;
const float p_o643674681400_scale = 0.000000000;
const float p_o643657904183_amount1 = 1.000000000;
const float p_o643691458617_repeat = 1.000000000;
const float p_o643691458617_rotate = 0.000000000;
const float p_o643691458617_gradient_pos[2] = float[]( 0.276037365, 1.000000000 );
const vec4 p_o643691458617_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o643909562429_r = 0.450000000;
const float p_o643909562429_g = 0.066000000;
const float p_o643909562429_b = 0.047000000;
const float p_o644043780164_r = 0.000000000;
const float p_o644043780164_g = 0.000000000;
const float p_o644043780164_b = 0.000000000;
const float p_o643406245934_amount = 0.400000000;
const float p_o643406245934_eps = 0.100000000;
const float seed_o642886152216 = 0.074066281;
const float p_o642886152216_scale_x = 2.000000000;
const float p_o642886152216_scale_y = 2.000000000;
const float p_o642886152216_folds = 0.000000000;
const float p_o642886152216_iterations = 6.000000000;
const float p_o642886152216_persistence = 0.650000000;
const float p_o642886152216_offset = 0.000000000;
const float p_o643020369949_ax = 0.000000000;
const float p_o643020369949_ay = 180.000000000;
const float p_o643020369949_az = 0.000000000;
const float p_o643204919327_default_in1 = 0.000000000;
const float p_o643221696545_min = -1.000000000;
const float p_o643221696545_max = 1.000000000;
const float p_o643221696545_step = 0.000000000;
const float p_o643037147166_g_pos[2] = float[]( 0.000000000, 0.461261570 );
const vec4 p_o643037147166_g_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float seed_o644681314370 = 0.000000000;
const float p_o644681314370_sx = 1.000000000;
const float p_o644681314370_sy = 1.000000000;
const float p_o644681314370_rotate = 0.000000000;
const float p_o644681314370_scale = 0.000000000;
const float p_o644664537155_amount1 = 1.000000000;
const float p_o644698091578_repeat = 1.000000000;
const float p_o644698091578_rotate = 0.000000000;
const float p_o644698091578_gradient_pos[2] = float[]( 0.276037365, 1.000000000 );
const vec4 p_o644698091578_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o644916195404_r = 0.082000000;
const float p_o644916195404_g = 0.141000000;
const float p_o644916195404_b = 0.176000000;
const float p_o645050413139_r = 0.000000000;
const float p_o645050413139_g = 0.000000000;
const float p_o645050413139_b = 0.000000000;
const float p_o643540463665_ax = 90.000000000;
const float p_o643540463665_ay = 0.000000000;
const float p_o643540463665_az = 0.000000000;
// #globals: sdf3d_boolean (o642668048393)
vec2 sdf3dc_union(vec2 a, vec2 b) {
	return vec2(min(a.x, b.x), mix(b.y, a.y, step(a.x, b.x)));
}
vec2 sdf3dc_sub(vec2 a, vec2 b) {
	return vec2(max(-a.x, b.x), a.y);
}
vec2 sdf3dc_inter(vec2 a, vec2 b) {
	return vec2(max(a.x, b.x), mix(a.y, b.y, step(a.x, b.x)));
}
// #globals: sdf3d_color_2 (o643305582632)
// #globals: sdf3d_cylinder_3 (o643389468717)
float sdCylinder(vec3 p, float h, float r) {
	vec2 d = abs(vec2(length(p.xz), p.y)) - vec2(r, h);
	return min(max(d.x, d.y),0.0) + length(max(d, 0.0));
}
// #globals: sdf3d_rotate_3 (o642701602828)
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
// #globals: math_6 (o642735157263)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: sdf3d_smoothboolean (o642282172410)
vec2 sdf3d_smooth_union(vec2 d1, vec2 d2, float k) {
	float h = clamp(0.5+0.5*(d2.x-d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, d1.x, h)-k*h*(1.0-h), mix(d2.y, d1.y, step(d1.x, d2.x)));
}
vec2 sdf3d_smooth_subtraction(vec2 d1, vec2 d2, float k ) {
	float h = clamp(0.5-0.5*(d2.x+d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, -d1.x, h )+k*h*(1.0-h), d2.y);
}
vec2 sdf3d_smooth_intersection(vec2 d1, vec2 d2, float k ) {
	float h = clamp(0.5-0.5*(d2.x-d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, d1.x, h)+k*h*(1.0-h), mix(d1.y, d2.y, step(d1.x, d2.x)));
}
// #globals: sdbox_3 (o642315726844)
float sd_box(vec2 uv, vec2 size) {
	vec2 d = abs(uv)-size;
	return length(max(d, vec2(0)))+min(max(d.x, d.y), 0.0);
}
// #globals: sdf3d_torus (o642248617976)
float sdTorus(vec3 p, vec2 t) {
  vec2 q = vec2(length(p.xz)-t.x,p.y);
  return length(q)-t.y;
}
// #globals: sdf3d_box (o642869374999)
float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
}
// #globals: sdf3d_circle_repeat_2 (o642231840759)
vec3 circle_repeat_transform(vec3 p, float count) {
	float r = 6.28318530718/count;
	float pa = atan(p.x, p.y);
	float a = mod(pa+0.5*r, r)-0.5*r;
	vec3 rv;
	float c = cos(a-pa);
	float s = sin(a-pa);
	rv.x = p.x*c+p.y*s;
	rv.y = -p.x*s+p.y*c;
	rv.z = p.z;
	return rv;
}
// #globals: sdroundedbox (o642147954674)
float sdRoundedBox( in vec2 p, in vec2 b, in vec4 r )
{
	r.xy = (p.x>0.0)?r.xy : r.zw;
	r.x  = (p.y>0.0)?r.x  : r.y;
	vec2 q = abs(p)-b+r.x;
	return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - r.x;
}
// #globals: tex3d_rotate_3 (o643355914283)
vec3 tex3d_rotate(vec3 p, vec3 a) {
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
// #globals: pattern (o643339137066)
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
// #globals: graph_3/blend2_3 (o643657904183)
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
// #globals: graph_3/custom_uv (o643674681400)
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
// #globals: fbm3 (o642886152216)
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
vec4 o642483499014_g_gradient_fct(float x) {
  if (x < p_o642483499014_g_pos[1]) {
    return p_o642483499014_g_col[0];
  }
  return p_o642483499014_g_col[1];
}
vec2 o642231840759_input_in(vec3 p, float _seed_variation_) {
// #output0: sdf3d_box (o642869374999)
float o642869374999_0_1_sdf3d = box3d(p, vec3(p_o642869374999_sx, p_o642869374999_sy, p_o642869374999_sz))-p_o642869374999_r;
return vec2(o642869374999_0_1_sdf3d, 0.0);
}
vec2 o642097623023_input_in(vec3 p, float _seed_variation_) {
// #output0: sdroundedbox (o642147954674)
float o642147954674_0_1_sdf2d = sdRoundedBox(((p-vec3(p_o642114400240_x, p_o642114400240_y, p_o642114400240_z)).xyz.xy+vec2(0.5))-0.5-vec2(p_o642147954674_center_x, p_o642147954674_center_y), vec2(p_o642147954674_width, p_o642147954674_height), min(vec4(p_o642147954674_bottom_right, p_o642147954674_top_right, p_o642147954674_bottom_left, p_o642147954674_top_left), min(p_o642147954674_width, p_o642147954674_height)));
// #code: sdf3d_extrusion2 (o642164731891)
vec2 o642164731891_0_w = vec2(o642147954674_0_1_sdf2d,abs((p-vec3(p_o642114400240_x, p_o642114400240_y, p_o642114400240_z)).xyz.z)-(o642382835712_height));
// #output0: sdf3d_extrusion2 (o642164731891)
float o642164731891_0_1_sdf3d = min(max(o642164731891_0_w.x,o642164731891_0_w.y),0.0)+length(max(o642164731891_0_w,0.0));
// #output0: sdf3d_translate_3_2 (o642114400240)
vec2 o642114400240_0_1_sdf3dc = vec2(o642164731891_0_1_sdf3d, 0.0);
return o642114400240_0_1_sdf3dc;
}
vec2 o642080845806_input_distance(vec3 p, float _seed_variation_) {
// #output0: sdf3d_cylinder_3 (o643389468717)
float o643389468717_0_1_sdf3d = sdCylinder(((p)-vec3(p_o643288805415_x, p_o643288805415_y, p_o643288805415_z)), p_o643389468717_l, p_o643389468717_r);
// #output0: sdf3d_translate_3_3 (o643288805415)
vec2 o643288805415_0_1_sdf3dc = vec2(o643389468717_0_1_sdf3d, 0.0);
// #output0: sdf3d_color_2 (o643305582632)
vec2 o643305582632_0_1_sdf3dc = vec2((o643288805415_0_1_sdf3dc).x, p_o643305582632_c1);
// #output0: tex3d_colorize_2 (o642483499014)
vec3 o642483499014_0_1_tex3d = o642483499014_g_gradient_fct(dot(vec3((-(rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)).zyx).x+0.5), vec3(1.0))/3.0).rgb;
// #code: remap_3 (o643255250980)
float o643255250980_0_x = (dot(o642483499014_0_1_tex3d, vec3(1.0))/3.0)*(p_o643255250980_max-p_o643255250980_min);
// #output0: remap_3 (o643255250980)
float o643255250980_0_1_tex3d_gs = p_o643255250980_min+o643255250980_0_x-mod(o643255250980_0_x, max(p_o643255250980_step, 0.00000001));
// #code: remap_2 (o643238473760)
float o643238473760_0_x = (dot(o642483499014_0_1_tex3d, vec3(1.0))/3.0)*(p_o643238473760_max-p_o643238473760_min);
// #output0: remap_2 (o643238473760)
float o643238473760_0_1_tex3d_gs = p_o643238473760_min+o643238473760_0_x-mod(o643238473760_0_x, max(p_o643238473760_step, 0.00000001));
// #code: math_7 (o642751934480)
float o642751934480_0_clamp_false = o643238473760_0_1_tex3d_gs*(elapsed_time*0.25);
float o642751934480_0_clamp_true = clamp(o642751934480_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o642751934480)
float o642751934480_0_1_tex3d_gs = o642751934480_0_clamp_false;
// #code: math_8 (o642785488914)
float o642785488914_0_clamp_false = o642751934480_0_1_tex3d_gs-o643255250980_0_1_tex3d_gs;
float o642785488914_0_clamp_true = clamp(o642785488914_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o642785488914)
float o642785488914_0_1_tex3d_gs = o642785488914_0_clamp_false;
// #code: math_4 (o642684825608)
float o642684825608_0_clamp_false = o642785488914_0_1_tex3d_gs*p_o642684825608_default_in2;
float o642684825608_0_clamp_true = clamp(o642684825608_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o642684825608)
float o642684825608_0_1_tex3d_gs = o642684825608_0_clamp_false;
// #code: math_6 (o642735157263)
float o642735157263_0_clamp_false = o642684825608_0_1_tex3d_gs-p_o642735157263_default_in2;
float o642735157263_0_clamp_true = clamp(o642735157263_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o642735157263)
float o642735157263_0_1_tex3d_gs = o642735157263_0_clamp_false;
// #output0: sdf3d_cylinder_2 (o642819043348)
float o642819043348_0_1_sdf3d = sdCylinder((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z))).xzy, p_o642819043348_l, p_o642819043348_r);
// #code: sdf3d_revolution2_3 (o642298949627)
vec2 o642298949627_0_q = vec2(length(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642298949627_d+0.5, ((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_3 (o642315726844)
float o642315726844_0_1_sdf2d = sd_box((o642298949627_0_q)-vec2(p_o642315726844_cx+0.5, p_o642315726844_cy+0.5), vec2(p_o642315726844_w, (o642382835712_height+0.02)));
// #output0: sdf3d_revolution2_3 (o642298949627)
float o642298949627_0_1_sdf3d = o642315726844_0_1_sdf2d;
// #output0: sdf3d_torus (o642248617976)
float o642248617976_0_1_sdf3d = sdTorus((((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s)-vec3(p_o642265395193_x, p_o642265395193_y, p_o642265395193_z)).yzx, vec2(p_o642248617976_R, p_o642248617976_r));
// #output0: sdf3d_translate_3_4 (o642265395193)
vec2 o642265395193_0_1_sdf3dc = vec2(o642248617976_0_1_sdf3d, 0.0);
// #code: sdf3d_circle_repeat_2 (o642231840759)
float o642231840759_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642231840759_c)) * p_o642231840759_c) / p_o642231840759_c))) + (seed_o642231840759+fract(_seed_variation_)) : 0.0;
vec2 o642231840759_0_in = o642231840759_input_in(circle_repeat_transform(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642231840759_c), o642231840759_0_ids);
// #output0: sdf3d_circle_repeat_2 (o642231840759)
vec2 o642231840759_0_1_sdf3dc = o642231840759_0_in;
// #code: sdf3d_revolution2_2 (o642215063542)
vec2 o642215063542_0_q = vec2(length(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642215063542_d+0.5, ((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_1_sdf2d = sd_box((o642215063542_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2_2 (o642215063542)
float o642215063542_0_1_sdf3d = o642198286325_0_1_sdf2d;
// #code: sdf3d_revolution2 (o642131177457)
vec2 o642131177457_0_q = vec2(length(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642131177457_d+0.5, ((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_3_sdf2d = sd_box((o642131177457_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2 (o642131177457)
float o642131177457_0_1_sdf3d = o642198286325_0_3_sdf2d;
// #code: sdf3d_circle_repeat (o642097623023)
float o642097623023_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642097623023_c)) * p_o642097623023_c) / p_o642097623023_c))) + (seed_o642097623023+fract(_seed_variation_)) : 0.0;
vec2 o642097623023_0_in = o642097623023_input_in(circle_repeat_transform(((((vec3((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((rotate3d((p), -vec3(p_o642701602828_ax, p_o642701602828_ay, p_o642701602828_az)*0.01745329251)), -vec3(p_o642768711697_ax*1.0, p_o642768711697_ay*1.0, p_o642768711697_az*o642735157263_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642097623023_c), o642097623023_0_ids);
// #output0: sdf3d_circle_repeat (o642097623023)
vec2 o642097623023_0_1_sdf3dc = o642097623023_0_in;
// #code: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_b = o642097623023_0_1_sdf3dc;
o642282172410_0_b = sdf3d_smooth_union(vec2(o642131177457_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k1);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642215063542_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k2);
o642282172410_0_b = sdf3d_smooth_union(o642231840759_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k3);
o642282172410_0_b = sdf3d_smooth_subtraction(o642265395193_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k4);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642298949627_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k5);
// #output0: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_1_sdf3dc = o642282172410_0_b;
// #code: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_v = o642282172410_0_1_sdf3dc;
// #output0: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_1_sdf3dc = vec2(o642181509108_0_v.x-p_o642181509108_r, o642181509108_0_v.y);
// #output0: sdf3d_scale_2 (o642399612929)
vec2 o642399612929_0_1_sdf3dc = vec2(o642181509108_0_1_sdf3dc.x*p_o642399612929_s, o642181509108_0_1_sdf3dc.y);
// #output0: sdf3d_translate_3_6 (o642449944580)
vec2 o642449944580_0_1_sdf3dc = o642399612929_0_1_sdf3dc;
// #code: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_b = o642449944580_0_1_sdf3dc;
o642802266131_0_b = sdf3dc_union(vec2(o642819043348_0_1_sdf3d, 0.0), o642802266131_0_b);
// #output0: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_1_sdf3dc = o642802266131_0_b;
// #output0: pxflib_2 (o642433167363)
float o642433167363_0_1_sdf3d = (o642802266131_0_1_sdf3dc).x;
// #output0: sdf3d_rotate_2 (o642768711697)
vec2 o642768711697_0_1_sdf3dc = vec2(o642433167363_0_1_sdf3d, 0.0);
// #output0: sdf3d_rotate_3 (o642701602828)
vec2 o642701602828_0_1_sdf3dc = o642768711697_0_1_sdf3dc;
// #output0: tex3d_colorize_2 (o642483499014)
vec3 o642483499014_0_3_tex3d = o642483499014_g_gradient_fct(dot(vec3((-(p).zyx).x+0.5), vec3(1.0))/3.0).rgb;
// #code: remap_3 (o643255250980)
float o643255250980_2_x = (dot(o642483499014_0_3_tex3d, vec3(1.0))/3.0)*(p_o643255250980_max-p_o643255250980_min);
// #output0: remap_3 (o643255250980)
float o643255250980_0_3_tex3d_gs = p_o643255250980_min+o643255250980_2_x-mod(o643255250980_2_x, max(p_o643255250980_step, 0.00000001));
// #code: remap_2 (o643238473760)
float o643238473760_2_x = (dot(o642483499014_0_3_tex3d, vec3(1.0))/3.0)*(p_o643238473760_max-p_o643238473760_min);
// #output0: remap_2 (o643238473760)
float o643238473760_0_3_tex3d_gs = p_o643238473760_min+o643238473760_2_x-mod(o643238473760_2_x, max(p_o643238473760_step, 0.00000001));
// #code: math_7 (o642751934480)
float o642751934480_2_clamp_false = o643238473760_0_3_tex3d_gs*(elapsed_time*0.25);
float o642751934480_2_clamp_true = clamp(o642751934480_2_clamp_false, 0.0, 1.0);
// #output0: math_7 (o642751934480)
float o642751934480_0_3_tex3d_gs = o642751934480_2_clamp_false;
// #code: math_8 (o642785488914)
float o642785488914_2_clamp_false = o642751934480_0_3_tex3d_gs-o643255250980_0_3_tex3d_gs;
float o642785488914_2_clamp_true = clamp(o642785488914_2_clamp_false, 0.0, 1.0);
// #output0: math_8 (o642785488914)
float o642785488914_0_3_tex3d_gs = o642785488914_2_clamp_false;
// #code: math_3 (o642651271175)
float o642651271175_0_clamp_false = o642785488914_0_3_tex3d_gs*p_o642651271175_default_in2;
float o642651271175_0_clamp_true = clamp(o642651271175_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o642651271175)
float o642651271175_0_1_tex3d_gs = o642651271175_0_clamp_false;
// #code: math_5 (o642718380046)
float o642718380046_0_clamp_false = o642651271175_0_1_tex3d_gs-p_o642718380046_default_in2;
float o642718380046_0_clamp_true = clamp(o642718380046_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o642718380046)
float o642718380046_0_1_tex3d_gs = o642718380046_0_clamp_false;
// #output0: sdf3d_cylinder_2 (o642819043348)
float o642819043348_0_3_sdf3d = sdCylinder((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z))).xzy, p_o642819043348_l, p_o642819043348_r);
// #code: sdf3d_revolution2_3 (o642298949627)
vec2 o642298949627_2_q = vec2(length(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642298949627_d+0.5, ((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_3 (o642315726844)
float o642315726844_0_3_sdf2d = sd_box((o642298949627_2_q)-vec2(p_o642315726844_cx+0.5, p_o642315726844_cy+0.5), vec2(p_o642315726844_w, (o642382835712_height+0.02)));
// #output0: sdf3d_revolution2_3 (o642298949627)
float o642298949627_0_3_sdf3d = o642315726844_0_3_sdf2d;
// #output0: sdf3d_torus (o642248617976)
float o642248617976_0_3_sdf3d = sdTorus((((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s)-vec3(p_o642265395193_x, p_o642265395193_y, p_o642265395193_z)).yzx, vec2(p_o642248617976_R, p_o642248617976_r));
// #output0: sdf3d_translate_3_4 (o642265395193)
vec2 o642265395193_0_3_sdf3dc = vec2(o642248617976_0_3_sdf3d, 0.0);
// #code: sdf3d_circle_repeat_2 (o642231840759)
float o642231840759_2_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642231840759_c)) * p_o642231840759_c) / p_o642231840759_c))) + (seed_o642231840759+fract(_seed_variation_)) : 0.0;
vec2 o642231840759_2_in = o642231840759_input_in(circle_repeat_transform(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642231840759_c), o642231840759_2_ids);
// #output0: sdf3d_circle_repeat_2 (o642231840759)
vec2 o642231840759_0_3_sdf3dc = o642231840759_2_in;
// #code: sdf3d_revolution2_2 (o642215063542)
vec2 o642215063542_2_q = vec2(length(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642215063542_d+0.5, ((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_5_sdf2d = sd_box((o642215063542_2_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2_2 (o642215063542)
float o642215063542_0_3_sdf3d = o642198286325_0_5_sdf2d;
// #code: sdf3d_revolution2 (o642131177457)
vec2 o642131177457_2_q = vec2(length(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642131177457_d+0.5, ((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_7_sdf2d = sd_box((o642131177457_2_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2 (o642131177457)
float o642131177457_0_3_sdf3d = o642198286325_0_7_sdf2d;
// #code: sdf3d_circle_repeat (o642097623023)
float o642097623023_2_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642097623023_c)) * p_o642097623023_c) / p_o642097623023_c))) + (seed_o642097623023+fract(_seed_variation_)) : 0.0;
vec2 o642097623023_2_in = o642097623023_input_in(circle_repeat_transform(((((vec3((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).x,(rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).y,abs((rotate3d((p), -vec3(p_o642466721797_ax*1.0, p_o642466721797_ay*1.0, p_o642466721797_az*o642718380046_0_1_tex3d_gs)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642097623023_c), o642097623023_2_ids);
// #output0: sdf3d_circle_repeat (o642097623023)
vec2 o642097623023_0_3_sdf3dc = o642097623023_2_in;
// #code: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_2_b = o642097623023_0_3_sdf3dc;
o642282172410_2_b = sdf3d_smooth_union(vec2(o642131177457_0_3_sdf3d, 0.0), o642282172410_2_b, p_o642282172410_k1);
o642282172410_2_b = sdf3d_smooth_union(vec2(o642215063542_0_3_sdf3d, 0.0), o642282172410_2_b, p_o642282172410_k2);
o642282172410_2_b = sdf3d_smooth_union(o642231840759_0_3_sdf3dc, o642282172410_2_b, p_o642282172410_k3);
o642282172410_2_b = sdf3d_smooth_subtraction(o642265395193_0_3_sdf3dc, o642282172410_2_b, p_o642282172410_k4);
o642282172410_2_b = sdf3d_smooth_union(vec2(o642298949627_0_3_sdf3d, 0.0), o642282172410_2_b, p_o642282172410_k5);
// #output0: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_3_sdf3dc = o642282172410_2_b;
// #code: sdf3d_rounded (o642181509108)
vec2 o642181509108_2_v = o642282172410_0_3_sdf3dc;
// #output0: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_3_sdf3dc = vec2(o642181509108_2_v.x-p_o642181509108_r, o642181509108_2_v.y);
// #output0: sdf3d_scale_2 (o642399612929)
vec2 o642399612929_0_3_sdf3dc = vec2(o642181509108_0_3_sdf3dc.x*p_o642399612929_s, o642181509108_0_3_sdf3dc.y);
// #output0: sdf3d_translate_3_6 (o642449944580)
vec2 o642449944580_0_3_sdf3dc = o642399612929_0_3_sdf3dc;
// #code: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_2_b = o642449944580_0_3_sdf3dc;
o642802266131_2_b = sdf3dc_union(vec2(o642819043348_0_3_sdf3d, 0.0), o642802266131_2_b);
// #output0: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_3_sdf3dc = o642802266131_2_b;
// #output0: pxflib_2 (o642433167363)
float o642433167363_0_3_sdf3d = (o642802266131_0_3_sdf3dc).x;
// #output0: sdf3d_rotate_4 (o642466721797)
vec2 o642466721797_0_1_sdf3dc = vec2(o642433167363_0_3_sdf3d, 0.0);
// #output0: sdf3d_color (o642986815514)
vec2 o642986815514_0_1_sdf3dc = vec2((o642466721797_0_1_sdf3dc).x, p_o642986815514_c1);
// #code: sdf3d_boolean (o642668048393)
vec2 o642668048393_0_b = o642986815514_0_1_sdf3dc;
o642668048393_0_b = sdf3dc_union(o642701602828_0_1_sdf3dc, o642668048393_0_b);
o642668048393_0_b = sdf3dc_union(o643305582632_0_1_sdf3dc, o642668048393_0_b);
// #output0: sdf3d_boolean (o642668048393)
vec2 o642668048393_0_1_sdf3dc = o642668048393_0_b;
return o642668048393_0_1_sdf3dc;
}
vec4 o643691458617_gradient_gradient_fct(float x) {
  if (x < p_o643691458617_gradient_pos[0]) {
    return p_o643691458617_gradient_col[0];
  } else if (x < p_o643691458617_gradient_pos[1]) {
    return mix(p_o643691458617_gradient_col[0], p_o643691458617_gradient_col[1], ((x-p_o643691458617_gradient_pos[0])/(p_o643691458617_gradient_pos[1]-p_o643691458617_gradient_pos[0])));
  }
  return p_o643691458617_gradient_col[1];
}
vec4 o643674681400_input_in(vec2 uv, float _seed_variation_) {
// #code: graph_3/gradient (o643691458617)
float o643691458617_0_r = 0.5+(cos(p_o643691458617_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o643691458617_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o643691458617_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: graph_3/gradient (o643691458617)
vec4 o643691458617_0_1_rgba = o643691458617_gradient_gradient_fct(fract(o643691458617_0_r*p_o643691458617_repeat));
// #output0: graph_3/_3 (o643909562429)
vec3 o643909562429_0_1_rgb = vec3(p_o643909562429_r,p_o643909562429_g,p_o643909562429_b);
// #output0: graph_3/_2 (o644043780164)
vec3 o644043780164_0_1_rgb = vec3(p_o644043780164_r,p_o644043780164_g,p_o644043780164_b);
// #code: graph_3/blend2_3 (o643657904183)
vec4 o643657904183_0_b = vec4(o644043780164_0_1_rgb, 1.0);
vec4 o643657904183_0_l;
float o643657904183_0_a;
o643657904183_0_l = vec4(o643909562429_0_1_rgb, 1.0);
o643657904183_0_a = p_o643657904183_amount1*(dot((o643691458617_0_1_rgba).rgb, vec3(1.0))/3.0);
o643657904183_0_b = vec4(blend_normal(uv, o643657904183_0_l.rgb, o643657904183_0_b.rgb, o643657904183_0_a*o643657904183_0_l.a), min(1.0, o643657904183_0_b.a+o643657904183_0_a*o643657904183_0_l.a));
// #output0: graph_3/blend2_3 (o643657904183)
vec4 o643657904183_0_1_rgba = o643657904183_0_b;
return o643657904183_0_1_rgba;
}
float o643406245934_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(uv, vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
return o642886152216_0_1_f;
}
// #instance: warp (o643406245934)
vec2 o643406245934_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o643406245934_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o643406245934_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o643406245934_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o643406245934_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec3 o642902929433_input_texx(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_3/custom_uv (o643674681400)
vec3 o643674681400_0_map = ((o643406245934_0_1_rgba).rgb);
float o643674681400_0_rnd =  float((seed_o643674681400+fract(_seed_variation_)))+o643674681400_0_map.z;
// #output0: graph_3/custom_uv (o643674681400)
vec4 o643674681400_0_1_rgba = o643674681400_input_in(get_from_tileset(1.0, o643674681400_0_rnd, custom_uv_transform(o643674681400_0_map.xy, vec2(p_o643674681400_sx, p_o643674681400_sy), p_o643674681400_rotate*0.01745329251, p_o643674681400_scale, vec2(o643674681400_0_map.z, float((seed_o643674681400+fract(_seed_variation_)))))), false ? o643674681400_0_rnd : 0.0);
return ((o643674681400_0_1_rgba).rgb);
}
vec3 o642902929433_input_texy(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_3/custom_uv (o643674681400)
vec3 o643674681400_0_map = ((o643406245934_0_1_rgba).rgb);
float o643674681400_0_rnd =  float((seed_o643674681400+fract(_seed_variation_)))+o643674681400_0_map.z;
// #output0: graph_3/custom_uv (o643674681400)
vec4 o643674681400_0_1_rgba = o643674681400_input_in(get_from_tileset(1.0, o643674681400_0_rnd, custom_uv_transform(o643674681400_0_map.xy, vec2(p_o643674681400_sx, p_o643674681400_sy), p_o643674681400_rotate*0.01745329251, p_o643674681400_scale, vec2(o643674681400_0_map.z, float((seed_o643674681400+fract(_seed_variation_)))))), false ? o643674681400_0_rnd : 0.0);
return ((o643674681400_0_1_rgba).rgb);
}
vec3 o642902929433_input_texz(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_3/custom_uv (o643674681400)
vec3 o643674681400_0_map = ((o643406245934_0_1_rgba).rgb);
float o643674681400_0_rnd =  float((seed_o643674681400+fract(_seed_variation_)))+o643674681400_0_map.z;
// #output0: graph_3/custom_uv (o643674681400)
vec4 o643674681400_0_1_rgba = o643674681400_input_in(get_from_tileset(1.0, o643674681400_0_rnd, custom_uv_transform(o643674681400_0_map.xy, vec2(p_o643674681400_sx, p_o643674681400_sy), p_o643674681400_rotate*0.01745329251, p_o643674681400_scale, vec2(o643674681400_0_map.z, float((seed_o643674681400+fract(_seed_variation_)))))), false ? o643674681400_0_rnd : 0.0);
return ((o643674681400_0_1_rgba).rgb);
}
float o642902929433_input_sdf(vec3 p, float _seed_variation_) {
// #output0: sdf3d_cylinder_2 (o642819043348)
float o642819043348_0_1_sdf3d = sdCylinder((vec3(p.x,p.y,abs(p.z))).xzy, p_o642819043348_l, p_o642819043348_r);
// #code: sdf3d_revolution2_3 (o642298949627)
vec2 o642298949627_0_q = vec2(length(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642298949627_d+0.5, ((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_3 (o642315726844)
float o642315726844_0_1_sdf2d = sd_box((o642298949627_0_q)-vec2(p_o642315726844_cx+0.5, p_o642315726844_cy+0.5), vec2(p_o642315726844_w, (o642382835712_height+0.02)));
// #output0: sdf3d_revolution2_3 (o642298949627)
float o642298949627_0_1_sdf3d = o642315726844_0_1_sdf2d;
// #output0: sdf3d_torus (o642248617976)
float o642248617976_0_1_sdf3d = sdTorus((((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s)-vec3(p_o642265395193_x, p_o642265395193_y, p_o642265395193_z)).yzx, vec2(p_o642248617976_R, p_o642248617976_r));
// #output0: sdf3d_translate_3_4 (o642265395193)
vec2 o642265395193_0_1_sdf3dc = vec2(o642248617976_0_1_sdf3d, 0.0);
// #code: sdf3d_circle_repeat_2 (o642231840759)
float o642231840759_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642231840759_c)) * p_o642231840759_c) / p_o642231840759_c))) + (seed_o642231840759+fract(_seed_variation_)) : 0.0;
vec2 o642231840759_0_in = o642231840759_input_in(circle_repeat_transform(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642231840759_c), o642231840759_0_ids);
// #output0: sdf3d_circle_repeat_2 (o642231840759)
vec2 o642231840759_0_1_sdf3dc = o642231840759_0_in;
// #code: sdf3d_revolution2_2 (o642215063542)
vec2 o642215063542_0_q = vec2(length(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642215063542_d+0.5, ((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_1_sdf2d = sd_box((o642215063542_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2_2 (o642215063542)
float o642215063542_0_1_sdf3d = o642198286325_0_1_sdf2d;
// #code: sdf3d_revolution2 (o642131177457)
vec2 o642131177457_0_q = vec2(length(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642131177457_d+0.5, ((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_3_sdf2d = sd_box((o642131177457_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2 (o642131177457)
float o642131177457_0_1_sdf3d = o642198286325_0_3_sdf2d;
// #code: sdf3d_circle_repeat (o642097623023)
float o642097623023_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642097623023_c)) * p_o642097623023_c) / p_o642097623023_c))) + (seed_o642097623023+fract(_seed_variation_)) : 0.0;
vec2 o642097623023_0_in = o642097623023_input_in(circle_repeat_transform(((((vec3(p.x,p.y,abs(p.z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642097623023_c), o642097623023_0_ids);
// #output0: sdf3d_circle_repeat (o642097623023)
vec2 o642097623023_0_1_sdf3dc = o642097623023_0_in;
// #code: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_b = o642097623023_0_1_sdf3dc;
o642282172410_0_b = sdf3d_smooth_union(vec2(o642131177457_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k1);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642215063542_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k2);
o642282172410_0_b = sdf3d_smooth_union(o642231840759_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k3);
o642282172410_0_b = sdf3d_smooth_subtraction(o642265395193_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k4);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642298949627_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k5);
// #output0: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_1_sdf3dc = o642282172410_0_b;
// #code: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_v = o642282172410_0_1_sdf3dc;
// #output0: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_1_sdf3dc = vec2(o642181509108_0_v.x-p_o642181509108_r, o642181509108_0_v.y);
// #output0: sdf3d_scale_2 (o642399612929)
vec2 o642399612929_0_1_sdf3dc = vec2(o642181509108_0_1_sdf3dc.x*p_o642399612929_s, o642181509108_0_1_sdf3dc.y);
// #output0: sdf3d_translate_3_6 (o642449944580)
vec2 o642449944580_0_1_sdf3dc = o642399612929_0_1_sdf3dc;
// #code: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_b = o642449944580_0_1_sdf3dc;
o642802266131_0_b = sdf3dc_union(vec2(o642819043348_0_1_sdf3d, 0.0), o642802266131_0_b);
// #output0: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_1_sdf3dc = o642802266131_0_b;
// #output0: pxflib_2 (o642433167363)
float o642433167363_0_1_sdf3d = (o642802266131_0_1_sdf3dc).x;
return o642433167363_0_1_sdf3d;
}
// #instance: pxflib (o642902929433)
//tetrahedron normal by PauloFalcao
//https://www.shadertoy.com/view/XstGDS
vec3 normal_o642902929433(vec3 p, float _seed_variation_) {  
  const vec3 e=vec3(0.001,-0.001,0.0);
  float v1=o642902929433_input_sdf((p+e.xyy), _seed_variation_);
  float v2=o642902929433_input_sdf((p+e.yyx), _seed_variation_);
  float v3=o642902929433_input_sdf((p+e.yxy), _seed_variation_);
  float v4=o642902929433_input_sdf((p+e.xxx), _seed_variation_);
  return normalize(vec3(v4+v1-v3-v2,v3+v4-v1-v2,v2+v4-v3-v1));
}
vec4 o643037147166_g_gradient_fct(float x) {
  if (x < p_o643037147166_g_pos[1]) {
    return p_o643037147166_g_col[0];
  }
  return p_o643037147166_g_col[1];
}
vec4 o644698091578_gradient_gradient_fct(float x) {
  if (x < p_o644698091578_gradient_pos[0]) {
    return p_o644698091578_gradient_col[0];
  } else if (x < p_o644698091578_gradient_pos[1]) {
    return mix(p_o644698091578_gradient_col[0], p_o644698091578_gradient_col[1], ((x-p_o644698091578_gradient_pos[0])/(p_o644698091578_gradient_pos[1]-p_o644698091578_gradient_pos[0])));
  }
  return p_o644698091578_gradient_col[1];
}
vec4 o644681314370_input_in(vec2 uv, float _seed_variation_) {
// #code: graph_2/gradient (o644698091578)
float o644698091578_0_r = 0.5+(cos(p_o644698091578_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o644698091578_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o644698091578_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: graph_2/gradient (o644698091578)
vec4 o644698091578_0_1_rgba = o644698091578_gradient_gradient_fct(fract(o644698091578_0_r*p_o644698091578_repeat));
// #output0: graph_2/_3 (o644916195404)
vec3 o644916195404_0_1_rgb = vec3(p_o644916195404_r,p_o644916195404_g,p_o644916195404_b);
// #output0: graph_2/_2 (o645050413139)
vec3 o645050413139_0_1_rgb = vec3(p_o645050413139_r,p_o645050413139_g,p_o645050413139_b);
// #code: graph_2/blend2_3 (o644664537155)
vec4 o644664537155_0_b = vec4(o645050413139_0_1_rgb, 1.0);
vec4 o644664537155_0_l;
float o644664537155_0_a;
o644664537155_0_l = vec4(o644916195404_0_1_rgb, 1.0);
o644664537155_0_a = p_o644664537155_amount1*(dot((o644698091578_0_1_rgba).rgb, vec3(1.0))/3.0);
o644664537155_0_b = vec4(blend_normal(uv, o644664537155_0_l.rgb, o644664537155_0_b.rgb, o644664537155_0_a*o644664537155_0_l.a), min(1.0, o644664537155_0_b.a+o644664537155_0_a*o644664537155_0_l.a));
// #output0: graph_2/blend2_3 (o644664537155)
vec4 o644664537155_0_1_rgba = o644664537155_0_b;
return o644664537155_0_1_rgba;
}
vec3 o643473354800_input_texx(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_2/custom_uv (o644681314370)
vec3 o644681314370_0_map = ((o643406245934_0_1_rgba).rgb);
float o644681314370_0_rnd =  float((seed_o644681314370+fract(_seed_variation_)))+o644681314370_0_map.z;
// #output0: graph_2/custom_uv (o644681314370)
vec4 o644681314370_0_1_rgba = o644681314370_input_in(get_from_tileset(1.0, o644681314370_0_rnd, custom_uv_transform(o644681314370_0_map.xy, vec2(p_o644681314370_sx, p_o644681314370_sy), p_o644681314370_rotate*0.01745329251, p_o644681314370_scale, vec2(o644681314370_0_map.z, float((seed_o644681314370+fract(_seed_variation_)))))), false ? o644681314370_0_rnd : 0.0);
return ((o644681314370_0_1_rgba).rgb);
}
vec3 o643473354800_input_texy(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_2/custom_uv (o644681314370)
vec3 o644681314370_0_map = ((o643406245934_0_1_rgba).rgb);
float o644681314370_0_rnd =  float((seed_o644681314370+fract(_seed_variation_)))+o644681314370_0_map.z;
// #output0: graph_2/custom_uv (o644681314370)
vec4 o644681314370_0_1_rgba = o644681314370_input_in(get_from_tileset(1.0, o644681314370_0_rnd, custom_uv_transform(o644681314370_0_map.xy, vec2(p_o644681314370_sx, p_o644681314370_sy), p_o644681314370_rotate*0.01745329251, p_o644681314370_scale, vec2(o644681314370_0_map.z, float((seed_o644681314370+fract(_seed_variation_)))))), false ? o644681314370_0_rnd : 0.0);
return ((o644681314370_0_1_rgba).rgb);
}
vec3 o643473354800_input_texz(vec2 uv, float _seed_variation_) {
// #code: warp (o643406245934)
vec2 o643406245934_0_slope = o643406245934_slope((uv), p_o643406245934_eps, _seed_variation_);
vec2 o643406245934_0_warp = o643406245934_0_slope;
// #output0: fbm3 (o642886152216)
float o642886152216_0_1_f = fbm_2d_simplex(((uv)+p_o643406245934_amount*o643406245934_0_warp), vec2(p_o642886152216_scale_x, p_o642886152216_scale_y), int(p_o642886152216_folds), int(p_o642886152216_iterations), p_o642886152216_persistence, p_o642886152216_offset, (seed_o642886152216+fract(_seed_variation_)));
// #output0: warp (o643406245934)
vec4 o643406245934_0_1_rgba = vec4(vec3(o642886152216_0_1_f), 1.0);
// #code: graph_2/custom_uv (o644681314370)
vec3 o644681314370_0_map = ((o643406245934_0_1_rgba).rgb);
float o644681314370_0_rnd =  float((seed_o644681314370+fract(_seed_variation_)))+o644681314370_0_map.z;
// #output0: graph_2/custom_uv (o644681314370)
vec4 o644681314370_0_1_rgba = o644681314370_input_in(get_from_tileset(1.0, o644681314370_0_rnd, custom_uv_transform(o644681314370_0_map.xy, vec2(p_o644681314370_sx, p_o644681314370_sy), p_o644681314370_rotate*0.01745329251, p_o644681314370_scale, vec2(o644681314370_0_map.z, float((seed_o644681314370+fract(_seed_variation_)))))), false ? o644681314370_0_rnd : 0.0);
return ((o644681314370_0_1_rgba).rgb);
}
float o643473354800_input_sdf(vec3 p, float _seed_variation_) {
// #output0: sdf3d_cylinder_2 (o642819043348)
float o642819043348_0_1_sdf3d = sdCylinder((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z))).xzy, p_o642819043348_l, p_o642819043348_r);
// #code: sdf3d_revolution2_3 (o642298949627)
vec2 o642298949627_0_q = vec2(length(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642298949627_d+0.5, ((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_3 (o642315726844)
float o642315726844_0_1_sdf2d = sd_box((o642298949627_0_q)-vec2(p_o642315726844_cx+0.5, p_o642315726844_cy+0.5), vec2(p_o642315726844_w, (o642382835712_height+0.02)));
// #output0: sdf3d_revolution2_3 (o642298949627)
float o642298949627_0_1_sdf3d = o642315726844_0_1_sdf2d;
// #output0: sdf3d_torus (o642248617976)
float o642248617976_0_1_sdf3d = sdTorus((((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s)-vec3(p_o642265395193_x, p_o642265395193_y, p_o642265395193_z)).yzx, vec2(p_o642248617976_R, p_o642248617976_r));
// #output0: sdf3d_translate_3_4 (o642265395193)
vec2 o642265395193_0_1_sdf3dc = vec2(o642248617976_0_1_sdf3d, 0.0);
// #code: sdf3d_circle_repeat_2 (o642231840759)
float o642231840759_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642231840759_c)) * p_o642231840759_c) / p_o642231840759_c))) + (seed_o642231840759+fract(_seed_variation_)) : 0.0;
vec2 o642231840759_0_in = o642231840759_input_in(circle_repeat_transform(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642231840759_c), o642231840759_0_ids);
// #output0: sdf3d_circle_repeat_2 (o642231840759)
vec2 o642231840759_0_1_sdf3dc = o642231840759_0_in;
// #code: sdf3d_revolution2_2 (o642215063542)
vec2 o642215063542_0_q = vec2(length(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642215063542_d+0.5, ((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_1_sdf2d = sd_box((o642215063542_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2_2 (o642215063542)
float o642215063542_0_1_sdf3d = o642198286325_0_1_sdf2d;
// #code: sdf3d_revolution2 (o642131177457)
vec2 o642131177457_0_q = vec2(length(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.xy)-p_o642131177457_d+0.5, ((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).xyz.z+0.5);
// #output0: sdbox_2 (o642198286325)
float o642198286325_0_3_sdf2d = sd_box((o642131177457_0_q)-vec2(p_o642198286325_cx+0.5, p_o642198286325_cy+0.5), vec2(p_o642198286325_w, (o642382835712_height)));
// #output0: sdf3d_revolution2 (o642131177457)
float o642131177457_0_1_sdf3d = o642198286325_0_3_sdf2d;
// #code: sdf3d_circle_repeat (o642097623023)
float o642097623023_0_ids = false ? rand(vec2((floor(fract((0.15915494309*atan(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).x, ((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s).y) - 0.5 / p_o642097623023_c)) * p_o642097623023_c) / p_o642097623023_c))) + (seed_o642097623023+fract(_seed_variation_)) : 0.0;
vec2 o642097623023_0_in = o642097623023_input_in(circle_repeat_transform(((((vec3((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).x,(rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).y,abs((rotate3d(p, -vec3(p_o643540463665_ax, p_o643540463665_ay, p_o643540463665_az)*0.01745329251)).z)))-vec3(p_o642449944580_x, p_o642449944580_y, p_o642449944580_z)))/p_o642399612929_s), p_o642097623023_c), o642097623023_0_ids);
// #output0: sdf3d_circle_repeat (o642097623023)
vec2 o642097623023_0_1_sdf3dc = o642097623023_0_in;
// #code: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_b = o642097623023_0_1_sdf3dc;
o642282172410_0_b = sdf3d_smooth_union(vec2(o642131177457_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k1);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642215063542_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k2);
o642282172410_0_b = sdf3d_smooth_union(o642231840759_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k3);
o642282172410_0_b = sdf3d_smooth_subtraction(o642265395193_0_1_sdf3dc, o642282172410_0_b, p_o642282172410_k4);
o642282172410_0_b = sdf3d_smooth_union(vec2(o642298949627_0_1_sdf3d, 0.0), o642282172410_0_b, p_o642282172410_k5);
// #output0: sdf3d_smoothboolean (o642282172410)
vec2 o642282172410_0_1_sdf3dc = o642282172410_0_b;
// #code: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_v = o642282172410_0_1_sdf3dc;
// #output0: sdf3d_rounded (o642181509108)
vec2 o642181509108_0_1_sdf3dc = vec2(o642181509108_0_v.x-p_o642181509108_r, o642181509108_0_v.y);
// #output0: sdf3d_scale_2 (o642399612929)
vec2 o642399612929_0_1_sdf3dc = vec2(o642181509108_0_1_sdf3dc.x*p_o642399612929_s, o642181509108_0_1_sdf3dc.y);
// #output0: sdf3d_translate_3_6 (o642449944580)
vec2 o642449944580_0_1_sdf3dc = o642399612929_0_1_sdf3dc;
// #code: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_b = o642449944580_0_1_sdf3dc;
o642802266131_0_b = sdf3dc_union(vec2(o642819043348_0_1_sdf3d, 0.0), o642802266131_0_b);
// #output0: sdf3d_boolean_2 (o642802266131)
vec2 o642802266131_0_1_sdf3dc = o642802266131_0_b;
// #output0: pxflib_2 (o642433167363)
float o642433167363_0_1_sdf3d = (o642802266131_0_1_sdf3dc).x;
// #output0: sdf3d_rotate_5 (o643540463665)
vec2 o643540463665_0_1_sdf3dc = vec2(o642433167363_0_1_sdf3d, 0.0);
return (o643540463665_0_1_sdf3dc).x;
}
// #instance: pxflib_3 (o643473354800)
//tetrahedron normal by PauloFalcao
//https://www.shadertoy.com/view/XstGDS
vec3 normal_o643473354800(vec3 p, float _seed_variation_) {  
  const vec3 e=vec3(0.001,-0.001,0.0);
  float v1=o643473354800_input_sdf((p+e.xyy), _seed_variation_);
  float v2=o643473354800_input_sdf((p+e.yyx), _seed_variation_);
  float v3=o643473354800_input_sdf((p+e.yxy), _seed_variation_);
  float v4=o643473354800_input_sdf((p+e.xxx), _seed_variation_);
  return normalize(vec3(v4+v1-v3-v2,v3+v4-v1-v2,v2+v4-v3-v1));
}
const int MAX_STEPS = 100;
const float MAX_DIST = 100.0;
const float SURF_DIST = 1e-3;
vec2 GetDist(vec3 p) {
	float _seed_variation_ = 0.0;
	

		if (false) {
			p *= vec3(1.0, -1.0, 1.0);
		} 


	vec2 d = o642080845806_input_distance((p), _seed_variation_);
	return d;
}
vec2 RayMarch(vec3 ro, vec3 rd) {
	float dO = 0.0;
	float color = 0.0;
	vec2 dS;
	
	for (int i = 0; i < MAX_STEPS; i++)
	{
		vec3 p = ro + dO * rd;
		dS = GetDist(p);
		dO += dS.x;
		
		if (abs(dS.x) < SURF_DIST || dO > MAX_DIST) {
			color = dS.y;
			break;
		}
	}
	return vec2(dO, color);
}
vec3 GetNormal(vec3 p) {
	vec2 e = vec2(1e-3, 0);
	
	vec3 n = GetDist(p).x - vec3(
		GetDist(p - e.xyy).x,
		GetDist(p - e.yxy).x,
		GetDist(p - e.yyx).x
	);
	
	return normalize(n);
}
float softshadow( in vec3 ro, in vec3 rd, float mint, float maxt, float w, int iter )
{
    float res = 1.0;
    float t = mint;
    for( int i=0; i<iter && t<maxt; i++ )
    {
        float h = GetDist(ro + t*rd).x;
        res = min( res, h/(w*t) );
        t += clamp(h, 0.005, 0.50);
        if( res<-1.0 || t>maxt ) break;
    }
    res = max(res,-1.0);
    return 0.25*(1.0+res)*(1.0+res)*(2.0-res);
}
vec3 randomSphereDir(vec2 rnd)
{
    float s = rnd.x*6.283185;
    float t = rnd.y*2.0-1.0;
    return vec3(sin(s), cos(s), t) / sqrt(1.0 + t * t);
}
vec3 randomHemisphereDir(vec3 dir, float i)
{
	vec3 v = randomSphereDir(vec2(rand(vec2(i+1.0)),rand(vec2(i+2.0))));
    return v * sign(dot(v, dir));
}
float ambientOcclusion( in vec3 p, in vec3 n, in float maxDist, in float falloff, int iter )
{
   float nbIteInv = 1./float(iter);
   float rad = 1.-1.*nbIteInv; //Hemispherical factor (self occlusion correction)
   float ao = 0.0;
   for( int i=0; i<iter; i++ )
   {
	float l = rand(vec2(float(i)))*maxDist;
    vec3 rd = normalize(n+randomHemisphereDir(n, l )*rad)*l; // mix direction with the normal for self occlusion problems!
	ao += (l - max(GetDist( p + rd ),0.).x) / maxDist * falloff;
   }
	return clamp( 1.-ao*nbIteInv, 0., 1.);
}
void vertex() {
	elapsed_time = TIME;
	world_position = VERTEX;
	world_camera = (inverse(MODELVIEW_MATRIX) * vec4(0, 0, 0, 1)).xyz; //object space
	//world_camera = ( INV_VIEW_MATRIX  * vec4(0, 0, 0, 1)).xyz; //uncomment this to raymarch in world space
}
void fragment() {
	float _seed_variation_ = 0.0;
	vec3 ro = world_camera;
	vec3 rd =  normalize(world_position - ro);
	
	vec2 rm  = RayMarch(ro, rd);
	float d = rm.x;
	if (d >= MAX_DIST)
		discard;
	else
	{
		vec3 p = ro + rd * d;
		vec3 n = GetNormal(p);
		

		float occ = ambientOcclusion(p, n, ao_spread, ao_strength, int(ao_samples));
		vec3 lig = normalize( light_direction );
		float sha = softshadow(p, lig, shadow_min_dist, shadow_max_dist, light_size, int(shadow_samples));
		if (false) {
			p *= vec3(1.0, -1.0, 1.0);
			n *= vec3(1.0, -1.0, 1.0);
		}


// #output0: tex3d_uniform (o642416390146)
vec3 o642416390146_0_1_tex3d = p_o642416390146_color.rgb;

// #output0: pattern (o643339137066)
float o643339137066_0_1_f = mix_xor(wave_square(p_o643339137066_x_scale*((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643355914283_ax*1.0, p_o643355914283_ay*1.0, p_o643355914283_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).xy+vec2(0.5)).x), wave_square(p_o643339137066_y_scale*((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643355914283_ax*1.0, p_o643355914283_ay*1.0, p_o643355914283_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).xy+vec2(0.5)).y));

// #code: remap_4 (o643372691500)
float o643372691500_0_x = o643339137066_0_1_f*(p_o643372691500_max-p_o643372691500_min);
// #output0: remap_4 (o643372691500)
float o643372691500_0_1_f = p_o643372691500_min+o643372691500_0_x-mod(o643372691500_0_x, max(p_o643372691500_step, 0.00000001));

// #output0: tex3d_from2d_2 (o643322359849)
vec3 o643322359849_0_1_tex3d = vec3(o643372691500_0_1_f);

// #output0: tex3d_rotate_3 (o643355914283)
vec3 o643355914283_0_1_tex3d = o643322359849_0_1_tex3d;

// #output0: tex3d_colorize_2 (o642483499014)
vec3 o642483499014_0_1_tex3d = o642483499014_g_gradient_fct(dot(vec3((-(vec4(p, rm.y)).zyx).x+0.5), vec3(1.0))/3.0).rgb;

// #code: remap_2 (o643238473760)
float o643238473760_0_x = (dot(o642483499014_0_1_tex3d, vec3(1.0))/3.0)*(p_o643238473760_max-p_o643238473760_min);
// #output0: remap_2 (o643238473760)
float o643238473760_0_1_tex3d_gs = p_o643238473760_min+o643238473760_0_x-mod(o643238473760_0_x, max(p_o643238473760_step, 0.00000001));

// #code: math_7 (o642751934480)
float o642751934480_0_clamp_false = o643238473760_0_1_tex3d_gs*(elapsed_time*0.25);
float o642751934480_0_clamp_true = clamp(o642751934480_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o642751934480)
float o642751934480_0_1_tex3d_gs = o642751934480_0_clamp_false;

// #code: pxflib (o642902929433)
vec3 texx_o642902929433_0=o642902929433_input_texx(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o642970038299_ax*1.0, p_o642970038299_ay*1.0, p_o642970038299_az*o642751934480_0_1_tex3d_gs)*0.01745329251), (vec4(p, rm.y)).w)).yz+0.5), _seed_variation_);
vec3 texy_o642902929433_0=o642902929433_input_texy(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o642970038299_ax*1.0, p_o642970038299_ay*1.0, p_o642970038299_az*o642751934480_0_1_tex3d_gs)*0.01745329251), (vec4(p, rm.y)).w)).xz+0.5), _seed_variation_);
vec3 texz_o642902929433_0=o642902929433_input_texz(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o642970038299_ax*1.0, p_o642970038299_ay*1.0, p_o642970038299_az*o642751934480_0_1_tex3d_gs)*0.01745329251), (vec4(p, rm.y)).w)).xy+0.5), _seed_variation_);
// #output0: pxflib (o642902929433)
vec3 o642902929433_0_1_tex3d = abs(normal_o642902929433((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o642970038299_ax*1.0, p_o642970038299_ay*1.0, p_o642970038299_az*o642751934480_0_1_tex3d_gs)*0.01745329251), (vec4(p, rm.y)).w)).xyz, _seed_variation_))*mat3(vec3(texx_o642902929433_0.x,texy_o642902929433_0.x,texz_o642902929433_0.x),vec3(texx_o642902929433_0.y,texy_o642902929433_0.y,texz_o642902929433_0.y),vec3(texx_o642902929433_0.z,texy_o642902929433_0.z,texz_o642902929433_0.z));

// #output0: tex3d_rotate (o642970038299)
vec3 o642970038299_0_1_tex3d = o642902929433_0_1_tex3d;

// #output0: tex3d_colorize_3 (o643037147166)
vec3 o643037147166_0_1_tex3d = o643037147166_g_gradient_fct(dot(vec3((-(vec4(p, rm.y)).yxz).x+0.5), vec3(1.0))/3.0).rgb;

// #code: remap (o643221696545)
float o643221696545_0_x = (dot(o643037147166_0_1_tex3d, vec3(1.0))/3.0)*(p_o643221696545_max-p_o643221696545_min);
// #output0: remap (o643221696545)
float o643221696545_0_1_tex3d_gs = p_o643221696545_min+o643221696545_0_x-mod(o643221696545_0_x, max(p_o643221696545_step, 0.00000001));

// #code: math_9 (o643204919327)
float o643204919327_0_clamp_false = o643221696545_0_1_tex3d_gs*(elapsed_time*0.25);
float o643204919327_0_clamp_true = clamp(o643204919327_0_clamp_false, 0.0, 1.0);
// #output0: math_9 (o643204919327)
float o643204919327_0_1_tex3d_gs = o643204919327_0_clamp_false;

// #code: pxflib_3 (o643473354800)
vec3 texx_o643473354800_0=o643473354800_input_texx(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643020369949_ax*1.0, p_o643020369949_ay*o643204919327_0_1_tex3d_gs, p_o643020369949_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).yz+0.5), _seed_variation_);
vec3 texy_o643473354800_0=o643473354800_input_texy(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643020369949_ax*1.0, p_o643020369949_ay*o643204919327_0_1_tex3d_gs, p_o643020369949_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).xz+0.5), _seed_variation_);
vec3 texz_o643473354800_0=o643473354800_input_texz(((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643020369949_ax*1.0, p_o643020369949_ay*o643204919327_0_1_tex3d_gs, p_o643020369949_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).xy+0.5), _seed_variation_);
// #output0: pxflib_3 (o643473354800)
vec3 o643473354800_0_1_tex3d = abs(normal_o643473354800((vec4(tex3d_rotate((vec4(p, rm.y)).xyz, -vec3(p_o643020369949_ax*1.0, p_o643020369949_ay*o643204919327_0_1_tex3d_gs, p_o643020369949_az*1.0)*0.01745329251), (vec4(p, rm.y)).w)).xyz, _seed_variation_))*mat3(vec3(texx_o643473354800_0.x,texy_o643473354800_0.x,texz_o643473354800_0.x),vec3(texx_o643473354800_0.y,texy_o643473354800_0.y,texz_o643473354800_0.y),vec3(texx_o643473354800_0.z,texy_o643473354800_0.z,texz_o643473354800_0.z));

// #output0: tex3d_rotate_2 (o643020369949)
vec3 o643020369949_0_1_tex3d = o643473354800_0_1_tex3d;

// #code: tex3d_select (o643003592732)
vec3 o643003592732_0_b = o643020369949_0_1_tex3d;
float o643003592732_0_d = 0.0;


o643003592732_0_d = ((vec4(p, rm.y)).w-p_o643003592732_v1)/p_o643003592732_t1;
o643003592732_0_b = mix(o643003592732_0_b, o642970038299_0_1_tex3d, clamp(1.0-o643003592732_0_d*o643003592732_0_d, 0.0, 1.0));

o643003592732_0_d = ((vec4(p, rm.y)).w-p_o643003592732_v2)/p_o643003592732_t2;
o643003592732_0_b = mix(o643003592732_0_b, o643355914283_0_1_tex3d, clamp(1.0-o643003592732_0_d*o643003592732_0_d, 0.0, 1.0));
// #output0: tex3d_select (o643003592732)
vec3 o643003592732_0_1_tex3d = o643003592732_0_b;

// #code: math_v3 (o643272028198)
vec3 o643272028198_0_clamp_false = o643003592732_0_1_tex3d*vec3(p_o643272028198_d_in2_x, p_o643272028198_d_in2_y, p_o643272028198_d_in2_z);
vec3 o643272028198_0_clamp_true = clamp(o643272028198_0_clamp_false, vec3(0.0), vec3(1.0));
// #output0: math_v3 (o643272028198)
vec3 o643272028198_0_1_tex3d = o643272028198_0_clamp_false;

		ALBEDO = o643272028198_0_1_tex3d
			* (ambient_occlusion ? occ : 1.0)
			* (shadow ? mix(1.0,sha,shadow_mix) : 1.0);
		ROUGHNESS = (dot(o642416390146_0_1_tex3d, vec3(1.0))/3.0);
		METALLIC = (dot(o642416390146_0_1_tex3d, vec3(1.0))/3.0);
		EMISSION = vec3(0.0);
		NORMAL = (VIEW_MATRIX*MODEL_MATRIX*vec4(n, 0.0)).xyz;
	}
}



