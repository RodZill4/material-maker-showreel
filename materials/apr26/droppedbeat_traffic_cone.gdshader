shader_type spatial;
uniform float seed_variation = 0.0;
varying float elapsed_time;
varying vec3 world_camera;
varying vec3 world_position;
const int MAX_STEPS = 100;
const float MAX_DIST = 100.0;
const float SURF_DIST = 1e-3;
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
const float p_o112289908566_s = 1.600000000;
const float p_o111585265475_k1 = 0.018300000;
const float p_o111568488258_x = 0.000000000;
const float p_o111568488258_y = -0.150700000;
const float p_o111568488258_z = 0.000000000;
const float p_o111551711041_sx = 0.250000000;
const float p_o111551711041_sy = 0.030000000;
const float p_o111551711041_sz = 0.250000000;
const float p_o111551711041_r = 0.010000000;
const float p_o111534933824_d = 0.215400000;
const float p_o111518156607_ax = -0.058300000;
const float p_o111518156607_ay = -0.121200000;
const float p_o111518156607_bx = -0.203300000;
const float p_o111518156607_by = 0.300100000;
const float p_o111518156607_r = 0.025000000;
const float p_o112273131351_s = 1.600000000;
const float p_o111669151560_amount1 = 0.481250000;
const float p_o111669151560_amount2 = 1.000000000;
const float p_o111971141457_ax = 0.000000000;
const float p_o111971141457_ay = 0.000000000;
const float p_o111971141457_az = 90.000000000;
const float p_o111987918672_g_pos[3] = float[]( 0.000000000, 0.350095689, 0.484950334 );
const vec4 p_o111987918672_g_col[3] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000) );
const vec4 p_o112256354133_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o111954364239_amount1 = 1.000000000;
const float p_o111719483211_g_pos[2] = float[]( 0.000000000, 0.636363626 );
const vec4 p_o111719483211_g_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000) );
const float p_o111685928777_ax = 90.000000000;
const float p_o111685928777_ay = 0.000000000;
const float p_o111685928777_az = 0.000000000;
const float p_o111652374343_value = 0.620000000;
const float p_o111652374343_width = 0.190000000;
const float p_o111652374343_contrast = 0.000000000;
const float p_o111635597126_sides = 6.000000000;
const float p_o111635597126_radius = 1.000000000;
const float p_o111635597126_edge = 1.000000000;
const vec4 p_o111702705994_color = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const vec4 p_o111602042692_color = vec4(0.914062500, 0.378981113, 0.169601440, 1.000000000);
// #globals: sdf3d_scale_2 (o112289908566)
// #globals: sdf3d_smoothboolean (o111585265475)
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
// #globals: sdf3d_box (o111551711041)
float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
}
// #globals: sdline2 (o111518156607)
vec2 sdLine(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p-a, ba = b-a;
	float h = clamp(dot(pa,ba)/dot(ba,ba), 0.0, 1.0);
	return vec2(length(pa-ba*h), h);
}
// #globals: tex3d_blend_2 (o111669151560)
vec3 blend3d_normal(vec3 c1, vec3 c2, float opacity) {
	return opacity*c1 + (1.0-opacity)*c2;
}
vec3 blend3d_multiply(vec3 c1, vec3 c2, float opacity) {
	return opacity*c1*c2 + (1.0-opacity)*c2;
}
vec3 blend3d_screen(vec3 c1, vec3 c2, float opacity) {
	return opacity*(1.0-(1.0-c1)*(1.0-c2)) + (1.0-opacity)*c2;
}
float blend3d_overlay_f(float c1, float c2) {
	return (c1 < 0.5) ? (2.0*c1*c2) : (1.0-2.0*(1.0-c1)*(1.0-c2));
}
vec3 blend3d_overlay(vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend3d_overlay_f(c1.x, c2.x), blend3d_overlay_f(c1.y, c2.y), blend3d_overlay_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend3d_hard_light(vec3 c1, vec3 c2, float opacity) {
	return opacity*0.5*(c1*c2+blend3d_overlay(c1, c2, 1.0)) + (1.0-opacity)*c2;
}
float blend3d_soft_light_f(float c1, float c2) {
	return (c2 < 0.5) ? (2.0*c1*c2+c1*c1*(1.0-2.0*c2)) : 2.0*c1*(1.0-c2)+sqrt(c1)*(2.0*c2-1.0);
}
vec3 blend3d_soft_light(vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend3d_soft_light_f(c1.x, c2.x), blend3d_soft_light_f(c1.y, c2.y), blend3d_soft_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend3d_burn_f(float c1, float c2) {
	return (c1==0.0)?c1:max((1.0-((1.0-c2)/c1)),0.0);
}
vec3 blend3d_burn(vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend3d_burn_f(c1.x, c2.x), blend3d_burn_f(c1.y, c2.y), blend3d_burn_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend3d_dodge_f(float c1, float c2) {
	return (c1==1.0)?c1:min(c2/(1.0-c1),1.0);
}
vec3 blend3d_dodge(vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend3d_dodge_f(c1.x, c2.x), blend3d_dodge_f(c1.y, c2.y), blend3d_dodge_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend3d_lighten(vec3 c1, vec3 c2, float opacity) {
	return opacity*max(c1, c2) + (1.0-opacity)*c2;
}
vec3 blend3d_darken(vec3 c1, vec3 c2, float opacity) {
	return opacity*min(c1, c2) + (1.0-opacity)*c2;
}
vec3 blend3d_difference(vec3 c1, vec3 c2, float opacity) {
	return opacity*clamp(c2-c1, vec3(0.0), vec3(1.0)) + (1.0-opacity)*c2;
}
// #globals: tex3d_rotate_2 (o111971141457)
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
// #globals: shape (o111635597126)
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
vec2 o111501379390_input_distance(vec3 p, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: sdf3d_box (o111551711041)
float o111551711041_0_1_sdf3d = box3d((((p)/p_o112289908566_s)-vec3(p_o111568488258_x, p_o111568488258_y, p_o111568488258_z)), vec3(p_o111551711041_sx, p_o111551711041_sy, p_o111551711041_sz))-p_o111551711041_r;
// #output0: sdf3d_translate_3_2 (o111568488258)
vec2 o111568488258_0_1_sdf3dc = vec2(o111551711041_0_1_sdf3d, 0.0);
// #code: sdf3d_revolution2 (o111534933824)
vec2 o111534933824_0_q = vec2(length(((p)/p_o112289908566_s).xzy.xy)-p_o111534933824_d+0.5, ((p)/p_o112289908566_s).xzy.z+0.5);
// #code: sdline2 (o111518156607)
vec2 o111518156607_0_sdl = sdLine((o111534933824_0_q), vec2(p_o111518156607_ax+0.5, p_o111518156607_ay+0.5), vec2(p_o111518156607_bx+0.5, p_o111518156607_by+0.5));
// #output0: sdline2 (o111518156607)
float o111518156607_0_1_sdf2d = o111518156607_0_sdl.x-p_o111518156607_r*1.0;
// #output0: sdf3d_revolution2 (o111534933824)
float o111534933824_0_1_sdf3d = o111518156607_0_1_sdf2d;
// #code: sdf3d_smoothboolean (o111585265475)
vec2 o111585265475_0_b = vec2(o111534933824_0_1_sdf3d, 0.0);
o111585265475_0_b = sdf3d_smooth_union(o111568488258_0_1_sdf3dc, o111585265475_0_b, p_o111585265475_k1);
// #output0: sdf3d_smoothboolean (o111585265475)
vec2 o111585265475_0_1_sdf3dc = o111585265475_0_b;
// #output0: sdf3d_scale_2 (o112289908566)
vec2 o112289908566_0_1_sdf3dc = vec2(o111585265475_0_1_sdf3dc.x*p_o112289908566_s, o111585265475_0_1_sdf3dc.y);
return o112289908566_0_1_sdf3dc;
}
vec4 o111987918672_g_gradient_fct(float x) {
  if (x < p_o111987918672_g_pos[1]) {
    return p_o111987918672_g_col[0];
  } else if (x < p_o111987918672_g_pos[2]) {
    return p_o111987918672_g_col[1];
  }
  return p_o111987918672_g_col[2];
}
vec4 o111719483211_g_gradient_fct(float x) {
  if (x < p_o111719483211_g_pos[1]) {
    return p_o111719483211_g_col[0];
  }
  return p_o111719483211_g_col[1];
}
vec2 GetDist(vec3 p) {
	float _seed_variation_ = seed_variation;
	vec4 _controlled_variation_ = vec4(0.0);

	if (false) {
		p *= vec3(1.0, -1.0, 1.0);
	}


	vec2 d = o111501379390_input_distance((p), _seed_variation_, _controlled_variation_);
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
	vec4 _controlled_variation_ = vec4(0.0);
	vec3 ro = world_camera;
	vec3 rd =  normalize(world_position - ro);
	
	vec2 rm  = RayMarch(ro, rd);
	float d = rm.x;
	if (d >= MAX_DIST) {
		discard;
	} else {
		vec3 p = ro + rd * d;
		vec3 n = GetNormal(p);

		if (false) {
			p *= vec3(1.0, -1.0, 1.0);
			n *= vec3(1.0, -1.0, 1.0);
		} 


// #output0: tex3d_colorize_2 (o111987918672)
vec3 o111987918672_0_1_tex3d = o111987918672_g_gradient_fct(dot(vec3((vec4(tex3d_rotate((vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).xyz, -vec3(p_o111971141457_ax, p_o111971141457_ay, p_o111971141457_az)*0.01745329251), (vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).w)).x+0.5), vec3(1.0))/3.0).rgb;

// #output1: tex3d_rotate_2 (o111971141457)
vec3 o111971141457_1_1_tex3d = o111987918672_0_1_tex3d;

// #output0: tex3d_uniform_3 (o112256354133)
vec3 o112256354133_0_1_tex3d = p_o112256354133_color.rgb;

// #output0: tex3d_colorize_3 (o111719483211)
vec3 o111719483211_0_1_tex3d = o111719483211_g_gradient_fct(dot(vec3((vec4(tex3d_rotate((vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).xyz, -vec3(p_o111971141457_ax, p_o111971141457_ay, p_o111971141457_az)*0.01745329251), (vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).w)).x+0.5), vec3(1.0))/3.0).rgb;

// #output0: tex3d_rotate_2 (o111971141457)
vec3 o111971141457_0_2_tex3d = o111719483211_0_1_tex3d;

// #output0: shape (o111635597126)
float o111635597126_0_1_f = shape_circle(((vec4(tex3d_rotate((vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).xyz, -vec3(p_o111685928777_ax, p_o111685928777_ay, p_o111685928777_az)*0.01745329251), (vec4((vec4(p, rm.y)).xyz/max(p_o112273131351_s, 0.00001), (vec4(p, rm.y)).w)).w)).xy+vec2(0.5)), p_o111635597126_sides+1.0e-5, p_o111635597126_radius*1.0, p_o111635597126_edge*1.0);

// #code: tones_range (o111652374343)
float o111652374343_0_step = clamp((o111635597126_0_1_f - (p_o111652374343_value))/max(0.0001, p_o111652374343_width)+0.5, 0.0, 1.0);
float o111652374343_0_false = clamp((min(o111652374343_0_step, 1.0-o111652374343_0_step) * 2.0) / (1.0 - p_o111652374343_contrast), 0.0, 1.0);
float o111652374343_0_true = 1.0-o111652374343_0_false;
// #output0: tones_range (o111652374343)
float o111652374343_0_1_f = o111652374343_0_false;

// #output0: tex3d_from2d (o111618819909)
vec3 o111618819909_0_1_tex3d = vec3(o111652374343_0_1_f);

// #output0: tex3d_rotate (o111685928777)
vec3 o111685928777_0_1_tex3d = o111618819909_0_1_tex3d;

// #code: tex3d_blend_3 (o111954364239)
vec3 o111954364239_0_b = o111685928777_0_1_tex3d;
vec3 o111954364239_0_l;
vec3 o111954364239_0_a;

o111954364239_0_l = o111971141457_0_2_tex3d;
o111954364239_0_a = p_o111954364239_amount1*vec3(1.0);
o111954364239_0_b = blend3d_multiply(o111954364239_0_l.rgb, o111954364239_0_b.rgb, p_o111954364239_amount1*dot(vec3(1.0), vec3(1.0))/3.0 );
// #output0: tex3d_blend_3 (o111954364239)
vec3 o111954364239_0_1_tex3d = o111954364239_0_b;

// #output0: tex3d_uniform_2 (o111702705994)
vec3 o111702705994_0_1_tex3d = p_o111702705994_color.rgb;

// #output0: tex3d_uniform (o111602042692)
vec3 o111602042692_0_1_tex3d = p_o111602042692_color.rgb;

// #code: tex3d_blend_2 (o111669151560)
vec3 o111669151560_0_b = o111602042692_0_1_tex3d;
vec3 o111669151560_0_l;
vec3 o111669151560_0_a;

o111669151560_0_l = o111702705994_0_1_tex3d;
o111669151560_0_a = p_o111669151560_amount1*o111954364239_0_1_tex3d;
o111669151560_0_b = blend3d_normal(o111669151560_0_l.rgb, o111669151560_0_b.rgb, p_o111669151560_amount1*dot(o111954364239_0_1_tex3d, vec3(1.0))/3.0 );

o111669151560_0_l = o112256354133_0_1_tex3d;
o111669151560_0_a = p_o111669151560_amount2*o111971141457_1_1_tex3d;
o111669151560_0_b = blend3d_normal(o111669151560_0_l.rgb, o111669151560_0_b.rgb, p_o111669151560_amount2*dot(o111971141457_1_1_tex3d, vec3(1.0))/3.0 );
// #output0: tex3d_blend_2 (o111669151560)
vec3 o111669151560_0_1_tex3d = o111669151560_0_b;

// #output0: tex3d_scale (o112273131351)
vec3 o112273131351_0_1_tex3d = o111669151560_0_1_tex3d;

		ALBEDO = o112273131351_0_1_tex3d;
		ROUGHNESS = 1.0;
		METALLIC = 0.0;
		EMISSION = vec3(0.0);
		NORMAL = (INV_VIEW_MATRIX*vec4(n, 0.0)).xyz;
	}
}



