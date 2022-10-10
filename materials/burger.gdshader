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


float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
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

float sdCylinder(vec3 p, float h, float r) {
	vec2 d = abs(vec2(length(p.xz), p.y)) - vec2(r, h);
	return min(max(d.x, d.y),0.0) + length(max(d, 0.0));
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

const float p_o1732894_ax = 180.000000000;
const float p_o1732894_ay = 0.000000000;
const float p_o1732894_az = 0.000000000;
const float p_o1732913_x = 0.000000000;
const float p_o1732913_y = -0.050000000;
const float p_o1732913_z = 0.000000000;
const float p_o1732895_k = 0.050000000;
const float p_o1732893_x = 0.000000000;
const float p_o1732893_y = 0.310000000;
const float p_o1732893_z = 0.000000000;
const float p_o1732892_sx = 0.500000000;
const float p_o1732892_sy = 0.300000000;
const float p_o1732892_sz = 0.500000000;
const float p_o1732892_r = 0.000000000;
const float p_o1732896_r = 0.400000000;
const float p_o1732907_x = 0.000000000;
const float p_o1732907_y = 0.040000000;
const float p_o1732907_z = 0.000000000;
const float p_o1732906_ax = 90.000000000;
const float p_o1732906_ay = 0.000000000;
const float p_o1732906_az = 0.000000000;
const float p_o1732903_k = 0.110000000;
const float p_o1732900_c = 5.000000000;
const float p_o1732901_x = 0.000000000;
const float p_o1732901_y = 0.320000000;
const float p_o1732901_z = 0.000000000;
const float p_o1732899_l = 0.010000000;
const float p_o1732899_r = 0.140000000;
const float p_o1732904_ax = 0.000000000;
const float p_o1732904_ay = 0.000000000;
const float p_o1732904_az = 30.000000000;
const float p_o1732902_c = 5.000000000;
const float p_o1732905_x = 0.000000000;
const float p_o1732905_y = 0.320000000;
const float p_o1732905_z = 0.000000000;
const float p_o1732898_x = 0.000000000;
const float p_o1732898_y = 0.120000000;
const float p_o1732898_z = 0.000000000;
const float p_o1732891_r = 0.030000000;
const float p_o1732890_l = 0.020000000;
const float p_o1732890_r = 0.350000000;
const float p_o1732909_x = 0.000000000;
const float p_o1732909_y = 0.270000000;
const float p_o1732909_z = 0.000000000;
const float p_o1732910_r = 0.070000000;
const float p_o1732911_l = 0.020000000;
const float p_o1732911_r = 0.350000000;
const float p_o1732921_x = 0.000000000;
const float p_o1732921_y = 0.230000000;
const float p_o1732921_z = 0.000000000;
const float p_o1732920_ax = -90.000000000;
const float p_o1732920_ay = 0.000000000;
const float p_o1732920_az = 0.000000000;
const float p_o1732915_k = 0.070000000;
const float p_o1732917_x = 0.000000000;
const float p_o1732917_y = 0.000000000;
const float p_o1732917_z = -0.110000000;
const float p_o1732918_c = 5.000000000;
const float p_o1732916_l = 0.460000000;
const float p_o1732916_r = 0.120000000;
const float p_o1732914_R = 0.360000000;
const float p_o1732914_r = 0.090000000;
const float p_o1732924_x = 0.000000000;
const float p_o1732924_y = 0.430000000;
const float p_o1732924_z = 0.000000000;
const float p_o1732923_r = 0.030000000;
const float p_o1732922_l = 0.030000000;
const float p_o1732922_r = 0.380000000;
vec2 o1732889_input_distance(vec3 p, float _seed_variation_) {
float o1732892_0_1_sdf3d = box3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732893_x, p_o1732893_y, p_o1732893_z)), vec3(p_o1732892_sx, p_o1732892_sy, p_o1732892_sz))-p_o1732892_r;
vec2 o1732893_0_1_sdf3dc = vec2(o1732892_0_1_sdf3d, 0.0);
float o1732896_0_1_sdf3d = length(((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z)))-p_o1732896_r;
vec2 o1732895_0_1_sdf3dc = sdf3d_smooth_subtraction(o1732893_0_1_sdf3dc, vec2(o1732896_0_1_sdf3d, 0.0), p_o1732895_k);
float o1732899_0_1_sdf3d = sdCylinder(((circle_repeat_transform((rotate3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732907_x, p_o1732907_y, p_o1732907_z)), -vec3(p_o1732906_ax, p_o1732906_ay, p_o1732906_az)*0.01745329251)), p_o1732900_c))-vec3(p_o1732901_x, p_o1732901_y, p_o1732901_z)).xzy, p_o1732899_l, p_o1732899_r);
vec2 o1732901_0_1_sdf3dc = vec2(o1732899_0_1_sdf3d, 0.0);
vec2 o1732900_0_1_sdf3dc = o1732901_0_1_sdf3dc;
float o1732899_0_3_sdf3d = sdCylinder(((circle_repeat_transform((rotate3d((rotate3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732907_x, p_o1732907_y, p_o1732907_z)), -vec3(p_o1732906_ax, p_o1732906_ay, p_o1732906_az)*0.01745329251)), -vec3(p_o1732904_ax, p_o1732904_ay, p_o1732904_az)*0.01745329251)), p_o1732902_c))-vec3(p_o1732905_x, p_o1732905_y, p_o1732905_z)).xzy, p_o1732899_l, p_o1732899_r);
vec2 o1732905_0_1_sdf3dc = vec2(o1732899_0_3_sdf3d, 0.0);
vec2 o1732902_0_1_sdf3dc = o1732905_0_1_sdf3dc;
vec2 o1732904_0_1_sdf3dc = o1732902_0_1_sdf3dc;
vec2 o1732903_0_1_sdf3dc = sdf3d_smooth_union(o1732900_0_1_sdf3dc, o1732904_0_1_sdf3dc, p_o1732903_k);
vec2 o1732906_0_1_sdf3dc = o1732903_0_1_sdf3dc;
vec2 o1732907_0_1_sdf3dc = o1732906_0_1_sdf3dc;
vec2 o1732897_0_1_sdf3dc = sdf3dc_union(o1732895_0_1_sdf3dc, o1732907_0_1_sdf3dc);
float o1732890_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732898_x, p_o1732898_y, p_o1732898_z)), p_o1732890_l, p_o1732890_r);
vec2 o1732891_0_v = vec2(o1732890_0_1_sdf3d, 0.0);vec2 o1732891_0_1_sdf3dc = vec2(o1732891_0_v.x-p_o1732891_r, o1732891_0_v.y);
vec2 o1732898_0_1_sdf3dc = o1732891_0_1_sdf3dc;
vec2 o1732908_0_1_sdf3dc = sdf3dc_union(o1732897_0_1_sdf3dc, o1732898_0_1_sdf3dc);
float o1732911_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732909_x, p_o1732909_y, p_o1732909_z)), p_o1732911_l, p_o1732911_r);
vec2 o1732910_0_v = vec2(o1732911_0_1_sdf3d, 0.0);vec2 o1732910_0_1_sdf3dc = vec2(o1732910_0_v.x-p_o1732910_r, o1732910_0_v.y);
vec2 o1732909_0_1_sdf3dc = o1732910_0_1_sdf3dc;
vec2 o1732912_0_1_sdf3dc = sdf3dc_union(o1732908_0_1_sdf3dc, o1732909_0_1_sdf3dc);
float o1732916_0_1_sdf3d = sdCylinder((circle_repeat_transform(((rotate3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251))-vec3(p_o1732917_x, p_o1732917_y, p_o1732917_z)), p_o1732918_c)), p_o1732916_l, p_o1732916_r);
vec2 o1732918_0_1_sdf3dc = vec2(o1732916_0_1_sdf3d, 0.0);
vec2 o1732917_0_1_sdf3dc = o1732918_0_1_sdf3dc;
vec2 o1732914_0_q = vec2(length((rotate3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251)).xy)-p_o1732914_R,(rotate3d((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251)).z);
float o1732914_0_1_sdf3d = length(o1732914_0_q)-p_o1732914_r;
vec2 o1732915_0_1_sdf3dc = sdf3d_smooth_subtraction(o1732917_0_1_sdf3dc, vec2(o1732914_0_1_sdf3d, 0.0), p_o1732915_k);
vec2 o1732920_0_1_sdf3dc = o1732915_0_1_sdf3dc;
vec2 o1732921_0_1_sdf3dc = o1732920_0_1_sdf3dc;
vec2 o1732919_0_1_sdf3dc = sdf3dc_union(o1732912_0_1_sdf3dc, o1732921_0_1_sdf3dc);
float o1732922_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o1732894_ax, p_o1732894_ay, p_o1732894_az)*0.01745329251))-vec3(p_o1732913_x, p_o1732913_y, p_o1732913_z))-vec3(p_o1732924_x, p_o1732924_y, p_o1732924_z)), p_o1732922_l, p_o1732922_r);
vec2 o1732923_0_v = vec2(o1732922_0_1_sdf3d, 0.0);vec2 o1732923_0_1_sdf3dc = vec2(o1732923_0_v.x-p_o1732923_r, o1732923_0_v.y);
vec2 o1732924_0_1_sdf3dc = o1732923_0_1_sdf3dc;
vec2 o1732925_0_1_sdf3dc = sdf3dc_union(o1732919_0_1_sdf3dc, o1732924_0_1_sdf3dc);
vec2 o1732913_0_1_sdf3dc = o1732925_0_1_sdf3dc;
vec2 o1732894_0_1_sdf3dc = o1732913_0_1_sdf3dc;

return o1732894_0_1_sdf3dc;
}
const float p_o1732968_ax = 180.000000000;
const float p_o1732968_ay = 0.000000000;
const float p_o1732968_az = 0.000000000;
const float p_o1732967_x = 0.000000000;
const float p_o1732967_y = -0.050000000;
const float p_o1732967_z = 0.000000000;
const float p_o1732997_d = 0.010000000;
const float p_o1732998_g_0_pos = 0.672727000;
const float p_o1732998_g_0_r = 0.273438007;
const float p_o1732998_g_0_g = 0.134582996;
const float p_o1732998_g_0_b = 0.000000000;
const float p_o1732998_g_0_a = 1.000000000;
const float p_o1732998_g_1_pos = 0.845455000;
const float p_o1732998_g_1_r = 0.273438007;
const float p_o1732998_g_1_g = 0.134582996;
const float p_o1732998_g_1_b = 0.000000000;
const float p_o1732998_g_1_a = 1.000000000;
vec4 o1732998_g_gradient_fct(float x) {
  if (x < p_o1732998_g_0_pos) {
    return vec4(p_o1732998_g_0_r,p_o1732998_g_0_g,p_o1732998_g_0_b,p_o1732998_g_0_a);
  } else if (x < p_o1732998_g_1_pos) {
    return mix(vec4(p_o1732998_g_0_r,p_o1732998_g_0_g,p_o1732998_g_0_b,p_o1732998_g_0_a), vec4(p_o1732998_g_1_r,p_o1732998_g_1_g,p_o1732998_g_1_b,p_o1732998_g_1_a), ((x-p_o1732998_g_0_pos)/(p_o1732998_g_1_pos-p_o1732998_g_0_pos)));
  }
  return vec4(p_o1732998_g_1_r,p_o1732998_g_1_g,p_o1732998_g_1_b,p_o1732998_g_1_a);
}
const float p_o1732996_d = 0.010000000;
const float p_o1732983_g_0_pos = 0.909091000;
const float p_o1732983_g_0_r = 0.960937977;
const float p_o1732983_g_0_g = 0.827799976;
const float p_o1732983_g_0_b = 0.108856000;
const float p_o1732983_g_0_a = 1.000000000;
const float p_o1732983_g_1_pos = 1.000000000;
const float p_o1732983_g_1_r = 0.960937977;
const float p_o1732983_g_1_g = 0.827799976;
const float p_o1732983_g_1_b = 0.108856000;
const float p_o1732983_g_1_a = 1.000000000;
vec4 o1732983_g_gradient_fct(float x) {
  if (x < p_o1732983_g_0_pos) {
    return vec4(p_o1732983_g_0_r,p_o1732983_g_0_g,p_o1732983_g_0_b,p_o1732983_g_0_a);
  } else if (x < p_o1732983_g_1_pos) {
    return mix(vec4(p_o1732983_g_0_r,p_o1732983_g_0_g,p_o1732983_g_0_b,p_o1732983_g_0_a), vec4(p_o1732983_g_1_r,p_o1732983_g_1_g,p_o1732983_g_1_b,p_o1732983_g_1_a), ((x-p_o1732983_g_0_pos)/(p_o1732983_g_1_pos-p_o1732983_g_0_pos)));
  }
  return vec4(p_o1732983_g_1_r,p_o1732983_g_1_g,p_o1732983_g_1_b,p_o1732983_g_1_a);
}
const float p_o1732969_d = 0.010000000;
const float p_o1732970_g_0_pos = 0.900000000;
const float p_o1732970_g_0_r = 0.960937977;
const float p_o1732970_g_0_g = 0.188739002;
const float p_o1732970_g_0_b = 0.108856000;
const float p_o1732970_g_0_a = 1.000000000;
const float p_o1732970_g_1_pos = 1.000000000;
const float p_o1732970_g_1_r = 0.960937977;
const float p_o1732970_g_1_g = 0.188739002;
const float p_o1732970_g_1_b = 0.108856000;
const float p_o1732970_g_1_a = 1.000000000;
vec4 o1732970_g_gradient_fct(float x) {
  if (x < p_o1732970_g_0_pos) {
    return vec4(p_o1732970_g_0_r,p_o1732970_g_0_g,p_o1732970_g_0_b,p_o1732970_g_0_a);
  } else if (x < p_o1732970_g_1_pos) {
    return mix(vec4(p_o1732970_g_0_r,p_o1732970_g_0_g,p_o1732970_g_0_b,p_o1732970_g_0_a), vec4(p_o1732970_g_1_r,p_o1732970_g_1_g,p_o1732970_g_1_b,p_o1732970_g_1_a), ((x-p_o1732970_g_0_pos)/(p_o1732970_g_1_pos-p_o1732970_g_0_pos)));
  }
  return vec4(p_o1732970_g_1_r,p_o1732970_g_1_g,p_o1732970_g_1_b,p_o1732970_g_1_a);
}
const float p_o1732953_d = 0.010000000;
const float p_o1732954_g_0_pos = 0.745454000;
const float p_o1732954_g_0_r = 0.000000000;
const float p_o1732954_g_0_g = 0.683593988;
const float p_o1732954_g_0_b = 0.138854995;
const float p_o1732954_g_0_a = 1.000000000;
const float p_o1732954_g_1_pos = 0.936364000;
const float p_o1732954_g_1_r = 0.000000000;
const float p_o1732954_g_1_g = 0.683593988;
const float p_o1732954_g_1_b = 0.138854995;
const float p_o1732954_g_1_a = 1.000000000;
vec4 o1732954_g_gradient_fct(float x) {
  if (x < p_o1732954_g_0_pos) {
    return vec4(p_o1732954_g_0_r,p_o1732954_g_0_g,p_o1732954_g_0_b,p_o1732954_g_0_a);
  } else if (x < p_o1732954_g_1_pos) {
    return mix(vec4(p_o1732954_g_0_r,p_o1732954_g_0_g,p_o1732954_g_0_b,p_o1732954_g_0_a), vec4(p_o1732954_g_1_r,p_o1732954_g_1_g,p_o1732954_g_1_b,p_o1732954_g_1_a), ((x-p_o1732954_g_0_pos)/(p_o1732954_g_1_pos-p_o1732954_g_0_pos)));
  }
  return vec4(p_o1732954_g_1_r,p_o1732954_g_1_g,p_o1732954_g_1_b,p_o1732954_g_1_a);
}
const float p_o1732926_g_0_pos = 0.754545000;
const float p_o1732926_g_0_r = 0.753906012;
const float p_o1732926_g_0_g = 0.575553000;
const float p_o1732926_g_0_b = 0.418181986;
const float p_o1732926_g_0_a = 1.000000000;
const float p_o1732926_g_1_pos = 0.890909000;
const float p_o1732926_g_1_r = 0.753906012;
const float p_o1732926_g_1_g = 0.575553000;
const float p_o1732926_g_1_b = 0.418181986;
const float p_o1732926_g_1_a = 1.000000000;
vec4 o1732926_g_gradient_fct(float x) {
  if (x < p_o1732926_g_0_pos) {
    return vec4(p_o1732926_g_0_r,p_o1732926_g_0_g,p_o1732926_g_0_b,p_o1732926_g_0_a);
  } else if (x < p_o1732926_g_1_pos) {
    return mix(vec4(p_o1732926_g_0_r,p_o1732926_g_0_g,p_o1732926_g_0_b,p_o1732926_g_0_a), vec4(p_o1732926_g_1_r,p_o1732926_g_1_g,p_o1732926_g_1_b,p_o1732926_g_1_a), ((x-p_o1732926_g_0_pos)/(p_o1732926_g_1_pos-p_o1732926_g_0_pos)));
  }
  return vec4(p_o1732926_g_1_r,p_o1732926_g_1_g,p_o1732926_g_1_b,p_o1732926_g_1_a);
}
vec3 o1732889_input_albedo(vec4 p, float _seed_variation_) {
vec3 o1732998_0_1_tex3d = o1732998_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o1732983_0_1_tex3d = o1732983_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o1732970_0_1_tex3d = o1732970_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o1732954_0_1_tex3d = o1732954_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o1732926_0_1_tex3d = o1732926_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
float o1732899_0_1_sdf3d = sdCylinder(((circle_repeat_transform((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732907_x, p_o1732907_y, p_o1732907_z)), -vec3(p_o1732906_ax, p_o1732906_ay, p_o1732906_az)*0.01745329251)), p_o1732900_c))-vec3(p_o1732901_x, p_o1732901_y, p_o1732901_z)).xzy, p_o1732899_l, p_o1732899_r);
vec2 o1732901_0_1_sdf3dc = vec2(o1732899_0_1_sdf3d, 0.0);
vec2 o1732900_0_1_sdf3dc = o1732901_0_1_sdf3dc;
float o1732899_0_3_sdf3d = sdCylinder(((circle_repeat_transform((rotate3d((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732907_x, p_o1732907_y, p_o1732907_z)), -vec3(p_o1732906_ax, p_o1732906_ay, p_o1732906_az)*0.01745329251)), -vec3(p_o1732904_ax, p_o1732904_ay, p_o1732904_az)*0.01745329251)), p_o1732902_c))-vec3(p_o1732905_x, p_o1732905_y, p_o1732905_z)).xzy, p_o1732899_l, p_o1732899_r);
vec2 o1732905_0_1_sdf3dc = vec2(o1732899_0_3_sdf3d, 0.0);
vec2 o1732902_0_1_sdf3dc = o1732905_0_1_sdf3dc;
vec2 o1732904_0_1_sdf3dc = o1732902_0_1_sdf3dc;
vec2 o1732903_0_1_sdf3dc = sdf3d_smooth_union(o1732900_0_1_sdf3dc, o1732904_0_1_sdf3dc, p_o1732903_k);
vec2 o1732906_0_1_sdf3dc = o1732903_0_1_sdf3dc;
vec2 o1732907_0_1_sdf3dc = o1732906_0_1_sdf3dc;
vec3 o1732953_0_1_tex3d = mix(o1732954_0_1_tex3d, o1732926_0_1_tex3d, clamp((o1732907_0_1_sdf3dc).x/max(p_o1732953_d, 0.0001), 0.0, 1.0));
float o1732890_0_1_sdf3d = sdCylinder((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732898_x, p_o1732898_y, p_o1732898_z)), p_o1732890_l, p_o1732890_r);
vec2 o1732891_0_v = vec2(o1732890_0_1_sdf3d, 0.0);vec2 o1732891_0_1_sdf3dc = vec2(o1732891_0_v.x-p_o1732891_r, o1732891_0_v.y);
vec2 o1732898_0_1_sdf3dc = o1732891_0_1_sdf3dc;
vec3 o1732969_0_1_tex3d = mix(o1732970_0_1_tex3d, o1732953_0_1_tex3d, clamp((o1732898_0_1_sdf3dc).x/max(p_o1732969_d, 0.0001), 0.0, 1.0));
float o1732916_0_1_sdf3d = sdCylinder((circle_repeat_transform(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251))-vec3(p_o1732917_x, p_o1732917_y, p_o1732917_z)), p_o1732918_c)), p_o1732916_l, p_o1732916_r);
vec2 o1732918_0_1_sdf3dc = vec2(o1732916_0_1_sdf3d, 0.0);
vec2 o1732917_0_1_sdf3dc = o1732918_0_1_sdf3dc;
vec2 o1732914_0_q = vec2(length((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251)).xy)-p_o1732914_R,(rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732921_x, p_o1732921_y, p_o1732921_z)), -vec3(p_o1732920_ax, p_o1732920_ay, p_o1732920_az)*0.01745329251)).z);
float o1732914_0_1_sdf3d = length(o1732914_0_q)-p_o1732914_r;
vec2 o1732915_0_1_sdf3dc = sdf3d_smooth_subtraction(o1732917_0_1_sdf3dc, vec2(o1732914_0_1_sdf3d, 0.0), p_o1732915_k);
vec2 o1732920_0_1_sdf3dc = o1732915_0_1_sdf3dc;
vec2 o1732921_0_1_sdf3dc = o1732920_0_1_sdf3dc;
vec3 o1732996_0_1_tex3d = mix(o1732983_0_1_tex3d, o1732969_0_1_tex3d, clamp((o1732921_0_1_sdf3dc).x/max(p_o1732996_d, 0.0001), 0.0, 1.0));
float o1732911_0_1_sdf3d = sdCylinder((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).xyz-vec3(p_o1732967_x, p_o1732967_y, p_o1732967_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o1732968_ax, p_o1732968_ay, p_o1732968_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o1732909_x, p_o1732909_y, p_o1732909_z)), p_o1732911_l, p_o1732911_r);
vec2 o1732910_0_v = vec2(o1732911_0_1_sdf3d, 0.0);vec2 o1732910_0_1_sdf3dc = vec2(o1732910_0_v.x-p_o1732910_r, o1732910_0_v.y);
vec2 o1732909_0_1_sdf3dc = o1732910_0_1_sdf3dc;
vec3 o1732997_0_1_tex3d = mix(o1732998_0_1_tex3d, o1732996_0_1_tex3d, clamp((o1732909_0_1_sdf3dc).x/max(p_o1732997_d, 0.0001), 0.0, 1.0));
vec3 o1732967_0_1_tex3d = o1732997_0_1_tex3d;
vec3 o1732968_0_1_tex3d = o1732967_0_1_tex3d;

return o1732968_0_1_tex3d;
}
vec3 o1732889_input_metallic(vec4 p, float _seed_variation_) {

return vec3(0.0);
}
const float p_o1732939_g_0_pos = 0.918182000;
const float p_o1732939_g_0_r = 0.777343988;
const float p_o1732939_g_0_g = 0.777343988;
const float p_o1732939_g_0_b = 0.777343988;
const float p_o1732939_g_0_a = 1.000000000;
const float p_o1732939_g_1_pos = 1.000000000;
const float p_o1732939_g_1_r = 0.777343988;
const float p_o1732939_g_1_g = 0.777343988;
const float p_o1732939_g_1_b = 0.777343988;
const float p_o1732939_g_1_a = 1.000000000;
vec4 o1732939_g_gradient_fct(float x) {
  if (x < p_o1732939_g_0_pos) {
    return vec4(p_o1732939_g_0_r,p_o1732939_g_0_g,p_o1732939_g_0_b,p_o1732939_g_0_a);
  } else if (x < p_o1732939_g_1_pos) {
    return mix(vec4(p_o1732939_g_0_r,p_o1732939_g_0_g,p_o1732939_g_0_b,p_o1732939_g_0_a), vec4(p_o1732939_g_1_r,p_o1732939_g_1_g,p_o1732939_g_1_b,p_o1732939_g_1_a), ((x-p_o1732939_g_0_pos)/(p_o1732939_g_1_pos-p_o1732939_g_0_pos)));
  }
  return vec4(p_o1732939_g_1_r,p_o1732939_g_1_g,p_o1732939_g_1_b,p_o1732939_g_1_a);
}
vec3 o1732889_input_roughness(vec4 p, float _seed_variation_) {
vec3 o1732939_0_1_tex3d = o1732939_g_gradient_fct(dot(vec3(((p)).x+0.5), vec3(1.0))/3.0).rgb;

return o1732939_0_1_tex3d;
}


vec2 GetDist(vec3 p) {
    float _seed_variation_ = seed_variation;

	vec2 d = o1732889_input_distance(p, _seed_variation_);

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
	vec3 ro = world_camera;
	vec3 rd =  normalize(world_position - ro);
	
	vec2 rm  = RayMarch(ro, rd);
	float d = rm.x;
	if (d >= MAX_DIST) {
		discard;
	} else {
		vec3 p = ro + rd * d;

		ALBEDO = o1732889_input_albedo(vec4(p, rm.y), _seed_variation_);
		ROUGHNESS = o1732889_input_roughness(vec4(p, rm.y), _seed_variation_).x;
		METALLIC = o1732889_input_metallic(vec4(p, rm.y), _seed_variation_).x;

		NORMAL = (INV_VIEW_MATRIX*vec4(GetNormal(p), 0.0)).xyz;
	}
}



