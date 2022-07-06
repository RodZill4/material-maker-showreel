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


float sdCylinder(vec3 p, float h, float r) {
	vec2 d = abs(vec2(length(p.xz), p.y)) - vec2(r, h);
	return min(max(d.x, d.y),0.0) + length(max(d, 0.0));
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

float sdCapsule(vec3 p, float h, float r) {
	p.y -= clamp(p.y, -h, h);
	return length(p)-r;
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

float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
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

const float p_o2089621_ax = 0.000000000;
const float p_o2089621_ay = 90.000000000;
const float p_o2089621_az = 0.000000000;
const float p_o2089524_x = 0.000000000;
const float p_o2089524_y = -0.440000000;
const float p_o2089524_z = 0.000000000;
const float p_o2089523_x = 0.000000000;
const float p_o2089523_y = 0.910000000;
const float p_o2089523_z = -0.010000000;
const float p_o2089525_ax = 14.000000000;
const float p_o2089525_ay = 0.000000000;
const float p_o2089525_az = 0.000000000;
const float p_o2089518_l = 0.005000000;
const float p_o2089518_r = 0.246883000;
const float p_o2089521_x = 0.000000000;
const float p_o2089521_y = 0.140000000;
const float p_o2089521_z = 0.000000000;
const float p_o2089520_l = 0.130000000;
const float p_o2089520_r = 0.178313000;
const float p_o2089515_k = 0.030000000;
const float p_o2089512_k = 0.030000000;
const float p_o2089511_r = 0.370000000;
const float p_o2089514_x = 0.000000000;
const float p_o2089514_y = 0.450000000;
const float p_o2089514_z = 0.000000000;
const float p_o2089513_r = 0.266819000;
const float p_o2089516_x = 0.000000000;
const float p_o2089516_y = 0.790000000;
const float p_o2089516_z = 0.000000000;
const float p_o2089517_r = 0.180000000;
const float p_o2089655_x = 0.000000000;
const float p_o2089655_y = 0.560000000;
const float p_o2089655_z = -0.230000000;
const float p_o2089654_ay = 0.000000000;
const float p_o2089654_az = 0.000000000;
const float p_o2089656_x = 0.000000000;
const float p_o2089656_y = 0.100000000;
const float p_o2089656_z = 0.000000000;
const float p_o2089652_l = 0.100000000;
const float p_o2089652_r = 0.010000000;
const float p_o2089657_x = 0.000000000;
const float p_o2089657_y = 0.190000000;
const float p_o2089657_z = 0.000000000;
const float p_o2089659_ay = 0.000000000;
const float p_o2089659_az = 0.000000000;
const float p_o2089667_x = 0.000000000;
const float p_o2089667_y = 0.200000000;
const float p_o2089667_z = 0.000000000;
const float p_o2089668_ax = 0.000000000;
const float p_o2089668_ay = 90.000000000;
const float p_o2089665_x = 0.000000000;
const float p_o2089665_y = 0.005000000;
const float p_o2089665_z = 0.000000000;
const float p_o2089662_c = 9.000000000;
const float p_o2089661_x = 0.000000000;
const float p_o2089661_y = 0.040000000;
const float p_o2089661_z = 0.000000000;
const float p_o2089660_l = 0.040000000;
const float p_o2089660_r = 0.010000000;
const float p_o2089676_x = 0.000000000;
const float p_o2089676_y = 0.570000000;
const float p_o2089676_z = 0.230000000;
const float p_o2089677_ax = -126.000000000;
const float p_o2089677_ay = 0.000000000;
const float p_o2089677_az = 0.000000000;
const float p_o2089670_x = 0.000000000;
const float p_o2089670_y = 0.100000000;
const float p_o2089670_z = 0.000000000;
const float p_o2089669_l = 0.100000000;
const float p_o2089669_r = 0.010000000;
const float p_o2089673_x = 0.000000000;
const float p_o2089673_y = 0.190000000;
const float p_o2089673_z = 0.000000000;
const float p_o2089674_ax = -30.000000000;
const float p_o2089674_ay = 0.000000000;
const float p_o2089674_az = 0.000000000;
const float p_o2089675_x = 0.000000000;
const float p_o2089675_y = 0.200000000;
const float p_o2089675_z = 0.000000000;
const float p_o2089672_ax = 0.000000000;
const float p_o2089672_ay = 90.000000000;
const float p_o2089672_az = 0.000000000;
const float p_o2089625_x = 0.000000000;
const float p_o2089625_y = 0.690000000;
const float p_o2089625_z = 0.000000000;
const float p_o2089624_r = 0.030000000;
const float p_o2089623_l = 0.010000000;
const float p_o2089623_r = 0.170000000;
const float p_o2089635_ax = 0.000000000;
const float p_o2089635_ay = 47.000000000;
const float p_o2089635_az = 0.000000000;
const float p_o2089633_x = -0.030000000;
const float p_o2089633_y = 0.390000000;
const float p_o2089633_z = 0.000000000;
const float p_o2089634_ax = 0.000000000;
const float p_o2089634_ay = 0.000000000;
const float p_o2089634_az = -27.000000000;
const float p_o2089629_l = 0.300000000;
const float p_o2089629_r = 0.300000000;
const float p_o2089627_l = 0.060000000;
const float p_o2089627_r = 0.340000000;
const float p_o2089630_angle = 65.000000000;
const float p_o2089531_x = 0.000000000;
const float p_o2089531_y = 0.800000000;
const float p_o2089531_z = 0.000000000;
const float p_o2089529_x = -0.420000000;
const float p_o2089529_y = 0.000000000;
const float p_o2089529_z = 0.000000000;
const float p_o2089526_a = 6.000000000;
const float p_o2089589_x = -0.150000000;
const float p_o2089589_y = 0.840000000;
const float p_o2089589_z = 0.070000000;
const float p_o2089588_ax = 90.000000000;
const float p_o2089588_ay = 100.000000000;
const float p_o2089588_az = 0.000000000;
const float p_o2089580_s = 0.090000000;
const float p_o2089574_r = 0.140000000;
const float p_o2089575_amount = 0.590000000;
const float p_o2089576_sx = 0.250000000;
const float p_o2089576_sy = 0.250000000;
const float p_o2089576_sz = 0.000000000;
const float p_o2089576_r = 0.010000000;
const float p_o2089577_r = 0.260000000;
const float p_o2089590_x = -0.150000000;
const float p_o2089590_y = 0.840000000;
const float p_o2089590_z = -0.060000000;
const float p_o2089581_x = -0.250000000;
const float p_o2089581_y = 0.550000000;
const float p_o2089581_z = 0.000000000;
const float p_o2089579_ax = 90.000000000;
const float p_o2089579_ay = 100.000000000;
const float p_o2089579_az = 0.000000000;
const float p_o2089583_x = -0.260000000;
const float p_o2089583_y = 0.390000000;
const float p_o2089583_z = 0.000000000;
const float p_o2089584_ax = 90.000000000;
const float p_o2089584_ay = 86.000000000;
const float p_o2089584_az = 0.000000000;
const float p_o2089585_x = -0.310000000;
const float p_o2089585_y = 0.210000000;
const float p_o2089585_z = 0.000000000;
const float p_o2089586_ax = 90.000000000;
const float p_o2089586_ay = 120.000000000;
const float p_o2089586_az = 0.000000000;
vec2 o2089510_input_distance(vec3 p, float _seed_variation_) {
float o2089518_0_1_sdf3d = sdCylinder((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089523_x, p_o2089523_y, p_o2089523_z)), -vec3(p_o2089525_ax, p_o2089525_ay, p_o2089525_az)*0.01745329251)), p_o2089518_l, p_o2089518_r);
float o2089520_0_1_sdf3d = sdCylinder(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089523_x, p_o2089523_y, p_o2089523_z)), -vec3(p_o2089525_ax, p_o2089525_ay, p_o2089525_az)*0.01745329251))-vec3(p_o2089521_x, p_o2089521_y, p_o2089521_z)), p_o2089520_l, p_o2089520_r);
vec2 o2089521_0_1_sdf3dc = vec2(o2089520_0_1_sdf3d, 0.0);
vec2 o2089519_0_1_sdf3dc = sdf3dc_union(vec2(o2089518_0_1_sdf3d, 0.0), o2089521_0_1_sdf3dc);
vec2 o2089525_0_1_sdf3dc = o2089519_0_1_sdf3dc;
vec2 o2089523_0_1_sdf3dc = o2089525_0_1_sdf3dc;
float o2089511_0_1_sdf3d = length(((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z)))-p_o2089511_r;
float o2089513_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089514_x, p_o2089514_y, p_o2089514_z)))-p_o2089513_r;
vec2 o2089514_0_1_sdf3dc = vec2(o2089513_0_1_sdf3d, 0.0);
vec2 o2089512_0_1_sdf3dc = sdf3d_smooth_union(vec2(o2089511_0_1_sdf3d, 0.0), o2089514_0_1_sdf3dc, p_o2089512_k);
float o2089517_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089516_x, p_o2089516_y, p_o2089516_z)))-p_o2089517_r;
vec2 o2089516_0_1_sdf3dc = vec2(o2089517_0_1_sdf3d, 0.0);
vec2 o2089515_0_1_sdf3dc = sdf3d_smooth_union(o2089512_0_1_sdf3dc, o2089516_0_1_sdf3dc, p_o2089515_k);
vec3 o2089652_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089655_x, p_o2089655_y, p_o2089655_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089654_ay, p_o2089654_az)*0.01745329251))-vec3(p_o2089656_x, p_o2089656_y, p_o2089656_z));
o2089652_0_p.y -= clamp(o2089652_0_p.y, -p_o2089652_l, p_o2089652_l);
float o2089652_0_1_sdf3d = length(o2089652_0_p)-p_o2089652_r*1.0;
vec2 o2089656_0_1_sdf3dc = vec2(o2089652_0_1_sdf3d, 0.0);
vec3 o2089652_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089655_x, p_o2089655_y, p_o2089655_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089654_ay, p_o2089654_az)*0.01745329251))-vec3(p_o2089657_x, p_o2089657_y, p_o2089657_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089659_ay, p_o2089659_az)*0.01745329251))-vec3(p_o2089656_x, p_o2089656_y, p_o2089656_z));
o2089652_3_p.y -= clamp(o2089652_3_p.y, -p_o2089652_l, p_o2089652_l);
float o2089652_0_4_sdf3d = length(o2089652_3_p)-p_o2089652_r*1.0;
vec2 o2089656_0_3_sdf3dc = vec2(o2089652_0_4_sdf3d, 0.0);
float o2089663_0_1_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089655_x, p_o2089655_y, p_o2089655_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089654_ay, p_o2089654_az)*0.01745329251))-vec3(p_o2089657_x, p_o2089657_y, p_o2089657_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089659_ay, p_o2089659_az)*0.01745329251))-vec3(p_o2089667_x, p_o2089667_y, p_o2089667_z)), -vec3(p_o2089668_ax, p_o2089668_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251)).y;
vec3 o2089660_0_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089655_x, p_o2089655_y, p_o2089655_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089654_ay, p_o2089654_az)*0.01745329251))-vec3(p_o2089657_x, p_o2089657_y, p_o2089657_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o2089659_ay, p_o2089659_az)*0.01745329251))-vec3(p_o2089667_x, p_o2089667_y, p_o2089667_z)), -vec3(p_o2089668_ax, p_o2089668_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251))-vec3(p_o2089665_x, p_o2089665_y, p_o2089665_z)), p_o2089662_c))-vec3(p_o2089661_x, p_o2089661_y, p_o2089661_z));
o2089660_0_p.y -= clamp(o2089660_0_p.y, -p_o2089660_l, p_o2089660_l);
float o2089660_0_1_sdf3d = length(o2089660_0_p)-p_o2089660_r*1.0;
vec2 o2089661_0_1_sdf3dc = vec2(o2089660_0_1_sdf3d, 0.0);
vec2 o2089662_0_1_sdf3dc = o2089661_0_1_sdf3dc;
vec2 o2089665_0_1_sdf3dc = o2089662_0_1_sdf3dc;
vec2 o2089664_0_1_sdf3dc = sdf3dc_sub(vec2(o2089663_0_1_sdf3d, 0.0), o2089665_0_1_sdf3dc);
vec2 o2089668_0_1_sdf3dc = o2089664_0_1_sdf3dc;
vec2 o2089667_0_1_sdf3dc = o2089668_0_1_sdf3dc;
vec2 o2089666_0_1_sdf3dc = sdf3dc_union(o2089656_0_3_sdf3dc, o2089667_0_1_sdf3dc);
vec2 o2089659_0_1_sdf3dc = o2089666_0_1_sdf3dc;
vec2 o2089657_0_1_sdf3dc = o2089659_0_1_sdf3dc;
vec2 o2089658_0_1_sdf3dc = sdf3dc_union(o2089656_0_1_sdf3dc, o2089657_0_1_sdf3dc);
vec2 o2089654_0_1_sdf3dc = o2089658_0_1_sdf3dc;
vec2 o2089655_0_1_sdf3dc = o2089654_0_1_sdf3dc;
vec3 o2089669_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089676_x, p_o2089676_y, p_o2089676_z)), -vec3(p_o2089677_ax, p_o2089677_ay, p_o2089677_az)*0.01745329251))-vec3(p_o2089670_x, p_o2089670_y, p_o2089670_z));
o2089669_0_p.y -= clamp(o2089669_0_p.y, -p_o2089669_l, p_o2089669_l);
float o2089669_0_1_sdf3d = length(o2089669_0_p)-p_o2089669_r*1.0;
vec2 o2089670_0_1_sdf3dc = vec2(o2089669_0_1_sdf3d, 0.0);
vec3 o2089669_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089676_x, p_o2089676_y, p_o2089676_z)), -vec3(p_o2089677_ax, p_o2089677_ay, p_o2089677_az)*0.01745329251))-vec3(p_o2089673_x, p_o2089673_y, p_o2089673_z)), -vec3(p_o2089674_ax, p_o2089674_ay, p_o2089674_az)*0.01745329251))-vec3(p_o2089670_x, p_o2089670_y, p_o2089670_z));
o2089669_3_p.y -= clamp(o2089669_3_p.y, -p_o2089669_l, p_o2089669_l);
float o2089669_0_4_sdf3d = length(o2089669_3_p)-p_o2089669_r*1.0;
vec2 o2089670_0_3_sdf3dc = vec2(o2089669_0_4_sdf3d, 0.0);
float o2089663_0_3_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089676_x, p_o2089676_y, p_o2089676_z)), -vec3(p_o2089677_ax, p_o2089677_ay, p_o2089677_az)*0.01745329251))-vec3(p_o2089673_x, p_o2089673_y, p_o2089673_z)), -vec3(p_o2089674_ax, p_o2089674_ay, p_o2089674_az)*0.01745329251))-vec3(p_o2089675_x, p_o2089675_y, p_o2089675_z)), -vec3(p_o2089672_ax, p_o2089672_ay, p_o2089672_az)*0.01745329251)).y;
vec3 o2089660_3_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089676_x, p_o2089676_y, p_o2089676_z)), -vec3(p_o2089677_ax, p_o2089677_ay, p_o2089677_az)*0.01745329251))-vec3(p_o2089673_x, p_o2089673_y, p_o2089673_z)), -vec3(p_o2089674_ax, p_o2089674_ay, p_o2089674_az)*0.01745329251))-vec3(p_o2089675_x, p_o2089675_y, p_o2089675_z)), -vec3(p_o2089672_ax, p_o2089672_ay, p_o2089672_az)*0.01745329251))-vec3(p_o2089665_x, p_o2089665_y, p_o2089665_z)), p_o2089662_c))-vec3(p_o2089661_x, p_o2089661_y, p_o2089661_z));
o2089660_3_p.y -= clamp(o2089660_3_p.y, -p_o2089660_l, p_o2089660_l);
float o2089660_0_4_sdf3d = length(o2089660_3_p)-p_o2089660_r*1.0;
vec2 o2089661_0_3_sdf3dc = vec2(o2089660_0_4_sdf3d, 0.0);
vec2 o2089662_0_3_sdf3dc = o2089661_0_3_sdf3dc;
vec2 o2089665_0_3_sdf3dc = o2089662_0_3_sdf3dc;
vec2 o2089664_0_3_sdf3dc = sdf3dc_sub(vec2(o2089663_0_3_sdf3d, 0.0), o2089665_0_3_sdf3dc);
vec2 o2089672_0_1_sdf3dc = o2089664_0_3_sdf3dc;
vec2 o2089675_0_1_sdf3dc = o2089672_0_1_sdf3dc;
vec2 o2089671_0_1_sdf3dc = sdf3dc_union(o2089670_0_3_sdf3dc, o2089675_0_1_sdf3dc);
vec2 o2089674_0_1_sdf3dc = o2089671_0_1_sdf3dc;
vec2 o2089673_0_1_sdf3dc = o2089674_0_1_sdf3dc;
vec2 o2089678_0_1_sdf3dc = sdf3dc_union(o2089670_0_1_sdf3dc, o2089673_0_1_sdf3dc);
vec2 o2089677_0_1_sdf3dc = o2089678_0_1_sdf3dc;
vec2 o2089676_0_1_sdf3dc = o2089677_0_1_sdf3dc;
vec2 o2089679_0_1_sdf3dc = sdf3dc_union(o2089655_0_1_sdf3dc, o2089676_0_1_sdf3dc);
vec2 o2089653_0_1_sdf3dc = sdf3dc_union(o2089515_0_1_sdf3dc, o2089679_0_1_sdf3dc);
float o2089623_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089625_x, p_o2089625_y, p_o2089625_z)), p_o2089623_l, p_o2089623_r);
vec2 o2089624_0_v = vec2(o2089623_0_1_sdf3d, 0.0);vec2 o2089624_0_1_sdf3dc = vec2(o2089624_0_v.x-p_o2089624_r, o2089624_0_v.y);
vec2 o2089625_0_1_sdf3dc = o2089624_0_1_sdf3dc;
float o2089629_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z)), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).xzy, p_o2089629_l, p_o2089629_r);
float o2089627_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z)), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).xzy, p_o2089627_l, p_o2089627_r);
vec2 o2089628_0_1_sdf3dc = sdf3dc_sub(vec2(o2089629_0_1_sdf3d, 0.0), vec2(o2089627_0_1_sdf3d, 0.0));
vec3 o2089630_0_uv = (rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z)), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).zxy;
float o2089630_0_rotated = rotate3d(o2089630_0_uv, vec3((p_o2089630_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o2089630_0_d1 = max(o2089630_0_uv.y, o2089630_0_rotated);
float o2089630_0_d2 = min(o2089630_0_uv.y, o2089630_0_rotated);
float o2089630_0_d = (mod(p_o2089630_angle, 360.0) < 180.0) ? o2089630_0_d1 : o2089630_0_d2;float o2089630_0_1_sdf3d = o2089630_0_d;
vec2 o2089631_0_1_sdf3dc = sdf3dc_inter(o2089628_0_1_sdf3dc, vec2(o2089630_0_1_sdf3d, 0.0));
vec2 o2089634_0_1_sdf3dc = o2089631_0_1_sdf3dc;
vec2 o2089633_0_1_sdf3dc = o2089634_0_1_sdf3dc;
vec2 o2089635_0_1_sdf3dc = o2089633_0_1_sdf3dc;
vec2 o2089632_0_1_sdf3dc = sdf3dc_union(o2089625_0_1_sdf3dc, o2089635_0_1_sdf3dc);
vec2 o2089626_0_1_sdf3dc = sdf3dc_union(o2089653_0_1_sdf3dc, o2089632_0_1_sdf3dc);
vec2 o2089522_0_1_sdf3dc = sdf3dc_union(o2089523_0_1_sdf3dc, o2089626_0_1_sdf3dc);
float o2089528_0_1_sdf3d = (((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z)).x;
float o2089526_0_1_sdf3d = dot(vec2(cos(p_o2089526_a*0.01745329251),sin(p_o2089526_a*0.01745329251)),vec2(length(((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z))-vec3(p_o2089529_x, p_o2089529_y, p_o2089529_z)).yz),-((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z))-vec3(p_o2089529_x, p_o2089529_y, p_o2089529_z)).x));
vec2 o2089529_0_1_sdf3dc = vec2(o2089526_0_1_sdf3d, 0.0);
vec2 o2089527_0_1_sdf3dc = sdf3dc_inter(vec2(o2089528_0_1_sdf3d, 0.0), o2089529_0_1_sdf3dc);
vec2 o2089531_0_1_sdf3dc = o2089527_0_1_sdf3dc;
vec2 o2089530_0_1_sdf3dc = sdf3dc_union(o2089522_0_1_sdf3dc, o2089531_0_1_sdf3dc);
float o2089576_0_1_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089589_x, p_o2089589_y, p_o2089589_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_1_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089589_x, p_o2089589_y, p_o2089589_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_1_sdf3d = mix(o2089576_0_1_sdf3d, o2089577_0_1_sdf3d, p_o2089575_amount);
vec2 o2089574_0_v = vec2(o2089575_0_1_sdf3d, 0.0);vec2 o2089574_0_1_sdf3dc = vec2(o2089574_0_v.x-p_o2089574_r, o2089574_0_v.y);
vec2 o2089580_0_in = o2089574_0_1_sdf3dc;vec2 o2089580_0_1_sdf3dc = vec2(o2089580_0_in.x*p_o2089580_s, o2089580_0_in.y);
vec2 o2089588_0_1_sdf3dc = o2089580_0_1_sdf3dc;
vec2 o2089589_0_1_sdf3dc = o2089588_0_1_sdf3dc;
float o2089576_0_3_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089590_x, p_o2089590_y, p_o2089590_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_3_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089590_x, p_o2089590_y, p_o2089590_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_3_sdf3d = mix(o2089576_0_3_sdf3d, o2089577_0_3_sdf3d, p_o2089575_amount);
vec2 o2089574_2_v = vec2(o2089575_0_3_sdf3d, 0.0);vec2 o2089574_0_3_sdf3dc = vec2(o2089574_2_v.x-p_o2089574_r, o2089574_2_v.y);
vec2 o2089580_2_in = o2089574_0_3_sdf3dc;vec2 o2089580_0_3_sdf3dc = vec2(o2089580_2_in.x*p_o2089580_s, o2089580_2_in.y);
vec2 o2089588_0_3_sdf3dc = o2089580_0_3_sdf3dc;
vec2 o2089590_0_1_sdf3dc = o2089588_0_3_sdf3dc;
vec2 o2089591_0_1_sdf3dc = sdf3dc_union(o2089589_0_1_sdf3dc, o2089590_0_1_sdf3dc);
float o2089576_0_5_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089581_x, p_o2089581_y, p_o2089581_z)), -vec3(p_o2089579_ax, p_o2089579_ay, p_o2089579_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_5_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089581_x, p_o2089581_y, p_o2089581_z)), -vec3(p_o2089579_ax, p_o2089579_ay, p_o2089579_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_5_sdf3d = mix(o2089576_0_5_sdf3d, o2089577_0_5_sdf3d, p_o2089575_amount);
vec2 o2089574_4_v = vec2(o2089575_0_5_sdf3d, 0.0);vec2 o2089574_0_5_sdf3dc = vec2(o2089574_4_v.x-p_o2089574_r, o2089574_4_v.y);
vec2 o2089580_4_in = o2089574_0_5_sdf3dc;vec2 o2089580_0_5_sdf3dc = vec2(o2089580_4_in.x*p_o2089580_s, o2089580_4_in.y);
vec2 o2089579_0_1_sdf3dc = o2089580_0_5_sdf3dc;
vec2 o2089581_0_1_sdf3dc = o2089579_0_1_sdf3dc;
float o2089576_0_7_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089583_x, p_o2089583_y, p_o2089583_z)), -vec3(p_o2089584_ax, p_o2089584_ay, p_o2089584_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_7_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089583_x, p_o2089583_y, p_o2089583_z)), -vec3(p_o2089584_ax, p_o2089584_ay, p_o2089584_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_7_sdf3d = mix(o2089576_0_7_sdf3d, o2089577_0_7_sdf3d, p_o2089575_amount);
vec2 o2089574_6_v = vec2(o2089575_0_7_sdf3d, 0.0);vec2 o2089574_0_7_sdf3dc = vec2(o2089574_6_v.x-p_o2089574_r, o2089574_6_v.y);
vec2 o2089580_6_in = o2089574_0_7_sdf3dc;vec2 o2089580_0_7_sdf3dc = vec2(o2089580_6_in.x*p_o2089580_s, o2089580_6_in.y);
vec2 o2089584_0_1_sdf3dc = o2089580_0_7_sdf3dc;
vec2 o2089583_0_1_sdf3dc = o2089584_0_1_sdf3dc;
vec2 o2089582_0_1_sdf3dc = sdf3dc_union(o2089581_0_1_sdf3dc, o2089583_0_1_sdf3dc);
float o2089576_0_9_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089585_x, p_o2089585_y, p_o2089585_z)), -vec3(p_o2089586_ax, p_o2089586_ay, p_o2089586_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_9_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o2089621_ax, p_o2089621_ay, p_o2089621_az)*0.01745329251))-vec3(p_o2089524_x, p_o2089524_y, p_o2089524_z))-vec3(p_o2089585_x, p_o2089585_y, p_o2089585_z)), -vec3(p_o2089586_ax, p_o2089586_ay, p_o2089586_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_9_sdf3d = mix(o2089576_0_9_sdf3d, o2089577_0_9_sdf3d, p_o2089575_amount);
vec2 o2089574_8_v = vec2(o2089575_0_9_sdf3d, 0.0);vec2 o2089574_0_9_sdf3dc = vec2(o2089574_8_v.x-p_o2089574_r, o2089574_8_v.y);
vec2 o2089580_8_in = o2089574_0_9_sdf3dc;vec2 o2089580_0_9_sdf3dc = vec2(o2089580_8_in.x*p_o2089580_s, o2089580_8_in.y);
vec2 o2089586_0_1_sdf3dc = o2089580_0_9_sdf3dc;
vec2 o2089585_0_1_sdf3dc = o2089586_0_1_sdf3dc;
vec2 o2089587_0_1_sdf3dc = sdf3dc_union(o2089582_0_1_sdf3dc, o2089585_0_1_sdf3dc);
vec2 o2089592_0_1_sdf3dc = sdf3dc_union(o2089591_0_1_sdf3dc, o2089587_0_1_sdf3dc);
vec2 o2089578_0_1_sdf3dc = sdf3dc_union(o2089530_0_1_sdf3dc, o2089592_0_1_sdf3dc);
vec2 o2089524_0_1_sdf3dc = o2089578_0_1_sdf3dc;
vec2 o2089621_0_1_sdf3dc = o2089524_0_1_sdf3dc;

return o2089621_0_1_sdf3dc;
}
const float p_o2089622_ax = 0.000000000;
const float p_o2089622_ay = 90.000000000;
const float p_o2089622_az = 0.000000000;
const float p_o2089559_x = 0.000000000;
const float p_o2089559_y = -0.440000000;
const float p_o2089559_z = 0.000000000;
const float p_o2089593_d = 0.010000000;
const float p_o2089594_g_0_pos = 0.663637000;
const float p_o2089594_g_0_r = 0.000000000;
const float p_o2089594_g_0_g = 0.000000000;
const float p_o2089594_g_0_b = 0.000000000;
const float p_o2089594_g_0_a = 1.000000000;
const float p_o2089594_g_1_pos = 0.872727000;
const float p_o2089594_g_1_r = 0.000000000;
const float p_o2089594_g_1_g = 0.000000000;
const float p_o2089594_g_1_b = 0.000000000;
const float p_o2089594_g_1_a = 1.000000000;
vec4 o2089594_g_gradient_fct(float x) {
  if (x < p_o2089594_g_0_pos) {
    return vec4(p_o2089594_g_0_r,p_o2089594_g_0_g,p_o2089594_g_0_b,p_o2089594_g_0_a);
  } else if (x < p_o2089594_g_1_pos) {
    return mix(vec4(p_o2089594_g_0_r,p_o2089594_g_0_g,p_o2089594_g_0_b,p_o2089594_g_0_a), vec4(p_o2089594_g_1_r,p_o2089594_g_1_g,p_o2089594_g_1_b,p_o2089594_g_1_a), ((x-p_o2089594_g_0_pos)/(p_o2089594_g_1_pos-p_o2089594_g_0_pos)));
  }
  return vec4(p_o2089594_g_1_r,p_o2089594_g_1_g,p_o2089594_g_1_b,p_o2089594_g_1_a);
}
const float p_o2089560_d = 0.010000000;
const float p_o2089561_g_0_pos = 0.806305000;
const float p_o2089561_g_0_r = 0.078125000;
const float p_o2089561_g_0_g = 0.078125000;
const float p_o2089561_g_0_b = 0.078125000;
const float p_o2089561_g_0_a = 1.000000000;
const float p_o2089561_g_1_pos = 0.979033000;
const float p_o2089561_g_1_r = 0.078125000;
const float p_o2089561_g_1_g = 0.078125000;
const float p_o2089561_g_1_b = 0.078125000;
const float p_o2089561_g_1_a = 1.000000000;
vec4 o2089561_g_gradient_fct(float x) {
  if (x < p_o2089561_g_0_pos) {
    return vec4(p_o2089561_g_0_r,p_o2089561_g_0_g,p_o2089561_g_0_b,p_o2089561_g_0_a);
  } else if (x < p_o2089561_g_1_pos) {
    return mix(vec4(p_o2089561_g_0_r,p_o2089561_g_0_g,p_o2089561_g_0_b,p_o2089561_g_0_a), vec4(p_o2089561_g_1_r,p_o2089561_g_1_g,p_o2089561_g_1_b,p_o2089561_g_1_a), ((x-p_o2089561_g_0_pos)/(p_o2089561_g_1_pos-p_o2089561_g_0_pos)));
  }
  return vec4(p_o2089561_g_1_r,p_o2089561_g_1_g,p_o2089561_g_1_b,p_o2089561_g_1_a);
}
const float p_o2089636_d = 0.010000000;
const float p_o2089637_g_0_pos = 0.690909000;
const float p_o2089637_g_0_r = 0.738281012;
const float p_o2089637_g_0_g = 0.000000000;
const float p_o2089637_g_0_b = 0.000000000;
const float p_o2089637_g_0_a = 1.000000000;
const float p_o2089637_g_1_pos = 0.936364000;
const float p_o2089637_g_1_r = 0.738281012;
const float p_o2089637_g_1_g = 0.000000000;
const float p_o2089637_g_1_b = 0.000000000;
const float p_o2089637_g_1_a = 1.000000000;
vec4 o2089637_g_gradient_fct(float x) {
  if (x < p_o2089637_g_0_pos) {
    return vec4(p_o2089637_g_0_r,p_o2089637_g_0_g,p_o2089637_g_0_b,p_o2089637_g_0_a);
  } else if (x < p_o2089637_g_1_pos) {
    return mix(vec4(p_o2089637_g_0_r,p_o2089637_g_0_g,p_o2089637_g_0_b,p_o2089637_g_0_a), vec4(p_o2089637_g_1_r,p_o2089637_g_1_g,p_o2089637_g_1_b,p_o2089637_g_1_a), ((x-p_o2089637_g_0_pos)/(p_o2089637_g_1_pos-p_o2089637_g_0_pos)));
  }
  return vec4(p_o2089637_g_1_r,p_o2089637_g_1_g,p_o2089637_g_1_b,p_o2089637_g_1_a);
}
const float p_o2089680_d = 0.010000000;
const float p_o2089681_g_0_pos = 0.886364000;
const float p_o2089681_g_0_r = 0.859375000;
const float p_o2089681_g_0_g = 0.868164003;
const float p_o2089681_g_0_b = 1.000000000;
const float p_o2089681_g_0_a = 1.000000000;
const float p_o2089681_g_1_pos = 1.000000000;
const float p_o2089681_g_1_r = 0.859375000;
const float p_o2089681_g_1_g = 0.868164003;
const float p_o2089681_g_1_b = 1.000000000;
const float p_o2089681_g_1_a = 1.000000000;
vec4 o2089681_g_gradient_fct(float x) {
  if (x < p_o2089681_g_0_pos) {
    return vec4(p_o2089681_g_0_r,p_o2089681_g_0_g,p_o2089681_g_0_b,p_o2089681_g_0_a);
  } else if (x < p_o2089681_g_1_pos) {
    return mix(vec4(p_o2089681_g_0_r,p_o2089681_g_0_g,p_o2089681_g_0_b,p_o2089681_g_0_a), vec4(p_o2089681_g_1_r,p_o2089681_g_1_g,p_o2089681_g_1_b,p_o2089681_g_1_a), ((x-p_o2089681_g_0_pos)/(p_o2089681_g_1_pos-p_o2089681_g_0_pos)));
  }
  return vec4(p_o2089681_g_1_r,p_o2089681_g_1_g,p_o2089681_g_1_b,p_o2089681_g_1_a);
}
const float p_o2089532_d = 0.010000000;
const float p_o2089533_g_0_pos = 0.901993000;
const float p_o2089533_g_0_r = 0.824218988;
const float p_o2089533_g_0_g = 0.270446986;
const float p_o2089533_g_0_b = 0.000000000;
const float p_o2089533_g_0_a = 1.000000000;
const float p_o2089533_g_1_pos = 0.961794000;
const float p_o2089533_g_1_r = 0.824218988;
const float p_o2089533_g_1_g = 0.270446986;
const float p_o2089533_g_1_b = 0.000000000;
const float p_o2089533_g_1_a = 1.000000000;
vec4 o2089533_g_gradient_fct(float x) {
  if (x < p_o2089533_g_0_pos) {
    return vec4(p_o2089533_g_0_r,p_o2089533_g_0_g,p_o2089533_g_0_b,p_o2089533_g_0_a);
  } else if (x < p_o2089533_g_1_pos) {
    return mix(vec4(p_o2089533_g_0_r,p_o2089533_g_0_g,p_o2089533_g_0_b,p_o2089533_g_0_a), vec4(p_o2089533_g_1_r,p_o2089533_g_1_g,p_o2089533_g_1_b,p_o2089533_g_1_a), ((x-p_o2089533_g_0_pos)/(p_o2089533_g_1_pos-p_o2089533_g_0_pos)));
  }
  return vec4(p_o2089533_g_1_r,p_o2089533_g_1_g,p_o2089533_g_1_b,p_o2089533_g_1_a);
}
const float p_o2089546_g_0_pos = 0.751760000;
const float p_o2089546_g_0_r = 0.136719003;
const float p_o2089546_g_0_g = 0.122262001;
const float p_o2089546_g_0_b = 0.112686001;
const float p_o2089546_g_0_a = 1.000000000;
const float p_o2089546_g_1_pos = 0.951760000;
const float p_o2089546_g_1_r = 0.136719003;
const float p_o2089546_g_1_g = 0.122262001;
const float p_o2089546_g_1_b = 0.112686001;
const float p_o2089546_g_1_a = 1.000000000;
vec4 o2089546_g_gradient_fct(float x) {
  if (x < p_o2089546_g_0_pos) {
    return vec4(p_o2089546_g_0_r,p_o2089546_g_0_g,p_o2089546_g_0_b,p_o2089546_g_0_a);
  } else if (x < p_o2089546_g_1_pos) {
    return mix(vec4(p_o2089546_g_0_r,p_o2089546_g_0_g,p_o2089546_g_0_b,p_o2089546_g_0_a), vec4(p_o2089546_g_1_r,p_o2089546_g_1_g,p_o2089546_g_1_b,p_o2089546_g_1_a), ((x-p_o2089546_g_0_pos)/(p_o2089546_g_1_pos-p_o2089546_g_0_pos)));
  }
  return vec4(p_o2089546_g_1_r,p_o2089546_g_1_g,p_o2089546_g_1_b,p_o2089546_g_1_a);
}
vec3 o2089510_input_albedo(vec4 p, float _seed_variation_) {
vec3 o2089594_0_1_tex3d = o2089594_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o2089561_0_1_tex3d = o2089561_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o2089637_0_1_tex3d = o2089637_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o2089681_0_1_tex3d = o2089681_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o2089533_0_1_tex3d = o2089533_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o2089546_0_1_tex3d = o2089546_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
float o2089528_0_1_sdf3d = (((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z)).x;
float o2089526_0_1_sdf3d = dot(vec2(cos(p_o2089526_a*0.01745329251),sin(p_o2089526_a*0.01745329251)),vec2(length(((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z))-vec3(p_o2089529_x, p_o2089529_y, p_o2089529_z)).yz),-((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089531_x, p_o2089531_y, p_o2089531_z))-vec3(p_o2089529_x, p_o2089529_y, p_o2089529_z)).x));
vec2 o2089529_0_1_sdf3dc = vec2(o2089526_0_1_sdf3d, 0.0);
vec2 o2089527_0_1_sdf3dc = sdf3dc_inter(vec2(o2089528_0_1_sdf3d, 0.0), o2089529_0_1_sdf3dc);
vec2 o2089531_0_1_sdf3dc = o2089527_0_1_sdf3dc;
vec3 o2089532_0_1_tex3d = mix(o2089533_0_1_tex3d, o2089546_0_1_tex3d, clamp((o2089531_0_1_sdf3dc).x/max(p_o2089532_d, 0.0001), 0.0, 1.0));
float o2089511_0_1_sdf3d = length(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz))-p_o2089511_r;
float o2089513_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089514_x, p_o2089514_y, p_o2089514_z)))-p_o2089513_r;
vec2 o2089514_0_1_sdf3dc = vec2(o2089513_0_1_sdf3d, 0.0);
vec2 o2089512_0_1_sdf3dc = sdf3d_smooth_union(vec2(o2089511_0_1_sdf3d, 0.0), o2089514_0_1_sdf3dc, p_o2089512_k);
float o2089517_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089516_x, p_o2089516_y, p_o2089516_z)))-p_o2089517_r;
vec2 o2089516_0_1_sdf3dc = vec2(o2089517_0_1_sdf3d, 0.0);
vec2 o2089515_0_1_sdf3dc = sdf3d_smooth_union(o2089512_0_1_sdf3dc, o2089516_0_1_sdf3dc, p_o2089515_k);
vec3 o2089680_0_1_tex3d = mix(o2089681_0_1_tex3d, o2089532_0_1_tex3d, clamp((o2089515_0_1_sdf3dc).x/max(p_o2089680_d, 0.0001), 0.0, 1.0));
float o2089623_0_1_sdf3d = sdCylinder((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089625_x, p_o2089625_y, p_o2089625_z)), p_o2089623_l, p_o2089623_r);
vec2 o2089624_0_v = vec2(o2089623_0_1_sdf3d, 0.0);vec2 o2089624_0_1_sdf3dc = vec2(o2089624_0_v.x-p_o2089624_r, o2089624_0_v.y);
vec2 o2089625_0_1_sdf3dc = o2089624_0_1_sdf3dc;
float o2089629_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).xzy, p_o2089629_l, p_o2089629_r);
float o2089627_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).xzy, p_o2089627_l, p_o2089627_r);
vec2 o2089628_0_1_sdf3dc = sdf3dc_sub(vec2(o2089629_0_1_sdf3d, 0.0), vec2(o2089627_0_1_sdf3d, 0.0));
vec3 o2089630_0_uv = (rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o2089635_ax, p_o2089635_ay, p_o2089635_az)*0.01745329251))-vec3(p_o2089633_x, p_o2089633_y, p_o2089633_z)), -vec3(p_o2089634_ax, p_o2089634_ay, p_o2089634_az)*0.01745329251)).zxy;
float o2089630_0_rotated = rotate3d(o2089630_0_uv, vec3((p_o2089630_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o2089630_0_d1 = max(o2089630_0_uv.y, o2089630_0_rotated);
float o2089630_0_d2 = min(o2089630_0_uv.y, o2089630_0_rotated);
float o2089630_0_d = (mod(p_o2089630_angle, 360.0) < 180.0) ? o2089630_0_d1 : o2089630_0_d2;float o2089630_0_1_sdf3d = o2089630_0_d;
vec2 o2089631_0_1_sdf3dc = sdf3dc_inter(o2089628_0_1_sdf3dc, vec2(o2089630_0_1_sdf3d, 0.0));
vec2 o2089634_0_1_sdf3dc = o2089631_0_1_sdf3dc;
vec2 o2089633_0_1_sdf3dc = o2089634_0_1_sdf3dc;
vec2 o2089635_0_1_sdf3dc = o2089633_0_1_sdf3dc;
vec2 o2089632_0_1_sdf3dc = sdf3dc_union(o2089625_0_1_sdf3dc, o2089635_0_1_sdf3dc);
vec3 o2089636_0_1_tex3d = mix(o2089637_0_1_tex3d, o2089680_0_1_tex3d, clamp((o2089632_0_1_sdf3dc).x/max(p_o2089636_d, 0.0001), 0.0, 1.0));
float o2089518_0_1_sdf3d = sdCylinder((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089523_x, p_o2089523_y, p_o2089523_z)), -vec3(p_o2089525_ax, p_o2089525_ay, p_o2089525_az)*0.01745329251)), p_o2089518_l, p_o2089518_r);
float o2089520_0_1_sdf3d = sdCylinder(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089523_x, p_o2089523_y, p_o2089523_z)), -vec3(p_o2089525_ax, p_o2089525_ay, p_o2089525_az)*0.01745329251))-vec3(p_o2089521_x, p_o2089521_y, p_o2089521_z)), p_o2089520_l, p_o2089520_r);
vec2 o2089521_0_1_sdf3dc = vec2(o2089520_0_1_sdf3d, 0.0);
vec2 o2089519_0_1_sdf3dc = sdf3dc_union(vec2(o2089518_0_1_sdf3d, 0.0), o2089521_0_1_sdf3dc);
vec2 o2089525_0_1_sdf3dc = o2089519_0_1_sdf3dc;
vec2 o2089523_0_1_sdf3dc = o2089525_0_1_sdf3dc;
vec3 o2089560_0_1_tex3d = mix(o2089561_0_1_tex3d, o2089636_0_1_tex3d, clamp((o2089523_0_1_sdf3dc).x/max(p_o2089560_d, 0.0001), 0.0, 1.0));
float o2089576_0_1_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089589_x, p_o2089589_y, p_o2089589_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_1_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089589_x, p_o2089589_y, p_o2089589_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_1_sdf3d = mix(o2089576_0_1_sdf3d, o2089577_0_1_sdf3d, p_o2089575_amount);
vec2 o2089574_0_v = vec2(o2089575_0_1_sdf3d, 0.0);vec2 o2089574_0_1_sdf3dc = vec2(o2089574_0_v.x-p_o2089574_r, o2089574_0_v.y);
vec2 o2089580_0_in = o2089574_0_1_sdf3dc;vec2 o2089580_0_1_sdf3dc = vec2(o2089580_0_in.x*p_o2089580_s, o2089580_0_in.y);
vec2 o2089588_0_1_sdf3dc = o2089580_0_1_sdf3dc;
vec2 o2089589_0_1_sdf3dc = o2089588_0_1_sdf3dc;
float o2089576_0_3_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089590_x, p_o2089590_y, p_o2089590_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_3_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089590_x, p_o2089590_y, p_o2089590_z)), -vec3(p_o2089588_ax, p_o2089588_ay, p_o2089588_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_3_sdf3d = mix(o2089576_0_3_sdf3d, o2089577_0_3_sdf3d, p_o2089575_amount);
vec2 o2089574_2_v = vec2(o2089575_0_3_sdf3d, 0.0);vec2 o2089574_0_3_sdf3dc = vec2(o2089574_2_v.x-p_o2089574_r, o2089574_2_v.y);
vec2 o2089580_2_in = o2089574_0_3_sdf3dc;vec2 o2089580_0_3_sdf3dc = vec2(o2089580_2_in.x*p_o2089580_s, o2089580_2_in.y);
vec2 o2089588_0_3_sdf3dc = o2089580_0_3_sdf3dc;
vec2 o2089590_0_1_sdf3dc = o2089588_0_3_sdf3dc;
vec2 o2089591_0_1_sdf3dc = sdf3dc_union(o2089589_0_1_sdf3dc, o2089590_0_1_sdf3dc);
float o2089576_0_5_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089581_x, p_o2089581_y, p_o2089581_z)), -vec3(p_o2089579_ax, p_o2089579_ay, p_o2089579_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_5_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089581_x, p_o2089581_y, p_o2089581_z)), -vec3(p_o2089579_ax, p_o2089579_ay, p_o2089579_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_5_sdf3d = mix(o2089576_0_5_sdf3d, o2089577_0_5_sdf3d, p_o2089575_amount);
vec2 o2089574_4_v = vec2(o2089575_0_5_sdf3d, 0.0);vec2 o2089574_0_5_sdf3dc = vec2(o2089574_4_v.x-p_o2089574_r, o2089574_4_v.y);
vec2 o2089580_4_in = o2089574_0_5_sdf3dc;vec2 o2089580_0_5_sdf3dc = vec2(o2089580_4_in.x*p_o2089580_s, o2089580_4_in.y);
vec2 o2089579_0_1_sdf3dc = o2089580_0_5_sdf3dc;
vec2 o2089581_0_1_sdf3dc = o2089579_0_1_sdf3dc;
float o2089576_0_7_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089583_x, p_o2089583_y, p_o2089583_z)), -vec3(p_o2089584_ax, p_o2089584_ay, p_o2089584_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_7_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089583_x, p_o2089583_y, p_o2089583_z)), -vec3(p_o2089584_ax, p_o2089584_ay, p_o2089584_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_7_sdf3d = mix(o2089576_0_7_sdf3d, o2089577_0_7_sdf3d, p_o2089575_amount);
vec2 o2089574_6_v = vec2(o2089575_0_7_sdf3d, 0.0);vec2 o2089574_0_7_sdf3dc = vec2(o2089574_6_v.x-p_o2089574_r, o2089574_6_v.y);
vec2 o2089580_6_in = o2089574_0_7_sdf3dc;vec2 o2089580_0_7_sdf3dc = vec2(o2089580_6_in.x*p_o2089580_s, o2089580_6_in.y);
vec2 o2089584_0_1_sdf3dc = o2089580_0_7_sdf3dc;
vec2 o2089583_0_1_sdf3dc = o2089584_0_1_sdf3dc;
vec2 o2089582_0_1_sdf3dc = sdf3dc_union(o2089581_0_1_sdf3dc, o2089583_0_1_sdf3dc);
float o2089576_0_9_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089585_x, p_o2089585_y, p_o2089585_z)), -vec3(p_o2089586_ax, p_o2089586_ay, p_o2089586_az)*0.01745329251)))/p_o2089580_s), vec3(p_o2089576_sx, p_o2089576_sy, p_o2089576_sz))-p_o2089576_r;
float o2089577_0_9_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).xyz-vec3(p_o2089559_x, p_o2089559_y, p_o2089559_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o2089622_ax, p_o2089622_ay, p_o2089622_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o2089585_x, p_o2089585_y, p_o2089585_z)), -vec3(p_o2089586_ax, p_o2089586_ay, p_o2089586_az)*0.01745329251)))/p_o2089580_s))-p_o2089577_r;
float o2089575_0_9_sdf3d = mix(o2089576_0_9_sdf3d, o2089577_0_9_sdf3d, p_o2089575_amount);
vec2 o2089574_8_v = vec2(o2089575_0_9_sdf3d, 0.0);vec2 o2089574_0_9_sdf3dc = vec2(o2089574_8_v.x-p_o2089574_r, o2089574_8_v.y);
vec2 o2089580_8_in = o2089574_0_9_sdf3dc;vec2 o2089580_0_9_sdf3dc = vec2(o2089580_8_in.x*p_o2089580_s, o2089580_8_in.y);
vec2 o2089586_0_1_sdf3dc = o2089580_0_9_sdf3dc;
vec2 o2089585_0_1_sdf3dc = o2089586_0_1_sdf3dc;
vec2 o2089587_0_1_sdf3dc = sdf3dc_union(o2089582_0_1_sdf3dc, o2089585_0_1_sdf3dc);
vec2 o2089592_0_1_sdf3dc = sdf3dc_union(o2089591_0_1_sdf3dc, o2089587_0_1_sdf3dc);
vec3 o2089593_0_1_tex3d = mix(o2089594_0_1_tex3d, o2089560_0_1_tex3d, clamp((o2089592_0_1_sdf3dc).x/max(p_o2089593_d, 0.0001), 0.0, 1.0));
vec3 o2089559_0_1_tex3d = o2089593_0_1_tex3d;
vec3 o2089622_0_1_tex3d = o2089559_0_1_tex3d;

return o2089622_0_1_tex3d;
}
vec3 o2089510_input_metallic(vec4 p, float _seed_variation_) {

return vec3(0.0);
}
vec3 o2089510_input_roughness(vec4 p, float _seed_variation_) {

return vec3(1.0);
}


vec2 GetDist(vec3 p) {
    float _seed_variation_ = seed_variation;

	vec2 d = o2089510_input_distance(p.zyx, _seed_variation_);

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

		ALBEDO = o2089510_input_albedo(vec4(p, rm.y), _seed_variation_);
		ROUGHNESS = o2089510_input_roughness(vec4(p, rm.y), _seed_variation_).x;
		METALLIC = o2089510_input_metallic(vec4(p, rm.y), _seed_variation_).x;

		NORMAL = (INV_CAMERA_MATRIX*WORLD_MATRIX*vec4(GetNormal(p), 0.0)).xyz;
	}
}



