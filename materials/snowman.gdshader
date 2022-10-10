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

const float p_o610292_ax = 0.000000000;
const float p_o610292_ay = 90.000000000;
const float p_o610292_az = 0.000000000;
const float p_o610195_x = 0.000000000;
const float p_o610195_y = -0.440000000;
const float p_o610195_z = 0.000000000;
const float p_o610194_x = 0.000000000;
const float p_o610194_y = 0.910000000;
const float p_o610194_z = -0.010000000;
const float p_o610196_ax = 14.000000000;
const float p_o610196_ay = 0.000000000;
const float p_o610196_az = 0.000000000;
const float p_o610189_l = 0.005000000;
const float p_o610189_r = 0.246883000;
const float p_o610192_x = 0.000000000;
const float p_o610192_y = 0.140000000;
const float p_o610192_z = 0.000000000;
const float p_o610191_l = 0.130000000;
const float p_o610191_r = 0.178313000;
const float p_o610186_k = 0.030000000;
const float p_o610183_k = 0.030000000;
const float p_o610182_r = 0.370000000;
const float p_o610185_x = 0.000000000;
const float p_o610185_y = 0.450000000;
const float p_o610185_z = 0.000000000;
const float p_o610184_r = 0.266819000;
const float p_o610187_x = 0.000000000;
const float p_o610187_y = 0.790000000;
const float p_o610187_z = 0.000000000;
const float p_o610188_r = 0.180000000;
const float p_o610326_x = 0.000000000;
const float p_o610326_y = 0.560000000;
const float p_o610326_z = -0.230000000;
const float p_o610325_ay = 0.000000000;
const float p_o610325_az = 0.000000000;
const float p_o610327_x = 0.000000000;
const float p_o610327_y = 0.100000000;
const float p_o610327_z = 0.000000000;
const float p_o610323_l = 0.100000000;
const float p_o610323_r = 0.010000000;
const float p_o610328_x = 0.000000000;
const float p_o610328_y = 0.190000000;
const float p_o610328_z = 0.000000000;
const float p_o610330_ay = 0.000000000;
const float p_o610330_az = 0.000000000;
const float p_o610338_x = 0.000000000;
const float p_o610338_y = 0.200000000;
const float p_o610338_z = 0.000000000;
const float p_o610339_ax = 0.000000000;
const float p_o610339_ay = 90.000000000;
const float p_o610336_x = 0.000000000;
const float p_o610336_y = 0.005000000;
const float p_o610336_z = 0.000000000;
const float p_o610333_c = 9.000000000;
const float p_o610332_x = 0.000000000;
const float p_o610332_y = 0.040000000;
const float p_o610332_z = 0.000000000;
const float p_o610331_l = 0.040000000;
const float p_o610331_r = 0.010000000;
const float p_o610347_x = 0.000000000;
const float p_o610347_y = 0.570000000;
const float p_o610347_z = 0.230000000;
const float p_o610348_ax = -126.000000000;
const float p_o610348_ay = 0.000000000;
const float p_o610348_az = 0.000000000;
const float p_o610341_x = 0.000000000;
const float p_o610341_y = 0.100000000;
const float p_o610341_z = 0.000000000;
const float p_o610340_l = 0.100000000;
const float p_o610340_r = 0.010000000;
const float p_o610344_x = 0.000000000;
const float p_o610344_y = 0.190000000;
const float p_o610344_z = 0.000000000;
const float p_o610345_ax = -30.000000000;
const float p_o610345_ay = 0.000000000;
const float p_o610345_az = 0.000000000;
const float p_o610346_x = 0.000000000;
const float p_o610346_y = 0.200000000;
const float p_o610346_z = 0.000000000;
const float p_o610343_ax = 0.000000000;
const float p_o610343_ay = 90.000000000;
const float p_o610343_az = 0.000000000;
const float p_o610296_x = 0.000000000;
const float p_o610296_y = 0.690000000;
const float p_o610296_z = 0.000000000;
const float p_o610295_r = 0.030000000;
const float p_o610294_l = 0.010000000;
const float p_o610294_r = 0.170000000;
const float p_o610306_ax = 0.000000000;
const float p_o610306_ay = 47.000000000;
const float p_o610306_az = 0.000000000;
const float p_o610304_x = -0.030000000;
const float p_o610304_y = 0.390000000;
const float p_o610304_z = 0.000000000;
const float p_o610305_ax = 0.000000000;
const float p_o610305_ay = 0.000000000;
const float p_o610305_az = -27.000000000;
const float p_o610300_l = 0.300000000;
const float p_o610300_r = 0.300000000;
const float p_o610298_l = 0.060000000;
const float p_o610298_r = 0.340000000;
const float p_o610301_angle = 65.000000000;
const float p_o610202_x = 0.000000000;
const float p_o610202_y = 0.800000000;
const float p_o610202_z = 0.000000000;
const float p_o610200_x = -0.420000000;
const float p_o610200_y = 0.000000000;
const float p_o610200_z = 0.000000000;
const float p_o610197_a = 6.000000000;
const float p_o610260_x = -0.150000000;
const float p_o610260_y = 0.840000000;
const float p_o610260_z = 0.070000000;
const float p_o610259_ax = 90.000000000;
const float p_o610259_ay = 100.000000000;
const float p_o610259_az = 0.000000000;
const float p_o610251_s = 0.090000000;
const float p_o610245_r = 0.140000000;
const float p_o610246_amount = 0.590000000;
const float p_o610247_sx = 0.250000000;
const float p_o610247_sy = 0.250000000;
const float p_o610247_sz = 0.000000000;
const float p_o610247_r = 0.010000000;
const float p_o610248_r = 0.260000000;
const float p_o610261_x = -0.150000000;
const float p_o610261_y = 0.840000000;
const float p_o610261_z = -0.060000000;
const float p_o610252_x = -0.250000000;
const float p_o610252_y = 0.550000000;
const float p_o610252_z = 0.000000000;
const float p_o610250_ax = 90.000000000;
const float p_o610250_ay = 100.000000000;
const float p_o610250_az = 0.000000000;
const float p_o610254_x = -0.260000000;
const float p_o610254_y = 0.390000000;
const float p_o610254_z = 0.000000000;
const float p_o610255_ax = 90.000000000;
const float p_o610255_ay = 86.000000000;
const float p_o610255_az = 0.000000000;
const float p_o610256_x = -0.310000000;
const float p_o610256_y = 0.210000000;
const float p_o610256_z = 0.000000000;
const float p_o610257_ax = 90.000000000;
const float p_o610257_ay = 120.000000000;
const float p_o610257_az = 0.000000000;
vec2 o610181_input_distance(vec3 p, float _seed_variation_) {
float o610189_0_1_sdf3d = sdCylinder((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610194_x, p_o610194_y, p_o610194_z)), -vec3(p_o610196_ax, p_o610196_ay, p_o610196_az)*0.01745329251)), p_o610189_l, p_o610189_r);
float o610191_0_1_sdf3d = sdCylinder(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610194_x, p_o610194_y, p_o610194_z)), -vec3(p_o610196_ax, p_o610196_ay, p_o610196_az)*0.01745329251))-vec3(p_o610192_x, p_o610192_y, p_o610192_z)), p_o610191_l, p_o610191_r);
vec2 o610192_0_1_sdf3dc = vec2(o610191_0_1_sdf3d, 0.0);
vec2 o610190_0_1_sdf3dc = sdf3dc_union(vec2(o610189_0_1_sdf3d, 0.0), o610192_0_1_sdf3dc);
vec2 o610196_0_1_sdf3dc = o610190_0_1_sdf3dc;
vec2 o610194_0_1_sdf3dc = o610196_0_1_sdf3dc;
float o610182_0_1_sdf3d = length(((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z)))-p_o610182_r;
float o610184_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610185_x, p_o610185_y, p_o610185_z)))-p_o610184_r;
vec2 o610185_0_1_sdf3dc = vec2(o610184_0_1_sdf3d, 0.0);
vec2 o610183_0_1_sdf3dc = sdf3d_smooth_union(vec2(o610182_0_1_sdf3d, 0.0), o610185_0_1_sdf3dc, p_o610183_k);
float o610188_0_1_sdf3d = length((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610187_x, p_o610187_y, p_o610187_z)))-p_o610188_r;
vec2 o610187_0_1_sdf3dc = vec2(o610188_0_1_sdf3d, 0.0);
vec2 o610186_0_1_sdf3dc = sdf3d_smooth_union(o610183_0_1_sdf3dc, o610187_0_1_sdf3dc, p_o610186_k);
vec3 o610323_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610326_x, p_o610326_y, p_o610326_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o610325_ay, p_o610325_az)*0.01745329251))-vec3(p_o610327_x, p_o610327_y, p_o610327_z));
o610323_0_p.y -= clamp(o610323_0_p.y, -p_o610323_l, p_o610323_l);
float o610323_0_1_sdf3d = length(o610323_0_p)-p_o610323_r*1.0;
vec2 o610327_0_1_sdf3dc = vec2(o610323_0_1_sdf3d, 0.0);
vec3 o610323_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610326_x, p_o610326_y, p_o610326_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o610325_ay, p_o610325_az)*0.01745329251))-vec3(p_o610328_x, p_o610328_y, p_o610328_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o610330_ay, p_o610330_az)*0.01745329251))-vec3(p_o610327_x, p_o610327_y, p_o610327_z));
o610323_3_p.y -= clamp(o610323_3_p.y, -p_o610323_l, p_o610323_l);
float o610323_0_4_sdf3d = length(o610323_3_p)-p_o610323_r*1.0;
vec2 o610327_0_3_sdf3dc = vec2(o610323_0_4_sdf3d, 0.0);
float o610334_0_1_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610326_x, p_o610326_y, p_o610326_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o610325_ay, p_o610325_az)*0.01745329251))-vec3(p_o610328_x, p_o610328_y, p_o610328_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o610330_ay, p_o610330_az)*0.01745329251))-vec3(p_o610338_x, p_o610338_y, p_o610338_z)), -vec3(p_o610339_ax, p_o610339_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251)).y;
vec3 o610331_0_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610326_x, p_o610326_y, p_o610326_z)), -vec3((60.0 + sin(elapsed_time * 4.0) * 10.0), p_o610325_ay, p_o610325_az)*0.01745329251))-vec3(p_o610328_x, p_o610328_y, p_o610328_z)), -vec3((-30.0 + sin(elapsed_time * 4.0) * 10.0), p_o610330_ay, p_o610330_az)*0.01745329251))-vec3(p_o610338_x, p_o610338_y, p_o610338_z)), -vec3(p_o610339_ax, p_o610339_ay, (sin(elapsed_time * 4.0) * 10.0))*0.01745329251))-vec3(p_o610336_x, p_o610336_y, p_o610336_z)), p_o610333_c))-vec3(p_o610332_x, p_o610332_y, p_o610332_z));
o610331_0_p.y -= clamp(o610331_0_p.y, -p_o610331_l, p_o610331_l);
float o610331_0_1_sdf3d = length(o610331_0_p)-p_o610331_r*1.0;
vec2 o610332_0_1_sdf3dc = vec2(o610331_0_1_sdf3d, 0.0);
vec2 o610333_0_1_sdf3dc = o610332_0_1_sdf3dc;
vec2 o610336_0_1_sdf3dc = o610333_0_1_sdf3dc;
vec2 o610335_0_1_sdf3dc = sdf3dc_sub(vec2(o610334_0_1_sdf3d, 0.0), o610336_0_1_sdf3dc);
vec2 o610339_0_1_sdf3dc = o610335_0_1_sdf3dc;
vec2 o610338_0_1_sdf3dc = o610339_0_1_sdf3dc;
vec2 o610337_0_1_sdf3dc = sdf3dc_union(o610327_0_3_sdf3dc, o610338_0_1_sdf3dc);
vec2 o610330_0_1_sdf3dc = o610337_0_1_sdf3dc;
vec2 o610328_0_1_sdf3dc = o610330_0_1_sdf3dc;
vec2 o610329_0_1_sdf3dc = sdf3dc_union(o610327_0_1_sdf3dc, o610328_0_1_sdf3dc);
vec2 o610325_0_1_sdf3dc = o610329_0_1_sdf3dc;
vec2 o610326_0_1_sdf3dc = o610325_0_1_sdf3dc;
vec3 o610340_0_p = ((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610347_x, p_o610347_y, p_o610347_z)), -vec3(p_o610348_ax, p_o610348_ay, p_o610348_az)*0.01745329251))-vec3(p_o610341_x, p_o610341_y, p_o610341_z));
o610340_0_p.y -= clamp(o610340_0_p.y, -p_o610340_l, p_o610340_l);
float o610340_0_1_sdf3d = length(o610340_0_p)-p_o610340_r*1.0;
vec2 o610341_0_1_sdf3dc = vec2(o610340_0_1_sdf3d, 0.0);
vec3 o610340_3_p = ((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610347_x, p_o610347_y, p_o610347_z)), -vec3(p_o610348_ax, p_o610348_ay, p_o610348_az)*0.01745329251))-vec3(p_o610344_x, p_o610344_y, p_o610344_z)), -vec3(p_o610345_ax, p_o610345_ay, p_o610345_az)*0.01745329251))-vec3(p_o610341_x, p_o610341_y, p_o610341_z));
o610340_3_p.y -= clamp(o610340_3_p.y, -p_o610340_l, p_o610340_l);
float o610340_0_4_sdf3d = length(o610340_3_p)-p_o610340_r*1.0;
vec2 o610341_0_3_sdf3dc = vec2(o610340_0_4_sdf3d, 0.0);
float o610334_0_3_sdf3d = (rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610347_x, p_o610347_y, p_o610347_z)), -vec3(p_o610348_ax, p_o610348_ay, p_o610348_az)*0.01745329251))-vec3(p_o610344_x, p_o610344_y, p_o610344_z)), -vec3(p_o610345_ax, p_o610345_ay, p_o610345_az)*0.01745329251))-vec3(p_o610346_x, p_o610346_y, p_o610346_z)), -vec3(p_o610343_ax, p_o610343_ay, p_o610343_az)*0.01745329251)).y;
vec3 o610331_3_p = ((circle_repeat_transform(((rotate3d(((rotate3d(((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610347_x, p_o610347_y, p_o610347_z)), -vec3(p_o610348_ax, p_o610348_ay, p_o610348_az)*0.01745329251))-vec3(p_o610344_x, p_o610344_y, p_o610344_z)), -vec3(p_o610345_ax, p_o610345_ay, p_o610345_az)*0.01745329251))-vec3(p_o610346_x, p_o610346_y, p_o610346_z)), -vec3(p_o610343_ax, p_o610343_ay, p_o610343_az)*0.01745329251))-vec3(p_o610336_x, p_o610336_y, p_o610336_z)), p_o610333_c))-vec3(p_o610332_x, p_o610332_y, p_o610332_z));
o610331_3_p.y -= clamp(o610331_3_p.y, -p_o610331_l, p_o610331_l);
float o610331_0_4_sdf3d = length(o610331_3_p)-p_o610331_r*1.0;
vec2 o610332_0_3_sdf3dc = vec2(o610331_0_4_sdf3d, 0.0);
vec2 o610333_0_3_sdf3dc = o610332_0_3_sdf3dc;
vec2 o610336_0_3_sdf3dc = o610333_0_3_sdf3dc;
vec2 o610335_0_3_sdf3dc = sdf3dc_sub(vec2(o610334_0_3_sdf3d, 0.0), o610336_0_3_sdf3dc);
vec2 o610343_0_1_sdf3dc = o610335_0_3_sdf3dc;
vec2 o610346_0_1_sdf3dc = o610343_0_1_sdf3dc;
vec2 o610342_0_1_sdf3dc = sdf3dc_union(o610341_0_3_sdf3dc, o610346_0_1_sdf3dc);
vec2 o610345_0_1_sdf3dc = o610342_0_1_sdf3dc;
vec2 o610344_0_1_sdf3dc = o610345_0_1_sdf3dc;
vec2 o610349_0_1_sdf3dc = sdf3dc_union(o610341_0_1_sdf3dc, o610344_0_1_sdf3dc);
vec2 o610348_0_1_sdf3dc = o610349_0_1_sdf3dc;
vec2 o610347_0_1_sdf3dc = o610348_0_1_sdf3dc;
vec2 o610350_0_1_sdf3dc = sdf3dc_union(o610326_0_1_sdf3dc, o610347_0_1_sdf3dc);
vec2 o610324_0_1_sdf3dc = sdf3dc_union(o610186_0_1_sdf3dc, o610350_0_1_sdf3dc);
float o610294_0_1_sdf3d = sdCylinder((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610296_x, p_o610296_y, p_o610296_z)), p_o610294_l, p_o610294_r);
vec2 o610295_0_v = vec2(o610294_0_1_sdf3d, 0.0);vec2 o610295_0_1_sdf3dc = vec2(o610295_0_v.x-p_o610295_r, o610295_0_v.y);
vec2 o610296_0_1_sdf3dc = o610295_0_1_sdf3dc;
float o610300_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z)), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).xzy, p_o610300_l, p_o610300_r);
float o610298_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z)), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).xzy, p_o610298_l, p_o610298_r);
vec2 o610299_0_1_sdf3dc = sdf3dc_sub(vec2(o610300_0_1_sdf3d, 0.0), vec2(o610298_0_1_sdf3d, 0.0));
vec3 o610301_0_uv = (rotate3d(((rotate3d(((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z)), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).zxy;
float o610301_0_rotated = rotate3d(o610301_0_uv, vec3((p_o610301_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o610301_0_d1 = max(o610301_0_uv.y, o610301_0_rotated);
float o610301_0_d2 = min(o610301_0_uv.y, o610301_0_rotated);
float o610301_0_d = (mod(p_o610301_angle, 360.0) < 180.0) ? o610301_0_d1 : o610301_0_d2;float o610301_0_1_sdf3d = o610301_0_d;
vec2 o610302_0_1_sdf3dc = sdf3dc_inter(o610299_0_1_sdf3dc, vec2(o610301_0_1_sdf3d, 0.0));
vec2 o610305_0_1_sdf3dc = o610302_0_1_sdf3dc;
vec2 o610304_0_1_sdf3dc = o610305_0_1_sdf3dc;
vec2 o610306_0_1_sdf3dc = o610304_0_1_sdf3dc;
vec2 o610303_0_1_sdf3dc = sdf3dc_union(o610296_0_1_sdf3dc, o610306_0_1_sdf3dc);
vec2 o610297_0_1_sdf3dc = sdf3dc_union(o610324_0_1_sdf3dc, o610303_0_1_sdf3dc);
vec2 o610193_0_1_sdf3dc = sdf3dc_union(o610194_0_1_sdf3dc, o610297_0_1_sdf3dc);
float o610199_0_1_sdf3d = (((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610202_x, p_o610202_y, p_o610202_z)).x;
float o610197_0_1_sdf3d = dot(vec2(cos(p_o610197_a*0.01745329251),sin(p_o610197_a*0.01745329251)),vec2(length(((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610202_x, p_o610202_y, p_o610202_z))-vec3(p_o610200_x, p_o610200_y, p_o610200_z)).yz),-((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610202_x, p_o610202_y, p_o610202_z))-vec3(p_o610200_x, p_o610200_y, p_o610200_z)).x));
vec2 o610200_0_1_sdf3dc = vec2(o610197_0_1_sdf3d, 0.0);
vec2 o610198_0_1_sdf3dc = sdf3dc_inter(vec2(o610199_0_1_sdf3d, 0.0), o610200_0_1_sdf3dc);
vec2 o610202_0_1_sdf3dc = o610198_0_1_sdf3dc;
vec2 o610201_0_1_sdf3dc = sdf3dc_union(o610193_0_1_sdf3dc, o610202_0_1_sdf3dc);
float o610247_0_1_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610260_x, p_o610260_y, p_o610260_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_1_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610260_x, p_o610260_y, p_o610260_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_1_sdf3d = mix(o610247_0_1_sdf3d, o610248_0_1_sdf3d, p_o610246_amount);
vec2 o610245_0_v = vec2(o610246_0_1_sdf3d, 0.0);vec2 o610245_0_1_sdf3dc = vec2(o610245_0_v.x-p_o610245_r, o610245_0_v.y);
vec2 o610251_0_in = o610245_0_1_sdf3dc;vec2 o610251_0_1_sdf3dc = vec2(o610251_0_in.x*p_o610251_s, o610251_0_in.y);
vec2 o610259_0_1_sdf3dc = o610251_0_1_sdf3dc;
vec2 o610260_0_1_sdf3dc = o610259_0_1_sdf3dc;
float o610247_0_3_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610261_x, p_o610261_y, p_o610261_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_3_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610261_x, p_o610261_y, p_o610261_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_3_sdf3d = mix(o610247_0_3_sdf3d, o610248_0_3_sdf3d, p_o610246_amount);
vec2 o610245_2_v = vec2(o610246_0_3_sdf3d, 0.0);vec2 o610245_0_3_sdf3dc = vec2(o610245_2_v.x-p_o610245_r, o610245_2_v.y);
vec2 o610251_2_in = o610245_0_3_sdf3dc;vec2 o610251_0_3_sdf3dc = vec2(o610251_2_in.x*p_o610251_s, o610251_2_in.y);
vec2 o610259_0_3_sdf3dc = o610251_0_3_sdf3dc;
vec2 o610261_0_1_sdf3dc = o610259_0_3_sdf3dc;
vec2 o610262_0_1_sdf3dc = sdf3dc_union(o610260_0_1_sdf3dc, o610261_0_1_sdf3dc);
float o610247_0_5_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610252_x, p_o610252_y, p_o610252_z)), -vec3(p_o610250_ax, p_o610250_ay, p_o610250_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_5_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610252_x, p_o610252_y, p_o610252_z)), -vec3(p_o610250_ax, p_o610250_ay, p_o610250_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_5_sdf3d = mix(o610247_0_5_sdf3d, o610248_0_5_sdf3d, p_o610246_amount);
vec2 o610245_4_v = vec2(o610246_0_5_sdf3d, 0.0);vec2 o610245_0_5_sdf3dc = vec2(o610245_4_v.x-p_o610245_r, o610245_4_v.y);
vec2 o610251_4_in = o610245_0_5_sdf3dc;vec2 o610251_0_5_sdf3dc = vec2(o610251_4_in.x*p_o610251_s, o610251_4_in.y);
vec2 o610250_0_1_sdf3dc = o610251_0_5_sdf3dc;
vec2 o610252_0_1_sdf3dc = o610250_0_1_sdf3dc;
float o610247_0_7_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610254_x, p_o610254_y, p_o610254_z)), -vec3(p_o610255_ax, p_o610255_ay, p_o610255_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_7_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610254_x, p_o610254_y, p_o610254_z)), -vec3(p_o610255_ax, p_o610255_ay, p_o610255_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_7_sdf3d = mix(o610247_0_7_sdf3d, o610248_0_7_sdf3d, p_o610246_amount);
vec2 o610245_6_v = vec2(o610246_0_7_sdf3d, 0.0);vec2 o610245_0_7_sdf3dc = vec2(o610245_6_v.x-p_o610245_r, o610245_6_v.y);
vec2 o610251_6_in = o610245_0_7_sdf3dc;vec2 o610251_0_7_sdf3dc = vec2(o610251_6_in.x*p_o610251_s, o610251_6_in.y);
vec2 o610255_0_1_sdf3dc = o610251_0_7_sdf3dc;
vec2 o610254_0_1_sdf3dc = o610255_0_1_sdf3dc;
vec2 o610253_0_1_sdf3dc = sdf3dc_union(o610252_0_1_sdf3dc, o610254_0_1_sdf3dc);
float o610247_0_9_sdf3d = box3d((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610256_x, p_o610256_y, p_o610256_z)), -vec3(p_o610257_ax, p_o610257_ay, p_o610257_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_9_sdf3d = length((((rotate3d((((rotate3d((p), -vec3(p_o610292_ax, p_o610292_ay, p_o610292_az)*0.01745329251))-vec3(p_o610195_x, p_o610195_y, p_o610195_z))-vec3(p_o610256_x, p_o610256_y, p_o610256_z)), -vec3(p_o610257_ax, p_o610257_ay, p_o610257_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_9_sdf3d = mix(o610247_0_9_sdf3d, o610248_0_9_sdf3d, p_o610246_amount);
vec2 o610245_8_v = vec2(o610246_0_9_sdf3d, 0.0);vec2 o610245_0_9_sdf3dc = vec2(o610245_8_v.x-p_o610245_r, o610245_8_v.y);
vec2 o610251_8_in = o610245_0_9_sdf3dc;vec2 o610251_0_9_sdf3dc = vec2(o610251_8_in.x*p_o610251_s, o610251_8_in.y);
vec2 o610257_0_1_sdf3dc = o610251_0_9_sdf3dc;
vec2 o610256_0_1_sdf3dc = o610257_0_1_sdf3dc;
vec2 o610258_0_1_sdf3dc = sdf3dc_union(o610253_0_1_sdf3dc, o610256_0_1_sdf3dc);
vec2 o610263_0_1_sdf3dc = sdf3dc_union(o610262_0_1_sdf3dc, o610258_0_1_sdf3dc);
vec2 o610249_0_1_sdf3dc = sdf3dc_union(o610201_0_1_sdf3dc, o610263_0_1_sdf3dc);
vec2 o610195_0_1_sdf3dc = o610249_0_1_sdf3dc;
vec2 o610292_0_1_sdf3dc = o610195_0_1_sdf3dc;

return o610292_0_1_sdf3dc;
}
const float p_o610293_ax = 0.000000000;
const float p_o610293_ay = 90.000000000;
const float p_o610293_az = 0.000000000;
const float p_o610230_x = 0.000000000;
const float p_o610230_y = -0.440000000;
const float p_o610230_z = 0.000000000;
const float p_o610264_d = 0.010000000;
const float p_o610265_g_0_pos = 0.663637000;
const float p_o610265_g_0_r = 0.000000000;
const float p_o610265_g_0_g = 0.000000000;
const float p_o610265_g_0_b = 0.000000000;
const float p_o610265_g_0_a = 1.000000000;
const float p_o610265_g_1_pos = 0.872727000;
const float p_o610265_g_1_r = 0.000000000;
const float p_o610265_g_1_g = 0.000000000;
const float p_o610265_g_1_b = 0.000000000;
const float p_o610265_g_1_a = 1.000000000;
vec4 o610265_g_gradient_fct(float x) {
  if (x < p_o610265_g_0_pos) {
    return vec4(p_o610265_g_0_r,p_o610265_g_0_g,p_o610265_g_0_b,p_o610265_g_0_a);
  } else if (x < p_o610265_g_1_pos) {
    return mix(vec4(p_o610265_g_0_r,p_o610265_g_0_g,p_o610265_g_0_b,p_o610265_g_0_a), vec4(p_o610265_g_1_r,p_o610265_g_1_g,p_o610265_g_1_b,p_o610265_g_1_a), ((x-p_o610265_g_0_pos)/(p_o610265_g_1_pos-p_o610265_g_0_pos)));
  }
  return vec4(p_o610265_g_1_r,p_o610265_g_1_g,p_o610265_g_1_b,p_o610265_g_1_a);
}
const float p_o610231_d = 0.010000000;
const float p_o610232_g_0_pos = 0.806305000;
const float p_o610232_g_0_r = 0.078125000;
const float p_o610232_g_0_g = 0.078125000;
const float p_o610232_g_0_b = 0.078125000;
const float p_o610232_g_0_a = 1.000000000;
const float p_o610232_g_1_pos = 0.979033000;
const float p_o610232_g_1_r = 0.078125000;
const float p_o610232_g_1_g = 0.078125000;
const float p_o610232_g_1_b = 0.078125000;
const float p_o610232_g_1_a = 1.000000000;
vec4 o610232_g_gradient_fct(float x) {
  if (x < p_o610232_g_0_pos) {
    return vec4(p_o610232_g_0_r,p_o610232_g_0_g,p_o610232_g_0_b,p_o610232_g_0_a);
  } else if (x < p_o610232_g_1_pos) {
    return mix(vec4(p_o610232_g_0_r,p_o610232_g_0_g,p_o610232_g_0_b,p_o610232_g_0_a), vec4(p_o610232_g_1_r,p_o610232_g_1_g,p_o610232_g_1_b,p_o610232_g_1_a), ((x-p_o610232_g_0_pos)/(p_o610232_g_1_pos-p_o610232_g_0_pos)));
  }
  return vec4(p_o610232_g_1_r,p_o610232_g_1_g,p_o610232_g_1_b,p_o610232_g_1_a);
}
const float p_o610307_d = 0.010000000;
const float p_o610308_g_0_pos = 0.690909000;
const float p_o610308_g_0_r = 0.738281012;
const float p_o610308_g_0_g = 0.000000000;
const float p_o610308_g_0_b = 0.000000000;
const float p_o610308_g_0_a = 1.000000000;
const float p_o610308_g_1_pos = 0.936364000;
const float p_o610308_g_1_r = 0.738281012;
const float p_o610308_g_1_g = 0.000000000;
const float p_o610308_g_1_b = 0.000000000;
const float p_o610308_g_1_a = 1.000000000;
vec4 o610308_g_gradient_fct(float x) {
  if (x < p_o610308_g_0_pos) {
    return vec4(p_o610308_g_0_r,p_o610308_g_0_g,p_o610308_g_0_b,p_o610308_g_0_a);
  } else if (x < p_o610308_g_1_pos) {
    return mix(vec4(p_o610308_g_0_r,p_o610308_g_0_g,p_o610308_g_0_b,p_o610308_g_0_a), vec4(p_o610308_g_1_r,p_o610308_g_1_g,p_o610308_g_1_b,p_o610308_g_1_a), ((x-p_o610308_g_0_pos)/(p_o610308_g_1_pos-p_o610308_g_0_pos)));
  }
  return vec4(p_o610308_g_1_r,p_o610308_g_1_g,p_o610308_g_1_b,p_o610308_g_1_a);
}
const float p_o610351_d = 0.010000000;
const float p_o610352_g_0_pos = 0.886364000;
const float p_o610352_g_0_r = 0.859375000;
const float p_o610352_g_0_g = 0.868164003;
const float p_o610352_g_0_b = 1.000000000;
const float p_o610352_g_0_a = 1.000000000;
const float p_o610352_g_1_pos = 1.000000000;
const float p_o610352_g_1_r = 0.859375000;
const float p_o610352_g_1_g = 0.868164003;
const float p_o610352_g_1_b = 1.000000000;
const float p_o610352_g_1_a = 1.000000000;
vec4 o610352_g_gradient_fct(float x) {
  if (x < p_o610352_g_0_pos) {
    return vec4(p_o610352_g_0_r,p_o610352_g_0_g,p_o610352_g_0_b,p_o610352_g_0_a);
  } else if (x < p_o610352_g_1_pos) {
    return mix(vec4(p_o610352_g_0_r,p_o610352_g_0_g,p_o610352_g_0_b,p_o610352_g_0_a), vec4(p_o610352_g_1_r,p_o610352_g_1_g,p_o610352_g_1_b,p_o610352_g_1_a), ((x-p_o610352_g_0_pos)/(p_o610352_g_1_pos-p_o610352_g_0_pos)));
  }
  return vec4(p_o610352_g_1_r,p_o610352_g_1_g,p_o610352_g_1_b,p_o610352_g_1_a);
}
const float p_o610203_d = 0.010000000;
const float p_o610204_g_0_pos = 0.901993000;
const float p_o610204_g_0_r = 0.824218988;
const float p_o610204_g_0_g = 0.270446986;
const float p_o610204_g_0_b = 0.000000000;
const float p_o610204_g_0_a = 1.000000000;
const float p_o610204_g_1_pos = 0.961794000;
const float p_o610204_g_1_r = 0.824218988;
const float p_o610204_g_1_g = 0.270446986;
const float p_o610204_g_1_b = 0.000000000;
const float p_o610204_g_1_a = 1.000000000;
vec4 o610204_g_gradient_fct(float x) {
  if (x < p_o610204_g_0_pos) {
    return vec4(p_o610204_g_0_r,p_o610204_g_0_g,p_o610204_g_0_b,p_o610204_g_0_a);
  } else if (x < p_o610204_g_1_pos) {
    return mix(vec4(p_o610204_g_0_r,p_o610204_g_0_g,p_o610204_g_0_b,p_o610204_g_0_a), vec4(p_o610204_g_1_r,p_o610204_g_1_g,p_o610204_g_1_b,p_o610204_g_1_a), ((x-p_o610204_g_0_pos)/(p_o610204_g_1_pos-p_o610204_g_0_pos)));
  }
  return vec4(p_o610204_g_1_r,p_o610204_g_1_g,p_o610204_g_1_b,p_o610204_g_1_a);
}
const float p_o610217_g_0_pos = 0.751760000;
const float p_o610217_g_0_r = 0.136719003;
const float p_o610217_g_0_g = 0.122262001;
const float p_o610217_g_0_b = 0.112686001;
const float p_o610217_g_0_a = 1.000000000;
const float p_o610217_g_1_pos = 0.951760000;
const float p_o610217_g_1_r = 0.136719003;
const float p_o610217_g_1_g = 0.122262001;
const float p_o610217_g_1_b = 0.112686001;
const float p_o610217_g_1_a = 1.000000000;
vec4 o610217_g_gradient_fct(float x) {
  if (x < p_o610217_g_0_pos) {
    return vec4(p_o610217_g_0_r,p_o610217_g_0_g,p_o610217_g_0_b,p_o610217_g_0_a);
  } else if (x < p_o610217_g_1_pos) {
    return mix(vec4(p_o610217_g_0_r,p_o610217_g_0_g,p_o610217_g_0_b,p_o610217_g_0_a), vec4(p_o610217_g_1_r,p_o610217_g_1_g,p_o610217_g_1_b,p_o610217_g_1_a), ((x-p_o610217_g_0_pos)/(p_o610217_g_1_pos-p_o610217_g_0_pos)));
  }
  return vec4(p_o610217_g_1_r,p_o610217_g_1_g,p_o610217_g_1_b,p_o610217_g_1_a);
}
vec3 o610181_input_albedo(vec4 p, float _seed_variation_) {
vec3 o610265_0_1_tex3d = o610265_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o610232_0_1_tex3d = o610232_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o610308_0_1_tex3d = o610308_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o610352_0_1_tex3d = o610352_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o610204_0_1_tex3d = o610204_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
vec3 o610217_0_1_tex3d = o610217_g_gradient_fct(dot(vec3(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w))).x+0.5), vec3(1.0))/3.0).rgb;
float o610199_0_1_sdf3d = (((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610202_x, p_o610202_y, p_o610202_z)).x;
float o610197_0_1_sdf3d = dot(vec2(cos(p_o610197_a*0.01745329251),sin(p_o610197_a*0.01745329251)),vec2(length(((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610202_x, p_o610202_y, p_o610202_z))-vec3(p_o610200_x, p_o610200_y, p_o610200_z)).yz),-((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610202_x, p_o610202_y, p_o610202_z))-vec3(p_o610200_x, p_o610200_y, p_o610200_z)).x));
vec2 o610200_0_1_sdf3dc = vec2(o610197_0_1_sdf3d, 0.0);
vec2 o610198_0_1_sdf3dc = sdf3dc_inter(vec2(o610199_0_1_sdf3d, 0.0), o610200_0_1_sdf3dc);
vec2 o610202_0_1_sdf3dc = o610198_0_1_sdf3dc;
vec3 o610203_0_1_tex3d = mix(o610204_0_1_tex3d, o610217_0_1_tex3d, clamp((o610202_0_1_sdf3dc).x/max(p_o610203_d, 0.0001), 0.0, 1.0));
float o610182_0_1_sdf3d = length(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz))-p_o610182_r;
float o610184_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610185_x, p_o610185_y, p_o610185_z)))-p_o610184_r;
vec2 o610185_0_1_sdf3dc = vec2(o610184_0_1_sdf3d, 0.0);
vec2 o610183_0_1_sdf3dc = sdf3d_smooth_union(vec2(o610182_0_1_sdf3d, 0.0), o610185_0_1_sdf3dc, p_o610183_k);
float o610188_0_1_sdf3d = length((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610187_x, p_o610187_y, p_o610187_z)))-p_o610188_r;
vec2 o610187_0_1_sdf3dc = vec2(o610188_0_1_sdf3d, 0.0);
vec2 o610186_0_1_sdf3dc = sdf3d_smooth_union(o610183_0_1_sdf3dc, o610187_0_1_sdf3dc, p_o610186_k);
vec3 o610351_0_1_tex3d = mix(o610352_0_1_tex3d, o610203_0_1_tex3d, clamp((o610186_0_1_sdf3dc).x/max(p_o610351_d, 0.0001), 0.0, 1.0));
float o610294_0_1_sdf3d = sdCylinder((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610296_x, p_o610296_y, p_o610296_z)), p_o610294_l, p_o610294_r);
vec2 o610295_0_v = vec2(o610294_0_1_sdf3d, 0.0);vec2 o610295_0_1_sdf3dc = vec2(o610295_0_v.x-p_o610295_r, o610295_0_v.y);
vec2 o610296_0_1_sdf3dc = o610295_0_1_sdf3dc;
float o610300_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).xzy, p_o610300_l, p_o610300_r);
float o610298_0_1_sdf3d = sdCylinder((rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).xzy, p_o610298_l, p_o610298_r);
vec2 o610299_0_1_sdf3dc = sdf3dc_sub(vec2(o610300_0_1_sdf3d, 0.0), vec2(o610298_0_1_sdf3d, 0.0));
vec3 o610301_0_uv = (rotate3d(((rotate3d(((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz), -vec3(p_o610306_ax, p_o610306_ay, p_o610306_az)*0.01745329251))-vec3(p_o610304_x, p_o610304_y, p_o610304_z)), -vec3(p_o610305_ax, p_o610305_ay, p_o610305_az)*0.01745329251)).zxy;
float o610301_0_rotated = rotate3d(o610301_0_uv, vec3((p_o610301_angle-180.0)*0.01745329251, 0.0, 0.0)).y;
float o610301_0_d1 = max(o610301_0_uv.y, o610301_0_rotated);
float o610301_0_d2 = min(o610301_0_uv.y, o610301_0_rotated);
float o610301_0_d = (mod(p_o610301_angle, 360.0) < 180.0) ? o610301_0_d1 : o610301_0_d2;float o610301_0_1_sdf3d = o610301_0_d;
vec2 o610302_0_1_sdf3dc = sdf3dc_inter(o610299_0_1_sdf3dc, vec2(o610301_0_1_sdf3d, 0.0));
vec2 o610305_0_1_sdf3dc = o610302_0_1_sdf3dc;
vec2 o610304_0_1_sdf3dc = o610305_0_1_sdf3dc;
vec2 o610306_0_1_sdf3dc = o610304_0_1_sdf3dc;
vec2 o610303_0_1_sdf3dc = sdf3dc_union(o610296_0_1_sdf3dc, o610306_0_1_sdf3dc);
vec3 o610307_0_1_tex3d = mix(o610308_0_1_tex3d, o610351_0_1_tex3d, clamp((o610303_0_1_sdf3dc).x/max(p_o610307_d, 0.0001), 0.0, 1.0));
float o610189_0_1_sdf3d = sdCylinder((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610194_x, p_o610194_y, p_o610194_z)), -vec3(p_o610196_ax, p_o610196_ay, p_o610196_az)*0.01745329251)), p_o610189_l, p_o610189_r);
float o610191_0_1_sdf3d = sdCylinder(((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610194_x, p_o610194_y, p_o610194_z)), -vec3(p_o610196_ax, p_o610196_ay, p_o610196_az)*0.01745329251))-vec3(p_o610192_x, p_o610192_y, p_o610192_z)), p_o610191_l, p_o610191_r);
vec2 o610192_0_1_sdf3dc = vec2(o610191_0_1_sdf3d, 0.0);
vec2 o610190_0_1_sdf3dc = sdf3dc_union(vec2(o610189_0_1_sdf3d, 0.0), o610192_0_1_sdf3dc);
vec2 o610196_0_1_sdf3dc = o610190_0_1_sdf3dc;
vec2 o610194_0_1_sdf3dc = o610196_0_1_sdf3dc;
vec3 o610231_0_1_tex3d = mix(o610232_0_1_tex3d, o610307_0_1_tex3d, clamp((o610194_0_1_sdf3dc).x/max(p_o610231_d, 0.0001), 0.0, 1.0));
float o610247_0_1_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610260_x, p_o610260_y, p_o610260_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_1_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610260_x, p_o610260_y, p_o610260_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_1_sdf3d = mix(o610247_0_1_sdf3d, o610248_0_1_sdf3d, p_o610246_amount);
vec2 o610245_0_v = vec2(o610246_0_1_sdf3d, 0.0);vec2 o610245_0_1_sdf3dc = vec2(o610245_0_v.x-p_o610245_r, o610245_0_v.y);
vec2 o610251_0_in = o610245_0_1_sdf3dc;vec2 o610251_0_1_sdf3dc = vec2(o610251_0_in.x*p_o610251_s, o610251_0_in.y);
vec2 o610259_0_1_sdf3dc = o610251_0_1_sdf3dc;
vec2 o610260_0_1_sdf3dc = o610259_0_1_sdf3dc;
float o610247_0_3_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610261_x, p_o610261_y, p_o610261_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_3_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610261_x, p_o610261_y, p_o610261_z)), -vec3(p_o610259_ax, p_o610259_ay, p_o610259_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_3_sdf3d = mix(o610247_0_3_sdf3d, o610248_0_3_sdf3d, p_o610246_amount);
vec2 o610245_2_v = vec2(o610246_0_3_sdf3d, 0.0);vec2 o610245_0_3_sdf3dc = vec2(o610245_2_v.x-p_o610245_r, o610245_2_v.y);
vec2 o610251_2_in = o610245_0_3_sdf3dc;vec2 o610251_0_3_sdf3dc = vec2(o610251_2_in.x*p_o610251_s, o610251_2_in.y);
vec2 o610259_0_3_sdf3dc = o610251_0_3_sdf3dc;
vec2 o610261_0_1_sdf3dc = o610259_0_3_sdf3dc;
vec2 o610262_0_1_sdf3dc = sdf3dc_union(o610260_0_1_sdf3dc, o610261_0_1_sdf3dc);
float o610247_0_5_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610252_x, p_o610252_y, p_o610252_z)), -vec3(p_o610250_ax, p_o610250_ay, p_o610250_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_5_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610252_x, p_o610252_y, p_o610252_z)), -vec3(p_o610250_ax, p_o610250_ay, p_o610250_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_5_sdf3d = mix(o610247_0_5_sdf3d, o610248_0_5_sdf3d, p_o610246_amount);
vec2 o610245_4_v = vec2(o610246_0_5_sdf3d, 0.0);vec2 o610245_0_5_sdf3dc = vec2(o610245_4_v.x-p_o610245_r, o610245_4_v.y);
vec2 o610251_4_in = o610245_0_5_sdf3dc;vec2 o610251_0_5_sdf3dc = vec2(o610251_4_in.x*p_o610251_s, o610251_4_in.y);
vec2 o610250_0_1_sdf3dc = o610251_0_5_sdf3dc;
vec2 o610252_0_1_sdf3dc = o610250_0_1_sdf3dc;
float o610247_0_7_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610254_x, p_o610254_y, p_o610254_z)), -vec3(p_o610255_ax, p_o610255_ay, p_o610255_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_7_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610254_x, p_o610254_y, p_o610254_z)), -vec3(p_o610255_ax, p_o610255_ay, p_o610255_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_7_sdf3d = mix(o610247_0_7_sdf3d, o610248_0_7_sdf3d, p_o610246_amount);
vec2 o610245_6_v = vec2(o610246_0_7_sdf3d, 0.0);vec2 o610245_0_7_sdf3dc = vec2(o610245_6_v.x-p_o610245_r, o610245_6_v.y);
vec2 o610251_6_in = o610245_0_7_sdf3dc;vec2 o610251_0_7_sdf3dc = vec2(o610251_6_in.x*p_o610251_s, o610251_6_in.y);
vec2 o610255_0_1_sdf3dc = o610251_0_7_sdf3dc;
vec2 o610254_0_1_sdf3dc = o610255_0_1_sdf3dc;
vec2 o610253_0_1_sdf3dc = sdf3dc_union(o610252_0_1_sdf3dc, o610254_0_1_sdf3dc);
float o610247_0_9_sdf3d = box3d((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610256_x, p_o610256_y, p_o610256_z)), -vec3(p_o610257_ax, p_o610257_ay, p_o610257_az)*0.01745329251)))/p_o610251_s), vec3(p_o610247_sx, p_o610247_sy, p_o610247_sz))-p_o610247_r;
float o610248_0_9_sdf3d = length((((rotate3d((((vec4((vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).xyz-vec3(p_o610230_x, p_o610230_y, p_o610230_z), (vec4(tex3d_rotate((p).xyz, -vec3(p_o610293_ax, p_o610293_ay, p_o610293_az)*0.01745329251), (p).w)).w)).xyz)-vec3(p_o610256_x, p_o610256_y, p_o610256_z)), -vec3(p_o610257_ax, p_o610257_ay, p_o610257_az)*0.01745329251)))/p_o610251_s))-p_o610248_r;
float o610246_0_9_sdf3d = mix(o610247_0_9_sdf3d, o610248_0_9_sdf3d, p_o610246_amount);
vec2 o610245_8_v = vec2(o610246_0_9_sdf3d, 0.0);vec2 o610245_0_9_sdf3dc = vec2(o610245_8_v.x-p_o610245_r, o610245_8_v.y);
vec2 o610251_8_in = o610245_0_9_sdf3dc;vec2 o610251_0_9_sdf3dc = vec2(o610251_8_in.x*p_o610251_s, o610251_8_in.y);
vec2 o610257_0_1_sdf3dc = o610251_0_9_sdf3dc;
vec2 o610256_0_1_sdf3dc = o610257_0_1_sdf3dc;
vec2 o610258_0_1_sdf3dc = sdf3dc_union(o610253_0_1_sdf3dc, o610256_0_1_sdf3dc);
vec2 o610263_0_1_sdf3dc = sdf3dc_union(o610262_0_1_sdf3dc, o610258_0_1_sdf3dc);
vec3 o610264_0_1_tex3d = mix(o610265_0_1_tex3d, o610231_0_1_tex3d, clamp((o610263_0_1_sdf3dc).x/max(p_o610264_d, 0.0001), 0.0, 1.0));
vec3 o610230_0_1_tex3d = o610264_0_1_tex3d;
vec3 o610293_0_1_tex3d = o610230_0_1_tex3d;

return o610293_0_1_tex3d;
}
vec3 o610181_input_metallic(vec4 p, float _seed_variation_) {

return vec3(0.0);
}
vec3 o610181_input_roughness(vec4 p, float _seed_variation_) {

return vec3(1.0);
}


vec2 GetDist(vec3 p) {
    float _seed_variation_ = seed_variation;

	vec2 d = o610181_input_distance(p, _seed_variation_);

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

		ALBEDO = o610181_input_albedo(vec4(p, rm.y), _seed_variation_);
		ROUGHNESS = o610181_input_roughness(vec4(p, rm.y), _seed_variation_).x;
		METALLIC = o610181_input_metallic(vec4(p, rm.y), _seed_variation_).x;

		NORMAL = (INV_VIEW_MATRIX*vec4(GetNormal(p), 0.0)).xyz;
	}
}



