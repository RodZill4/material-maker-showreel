shader_type spatial;
uniform float seed_variation = 0.0;
varying float elapsed_time;
varying vec3 world_camera;
varying vec3 world_position;
const int MAX_STEPS = 100;
const float MAX_DIST = 100.0;
const float SURF_DIST = 1e-3;
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

vec3 circle_repeat_transform(vec3 p, float count) {
	float r = 6.28/count;
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

vec2 sdf3dc_union(vec2 a, vec2 b) {
	return vec2(min(a.x, b.x), mix(b.y, a.y, step(a.x, b.x)));
}
vec2 sdf3dc_sub(vec2 a, vec2 b) {
	return vec2(max(-a.x, b.x), a.y);
}
vec2 sdf3dc_inter(vec2 a, vec2 b) {
	return vec2(max(a.x, b.x), mix(a.y, b.y, step(a.x, b.x)));
}

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

const float p_o10758_ax = 180.000000000;
const float p_o10758_ay = 0.000000000;
const float p_o10758_az = 0.000000000;
const float p_o10777_x = 0.000000000;
const float p_o10777_y = -0.050000000;
const float p_o10777_z = 0.000000000;
const float p_o10759_k = 0.050000000;
const float p_o10757_x = 0.000000000;
const float p_o10757_y = 0.310000000;
const float p_o10757_z = 0.000000000;
const float p_o10756_sx = 0.500000000;
const float p_o10756_sy = 0.300000000;
const float p_o10756_sz = 0.500000000;
const float p_o10756_r = 0.000000000;
const float p_o10760_r = 0.400000000;
const float p_o10771_x = 0.000000000;
const float p_o10771_y = 0.040000000;
const float p_o10771_z = 0.000000000;
const float p_o10770_ax = 90.000000000;
const float p_o10770_ay = 0.000000000;
const float p_o10770_az = 0.000000000;
const float p_o10767_k = 0.110000000;
const float p_o10764_c = 5.000000000;
const float p_o10765_x = 0.000000000;
const float p_o10765_y = 0.320000000;
const float p_o10765_z = 0.000000000;
const float p_o10763_l = 0.010000000;
const float p_o10763_r = 0.140000000;
const float p_o10768_ax = 0.000000000;
const float p_o10768_ay = 0.000000000;
const float p_o10768_az = 30.000000000;
const float p_o10766_c = 5.000000000;
const float p_o10769_x = 0.000000000;
const float p_o10769_y = 0.320000000;
const float p_o10769_z = 0.000000000;
const float p_o10762_x = 0.000000000;
const float p_o10762_y = 0.120000000;
const float p_o10762_z = 0.000000000;
const float p_o10755_r = 0.030000000;
const float p_o10754_l = 0.020000000;
const float p_o10754_r = 0.350000000;
const float p_o10773_x = 0.000000000;
const float p_o10773_y = 0.270000000;
const float p_o10773_z = 0.000000000;
const float p_o10774_r = 0.070000000;
const float p_o10775_l = 0.020000000;
const float p_o10775_r = 0.350000000;
const float p_o10785_x = 0.000000000;
const float p_o10785_y = 0.230000000;
const float p_o10785_z = 0.000000000;
const float p_o10784_ax = -90.000000000;
const float p_o10784_ay = 0.000000000;
const float p_o10784_az = 0.000000000;
const float p_o10779_k = 0.070000000;
const float p_o10781_x = 0.000000000;
const float p_o10781_y = 0.000000000;
const float p_o10781_z = -0.110000000;
const float p_o10782_c = 5.000000000;
const float p_o10780_l = 0.460000000;
const float p_o10780_r = 0.120000000;
const float p_o10778_R = 0.360000000;
const float p_o10778_r = 0.090000000;
const float p_o10788_x = 0.000000000;
const float p_o10788_y = 0.430000000;
const float p_o10788_z = 0.000000000;
const float p_o10787_r = 0.030000000;
const float p_o10786_l = 0.030000000;
const float p_o10786_r = 0.380000000;
vec2 o10753_input_distance(vec3 p, float _seed_variation_) {
vec3 o10756_0_q = abs((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10757_x, p_o10757_y, p_o10757_z))) - vec3(p_o10756_sx, p_o10756_sy, p_o10756_sz);
float o10756_0_1_sdf3d = length(max(o10756_0_q,0.0))+min(max(o10756_0_q.x,max(o10756_0_q.y,o10756_0_q.z)),0.0)-p_o10756_r;
vec2 o10757_0_1_sdf3dc = vec2(o10756_0_1_sdf3d, 0.0);
float o10760_0_1_sdf3d = length(((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z)))-p_o10760_r;
vec2 o10759_0_1_sdf3dc = sdf3d_smooth_subtraction(o10757_0_1_sdf3dc, vec2(o10760_0_1_sdf3d, 0.0), p_o10759_k);
vec2 o10763_0_d = abs(vec2(length(((circle_repeat_transform((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), p_o10764_c))-vec3(p_o10765_x, p_o10765_y, p_o10765_z)).xy),((circle_repeat_transform((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), p_o10764_c))-vec3(p_o10765_x, p_o10765_y, p_o10765_z)).z)) - vec2(p_o10763_r,p_o10763_l);
float o10763_0_1_sdf3d = min(max(o10763_0_d.x,o10763_0_d.y),0.0) + length(max(o10763_0_d,0.0));
vec2 o10765_0_1_sdf3dc = vec2(o10763_0_1_sdf3d, 0.0);
vec2 o10764_0_1_sdf3dc = o10765_0_1_sdf3dc;
vec2 o10763_2_d = abs(vec2(length(((circle_repeat_transform((rotate3d((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), -vec3(p_o10768_ax, p_o10768_ay, p_o10768_az)*0.01745329251)), p_o10766_c))-vec3(p_o10769_x, p_o10769_y, p_o10769_z)).xy),((circle_repeat_transform((rotate3d((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), -vec3(p_o10768_ax, p_o10768_ay, p_o10768_az)*0.01745329251)), p_o10766_c))-vec3(p_o10769_x, p_o10769_y, p_o10769_z)).z)) - vec2(p_o10763_r,p_o10763_l);
float o10763_0_3_sdf3d = min(max(o10763_2_d.x,o10763_2_d.y),0.0) + length(max(o10763_2_d,0.0));
vec2 o10769_0_1_sdf3dc = vec2(o10763_0_3_sdf3d, 0.0);
vec2 o10766_0_1_sdf3dc = o10769_0_1_sdf3dc;
vec2 o10768_0_1_sdf3dc = o10766_0_1_sdf3dc;
vec2 o10767_0_1_sdf3dc = sdf3d_smooth_union(o10764_0_1_sdf3dc, o10768_0_1_sdf3dc, p_o10767_k);
vec2 o10770_0_1_sdf3dc = o10767_0_1_sdf3dc;
vec2 o10771_0_1_sdf3dc = o10770_0_1_sdf3dc;
vec2 o10761_0_1_sdf3dc = sdf3dc_union(o10759_0_1_sdf3dc, o10771_0_1_sdf3dc);
vec2 o10754_0_d = abs(vec2(length((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10762_x, p_o10762_y, p_o10762_z)).xz),(((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10762_x, p_o10762_y, p_o10762_z)).y)) - vec2(p_o10754_r,p_o10754_l);
float o10754_0_1_sdf3d = min(max(o10754_0_d.x,o10754_0_d.y),0.0) + length(max(o10754_0_d,0.0));
vec2 o10755_0_v = vec2(o10754_0_1_sdf3d, 0.0);vec2 o10755_0_1_sdf3dc = vec2(o10755_0_v.x-p_o10755_r, o10755_0_v.y);
vec2 o10762_0_1_sdf3dc = o10755_0_1_sdf3dc;
vec2 o10772_0_1_sdf3dc = sdf3dc_union(o10761_0_1_sdf3dc, o10762_0_1_sdf3dc);
vec2 o10775_0_d = abs(vec2(length((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10773_x, p_o10773_y, p_o10773_z)).xz),(((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10773_x, p_o10773_y, p_o10773_z)).y)) - vec2(p_o10775_r,p_o10775_l);
float o10775_0_1_sdf3d = min(max(o10775_0_d.x,o10775_0_d.y),0.0) + length(max(o10775_0_d,0.0));
vec2 o10774_0_v = vec2(o10775_0_1_sdf3d, 0.0);vec2 o10774_0_1_sdf3dc = vec2(o10774_0_v.x-p_o10774_r, o10774_0_v.y);
vec2 o10773_0_1_sdf3dc = o10774_0_1_sdf3dc;
vec2 o10776_0_1_sdf3dc = sdf3dc_union(o10772_0_1_sdf3dc, o10773_0_1_sdf3dc);
vec2 o10780_0_d = abs(vec2(length((circle_repeat_transform(((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251))-vec3(p_o10781_x, p_o10781_y, p_o10781_z)), p_o10782_c)).xz),(circle_repeat_transform(((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251))-vec3(p_o10781_x, p_o10781_y, p_o10781_z)), p_o10782_c)).y)) - vec2(p_o10780_r,p_o10780_l);
float o10780_0_1_sdf3d = min(max(o10780_0_d.x,o10780_0_d.y),0.0) + length(max(o10780_0_d,0.0));
vec2 o10782_0_1_sdf3dc = vec2(o10780_0_1_sdf3d, 0.0);
vec2 o10781_0_1_sdf3dc = o10782_0_1_sdf3dc;
vec2 o10778_0_q = vec2(length((rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251)).xy)-p_o10778_R,(rotate3d((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251)).z);
float o10778_0_1_sdf3d = length(o10778_0_q)-p_o10778_r;
vec2 o10779_0_1_sdf3dc = sdf3d_smooth_subtraction(o10781_0_1_sdf3dc, vec2(o10778_0_1_sdf3d, 0.0), p_o10779_k);
vec2 o10784_0_1_sdf3dc = o10779_0_1_sdf3dc;
vec2 o10785_0_1_sdf3dc = o10784_0_1_sdf3dc;
vec2 o10783_0_1_sdf3dc = sdf3dc_union(o10776_0_1_sdf3dc, o10785_0_1_sdf3dc);
vec2 o10786_0_d = abs(vec2(length((((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10788_x, p_o10788_y, p_o10788_z)).xz),(((rotate3d((p), -vec3(p_o10758_ax, p_o10758_ay, p_o10758_az)*0.01745329251))-vec3(p_o10777_x, p_o10777_y, p_o10777_z))-vec3(p_o10788_x, p_o10788_y, p_o10788_z)).y)) - vec2(p_o10786_r,p_o10786_l);
float o10786_0_1_sdf3d = min(max(o10786_0_d.x,o10786_0_d.y),0.0) + length(max(o10786_0_d,0.0));
vec2 o10787_0_v = vec2(o10786_0_1_sdf3d, 0.0);vec2 o10787_0_1_sdf3dc = vec2(o10787_0_v.x-p_o10787_r, o10787_0_v.y);
vec2 o10788_0_1_sdf3dc = o10787_0_1_sdf3dc;
vec2 o10789_0_1_sdf3dc = sdf3dc_union(o10783_0_1_sdf3dc, o10788_0_1_sdf3dc);
vec2 o10777_0_1_sdf3dc = o10789_0_1_sdf3dc;
vec2 o10758_0_1_sdf3dc = o10777_0_1_sdf3dc;

return o10758_0_1_sdf3dc;
}
const float p_o10832_ax = 180.000000000;
const float p_o10832_ay = 0.000000000;
const float p_o10832_az = 0.000000000;
const float p_o10831_x = -0.000000000;
const float p_o10831_y = -0.050000000;
const float p_o10831_z = 0.000000000;
const float p_o10861_d = 0.010000000;
const float p_o10862_g_0_pos = 0.672727000;
const float p_o10862_g_0_r = 0.273438007;
const float p_o10862_g_0_g = 0.134582996;
const float p_o10862_g_0_b = 0.000000000;
const float p_o10862_g_0_a = 1.000000000;
const float p_o10862_g_1_pos = 0.845455000;
const float p_o10862_g_1_r = 0.273438007;
const float p_o10862_g_1_g = 0.134582996;
const float p_o10862_g_1_b = 0.000000000;
const float p_o10862_g_1_a = 1.000000000;
vec4 o10862_g_gradient_fct(float x) {
  if (x < p_o10862_g_0_pos) {
    return vec4(p_o10862_g_0_r,p_o10862_g_0_g,p_o10862_g_0_b,p_o10862_g_0_a);
  } else if (x < p_o10862_g_1_pos) {
    return mix(vec4(p_o10862_g_0_r,p_o10862_g_0_g,p_o10862_g_0_b,p_o10862_g_0_a), vec4(p_o10862_g_1_r,p_o10862_g_1_g,p_o10862_g_1_b,p_o10862_g_1_a), ((x-p_o10862_g_0_pos)/(p_o10862_g_1_pos-p_o10862_g_0_pos)));
  }
  return vec4(p_o10862_g_1_r,p_o10862_g_1_g,p_o10862_g_1_b,p_o10862_g_1_a);
}
const float p_o10860_d = 0.010000000;
const float p_o10847_g_0_pos = 0.909091000;
const float p_o10847_g_0_r = 0.960937977;
const float p_o10847_g_0_g = 0.827799976;
const float p_o10847_g_0_b = 0.108856000;
const float p_o10847_g_0_a = 1.000000000;
const float p_o10847_g_1_pos = 1.000000000;
const float p_o10847_g_1_r = 0.960937977;
const float p_o10847_g_1_g = 0.827799976;
const float p_o10847_g_1_b = 0.108856000;
const float p_o10847_g_1_a = 1.000000000;
vec4 o10847_g_gradient_fct(float x) {
  if (x < p_o10847_g_0_pos) {
    return vec4(p_o10847_g_0_r,p_o10847_g_0_g,p_o10847_g_0_b,p_o10847_g_0_a);
  } else if (x < p_o10847_g_1_pos) {
    return mix(vec4(p_o10847_g_0_r,p_o10847_g_0_g,p_o10847_g_0_b,p_o10847_g_0_a), vec4(p_o10847_g_1_r,p_o10847_g_1_g,p_o10847_g_1_b,p_o10847_g_1_a), ((x-p_o10847_g_0_pos)/(p_o10847_g_1_pos-p_o10847_g_0_pos)));
  }
  return vec4(p_o10847_g_1_r,p_o10847_g_1_g,p_o10847_g_1_b,p_o10847_g_1_a);
}
const float p_o10833_d = 0.010000000;
const float p_o10834_g_0_pos = 0.900000000;
const float p_o10834_g_0_r = 0.960937977;
const float p_o10834_g_0_g = 0.188739002;
const float p_o10834_g_0_b = 0.108856000;
const float p_o10834_g_0_a = 1.000000000;
const float p_o10834_g_1_pos = 1.000000000;
const float p_o10834_g_1_r = 0.960937977;
const float p_o10834_g_1_g = 0.188739002;
const float p_o10834_g_1_b = 0.108856000;
const float p_o10834_g_1_a = 1.000000000;
vec4 o10834_g_gradient_fct(float x) {
  if (x < p_o10834_g_0_pos) {
    return vec4(p_o10834_g_0_r,p_o10834_g_0_g,p_o10834_g_0_b,p_o10834_g_0_a);
  } else if (x < p_o10834_g_1_pos) {
    return mix(vec4(p_o10834_g_0_r,p_o10834_g_0_g,p_o10834_g_0_b,p_o10834_g_0_a), vec4(p_o10834_g_1_r,p_o10834_g_1_g,p_o10834_g_1_b,p_o10834_g_1_a), ((x-p_o10834_g_0_pos)/(p_o10834_g_1_pos-p_o10834_g_0_pos)));
  }
  return vec4(p_o10834_g_1_r,p_o10834_g_1_g,p_o10834_g_1_b,p_o10834_g_1_a);
}
const float p_o10817_d = 0.010000000;
const float p_o10818_g_0_pos = 0.745454000;
const float p_o10818_g_0_r = 0.000000000;
const float p_o10818_g_0_g = 0.683593988;
const float p_o10818_g_0_b = 0.138854995;
const float p_o10818_g_0_a = 1.000000000;
const float p_o10818_g_1_pos = 0.936364000;
const float p_o10818_g_1_r = 0.000000000;
const float p_o10818_g_1_g = 0.683593988;
const float p_o10818_g_1_b = 0.138854995;
const float p_o10818_g_1_a = 1.000000000;
vec4 o10818_g_gradient_fct(float x) {
  if (x < p_o10818_g_0_pos) {
    return vec4(p_o10818_g_0_r,p_o10818_g_0_g,p_o10818_g_0_b,p_o10818_g_0_a);
  } else if (x < p_o10818_g_1_pos) {
    return mix(vec4(p_o10818_g_0_r,p_o10818_g_0_g,p_o10818_g_0_b,p_o10818_g_0_a), vec4(p_o10818_g_1_r,p_o10818_g_1_g,p_o10818_g_1_b,p_o10818_g_1_a), ((x-p_o10818_g_0_pos)/(p_o10818_g_1_pos-p_o10818_g_0_pos)));
  }
  return vec4(p_o10818_g_1_r,p_o10818_g_1_g,p_o10818_g_1_b,p_o10818_g_1_a);
}
const float p_o10790_g_0_pos = 0.754545000;
const float p_o10790_g_0_r = 0.753906012;
const float p_o10790_g_0_g = 0.575553000;
const float p_o10790_g_0_b = 0.418181986;
const float p_o10790_g_0_a = 1.000000000;
const float p_o10790_g_1_pos = 0.890909000;
const float p_o10790_g_1_r = 0.753906012;
const float p_o10790_g_1_g = 0.575553000;
const float p_o10790_g_1_b = 0.418181986;
const float p_o10790_g_1_a = 1.000000000;
vec4 o10790_g_gradient_fct(float x) {
  if (x < p_o10790_g_0_pos) {
    return vec4(p_o10790_g_0_r,p_o10790_g_0_g,p_o10790_g_0_b,p_o10790_g_0_a);
  } else if (x < p_o10790_g_1_pos) {
    return mix(vec4(p_o10790_g_0_r,p_o10790_g_0_g,p_o10790_g_0_b,p_o10790_g_0_a), vec4(p_o10790_g_1_r,p_o10790_g_1_g,p_o10790_g_1_b,p_o10790_g_1_a), ((x-p_o10790_g_0_pos)/(p_o10790_g_1_pos-p_o10790_g_0_pos)));
  }
  return vec4(p_o10790_g_1_r,p_o10790_g_1_g,p_o10790_g_1_b,p_o10790_g_1_a);
}
vec3 o10753_input_albedo(vec4 p, float _seed_variation_) {
vec3 o10862_0_1_tex3d = o10862_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o10847_0_1_tex3d = o10847_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o10834_0_1_tex3d = o10834_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o10818_0_1_tex3d = o10818_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o10790_0_1_tex3d = o10790_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec2 o10763_0_d = abs(vec2(length(((circle_repeat_transform((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), p_o10764_c))-vec3(p_o10765_x, p_o10765_y, p_o10765_z)).xy),((circle_repeat_transform((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), p_o10764_c))-vec3(p_o10765_x, p_o10765_y, p_o10765_z)).z)) - vec2(p_o10763_r,p_o10763_l);
float o10763_0_1_sdf3d = min(max(o10763_0_d.x,o10763_0_d.y),0.0) + length(max(o10763_0_d,0.0));
vec2 o10765_0_1_sdf3dc = vec2(o10763_0_1_sdf3d, 0.0);
vec2 o10764_0_1_sdf3dc = o10765_0_1_sdf3dc;
vec2 o10763_2_d = abs(vec2(length(((circle_repeat_transform((rotate3d((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), -vec3(p_o10768_ax, p_o10768_ay, p_o10768_az)*0.01745329251)), p_o10766_c))-vec3(p_o10769_x, p_o10769_y, p_o10769_z)).xy),((circle_repeat_transform((rotate3d((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10771_x, p_o10771_y, p_o10771_z)), -vec3(p_o10770_ax, p_o10770_ay, p_o10770_az)*0.01745329251)), -vec3(p_o10768_ax, p_o10768_ay, p_o10768_az)*0.01745329251)), p_o10766_c))-vec3(p_o10769_x, p_o10769_y, p_o10769_z)).z)) - vec2(p_o10763_r,p_o10763_l);
float o10763_0_3_sdf3d = min(max(o10763_2_d.x,o10763_2_d.y),0.0) + length(max(o10763_2_d,0.0));
vec2 o10769_0_1_sdf3dc = vec2(o10763_0_3_sdf3d, 0.0);
vec2 o10766_0_1_sdf3dc = o10769_0_1_sdf3dc;
vec2 o10768_0_1_sdf3dc = o10766_0_1_sdf3dc;
vec2 o10767_0_1_sdf3dc = sdf3d_smooth_union(o10764_0_1_sdf3dc, o10768_0_1_sdf3dc, p_o10767_k);
vec2 o10770_0_1_sdf3dc = o10767_0_1_sdf3dc;
vec2 o10771_0_1_sdf3dc = o10770_0_1_sdf3dc;
vec3 o10817_0_1_tex3d = mix(o10818_0_1_tex3d, o10790_0_1_tex3d, clamp((o10771_0_1_sdf3dc).x/max(p_o10817_d, 0.0001), 0.0, 1.0));
vec2 o10754_0_d = abs(vec2(length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10762_x, p_o10762_y, p_o10762_z)).xz),(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10762_x, p_o10762_y, p_o10762_z)).y)) - vec2(p_o10754_r,p_o10754_l);
float o10754_0_1_sdf3d = min(max(o10754_0_d.x,o10754_0_d.y),0.0) + length(max(o10754_0_d,0.0));
vec2 o10755_0_v = vec2(o10754_0_1_sdf3d, 0.0);vec2 o10755_0_1_sdf3dc = vec2(o10755_0_v.x-p_o10755_r, o10755_0_v.y);
vec2 o10762_0_1_sdf3dc = o10755_0_1_sdf3dc;
vec3 o10833_0_1_tex3d = mix(o10834_0_1_tex3d, o10817_0_1_tex3d, clamp((o10762_0_1_sdf3dc).x/max(p_o10833_d, 0.0001), 0.0, 1.0));
vec2 o10780_0_d = abs(vec2(length((circle_repeat_transform(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251))-vec3(p_o10781_x, p_o10781_y, p_o10781_z)), p_o10782_c)).xz),(circle_repeat_transform(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251))-vec3(p_o10781_x, p_o10781_y, p_o10781_z)), p_o10782_c)).y)) - vec2(p_o10780_r,p_o10780_l);
float o10780_0_1_sdf3d = min(max(o10780_0_d.x,o10780_0_d.y),0.0) + length(max(o10780_0_d,0.0));
vec2 o10782_0_1_sdf3dc = vec2(o10780_0_1_sdf3d, 0.0);
vec2 o10781_0_1_sdf3dc = o10782_0_1_sdf3dc;
vec2 o10778_0_q = vec2(length((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251)).xy)-p_o10778_R,(rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10785_x, p_o10785_y, p_o10785_z)), -vec3(p_o10784_ax, p_o10784_ay, p_o10784_az)*0.01745329251)).z);
float o10778_0_1_sdf3d = length(o10778_0_q)-p_o10778_r;
vec2 o10779_0_1_sdf3dc = sdf3d_smooth_subtraction(o10781_0_1_sdf3dc, vec2(o10778_0_1_sdf3d, 0.0), p_o10779_k);
vec2 o10784_0_1_sdf3dc = o10779_0_1_sdf3dc;
vec2 o10785_0_1_sdf3dc = o10784_0_1_sdf3dc;
vec3 o10860_0_1_tex3d = mix(o10847_0_1_tex3d, o10833_0_1_tex3d, clamp((o10785_0_1_sdf3dc).x/max(p_o10860_d, 0.0001), 0.0, 1.0));
vec2 o10775_0_d = abs(vec2(length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10773_x, p_o10773_y, p_o10773_z)).xz),(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).xyz-vec3(p_o10831_x, p_o10831_y, p_o10831_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o10832_ax, p_o10832_ay, p_o10832_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o10773_x, p_o10773_y, p_o10773_z)).y)) - vec2(p_o10775_r,p_o10775_l);
float o10775_0_1_sdf3d = min(max(o10775_0_d.x,o10775_0_d.y),0.0) + length(max(o10775_0_d,0.0));
vec2 o10774_0_v = vec2(o10775_0_1_sdf3d, 0.0);vec2 o10774_0_1_sdf3dc = vec2(o10774_0_v.x-p_o10774_r, o10774_0_v.y);
vec2 o10773_0_1_sdf3dc = o10774_0_1_sdf3dc;
vec3 o10861_0_1_tex3d = mix(o10862_0_1_tex3d, o10860_0_1_tex3d, clamp((o10773_0_1_sdf3dc).x/max(p_o10861_d, 0.0001), 0.0, 1.0));
vec3 o10831_0_1_tex3d = o10861_0_1_tex3d;
vec3 o10832_0_1_tex3d = o10831_0_1_tex3d;

return o10832_0_1_tex3d;
}
vec3 o10753_input_metallic(vec4 p, float _seed_variation_) {

return vec3(0.0);
}
const float p_o10803_g_0_pos = 0.918182000;
const float p_o10803_g_0_r = 0.777343988;
const float p_o10803_g_0_g = 0.777343988;
const float p_o10803_g_0_b = 0.777343988;
const float p_o10803_g_0_a = 1.000000000;
const float p_o10803_g_1_pos = 1.000000000;
const float p_o10803_g_1_r = 0.777343988;
const float p_o10803_g_1_g = 0.777343988;
const float p_o10803_g_1_b = 0.777343988;
const float p_o10803_g_1_a = 1.000000000;
vec4 o10803_g_gradient_fct(float x) {
  if (x < p_o10803_g_0_pos) {
    return vec4(p_o10803_g_0_r,p_o10803_g_0_g,p_o10803_g_0_b,p_o10803_g_0_a);
  } else if (x < p_o10803_g_1_pos) {
    return mix(vec4(p_o10803_g_0_r,p_o10803_g_0_g,p_o10803_g_0_b,p_o10803_g_0_a), vec4(p_o10803_g_1_r,p_o10803_g_1_g,p_o10803_g_1_b,p_o10803_g_1_a), ((x-p_o10803_g_0_pos)/(p_o10803_g_1_pos-p_o10803_g_0_pos)));
  }
  return vec4(p_o10803_g_1_r,p_o10803_g_1_g,p_o10803_g_1_b,p_o10803_g_1_a);
}
vec3 o10753_input_roughness(vec4 p, float _seed_variation_) {
vec3 o10803_0_1_tex3d = o10803_g_gradient_fct(dot(vec3(((p)).x+0.5), vec3(1.0))/3.0).rgb;

return o10803_0_1_tex3d;
}


vec2 GetDist(vec3 p) {
    float _seed_variation_ = seed_variation;

	vec2 d = o10753_input_distance(p, _seed_variation_);

	return d;
}
vec2 RayMarch(vec3 ro, vec3 rd) {
	float dO = 0.0;
	float color = 0.0;
	vec2 dS;
	
	for (int i = 0; i < MAX_STEPS; i++) {
		vec3 p = ro + dO * rd;
		dS = GetDist(p);
		dO += dS.x;
		
		if (dS.x < SURF_DIST || dO > MAX_DIST) {
			color = dS.y;
			break;
		}
	}
	return vec2(dO, color);
}
vec3 GetNormal(vec3 p) {
	vec2 e = vec2(1e-2, 0);
	
	vec3 n = GetDist(p).x - vec3(
		GetDist(p - e.xyy).x,
		GetDist(p - e.yxy).x,
		GetDist(p - e.yyx).x
	);
	
	return normalize(n);
}
void vertex() {
	elapsed_time = TIME;
	world_position = VERTEX;
	world_camera = (inverse(MODELVIEW_MATRIX) * vec4(0, 0, 0, 1)).xyz; //object space
	//world_camera = ( CAMERA_MATRIX  * vec4(0, 0, 0, 1)).xyz; //uncomment this to raymarch in world space
}
void fragment() {
    float _seed_variation_ = seed_variation;
	vec3 ro = world_camera*0.6;
	vec3 rd =  normalize(world_position*0.6 - ro);
	
	vec2 rm  = RayMarch(ro, rd);
	float d = rm.x;
	if (d >= MAX_DIST) {
		discard;
	} else {
		vec3 p = ro + rd * d;

		ALBEDO = o10753_input_albedo(vec4(p, rm.y), _seed_variation_);
		ROUGHNESS = o10753_input_roughness(vec4(p, rm.y), _seed_variation_).x;
		METALLIC = o10753_input_metallic(vec4(p, rm.y), _seed_variation_).x;

		NORMAL = (INV_CAMERA_MATRIX*WORLD_MATRIX*vec4(GetNormal(p), 0.0)).xyz;
	}
}



