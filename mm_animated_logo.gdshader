shader_type spatial;

render_mode unshaded, blend_mix, depth_test_disabled;

uniform vec3 uv1_scale = vec3(1.0, 1.0, 1.0);
uniform vec3 uv1_offset = vec3(0.0, 0.0, 0.0);
uniform float variation = 0.0;
uniform float shader_time = 0.0;
uniform float speed = 5.0;
uniform float delay = 5.0;
varying float elapsed_time;

void vertex() {
	elapsed_time = clamp(speed*(shader_time - delay), 0.0, 23.0);
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

vec2 get_animation_frame(vec2 uv, float t) {
 	int it = int(t);
    return (uv+vec2(float(it%8), float(it/8)))*0.125;	
}
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


vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
    return rv;	
}
float sd_isosceles_triangle(vec2 uv, vec2 size)
{
    uv.x = abs(uv.x);
	uv.y += size.y; size.y *= 2.0;
    vec2 a = uv - size*clamp(dot(uv,size)/dot(size,size), 0.0, 1.0);
    vec2 b = uv - size*vec2(clamp(uv.x/size.x, 0.0, 1.0), 1.0);
    float s = -sign(size.y);
    vec2 d = min(vec2(dot(a,a), s*(uv.x*size.y-uv.y*size.x)),
                 vec2(dot(b,b), s*(uv.y-size.y)));
    return -sqrt(d.x)*sign(d.y);
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
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
    return uv;
}
const float p_o6406_cx = 0.000000000;
const float p_o6406_cy = 0.000000000;
const float p_o6406_scale_x = 1.100000000;
const float p_o6391_amount = 1.000000000;
const float p_o6392_repeat = 1.000000000;
const float p_o6392_rotate = 135.400000000;
const float p_o6392_gradient_0_pos = 0.119020000;
const float p_o6392_gradient_0_r = 0.265625000;
const float p_o6392_gradient_0_g = 0.655762017;
const float p_o6392_gradient_0_b = 1.000000000;
const float p_o6392_gradient_0_a = 1.000000000;
const float p_o6392_gradient_1_pos = 1.000000000;
const float p_o6392_gradient_1_r = 1.000000000;
const float p_o6392_gradient_1_g = 0.339843988;
const float p_o6392_gradient_1_b = 0.974213004;
const float p_o6392_gradient_1_a = 1.000000000;
vec4 o6392_gradient_gradient_fct(float x) {
  if (x < p_o6392_gradient_0_pos) {
    return vec4(p_o6392_gradient_0_r,p_o6392_gradient_0_g,p_o6392_gradient_0_b,p_o6392_gradient_0_a);
  } else if (x < p_o6392_gradient_1_pos) {
    return mix(vec4(p_o6392_gradient_0_r,p_o6392_gradient_0_g,p_o6392_gradient_0_b,p_o6392_gradient_0_a), vec4(p_o6392_gradient_1_r,p_o6392_gradient_1_g,p_o6392_gradient_1_b,p_o6392_gradient_1_a), ((x-p_o6392_gradient_0_pos)/(p_o6392_gradient_1_pos-p_o6392_gradient_0_pos)));
  }
  return vec4(p_o6392_gradient_1_r,p_o6392_gradient_1_g,p_o6392_gradient_1_b,p_o6392_gradient_1_a);
}
const float p_o6405_color_r = 1.000000000;
const float p_o6405_color_g = 1.000000000;
const float p_o6405_color_b = 1.000000000;
const float p_o6405_color_a = 1.000000000;
const float p_o6368_default_in1 = 0.000000000;
const float p_o6368_default_in2 = 0.000000000;
const float p_o6162_value = 0.500000000;
const float p_o6162_width = 0.010000000;
const float p_o6374_default_in1 = 0.000000000;
const float p_o6374_default_in2 = 0.000000000;
const float p_o6388_default_in1 = 0.000000000;
const float p_o6388_default_in2 = 0.000000000;
const float p_o6390_default_in1 = 0.780000000;
const float p_o6390_default_in2 = 0.000000000;
const float p_o6389_sides = 6.000000000;
const float p_o6389_radius = 1.000000000;
const float p_o6389_edge = 1.000000000;
const float p_o6379_translate_x = 0.000000000;
const float p_o6379_translate_y = -1.170000000;
const float p_o6379_rotate = 0.000000000;
const float p_o6379_scale_x = 1.000000000;
const float p_o6379_scale_y = 1.000000000;
const float p_o6387_translate_x = 0.000000000;
const float p_o6384_bevel = 0.620000000;
const float p_o6384_base = 0.510000000;
float o6380_d(vec2 uv, float _seed_variation_) {
vec2 _n325193_p = uv - vec2(0.000000000, 0.000000000);
_n325193_p = rotate(_n325193_p, radians(0.000000000))/1.000000000;
float _n325193 = 0.0;float _n325193_kk = 10.0/0.110000000;vec2 _n325194_p = _n325193_p - vec2(0.000000000, 0.000000000);
_n325194_p = rotate(_n325194_p, radians(0.000000000))/1.000000000;
float _n325194;
_n325194 = length(_n325194_p)-0.070000000;
_n325194 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325194);
vec2 _n325195_p = _n325193_p - vec2(0.001122000, -0.120000000);
_n325195_p = rotate(_n325195_p, radians(0.000000000))/1.000000000;
float _n325195;
_n325195 = sd_isosceles_triangle(_n325195_p, vec2(0.060561000, 0.094206000));
_n325195 *= 1.000000000;
_n325193 += exp2(-_n325193_kk*_n325195);
_n325193 = -log2(_n325193)/_n325193_kk;
_n325193 *= 1.000000000;
float return_value = _n325193;
return return_value;}
const float p_o6378_default_in1 = 0.000000000;
const float p_o6378_default_in2 = 0.000000000;
const float p_o6376_default_in1 = 0.000000000;
const float p_o6376_default_in2 = 0.000000000;
const float p_o6377_color = 1.000000000;
const float p_o6375_sides = 6.000000000;
const float p_o6375_radius = 1.480000000;
const float p_o6375_edge = 0.020000000;
const float p_o6369_sides = 6.000000000;
const float p_o6369_radius = 0.820000000;
const float p_o6369_edge = 0.020000000;


void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
float o6392_0_r = 0.5+(cos(p_o6392_rotate*0.01745329251)*((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))).x-0.5)+sin(p_o6392_rotate*0.01745329251)*((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))).y-0.5))/(cos(abs(mod(p_o6392_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);vec4 o6392_0_1_rgba = o6392_gradient_gradient_fct(fract(o6392_0_r*p_o6392_repeat));
vec4 o6405_0_1_rgba = vec4(p_o6405_color_r, p_o6405_color_g, p_o6405_color_b, p_o6405_color_a);
float o6252_0_t = clamp((elapsed_time), 0.0, 23.99);vec4 o6370_0 = textureLod(texture_1, get_animation_frame((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), o6252_0_t), 0.0);
vec4 o6370_1 = textureLod(texture_1, get_animation_frame((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), o6252_0_t+1.0), 0.0);
vec4 o6252_0_1_rgba = mix(o6370_0, o6370_1, fract(o6252_0_t));
float o6389_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), p_o6389_sides, p_o6389_radius*1.0, p_o6389_edge*1.0);
float o6390_0_clamp_false = p_o6390_default_in1-o6389_0_1_f;
float o6390_0_clamp_true = clamp(o6390_0_clamp_false, 0.0, 1.0);
float o6390_0_2_f = o6390_0_clamp_false;
float o6380_0_0_sdf2d = o6380_d(((transform2((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), vec2(p_o6379_translate_x*(2.0*1.0-1.0), p_o6379_translate_y*(2.0*1.0-1.0)), p_o6379_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o6379_scale_x*(2.0*1.0-1.0), p_o6379_scale_y*(2.0*1.0-1.0))))-vec2(p_o6387_translate_x, (elapsed_time*0.2)))-vec2(0.5), _seed_variation_);
float o6384_0_1_f = clamp(p_o6384_base-o6380_0_0_sdf2d/max(p_o6384_bevel, 0.00001), 0.0, 1.0);
vec4 o6385_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o6384_0_1_f), 1.0).rgb, vec4(vec3(o6384_0_1_f), 1.0).a);
vec4 o6387_0_1_rgba = o6385_0_1_rgba;
vec4 o6379_0_1_rgba = o6387_0_1_rgba;
float o6388_0_clamp_false = max(o6390_0_2_f,(dot((o6379_0_1_rgba).rgb, vec3(1.0))/3.0));
float o6388_0_clamp_true = clamp(o6388_0_clamp_false, 0.0, 1.0);
float o6388_0_1_f = o6388_0_clamp_false;
float o6374_0_clamp_false = min((dot((o6252_0_1_rgba).rgb, vec3(1.0))/3.0),o6388_0_1_f);
float o6374_0_clamp_true = clamp(o6374_0_clamp_false, 0.0, 1.0);
float o6374_0_1_f = o6374_0_clamp_false;
vec3 o6162_0_false = clamp((vec4(vec3(o6374_0_1_f), 1.0).rgb-vec3(p_o6162_value))/max(0.0001, p_o6162_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o6162_0_true = vec3(1.0)-o6162_0_false;vec4 o6162_0_1_rgba = vec4(o6162_0_false, vec4(vec3(o6374_0_1_f), 1.0).a);
float o6377_0_1_f = p_o6377_color;
float o6375_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), p_o6375_sides, p_o6375_radius*1.0, p_o6375_edge*1.0);
float o6376_0_clamp_false = o6377_0_1_f-o6375_0_1_f;
float o6376_0_clamp_true = clamp(o6376_0_clamp_false, 0.0, 1.0);
float o6376_0_1_f = o6376_0_clamp_false;
float o6369_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), p_o6369_sides, p_o6369_radius*1.0, p_o6369_edge*1.0);
float o6378_0_clamp_false = max(o6376_0_1_f,o6369_0_1_f);
float o6378_0_clamp_true = clamp(o6378_0_clamp_false, 0.0, 1.0);
float o6378_0_1_f = o6378_0_clamp_false;
float o6368_0_clamp_false = min((dot((o6162_0_1_rgba).rgb, vec3(1.0))/3.0),o6378_0_1_f);
float o6368_0_clamp_true = clamp(o6368_0_clamp_false, 0.0, 1.0);
float o6368_0_1_f = o6368_0_clamp_false;
vec4 o6391_0_s1 = o6392_0_1_rgba;
vec4 o6391_0_s2 = o6405_0_1_rgba;
float o6391_0_a = p_o6391_amount*o6368_0_1_f;
vec4 o6391_0_1_rgba = vec4(blend_normal((scale((uv), vec2(0.5+p_o6406_cx, 0.5+p_o6406_cy), vec2(p_o6406_scale_x, (p_o6406_scale_x)))), o6391_0_s1.rgb, o6391_0_s2.rgb, o6391_0_a*o6391_0_s1.a), min(1.0, o6391_0_s2.a+o6391_0_a*o6391_0_s1.a));
vec4 o6406_0_1_rgba = o6391_0_1_rgba;

	vec4 color_tex = o6406_0_1_rgba;
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	ALBEDO = color_tex.rgb;
	ALPHA = color_tex.a;

}



