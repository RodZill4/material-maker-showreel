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

const float p_o141556_ax = 0.000000000;
const float p_o141556_ay = 90.000000000;
const float p_o141556_az = 0.000000000;
const float p_o141459_x = 0.000000000;
const float p_o141459_y = -0.440000000;
const float p_o141459_z = 0.000000000;
const float p_o141458_x = 0.000000000;
const float p_o141458_y = 0.910000000;
const float p_o141458_z = -0.010000000;
const float p_o141460_ax = 14.000000000;
const float p_o141460_ay = 0.000000000;
const float p_o141460_az = 0.000000000;
const float p_o141453_l = 0.005000000;
const float p_o141453_r = 0.246883000;
const float p_o141456_x = 0.000000000;
const float p_o141456_y = 0.140000000;
const float p_o141456_z = 0.000000000;
const float p_o141455_l = 0.130000000;
const float p_o141455_r = 0.178313000;
const float p_o141450_k = 0.030000000;
const float p_o141447_k = 0.030000000;
const float p_o141446_r = 0.370000000;
const float p_o141449_x = 0.000000000;
const float p_o141449_y = 0.450000000;
const float p_o141449_z = 0.000000000;
const float p_o141448_r = 0.266819000;
const float p_o141451_x = 0.000000000;
const float p_o141451_y = 0.790000000;
const float p_o141451_z = 0.000000000;
const float p_o141452_r = 0.180000000;
const float p_o141590_x = 0.000000000;
const float p_o141590_y = 0.560000000;
const float p_o141590_z = -0.230000000;
const float p_o141589_ay = 0.000000000;
const float p_o141589_az = 0.000000000;
const float p_o141591_x = 0.000000000;
const float p_o141591_y = 0.100000000;
const float p_o141591_z = 0.000000000;
const float p_o141587_l = 0.100000000;
const float p_o141587_r = 0.010000000;
const float p_o141592_x = 0.000000000;
const float p_o141592_y = 0.190000000;
const float p_o141592_z = 0.000000000;
const float p_o141594_ay = 0.000000000;
const float p_o141594_az = 0.000000000;
const float p_o141602_x = 0.000000000;
const float p_o141602_y = 0.200000000;
const float p_o141602_z = 0.000000000;
const float p_o141603_ax = 0.000000000;
const float p_o141603_ay = 90.000000000;
const float p_o141600_x = 0.000000000;
const float p_o141600_y = 0.005000000;
const float p_o141600_z = 0.000000000;
const float p_o141597_c = 9.000000000;
const float p_o141596_x = 0.000000000;
const float p_o141596_y = 0.040000000;
const float p_o141596_z = 0.000000000;
const float p_o141595_l = 0.040000000;
const float p_o141595_r = 0.010000000;
const float p_o141611_x = 0.000000000;
const float p_o141611_y = 0.570000000;
const float p_o141611_z = 0.230000000;
const float p_o141612_ax = -126.000000000;
const float p_o141612_ay = 0.000000000;
const float p_o141612_az = 0.000000000;
const float p_o141605_x = 0.000000000;
const float p_o141605_y = 0.100000000;
const float p_o141605_z = 0.000000000;
const float p_o141604_l = 0.100000000;
const float p_o141604_r = 0.010000000;
const float p_o141608_x = 0.000000000;
const float p_o141608_y = 0.190000000;
const float p_o141608_z = 0.000000000;
const float p_o141609_ax = -30.000000000;
const float p_o141609_ay = 0.000000000;
const float p_o141609_az = 0.000000000;
const float p_o141610_x = 0.000000000;
const float p_o141610_y = 0.200000000;
const float p_o141610_z = 0.000000000;
const float p_o141607_ax = 0.000000000;
const float p_o141607_ay = 90.000000000;
const float p_o141607_az = 0.000000000;
const float p_o141560_x = 0.000000000;
const float p_o141560_y = 0.690000000;
const float p_o141560_z = 0.000000000;
const float p_o141559_r = 0.030000000;
const float p_o141558_l = 0.010000000;
const float p_o141558_r = 0.170000000;
const float p_o141570_ax = 0.000000000;
const float p_o141570_ay = 47.000000000;
const float p_o141570_az = 0.000000000;
const float p_o141568_x = -0.030000000;
const float p_o141568_y = 0.390000000;
const float p_o141568_z = 0.000000000;
const float p_o141569_ax = 0.000000000;
const float p_o141569_ay = 0.000000000;
const float p_o141569_az = -27.000000000;
const float p_o141564_l = 0.300000000;
const float p_o141564_r = 0.300000000;
const float p_o141562_l = 0.060000000;
const float p_o141562_r = 0.340000000;
const float p_o141565_angle = 65.000000000;
const float p_o141466_x = 0.000000000;
const float p_o141466_y = 0.800000000;
const float p_o141466_z = 0.000000000;
const float p_o141464_x = -0.420000000;
const float p_o141464_y = 0.000000000;
const float p_o141464_z = 0.000000000;
const float p_o141461_a = 6.000000000;
const float p_o141524_x = -0.150000000;
const float p_o141524_y = 0.840000000;
const float p_o141524_z = 0.070000000;
const float p_o141523_ax = 90.000000000;
const float p_o141523_ay = 100.000000000;
const float p_o141523_az = 0.000000000;
const float p_o141515_s = 0.090000000;
const float p_o141509_r = 0.140000000;
const float p_o141510_amount = 0.590000000;
const float p_o141511_sx = 0.250000000;
const float p_o141511_sy = 0.250000000;
const float p_o141511_sz = 0.000000000;
const float p_o141511_r = 0.010000000;
const float p_o141512_r = 0.260000000;
const float p_o141525_x = -0.150000000;
const float p_o141525_y = 0.840000000;
const float p_o141525_z = -0.060000000;
const float p_o141516_x = -0.250000000;
const float p_o141516_y = 0.550000000;
const float p_o141516_z = 0.000000000;
const float p_o141514_ax = 90.000000000;
const float p_o141514_ay = 100.000000000;
const float p_o141514_az = 0.000000000;
const float p_o141518_x = -0.260000000;
const float p_o141518_y = 0.390000000;
const float p_o141518_z = 0.000000000;
const float p_o141519_ax = 90.000000000;
const float p_o141519_ay = 86.000000000;
const float p_o141519_az = 0.000000000;
const float p_o141520_x = -0.310000000;
const float p_o141520_y = 0.210000000;
const float p_o141520_z = 0.000000000;
const float p_o141521_ax = 90.000000000;
const float p_o141521_ay = 120.000000000;
const float p_o141521_az = 0.000000000;
vec2 o141445_input_distance(vec3 p, float _seed_variation_) {
float o141453_0_1_sdf3d = sdCylinder((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141458_x, p_o141458_y, p_o141458_z)), -vec3(p_o141460_ax, p_o141460_ay, p_o141460_az)*0.01745329251)), p_o141453_l, p_o141453_r);
float o141455_0_1_sdf3d = sdCylinder(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141458_x, p_o141458_y, p_o141458_z)), -vec3(p_o141460_ax, p_o141460_ay, p_o141460_az)*0.01745329251))-vec3(p_o141456_x, p_o141456_y, p_o141456_z)), p_o141455_l, p_o141455_r);
vec2 o141456_0_1_sdf3dc = vec2(o141455_0_1_sdf3d, 0.0);
vec2 o141454_0_1_sdf3dc = sdf3dc_union(vec2(o141453_0_1_sdf3d, 0.0), o141456_0_1_sdf3dc);
vec2 o141460_0_1_sdf3dc = o141454_0_1_sdf3dc;
vec2 o141458_0_1_sdf3dc = o141460_0_1_sdf3dc;
float o141446_0_1_sdf3d = length(((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z)))-p_o141446_r;
float o141448_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141449_x, p_o141449_y, p_o141449_z)))-p_o141448_r;
vec2 o141449_0_1_sdf3dc = vec2(o141448_0_1_sdf3d, 0.0);
vec2 o141447_0_1_sdf3dc = sdf3d_smooth_union(vec2(o141446_0_1_sdf3d, 0.0), o141449_0_1_sdf3dc, p_o141447_k);
float o141452_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141451_x, p_o141451_y, p_o141451_z)))-p_o141452_r;
vec2 o141451_0_1_sdf3dc = vec2(o141452_0_1_sdf3d, 0.0);
vec2 o141450_0_1_sdf3dc = sdf3d_smooth_union(o141447_0_1_sdf3dc, o141451_0_1_sdf3dc, p_o141450_k);
vec3 o141587_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141590_x, p_o141590_y, p_o141590_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o141589_ay, p_o141589_az)*0.01745329251))-vec3(p_o141591_x, p_o141591_y, p_o141591_z));
o141587_0_p.y -= clamp(o141587_0_p.y, -p_o141587_l, p_o141587_l);
float o141587_0_1_sdf3d = length(o141587_0_p)-p_o141587_r*1.0;
vec2 o141591_0_1_sdf3dc = vec2(o141587_0_1_sdf3d, 0.0);
vec3 o141587_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141590_x, p_o141590_y, p_o141590_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o141589_ay, p_o141589_az)*0.01745329251))-vec3(p_o141592_x, p_o141592_y, p_o141592_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o141594_ay, p_o141594_az)*0.01745329251))-vec3(p_o141591_x, p_o141591_y, p_o141591_z));
o141587_3_p.y -= clamp(o141587_3_p.y, -p_o141587_l, p_o141587_l);
float o141587_0_4_sdf3d = length(o141587_3_p)-p_o141587_r*1.0;
vec2 o141591_0_3_sdf3dc = vec2(o141587_0_4_sdf3d, 0.0);
float o141598_0_1_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141590_x, p_o141590_y, p_o141590_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o141589_ay, p_o141589_az)*0.01745329251))-vec3(p_o141592_x, p_o141592_y, p_o141592_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o141594_ay, p_o141594_az)*0.01745329251))-vec3(p_o141602_x, p_o141602_y, p_o141602_z)), -vec3(p_o141603_ax, p_o141603_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251)).y;
vec3 o141595_0_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141590_x, p_o141590_y, p_o141590_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o141589_ay, p_o141589_az)*0.01745329251))-vec3(p_o141592_x, p_o141592_y, p_o141592_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o141594_ay, p_o141594_az)*0.01745329251))-vec3(p_o141602_x, p_o141602_y, p_o141602_z)), -vec3(p_o141603_ax, p_o141603_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251))-vec3(p_o141600_x, p_o141600_y, p_o141600_z)), p_o141597_c))-vec3(p_o141596_x, p_o141596_y, p_o141596_z));
o141595_0_p.y -= clamp(o141595_0_p.y, -p_o141595_l, p_o141595_l);
float o141595_0_1_sdf3d = length(o141595_0_p)-p_o141595_r*1.0;
vec2 o141596_0_1_sdf3dc = vec2(o141595_0_1_sdf3d, 0.0);
vec2 o141597_0_1_sdf3dc = o141596_0_1_sdf3dc;
vec2 o141600_0_1_sdf3dc = o141597_0_1_sdf3dc;
vec2 o141599_0_1_sdf3dc = sdf3dc_sub(vec2(o141598_0_1_sdf3d, 0.0), o141600_0_1_sdf3dc);
vec2 o141603_0_1_sdf3dc = o141599_0_1_sdf3dc;
vec2 o141602_0_1_sdf3dc = o141603_0_1_sdf3dc;
vec2 o141601_0_1_sdf3dc = sdf3dc_union(o141591_0_3_sdf3dc, o141602_0_1_sdf3dc);
vec2 o141594_0_1_sdf3dc = o141601_0_1_sdf3dc;
vec2 o141592_0_1_sdf3dc = o141594_0_1_sdf3dc;
vec2 o141593_0_1_sdf3dc = sdf3dc_union(o141591_0_1_sdf3dc, o141592_0_1_sdf3dc);
vec2 o141589_0_1_sdf3dc = o141593_0_1_sdf3dc;
vec2 o141590_0_1_sdf3dc = o141589_0_1_sdf3dc;
vec3 o141604_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141611_x, p_o141611_y, p_o141611_z)), -vec3(p_o141612_ax, p_o141612_ay, p_o141612_az)*0.01745329251))-vec3(p_o141605_x, p_o141605_y, p_o141605_z));
o141604_0_p.y -= clamp(o141604_0_p.y, -p_o141604_l, p_o141604_l);
float o141604_0_1_sdf3d = length(o141604_0_p)-p_o141604_r*1.0;
vec2 o141605_0_1_sdf3dc = vec2(o141604_0_1_sdf3d, 0.0);
vec3 o141604_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141611_x, p_o141611_y, p_o141611_z)), -vec3(p_o141612_ax, p_o141612_ay, p_o141612_az)*0.01745329251))-vec3(p_o141608_x, p_o141608_y, p_o141608_z)), -vec3(p_o141609_ax, p_o141609_ay, p_o141609_az)*0.01745329251))-vec3(p_o141605_x, p_o141605_y, p_o141605_z));
o141604_3_p.y -= clamp(o141604_3_p.y, -p_o141604_l, p_o141604_l);
float o141604_0_4_sdf3d = length(o141604_3_p)-p_o141604_r*1.0;
vec2 o141605_0_3_sdf3dc = vec2(o141604_0_4_sdf3d, 0.0);
float o141598_0_3_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141611_x, p_o141611_y, p_o141611_z)), -vec3(p_o141612_ax, p_o141612_ay, p_o141612_az)*0.01745329251))-vec3(p_o141608_x, p_o141608_y, p_o141608_z)), -vec3(p_o141609_ax, p_o141609_ay, p_o141609_az)*0.01745329251))-vec3(p_o141610_x, p_o141610_y, p_o141610_z)), -vec3(p_o141607_ax, p_o141607_ay, p_o141607_az)*0.01745329251)).y;
vec3 o141595_3_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141611_x, p_o141611_y, p_o141611_z)), -vec3(p_o141612_ax, p_o141612_ay, p_o141612_az)*0.01745329251))-vec3(p_o141608_x, p_o141608_y, p_o141608_z)), -vec3(p_o141609_ax, p_o141609_ay, p_o141609_az)*0.01745329251))-vec3(p_o141610_x, p_o141610_y, p_o141610_z)), -vec3(p_o141607_ax, p_o141607_ay, p_o141607_az)*0.01745329251))-vec3(p_o141600_x, p_o141600_y, p_o141600_z)), p_o141597_c))-vec3(p_o141596_x, p_o141596_y, p_o141596_z));
o141595_3_p.y -= clamp(o141595_3_p.y, -p_o141595_l, p_o141595_l);
float o141595_0_4_sdf3d = length(o141595_3_p)-p_o141595_r*1.0;
vec2 o141596_0_3_sdf3dc = vec2(o141595_0_4_sdf3d, 0.0);
vec2 o141597_0_3_sdf3dc = o141596_0_3_sdf3dc;
vec2 o141600_0_3_sdf3dc = o141597_0_3_sdf3dc;
vec2 o141599_0_3_sdf3dc = sdf3dc_sub(vec2(o141598_0_3_sdf3d, 0.0), o141600_0_3_sdf3dc);
vec2 o141607_0_1_sdf3dc = o141599_0_3_sdf3dc;
vec2 o141610_0_1_sdf3dc = o141607_0_1_sdf3dc;
vec2 o141606_0_1_sdf3dc = sdf3dc_union(o141605_0_3_sdf3dc, o141610_0_1_sdf3dc);
vec2 o141609_0_1_sdf3dc = o141606_0_1_sdf3dc;
vec2 o141608_0_1_sdf3dc = o141609_0_1_sdf3dc;
vec2 o141613_0_1_sdf3dc = sdf3dc_union(o141605_0_1_sdf3dc, o141608_0_1_sdf3dc);
vec2 o141612_0_1_sdf3dc = o141613_0_1_sdf3dc;
vec2 o141611_0_1_sdf3dc = o141612_0_1_sdf3dc;
vec2 o141614_0_1_sdf3dc = sdf3dc_union(o141590_0_1_sdf3dc, o141611_0_1_sdf3dc);
vec2 o141588_0_1_sdf3dc = sdf3dc_union(o141450_0_1_sdf3dc, o141614_0_1_sdf3dc);
float o141558_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141560_x, p_o141560_y, p_o141560_z)), p_o141558_l, p_o141558_r);
vec2 o141559_0_v = vec2(o141558_0_1_sdf3d, 0.0);vec2 o141559_0_1_sdf3dc = vec2(o141559_0_v.x-p_o141559_r, o141559_0_v.y);
vec2 o141560_0_1_sdf3dc = o141559_0_1_sdf3dc;
float o141564_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z)), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).xzy, p_o141564_l, p_o141564_r);
float o141562_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z)), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).xzy, p_o141562_l, p_o141562_r);
vec2 o141563_0_1_sdf3dc = sdf3dc_sub(vec2(o141564_0_1_sdf3d, 0.0), vec2(o141562_0_1_sdf3d, 0.0));
vec3 o141565_0_uv = (rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z)), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).zxy;
float o141565_0_rotated = rotate3d(o141565_0_uv, vec3((p_o141565_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o141565_0_d1 = max(o141565_0_uv.y, o141565_0_rotated);
float o141565_0_d2 = min(o141565_0_uv.y, o141565_0_rotated);
float o141565_0_d = (mod(p_o141565_angle, 360.0) < 180.0) ? o141565_0_d1 : o141565_0_d2;float o141565_0_1_sdf3d = o141565_0_d;
vec2 o141566_0_1_sdf3dc = sdf3dc_inter(o141563_0_1_sdf3dc, vec2(o141565_0_1_sdf3d, 0.0));
vec2 o141569_0_1_sdf3dc = o141566_0_1_sdf3dc;
vec2 o141568_0_1_sdf3dc = o141569_0_1_sdf3dc;
vec2 o141570_0_1_sdf3dc = o141568_0_1_sdf3dc;
vec2 o141567_0_1_sdf3dc = sdf3dc_union(o141560_0_1_sdf3dc, o141570_0_1_sdf3dc);
vec2 o141561_0_1_sdf3dc = sdf3dc_union(o141588_0_1_sdf3dc, o141567_0_1_sdf3dc);
vec2 o141457_0_1_sdf3dc = sdf3dc_union(o141458_0_1_sdf3dc, o141561_0_1_sdf3dc);
float o141463_0_1_sdf3d = (((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141466_x, p_o141466_y, p_o141466_z)).x;
float o141461_0_1_sdf3d = dot(vec2(cos(p_o141461_a*0.01745329251),sin(p_o141461_a*0.01745329251)),vec2(length(((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141466_x, p_o141466_y, p_o141466_z))-vec3(p_o141464_x, p_o141464_y, p_o141464_z)).yz),-((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141466_x, p_o141466_y, p_o141466_z))-vec3(p_o141464_x, p_o141464_y, p_o141464_z)).x));
vec2 o141464_0_1_sdf3dc = vec2(o141461_0_1_sdf3d, 0.0);
vec2 o141462_0_1_sdf3dc = sdf3dc_inter(vec2(o141463_0_1_sdf3d, 0.0), o141464_0_1_sdf3dc);
vec2 o141466_0_1_sdf3dc = o141462_0_1_sdf3dc;
vec2 o141465_0_1_sdf3dc = sdf3dc_union(o141457_0_1_sdf3dc, o141466_0_1_sdf3dc);
float o141511_0_1_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141524_x, p_o141524_y, p_o141524_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_1_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141524_x, p_o141524_y, p_o141524_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_1_sdf3d = mix(o141511_0_1_sdf3d, o141512_0_1_sdf3d, p_o141510_amount);
vec2 o141509_0_v = vec2(o141510_0_1_sdf3d, 0.0);vec2 o141509_0_1_sdf3dc = vec2(o141509_0_v.x-p_o141509_r, o141509_0_v.y);
vec2 o141515_0_in = o141509_0_1_sdf3dc;vec2 o141515_0_1_sdf3dc = vec2(o141515_0_in.x*p_o141515_s, o141515_0_in.y);
vec2 o141523_0_1_sdf3dc = o141515_0_1_sdf3dc;
vec2 o141524_0_1_sdf3dc = o141523_0_1_sdf3dc;
float o141511_0_3_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141525_x, p_o141525_y, p_o141525_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_3_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141525_x, p_o141525_y, p_o141525_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_3_sdf3d = mix(o141511_0_3_sdf3d, o141512_0_3_sdf3d, p_o141510_amount);
vec2 o141509_2_v = vec2(o141510_0_3_sdf3d, 0.0);vec2 o141509_0_3_sdf3dc = vec2(o141509_2_v.x-p_o141509_r, o141509_2_v.y);
vec2 o141515_2_in = o141509_0_3_sdf3dc;vec2 o141515_0_3_sdf3dc = vec2(o141515_2_in.x*p_o141515_s, o141515_2_in.y);
vec2 o141523_0_3_sdf3dc = o141515_0_3_sdf3dc;
vec2 o141525_0_1_sdf3dc = o141523_0_3_sdf3dc;
vec2 o141526_0_1_sdf3dc = sdf3dc_union(o141524_0_1_sdf3dc, o141525_0_1_sdf3dc);
float o141511_0_5_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141516_x, p_o141516_y, p_o141516_z)), -vec3(p_o141514_ax, p_o141514_ay, p_o141514_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_5_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141516_x, p_o141516_y, p_o141516_z)), -vec3(p_o141514_ax, p_o141514_ay, p_o141514_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_5_sdf3d = mix(o141511_0_5_sdf3d, o141512_0_5_sdf3d, p_o141510_amount);
vec2 o141509_4_v = vec2(o141510_0_5_sdf3d, 0.0);vec2 o141509_0_5_sdf3dc = vec2(o141509_4_v.x-p_o141509_r, o141509_4_v.y);
vec2 o141515_4_in = o141509_0_5_sdf3dc;vec2 o141515_0_5_sdf3dc = vec2(o141515_4_in.x*p_o141515_s, o141515_4_in.y);
vec2 o141514_0_1_sdf3dc = o141515_0_5_sdf3dc;
vec2 o141516_0_1_sdf3dc = o141514_0_1_sdf3dc;
float o141511_0_7_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141518_x, p_o141518_y, p_o141518_z)), -vec3(p_o141519_ax, p_o141519_ay, p_o141519_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_7_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141518_x, p_o141518_y, p_o141518_z)), -vec3(p_o141519_ax, p_o141519_ay, p_o141519_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_7_sdf3d = mix(o141511_0_7_sdf3d, o141512_0_7_sdf3d, p_o141510_amount);
vec2 o141509_6_v = vec2(o141510_0_7_sdf3d, 0.0);vec2 o141509_0_7_sdf3dc = vec2(o141509_6_v.x-p_o141509_r, o141509_6_v.y);
vec2 o141515_6_in = o141509_0_7_sdf3dc;vec2 o141515_0_7_sdf3dc = vec2(o141515_6_in.x*p_o141515_s, o141515_6_in.y);
vec2 o141519_0_1_sdf3dc = o141515_0_7_sdf3dc;
vec2 o141518_0_1_sdf3dc = o141519_0_1_sdf3dc;
vec2 o141517_0_1_sdf3dc = sdf3dc_union(o141516_0_1_sdf3dc, o141518_0_1_sdf3dc);
float o141511_0_9_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141520_x, p_o141520_y, p_o141520_z)), -vec3(p_o141521_ax, p_o141521_ay, p_o141521_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_9_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o141556_ax, p_o141556_ay, p_o141556_az)*0.01745329251))-vec3(p_o141459_x, p_o141459_y, p_o141459_z))-vec3(p_o141520_x, p_o141520_y, p_o141520_z)), -vec3(p_o141521_ax, p_o141521_ay, p_o141521_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_9_sdf3d = mix(o141511_0_9_sdf3d, o141512_0_9_sdf3d, p_o141510_amount);
vec2 o141509_8_v = vec2(o141510_0_9_sdf3d, 0.0);vec2 o141509_0_9_sdf3dc = vec2(o141509_8_v.x-p_o141509_r, o141509_8_v.y);
vec2 o141515_8_in = o141509_0_9_sdf3dc;vec2 o141515_0_9_sdf3dc = vec2(o141515_8_in.x*p_o141515_s, o141515_8_in.y);
vec2 o141521_0_1_sdf3dc = o141515_0_9_sdf3dc;
vec2 o141520_0_1_sdf3dc = o141521_0_1_sdf3dc;
vec2 o141522_0_1_sdf3dc = sdf3dc_union(o141517_0_1_sdf3dc, o141520_0_1_sdf3dc);
vec2 o141527_0_1_sdf3dc = sdf3dc_union(o141526_0_1_sdf3dc, o141522_0_1_sdf3dc);
vec2 o141513_0_1_sdf3dc = sdf3dc_union(o141465_0_1_sdf3dc, o141527_0_1_sdf3dc);
vec2 o141459_0_1_sdf3dc = o141513_0_1_sdf3dc;
vec2 o141556_0_1_sdf3dc = o141459_0_1_sdf3dc;

return o141556_0_1_sdf3dc;
}
const float p_o141557_ax = 0.000000000;
const float p_o141557_ay = 90.000000000;
const float p_o141557_az = 0.000000000;
const float p_o141494_x = 0.000000000;
const float p_o141494_y = -0.440000000;
const float p_o141494_z = 0.000000000;
const float p_o141528_d = 0.010000000;
const float p_o141529_g_0_pos = 0.663637000;
const float p_o141529_g_0_r = 0.000000000;
const float p_o141529_g_0_g = 0.000000000;
const float p_o141529_g_0_b = 0.000000000;
const float p_o141529_g_0_a = 1.000000000;
const float p_o141529_g_1_pos = 0.872727000;
const float p_o141529_g_1_r = 0.000000000;
const float p_o141529_g_1_g = 0.000000000;
const float p_o141529_g_1_b = 0.000000000;
const float p_o141529_g_1_a = 1.000000000;
vec4 o141529_g_gradient_fct(float x) {
  if (x < p_o141529_g_0_pos) {
    return vec4(p_o141529_g_0_r,p_o141529_g_0_g,p_o141529_g_0_b,p_o141529_g_0_a);
  } else if (x < p_o141529_g_1_pos) {
    return mix(vec4(p_o141529_g_0_r,p_o141529_g_0_g,p_o141529_g_0_b,p_o141529_g_0_a), vec4(p_o141529_g_1_r,p_o141529_g_1_g,p_o141529_g_1_b,p_o141529_g_1_a), ((x-p_o141529_g_0_pos)/(p_o141529_g_1_pos-p_o141529_g_0_pos)));
  }
  return vec4(p_o141529_g_1_r,p_o141529_g_1_g,p_o141529_g_1_b,p_o141529_g_1_a);
}
const float p_o141495_d = 0.010000000;
const float p_o141496_g_0_pos = 0.806305000;
const float p_o141496_g_0_r = 0.078125000;
const float p_o141496_g_0_g = 0.078125000;
const float p_o141496_g_0_b = 0.078125000;
const float p_o141496_g_0_a = 1.000000000;
const float p_o141496_g_1_pos = 0.979033000;
const float p_o141496_g_1_r = 0.078125000;
const float p_o141496_g_1_g = 0.078125000;
const float p_o141496_g_1_b = 0.078125000;
const float p_o141496_g_1_a = 1.000000000;
vec4 o141496_g_gradient_fct(float x) {
  if (x < p_o141496_g_0_pos) {
    return vec4(p_o141496_g_0_r,p_o141496_g_0_g,p_o141496_g_0_b,p_o141496_g_0_a);
  } else if (x < p_o141496_g_1_pos) {
    return mix(vec4(p_o141496_g_0_r,p_o141496_g_0_g,p_o141496_g_0_b,p_o141496_g_0_a), vec4(p_o141496_g_1_r,p_o141496_g_1_g,p_o141496_g_1_b,p_o141496_g_1_a), ((x-p_o141496_g_0_pos)/(p_o141496_g_1_pos-p_o141496_g_0_pos)));
  }
  return vec4(p_o141496_g_1_r,p_o141496_g_1_g,p_o141496_g_1_b,p_o141496_g_1_a);
}
const float p_o141571_d = 0.010000000;
const float p_o141572_g_0_pos = 0.690909000;
const float p_o141572_g_0_r = 0.738281012;
const float p_o141572_g_0_g = 0.000000000;
const float p_o141572_g_0_b = 0.000000000;
const float p_o141572_g_0_a = 1.000000000;
const float p_o141572_g_1_pos = 0.936364000;
const float p_o141572_g_1_r = 0.738281012;
const float p_o141572_g_1_g = 0.000000000;
const float p_o141572_g_1_b = 0.000000000;
const float p_o141572_g_1_a = 1.000000000;
vec4 o141572_g_gradient_fct(float x) {
  if (x < p_o141572_g_0_pos) {
    return vec4(p_o141572_g_0_r,p_o141572_g_0_g,p_o141572_g_0_b,p_o141572_g_0_a);
  } else if (x < p_o141572_g_1_pos) {
    return mix(vec4(p_o141572_g_0_r,p_o141572_g_0_g,p_o141572_g_0_b,p_o141572_g_0_a), vec4(p_o141572_g_1_r,p_o141572_g_1_g,p_o141572_g_1_b,p_o141572_g_1_a), ((x-p_o141572_g_0_pos)/(p_o141572_g_1_pos-p_o141572_g_0_pos)));
  }
  return vec4(p_o141572_g_1_r,p_o141572_g_1_g,p_o141572_g_1_b,p_o141572_g_1_a);
}
const float p_o141615_d = 0.010000000;
const float p_o141616_g_0_pos = 0.886364000;
const float p_o141616_g_0_r = 0.859375000;
const float p_o141616_g_0_g = 0.868164003;
const float p_o141616_g_0_b = 1.000000000;
const float p_o141616_g_0_a = 1.000000000;
const float p_o141616_g_1_pos = 1.000000000;
const float p_o141616_g_1_r = 0.859375000;
const float p_o141616_g_1_g = 0.868164003;
const float p_o141616_g_1_b = 1.000000000;
const float p_o141616_g_1_a = 1.000000000;
vec4 o141616_g_gradient_fct(float x) {
  if (x < p_o141616_g_0_pos) {
    return vec4(p_o141616_g_0_r,p_o141616_g_0_g,p_o141616_g_0_b,p_o141616_g_0_a);
  } else if (x < p_o141616_g_1_pos) {
    return mix(vec4(p_o141616_g_0_r,p_o141616_g_0_g,p_o141616_g_0_b,p_o141616_g_0_a), vec4(p_o141616_g_1_r,p_o141616_g_1_g,p_o141616_g_1_b,p_o141616_g_1_a), ((x-p_o141616_g_0_pos)/(p_o141616_g_1_pos-p_o141616_g_0_pos)));
  }
  return vec4(p_o141616_g_1_r,p_o141616_g_1_g,p_o141616_g_1_b,p_o141616_g_1_a);
}
const float p_o141467_d = 0.010000000;
const float p_o141468_g_0_pos = 0.901993000;
const float p_o141468_g_0_r = 0.824218988;
const float p_o141468_g_0_g = 0.270446986;
const float p_o141468_g_0_b = 0.000000000;
const float p_o141468_g_0_a = 1.000000000;
const float p_o141468_g_1_pos = 0.961794000;
const float p_o141468_g_1_r = 0.824218988;
const float p_o141468_g_1_g = 0.270446986;
const float p_o141468_g_1_b = 0.000000000;
const float p_o141468_g_1_a = 1.000000000;
vec4 o141468_g_gradient_fct(float x) {
  if (x < p_o141468_g_0_pos) {
    return vec4(p_o141468_g_0_r,p_o141468_g_0_g,p_o141468_g_0_b,p_o141468_g_0_a);
  } else if (x < p_o141468_g_1_pos) {
    return mix(vec4(p_o141468_g_0_r,p_o141468_g_0_g,p_o141468_g_0_b,p_o141468_g_0_a), vec4(p_o141468_g_1_r,p_o141468_g_1_g,p_o141468_g_1_b,p_o141468_g_1_a), ((x-p_o141468_g_0_pos)/(p_o141468_g_1_pos-p_o141468_g_0_pos)));
  }
  return vec4(p_o141468_g_1_r,p_o141468_g_1_g,p_o141468_g_1_b,p_o141468_g_1_a);
}
const float p_o141481_g_0_pos = 0.751760000;
const float p_o141481_g_0_r = 0.136719003;
const float p_o141481_g_0_g = 0.122262001;
const float p_o141481_g_0_b = 0.112686001;
const float p_o141481_g_0_a = 1.000000000;
const float p_o141481_g_1_pos = 0.951760000;
const float p_o141481_g_1_r = 0.136719003;
const float p_o141481_g_1_g = 0.122262001;
const float p_o141481_g_1_b = 0.112686001;
const float p_o141481_g_1_a = 1.000000000;
vec4 o141481_g_gradient_fct(float x) {
  if (x < p_o141481_g_0_pos) {
    return vec4(p_o141481_g_0_r,p_o141481_g_0_g,p_o141481_g_0_b,p_o141481_g_0_a);
  } else if (x < p_o141481_g_1_pos) {
    return mix(vec4(p_o141481_g_0_r,p_o141481_g_0_g,p_o141481_g_0_b,p_o141481_g_0_a), vec4(p_o141481_g_1_r,p_o141481_g_1_g,p_o141481_g_1_b,p_o141481_g_1_a), ((x-p_o141481_g_0_pos)/(p_o141481_g_1_pos-p_o141481_g_0_pos)));
  }
  return vec4(p_o141481_g_1_r,p_o141481_g_1_g,p_o141481_g_1_b,p_o141481_g_1_a);
}
vec3 o141445_input_albedo(vec4 p, float _seed_variation_) {
vec3 o141529_0_1_tex3d = o141529_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o141496_0_1_tex3d = o141496_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o141572_0_1_tex3d = o141572_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o141616_0_1_tex3d = o141616_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o141468_0_1_tex3d = o141468_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o141481_0_1_tex3d = o141481_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
float o141463_0_1_sdf3d = (((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141466_x, p_o141466_y, p_o141466_z)).x;
float o141461_0_1_sdf3d = dot(vec2(cos(p_o141461_a*0.01745329251),sin(p_o141461_a*0.01745329251)),vec2(length(((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141466_x, p_o141466_y, p_o141466_z))-vec3(p_o141464_x, p_o141464_y, p_o141464_z)).yz),-((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141466_x, p_o141466_y, p_o141466_z))-vec3(p_o141464_x, p_o141464_y, p_o141464_z)).x));
vec2 o141464_0_1_sdf3dc = vec2(o141461_0_1_sdf3d, 0.0);
vec2 o141462_0_1_sdf3dc = sdf3dc_inter(vec2(o141463_0_1_sdf3d, 0.0), o141464_0_1_sdf3dc);
vec2 o141466_0_1_sdf3dc = o141462_0_1_sdf3dc;
vec3 o141467_0_1_tex3d = mix(o141468_0_1_tex3d, o141481_0_1_tex3d, clamp((o141466_0_1_sdf3dc).x/max(p_o141467_d, 0.0001), 0.0, 1.0));
float o141446_0_1_sdf3d = length(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz))-p_o141446_r;
float o141448_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141449_x, p_o141449_y, p_o141449_z)))-p_o141448_r;
vec2 o141449_0_1_sdf3dc = vec2(o141448_0_1_sdf3d, 0.0);
vec2 o141447_0_1_sdf3dc = sdf3d_smooth_union(vec2(o141446_0_1_sdf3d, 0.0), o141449_0_1_sdf3dc, p_o141447_k);
float o141452_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141451_x, p_o141451_y, p_o141451_z)))-p_o141452_r;
vec2 o141451_0_1_sdf3dc = vec2(o141452_0_1_sdf3d, 0.0);
vec2 o141450_0_1_sdf3dc = sdf3d_smooth_union(o141447_0_1_sdf3dc, o141451_0_1_sdf3dc, p_o141450_k);
vec3 o141615_0_1_tex3d = mix(o141616_0_1_tex3d, o141467_0_1_tex3d, clamp((o141450_0_1_sdf3dc).x/max(p_o141615_d, 0.0001), 0.0, 1.0));
float o141558_0_1_sdf3d = sdCylinder((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141560_x, p_o141560_y, p_o141560_z)), p_o141558_l, p_o141558_r);
vec2 o141559_0_v = vec2(o141558_0_1_sdf3d, 0.0);vec2 o141559_0_1_sdf3dc = vec2(o141559_0_v.x-p_o141559_r, o141559_0_v.y);
vec2 o141560_0_1_sdf3dc = o141559_0_1_sdf3dc;
float o141564_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).xzy, p_o141564_l, p_o141564_r);
float o141562_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).xzy, p_o141562_l, p_o141562_r);
vec2 o141563_0_1_sdf3dc = sdf3dc_sub(vec2(o141564_0_1_sdf3d, 0.0), vec2(o141562_0_1_sdf3d, 0.0));
vec3 o141565_0_uv = (rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o141570_ax, p_o141570_ay, p_o141570_az)*0.01745329251))-vec3(p_o141568_x, p_o141568_y, p_o141568_z)), -vec3(p_o141569_ax, p_o141569_ay, p_o141569_az)*0.01745329251)).zxy;
float o141565_0_rotated = rotate3d(o141565_0_uv, vec3((p_o141565_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o141565_0_d1 = max(o141565_0_uv.y, o141565_0_rotated);
float o141565_0_d2 = min(o141565_0_uv.y, o141565_0_rotated);
float o141565_0_d = (mod(p_o141565_angle, 360.0) < 180.0) ? o141565_0_d1 : o141565_0_d2;float o141565_0_1_sdf3d = o141565_0_d;
vec2 o141566_0_1_sdf3dc = sdf3dc_inter(o141563_0_1_sdf3dc, vec2(o141565_0_1_sdf3d, 0.0));
vec2 o141569_0_1_sdf3dc = o141566_0_1_sdf3dc;
vec2 o141568_0_1_sdf3dc = o141569_0_1_sdf3dc;
vec2 o141570_0_1_sdf3dc = o141568_0_1_sdf3dc;
vec2 o141567_0_1_sdf3dc = sdf3dc_union(o141560_0_1_sdf3dc, o141570_0_1_sdf3dc);
vec3 o141571_0_1_tex3d = mix(o141572_0_1_tex3d, o141615_0_1_tex3d, clamp((o141567_0_1_sdf3dc).x/max(p_o141571_d, 0.0001), 0.0, 1.0));
float o141453_0_1_sdf3d = sdCylinder((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141458_x, p_o141458_y, p_o141458_z)), -vec3(p_o141460_ax, p_o141460_ay, p_o141460_az)*0.01745329251)), p_o141453_l, p_o141453_r);
float o141455_0_1_sdf3d = sdCylinder(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141458_x, p_o141458_y, p_o141458_z)), -vec3(p_o141460_ax, p_o141460_ay, p_o141460_az)*0.01745329251))-vec3(p_o141456_x, p_o141456_y, p_o141456_z)), p_o141455_l, p_o141455_r);
vec2 o141456_0_1_sdf3dc = vec2(o141455_0_1_sdf3d, 0.0);
vec2 o141454_0_1_sdf3dc = sdf3dc_union(vec2(o141453_0_1_sdf3d, 0.0), o141456_0_1_sdf3dc);
vec2 o141460_0_1_sdf3dc = o141454_0_1_sdf3dc;
vec2 o141458_0_1_sdf3dc = o141460_0_1_sdf3dc;
vec3 o141495_0_1_tex3d = mix(o141496_0_1_tex3d, o141571_0_1_tex3d, clamp((o141458_0_1_sdf3dc).x/max(p_o141495_d, 0.0001), 0.0, 1.0));
float o141511_0_1_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141524_x, p_o141524_y, p_o141524_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_1_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141524_x, p_o141524_y, p_o141524_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_1_sdf3d = mix(o141511_0_1_sdf3d, o141512_0_1_sdf3d, p_o141510_amount);
vec2 o141509_0_v = vec2(o141510_0_1_sdf3d, 0.0);vec2 o141509_0_1_sdf3dc = vec2(o141509_0_v.x-p_o141509_r, o141509_0_v.y);
vec2 o141515_0_in = o141509_0_1_sdf3dc;vec2 o141515_0_1_sdf3dc = vec2(o141515_0_in.x*p_o141515_s, o141515_0_in.y);
vec2 o141523_0_1_sdf3dc = o141515_0_1_sdf3dc;
vec2 o141524_0_1_sdf3dc = o141523_0_1_sdf3dc;
float o141511_0_3_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141525_x, p_o141525_y, p_o141525_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_3_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141525_x, p_o141525_y, p_o141525_z)), -vec3(p_o141523_ax, p_o141523_ay, p_o141523_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_3_sdf3d = mix(o141511_0_3_sdf3d, o141512_0_3_sdf3d, p_o141510_amount);
vec2 o141509_2_v = vec2(o141510_0_3_sdf3d, 0.0);vec2 o141509_0_3_sdf3dc = vec2(o141509_2_v.x-p_o141509_r, o141509_2_v.y);
vec2 o141515_2_in = o141509_0_3_sdf3dc;vec2 o141515_0_3_sdf3dc = vec2(o141515_2_in.x*p_o141515_s, o141515_2_in.y);
vec2 o141523_0_3_sdf3dc = o141515_0_3_sdf3dc;
vec2 o141525_0_1_sdf3dc = o141523_0_3_sdf3dc;
vec2 o141526_0_1_sdf3dc = sdf3dc_union(o141524_0_1_sdf3dc, o141525_0_1_sdf3dc);
float o141511_0_5_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141516_x, p_o141516_y, p_o141516_z)), -vec3(p_o141514_ax, p_o141514_ay, p_o141514_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_5_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141516_x, p_o141516_y, p_o141516_z)), -vec3(p_o141514_ax, p_o141514_ay, p_o141514_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_5_sdf3d = mix(o141511_0_5_sdf3d, o141512_0_5_sdf3d, p_o141510_amount);
vec2 o141509_4_v = vec2(o141510_0_5_sdf3d, 0.0);vec2 o141509_0_5_sdf3dc = vec2(o141509_4_v.x-p_o141509_r, o141509_4_v.y);
vec2 o141515_4_in = o141509_0_5_sdf3dc;vec2 o141515_0_5_sdf3dc = vec2(o141515_4_in.x*p_o141515_s, o141515_4_in.y);
vec2 o141514_0_1_sdf3dc = o141515_0_5_sdf3dc;
vec2 o141516_0_1_sdf3dc = o141514_0_1_sdf3dc;
float o141511_0_7_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141518_x, p_o141518_y, p_o141518_z)), -vec3(p_o141519_ax, p_o141519_ay, p_o141519_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_7_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141518_x, p_o141518_y, p_o141518_z)), -vec3(p_o141519_ax, p_o141519_ay, p_o141519_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_7_sdf3d = mix(o141511_0_7_sdf3d, o141512_0_7_sdf3d, p_o141510_amount);
vec2 o141509_6_v = vec2(o141510_0_7_sdf3d, 0.0);vec2 o141509_0_7_sdf3dc = vec2(o141509_6_v.x-p_o141509_r, o141509_6_v.y);
vec2 o141515_6_in = o141509_0_7_sdf3dc;vec2 o141515_0_7_sdf3dc = vec2(o141515_6_in.x*p_o141515_s, o141515_6_in.y);
vec2 o141519_0_1_sdf3dc = o141515_0_7_sdf3dc;
vec2 o141518_0_1_sdf3dc = o141519_0_1_sdf3dc;
vec2 o141517_0_1_sdf3dc = sdf3dc_union(o141516_0_1_sdf3dc, o141518_0_1_sdf3dc);
float o141511_0_9_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141520_x, p_o141520_y, p_o141520_z)), -vec3(p_o141521_ax, p_o141521_ay, p_o141521_az)*0.01745329251)))/p_o141515_s), vec3(p_o141511_sx, p_o141511_sy, p_o141511_sz))-p_o141511_r;
float o141512_0_9_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).xyz-vec3(p_o141494_x, p_o141494_y, p_o141494_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o141557_ax, p_o141557_ay, p_o141557_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o141520_x, p_o141520_y, p_o141520_z)), -vec3(p_o141521_ax, p_o141521_ay, p_o141521_az)*0.01745329251)))/p_o141515_s))-p_o141512_r;
float o141510_0_9_sdf3d = mix(o141511_0_9_sdf3d, o141512_0_9_sdf3d, p_o141510_amount);
vec2 o141509_8_v = vec2(o141510_0_9_sdf3d, 0.0);vec2 o141509_0_9_sdf3dc = vec2(o141509_8_v.x-p_o141509_r, o141509_8_v.y);
vec2 o141515_8_in = o141509_0_9_sdf3dc;vec2 o141515_0_9_sdf3dc = vec2(o141515_8_in.x*p_o141515_s, o141515_8_in.y);
vec2 o141521_0_1_sdf3dc = o141515_0_9_sdf3dc;
vec2 o141520_0_1_sdf3dc = o141521_0_1_sdf3dc;
vec2 o141522_0_1_sdf3dc = sdf3dc_union(o141517_0_1_sdf3dc, o141520_0_1_sdf3dc);
vec2 o141527_0_1_sdf3dc = sdf3dc_union(o141526_0_1_sdf3dc, o141522_0_1_sdf3dc);
vec3 o141528_0_1_tex3d = mix(o141529_0_1_tex3d, o141495_0_1_tex3d, clamp((o141527_0_1_sdf3dc).x/max(p_o141528_d, 0.0001), 0.0, 1.0));
vec3 o141494_0_1_tex3d = o141528_0_1_tex3d;
vec3 o141557_0_1_tex3d = o141494_0_1_tex3d;

return o141557_0_1_tex3d;
}
vec3 o141445_input_metallic(vec4 p, float _seed_variation_) {

return vec3(0.0);
}
vec3 o141445_input_roughness(vec4 p, float _seed_variation_) {

return vec3(1.0);
}


vec2 GetDist(vec3 p) {
    float _seed_variation_ = seed_variation;

	vec2 d = o141445_input_distance(p, _seed_variation_);

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

		ALBEDO = o141445_input_albedo(vec4(p, rm.y), _seed_variation_);
		ROUGHNESS = o141445_input_roughness(vec4(p, rm.y), _seed_variation_).x;
		METALLIC = o141445_input_metallic(vec4(p, rm.y), _seed_variation_).x;

		NORMAL = (INV_VIEW_MATRIX*vec4(GetNormal(p), 0.0)).xyz;
	}
}



