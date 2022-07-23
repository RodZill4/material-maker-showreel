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


uniform sampler2D texture_1;
const float texture_1_size = 1024.0;

uniform sampler2D texture_2;
const float texture_2_size = 256.0;

uniform sampler2D texture_3;
const float texture_3_size = 128.0;

const float o105750_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

float cross2( in vec2 a, in vec2 b ) { return a.x*b.y - a.y*b.x; }

// signed distance to a quadratic bezier
vec2 sdBezier( in vec2 pos, in vec2 A, in vec2 B, in vec2 C ) {    
    vec2 a = B - A;
    vec2 b = A - 2.0*B + C;
    vec2 c = a * 2.0;
    vec2 d = A - pos;

    float kk = 1.0/dot(b,b);
    float kx = kk * dot(a,b);
    float ky = kk * (2.0*dot(a,a)+dot(d,b))/3.0;
    float kz = kk * dot(d,a);      

    float res = 0.0;
    float sgn = 0.0;

    float p = ky - kx*kx;
    float p3 = p*p*p;
    float q = kx*(2.0*kx*kx - 3.0*ky) + kz;
    float h = q*q + 4.0*p3;
	float rvx;

    if( h>=0.0 ) { // 1 root
        h = sqrt(h);
        vec2 x = (vec2(h,-h)-q)/2.0;
        vec2 uv = sign(x)*pow(abs(x), vec2(1.0/3.0));
		rvx = uv.x+uv.y-kx;
        float t = clamp(rvx, 0.0, 1.0);
        vec2 q2 = d+(c+b*t)*t;
        res = dot(q2, q2);
    	sgn = cross2(c+2.0*b*t, q2);
    } else {   // 3 roots
        float z = sqrt(-p);
        float v = acos(q/(p*z*2.0))/3.0;
        float m = cos(v);
        float n = sin(v)*1.732050808;
        vec3  t = clamp(vec3(m+m,-n-m,n-m)*z-kx, 0.0, 1.0);
        vec2  qx=d+(c+b*t.x)*t.x; float dx=dot(qx, qx), sx = cross2(c+2.0*b*t.x,qx);
        vec2  qy=d+(c+b*t.y)*t.y; float dy=dot(qy, qy), sy = cross2(c+2.0*b*t.y,qy);
        if( dx<dy ) { res=dx; sgn=sx; rvx = t.x; } else { res=dy; sgn=sy; rvx = t.y; }
    }
    
    return vec2(rvx, sqrt(res)*sign(sgn));
}

const float o105813_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

const float o105587_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

const float o105684_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

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
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
    return rv;	
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
uniform sampler2D texture_4;
const float texture_4_size = 1024.0;

uniform sampler2D texture_5;
const float texture_5_size = 1024.0;

vec3 process_normal_default(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, -1.0))+vec3(0.5);
}

vec3 process_normal_opengl(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}

vec3 process_normal_directx(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*vec3(1.0, -1.0, 1.0)*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}

const float p_o104184_albedo_color_r = 1.000000000;
const float p_o104184_albedo_color_g = 1.000000000;
const float p_o104184_albedo_color_b = 1.000000000;
const float p_o104184_albedo_color_a = 1.000000000;
const float p_o104184_metallic = 0.000000000;
const float p_o104184_roughness = 1.000000000;
const float p_o104184_emission_energy = 1.000000000;
const float p_o104184_normal = 1.000000000;
const float p_o104184_ao = 1.000000000;
const float p_o104184_depth_scale = 0.500000000;
float o104184_input_depth_tex(vec2 uv, float _seed_variation_) {

return 0.0;
}
const float p_o104191_amount = 1.000000000;
const float p_o104192_color_r = 0.082030997;
const float p_o104192_color_g = 0.082030997;
const float p_o104192_color_b = 0.082030997;
const float p_o104192_color_a = 1.000000000;
const float p_o104190_value = 0.010000000;
const float p_o104190_width = 0.000000000;
const float seed_o104193 = 27301.000000000;
const float p_o104193_count = 8.000000000;
const float p_o104193_scale_x = 1.000000000;
const float p_o104193_scale_y = 1.000000000;
const float p_o104193_rotate = 180.000000000;
const float p_o104193_scale = 0.100000000;
const float p_o104193_value = 0.000000000;
const float p_o104198_cx = 0.000000000;
const float p_o104198_cy = 0.000000000;
const float p_o104197_translate_x = 0.340000000;
const float p_o104197_translate_y = 0.000000000;
const float p_o104197_rotate = 0.000000000;
const float p_o104197_scale_x = 0.200000000;
const float p_o104197_scale_y = 0.200000000;
const float p_o104188_cx = 0.000000000;
const float p_o104188_cy = 0.000000000;
const float p_o104185_amount = 1.000000000;
const float p_o105908_default_in1 = 0.000000000;
const float p_o105908_default_in2 = 0.200000000;
const float p_o105907_default_in1 = 0.000000000;
const float p_o105907_default_in2 = 0.000000000;
const float p_o105571_default_in1 = 0.000000000;
const float p_o105571_default_in2 = 0.000000000;
const float p_o105570_default_in1 = 0.000000000;
const float p_o105570_default_in2 = 0.000000000;
const float p_o105897_ax = 0.085000000;
const float p_o105897_ay = -0.130000000;
const float p_o105897_bx = 0.320000000;
const float p_o105897_by = -0.260000000;
const float p_o105897_cx = 0.046000000;
const float p_o105897_cy = -0.410000000;
const float p_o105897_width = 0.050000000;
const float p_o105897_repeat = 1.000000000;
vec4 o105897_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
const float p_o105740_default_in1 = 0.000000000;
const float p_o105740_default_in2 = 0.010000000;
const float p_o105745_default_in1 = 0.000000000;
const float p_o105745_default_in2 = 6.280000000;
const float p_o105747_default_in1 = 0.000000000;
const float p_o105747_default_in2 = 0.500000000;
const float p_o105738_default_in1 = 0.500000000;
const float p_o105738_default_in2 = 0.000000000;
float o105897_input_bx_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105745_0_clamp_false = cos(o105747_0_1_f*p_o105745_default_in2);
float o105745_0_clamp_true = clamp(o105745_0_clamp_false, 0.0, 1.0);
float o105745_0_2_f = o105745_0_clamp_false;
float o105740_0_clamp_false = o105745_0_2_f*p_o105740_default_in2;
float o105740_0_clamp_true = clamp(o105740_0_clamp_false, 0.0, 1.0);
float o105740_0_2_f = o105740_0_clamp_false;

return o105740_0_2_f;
}
const float p_o105741_default_in1 = 0.000000000;
const float p_o105741_default_in2 = 0.010000000;
const float p_o105744_default_in1 = 0.000000000;
const float p_o105744_default_in2 = 6.280000000;
float o105897_input_by_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105744_0_clamp_false = sin(o105747_0_1_f*p_o105744_default_in2);
float o105744_0_clamp_true = clamp(o105744_0_clamp_false, 0.0, 1.0);
float o105744_0_2_f = o105744_0_clamp_false;
float o105741_0_clamp_false = o105744_0_2_f*p_o105741_default_in2;
float o105741_0_clamp_true = clamp(o105741_0_clamp_false, 0.0, 1.0);
float o105741_0_2_f = o105741_0_clamp_false;

return o105741_0_2_f;
}
const float p_o105743_default_in1 = 0.000000000;
const float p_o105743_default_in2 = 0.035000000;
float o105897_input_cx_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105745_0_clamp_false = cos(o105747_0_1_f*p_o105745_default_in2);
float o105745_0_clamp_true = clamp(o105745_0_clamp_false, 0.0, 1.0);
float o105745_0_2_f = o105745_0_clamp_false;
float o105743_0_clamp_false = o105745_0_2_f*p_o105743_default_in2;
float o105743_0_clamp_true = clamp(o105743_0_clamp_false, 0.0, 1.0);
float o105743_0_2_f = o105743_0_clamp_false;

return o105743_0_2_f;
}
const float p_o105742_default_in1 = 0.000000000;
const float p_o105742_default_in2 = 0.035000000;
float o105897_input_cy_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105744_0_clamp_false = sin(o105747_0_1_f*p_o105744_default_in2);
float o105744_0_clamp_true = clamp(o105744_0_clamp_false, 0.0, 1.0);
float o105744_0_2_f = o105744_0_clamp_false;
float o105742_0_clamp_false = o105744_0_2_f*p_o105742_default_in2;
float o105742_0_clamp_true = clamp(o105742_0_clamp_false, 0.0, 1.0);
float o105742_0_2_f = o105742_0_clamp_false;

return o105742_0_2_f;
}
const float p_o105898_ax = 0.120000000;
const float p_o105898_ay = 0.003300000;
const float p_o105898_bx = 0.340000000;
const float p_o105898_by = -0.126000000;
const float p_o105898_cx = 0.350000000;
const float p_o105898_cy = 0.120000000;
const float p_o105898_width = 0.050000000;
const float p_o105898_repeat = 1.000000000;
vec4 o105898_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
const float p_o105803_default_in1 = 0.000000000;
const float p_o105803_default_in2 = 0.010000000;
const float p_o105808_default_in1 = 0.000000000;
const float p_o105808_default_in2 = 6.280000000;
const float p_o105810_default_in1 = 0.000000000;
const float p_o105810_default_in2 = 0.500000000;
const float p_o105802_default_in1 = 0.000000000;
const float p_o105802_default_in2 = 0.500000000;
float o105898_input_bx_o(vec2 uv, float _seed_variation_) {
float o105801_0_clamp_false = fract((o105813_speed * elapsed_time / 2.0));
float o105801_0_clamp_true = clamp(o105801_0_clamp_false, 0.0, 1.0);
float o105801_0_2_f = o105801_0_clamp_false;
float o105802_0_clamp_false = (1.0-step(p_o105802_default_in2,o105801_0_2_f));
float o105802_0_clamp_true = clamp(o105802_0_clamp_false, 0.0, 1.0);
float o105802_0_2_f = o105802_0_clamp_false;
float o105809_0_clamp_false = fract((o105813_speed * elapsed_time));
float o105809_0_clamp_true = clamp(o105809_0_clamp_false, 0.0, 1.0);
float o105809_0_2_f = o105809_0_clamp_false;
float o105810_0_clamp_false = o105802_0_2_f*o105809_0_2_f;
float o105810_0_clamp_true = clamp(o105810_0_clamp_false, 0.0, 1.0);
float o105810_0_1_f = o105810_0_clamp_false;
float o105808_0_clamp_false = cos(o105810_0_1_f*p_o105808_default_in2);
float o105808_0_clamp_true = clamp(o105808_0_clamp_false, 0.0, 1.0);
float o105808_0_2_f = o105808_0_clamp_false;
float o105803_0_clamp_false = o105808_0_2_f*p_o105803_default_in2;
float o105803_0_clamp_true = clamp(o105803_0_clamp_false, 0.0, 1.0);
float o105803_0_2_f = o105803_0_clamp_false;

return o105803_0_2_f;
}
const float p_o105804_default_in1 = 0.000000000;
const float p_o105804_default_in2 = 0.010000000;
const float p_o105807_default_in1 = 0.000000000;
const float p_o105807_default_in2 = 6.280000000;
float o105898_input_by_o(vec2 uv, float _seed_variation_) {
float o105801_0_clamp_false = fract((o105813_speed * elapsed_time / 2.0));
float o105801_0_clamp_true = clamp(o105801_0_clamp_false, 0.0, 1.0);
float o105801_0_2_f = o105801_0_clamp_false;
float o105802_0_clamp_false = (1.0-step(p_o105802_default_in2,o105801_0_2_f));
float o105802_0_clamp_true = clamp(o105802_0_clamp_false, 0.0, 1.0);
float o105802_0_2_f = o105802_0_clamp_false;
float o105809_0_clamp_false = fract((o105813_speed * elapsed_time));
float o105809_0_clamp_true = clamp(o105809_0_clamp_false, 0.0, 1.0);
float o105809_0_2_f = o105809_0_clamp_false;
float o105810_0_clamp_false = o105802_0_2_f*o105809_0_2_f;
float o105810_0_clamp_true = clamp(o105810_0_clamp_false, 0.0, 1.0);
float o105810_0_1_f = o105810_0_clamp_false;
float o105807_0_clamp_false = sin(o105810_0_1_f*p_o105807_default_in2);
float o105807_0_clamp_true = clamp(o105807_0_clamp_false, 0.0, 1.0);
float o105807_0_2_f = o105807_0_clamp_false;
float o105804_0_clamp_false = o105807_0_2_f*p_o105804_default_in2;
float o105804_0_clamp_true = clamp(o105804_0_clamp_false, 0.0, 1.0);
float o105804_0_2_f = o105804_0_clamp_false;

return o105804_0_2_f;
}
const float p_o105806_default_in1 = 0.000000000;
const float p_o105806_default_in2 = 0.035000000;
float o105898_input_cx_o(vec2 uv, float _seed_variation_) {
float o105801_0_clamp_false = fract((o105813_speed * elapsed_time / 2.0));
float o105801_0_clamp_true = clamp(o105801_0_clamp_false, 0.0, 1.0);
float o105801_0_2_f = o105801_0_clamp_false;
float o105802_0_clamp_false = (1.0-step(p_o105802_default_in2,o105801_0_2_f));
float o105802_0_clamp_true = clamp(o105802_0_clamp_false, 0.0, 1.0);
float o105802_0_2_f = o105802_0_clamp_false;
float o105809_0_clamp_false = fract((o105813_speed * elapsed_time));
float o105809_0_clamp_true = clamp(o105809_0_clamp_false, 0.0, 1.0);
float o105809_0_2_f = o105809_0_clamp_false;
float o105810_0_clamp_false = o105802_0_2_f*o105809_0_2_f;
float o105810_0_clamp_true = clamp(o105810_0_clamp_false, 0.0, 1.0);
float o105810_0_1_f = o105810_0_clamp_false;
float o105808_0_clamp_false = cos(o105810_0_1_f*p_o105808_default_in2);
float o105808_0_clamp_true = clamp(o105808_0_clamp_false, 0.0, 1.0);
float o105808_0_2_f = o105808_0_clamp_false;
float o105806_0_clamp_false = o105808_0_2_f*p_o105806_default_in2;
float o105806_0_clamp_true = clamp(o105806_0_clamp_false, 0.0, 1.0);
float o105806_0_2_f = o105806_0_clamp_false;

return o105806_0_2_f;
}
const float p_o105805_default_in1 = 0.000000000;
const float p_o105805_default_in2 = 0.035000000;
float o105898_input_cy_o(vec2 uv, float _seed_variation_) {
float o105801_0_clamp_false = fract((o105813_speed * elapsed_time / 2.0));
float o105801_0_clamp_true = clamp(o105801_0_clamp_false, 0.0, 1.0);
float o105801_0_2_f = o105801_0_clamp_false;
float o105802_0_clamp_false = (1.0-step(p_o105802_default_in2,o105801_0_2_f));
float o105802_0_clamp_true = clamp(o105802_0_clamp_false, 0.0, 1.0);
float o105802_0_2_f = o105802_0_clamp_false;
float o105809_0_clamp_false = fract((o105813_speed * elapsed_time));
float o105809_0_clamp_true = clamp(o105809_0_clamp_false, 0.0, 1.0);
float o105809_0_2_f = o105809_0_clamp_false;
float o105810_0_clamp_false = o105802_0_2_f*o105809_0_2_f;
float o105810_0_clamp_true = clamp(o105810_0_clamp_false, 0.0, 1.0);
float o105810_0_1_f = o105810_0_clamp_false;
float o105807_0_clamp_false = sin(o105810_0_1_f*p_o105807_default_in2);
float o105807_0_clamp_true = clamp(o105807_0_clamp_false, 0.0, 1.0);
float o105807_0_2_f = o105807_0_clamp_false;
float o105805_0_clamp_false = o105807_0_2_f*p_o105805_default_in2;
float o105805_0_clamp_true = clamp(o105805_0_clamp_false, 0.0, 1.0);
float o105805_0_2_f = o105805_0_clamp_false;

return o105805_0_2_f;
}
const float p_o105906_ax = 0.050000000;
const float p_o105906_ay = 0.120000000;
const float p_o105906_bx = 0.390000000;
const float p_o105906_by = 0.150000000;
const float p_o105906_cx = 0.150000000;
const float p_o105906_cy = 0.420000000;
const float p_o105906_width = 0.050000000;
const float p_o105906_repeat = 1.000000000;
vec4 o105906_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
float o105906_input_bx_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105745_0_clamp_false = cos(o105747_0_1_f*p_o105745_default_in2);
float o105745_0_clamp_true = clamp(o105745_0_clamp_false, 0.0, 1.0);
float o105745_0_2_f = o105745_0_clamp_false;
float o105740_0_clamp_false = o105745_0_2_f*p_o105740_default_in2;
float o105740_0_clamp_true = clamp(o105740_0_clamp_false, 0.0, 1.0);
float o105740_0_2_f = o105740_0_clamp_false;

return o105740_0_2_f;
}
float o105906_input_by_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105744_0_clamp_false = sin(o105747_0_1_f*p_o105744_default_in2);
float o105744_0_clamp_true = clamp(o105744_0_clamp_false, 0.0, 1.0);
float o105744_0_2_f = o105744_0_clamp_false;
float o105741_0_clamp_false = o105744_0_2_f*p_o105741_default_in2;
float o105741_0_clamp_true = clamp(o105741_0_clamp_false, 0.0, 1.0);
float o105741_0_2_f = o105741_0_clamp_false;

return o105741_0_2_f;
}
float o105906_input_cx_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105745_0_clamp_false = cos(o105747_0_1_f*p_o105745_default_in2);
float o105745_0_clamp_true = clamp(o105745_0_clamp_false, 0.0, 1.0);
float o105745_0_2_f = o105745_0_clamp_false;
float o105743_0_clamp_false = o105745_0_2_f*p_o105743_default_in2;
float o105743_0_clamp_true = clamp(o105743_0_clamp_false, 0.0, 1.0);
float o105743_0_2_f = o105743_0_clamp_false;

return o105743_0_2_f;
}
float o105906_input_cy_o(vec2 uv, float _seed_variation_) {
float o105739_0_clamp_false = fract((o105750_speed * elapsed_time / 2.0));
float o105739_0_clamp_true = clamp(o105739_0_clamp_false, 0.0, 1.0);
float o105739_0_2_f = o105739_0_clamp_false;
float o105738_0_clamp_false = (1.0-step(o105739_0_2_f,p_o105738_default_in1));
float o105738_0_clamp_true = clamp(o105738_0_clamp_false, 0.0, 1.0);
float o105738_0_2_f = o105738_0_clamp_false;
float o105746_0_clamp_false = fract((o105750_speed * elapsed_time));
float o105746_0_clamp_true = clamp(o105746_0_clamp_false, 0.0, 1.0);
float o105746_0_2_f = o105746_0_clamp_false;
float o105747_0_clamp_false = o105738_0_2_f*o105746_0_2_f;
float o105747_0_clamp_true = clamp(o105747_0_clamp_false, 0.0, 1.0);
float o105747_0_1_f = o105747_0_clamp_false;
float o105744_0_clamp_false = sin(o105747_0_1_f*p_o105744_default_in2);
float o105744_0_clamp_true = clamp(o105744_0_clamp_false, 0.0, 1.0);
float o105744_0_2_f = o105744_0_clamp_false;
float o105742_0_clamp_false = o105744_0_2_f*p_o105742_default_in2;
float o105742_0_clamp_true = clamp(o105742_0_clamp_false, 0.0, 1.0);
float o105742_0_2_f = o105742_0_clamp_false;

return o105742_0_2_f;
}
const float p_o105572_default_in1 = 0.000000000;
const float p_o105572_default_in2 = 0.000000000;
const float p_o105573_default_in1 = 0.000000000;
const float p_o105573_default_in2 = 0.000000000;
const float p_o105734_ax = -0.085000000;
const float p_o105734_ay = -0.130000000;
const float p_o105734_bx = -0.320000000;
const float p_o105734_by = -0.260000000;
const float p_o105734_cx = -0.046000000;
const float p_o105734_cy = -0.410000000;
const float p_o105734_width = 0.050000000;
const float p_o105734_repeat = 1.000000000;
vec4 o105734_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
const float p_o105577_default_in1 = 0.000000000;
const float p_o105577_default_in2 = 0.010000000;
const float p_o105582_default_in1 = 0.000000000;
const float p_o105582_default_in2 = 6.280000000;
const float p_o105584_default_in1 = 0.000000000;
const float p_o105584_default_in2 = 0.500000000;
const float p_o105576_default_in1 = 0.000000000;
const float p_o105576_default_in2 = 0.500000000;
float o105734_input_bx_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105582_0_clamp_false = cos(o105584_0_1_f*p_o105582_default_in2);
float o105582_0_clamp_true = clamp(o105582_0_clamp_false, 0.0, 1.0);
float o105582_0_2_f = o105582_0_clamp_false;
float o105577_0_clamp_false = o105582_0_2_f*p_o105577_default_in2;
float o105577_0_clamp_true = clamp(o105577_0_clamp_false, 0.0, 1.0);
float o105577_0_2_f = o105577_0_clamp_false;

return o105577_0_2_f;
}
const float p_o105578_default_in1 = 0.000000000;
const float p_o105578_default_in2 = 0.010000000;
const float p_o105581_default_in1 = 0.000000000;
const float p_o105581_default_in2 = 6.280000000;
float o105734_input_by_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105581_0_clamp_false = sin(o105584_0_1_f*p_o105581_default_in2);
float o105581_0_clamp_true = clamp(o105581_0_clamp_false, 0.0, 1.0);
float o105581_0_2_f = o105581_0_clamp_false;
float o105578_0_clamp_false = o105581_0_2_f*p_o105578_default_in2;
float o105578_0_clamp_true = clamp(o105578_0_clamp_false, 0.0, 1.0);
float o105578_0_2_f = o105578_0_clamp_false;

return o105578_0_2_f;
}
const float p_o105580_default_in1 = 0.000000000;
const float p_o105580_default_in2 = 0.035000000;
float o105734_input_cx_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105582_0_clamp_false = cos(o105584_0_1_f*p_o105582_default_in2);
float o105582_0_clamp_true = clamp(o105582_0_clamp_false, 0.0, 1.0);
float o105582_0_2_f = o105582_0_clamp_false;
float o105580_0_clamp_false = o105582_0_2_f*p_o105580_default_in2;
float o105580_0_clamp_true = clamp(o105580_0_clamp_false, 0.0, 1.0);
float o105580_0_2_f = o105580_0_clamp_false;

return o105580_0_2_f;
}
const float p_o105579_default_in1 = 0.000000000;
const float p_o105579_default_in2 = 0.035000000;
float o105734_input_cy_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105581_0_clamp_false = sin(o105584_0_1_f*p_o105581_default_in2);
float o105581_0_clamp_true = clamp(o105581_0_clamp_false, 0.0, 1.0);
float o105581_0_2_f = o105581_0_clamp_false;
float o105579_0_clamp_false = o105581_0_2_f*p_o105579_default_in2;
float o105579_0_clamp_true = clamp(o105579_0_clamp_false, 0.0, 1.0);
float o105579_0_2_f = o105579_0_clamp_false;

return o105579_0_2_f;
}
const float p_o105736_ax = -0.120000000;
const float p_o105736_ay = 0.003300000;
const float p_o105736_bx = -0.340000000;
const float p_o105736_by = -0.126000000;
const float p_o105736_cx = -0.350000000;
const float p_o105736_cy = 0.120000000;
const float p_o105736_width = 0.050000000;
const float p_o105736_repeat = 1.000000000;
vec4 o105736_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
const float p_o105674_default_in1 = 0.000000000;
const float p_o105674_default_in2 = 0.010000000;
const float p_o105679_default_in1 = 0.000000000;
const float p_o105679_default_in2 = 6.280000000;
const float p_o105681_default_in1 = 0.000000000;
const float p_o105681_default_in2 = 0.500000000;
const float p_o105672_default_in1 = 0.500000000;
const float p_o105672_default_in2 = 0.000000000;
float o105736_input_bx_o(vec2 uv, float _seed_variation_) {
float o105673_0_clamp_false = fract((o105684_speed * elapsed_time / 2.0));
float o105673_0_clamp_true = clamp(o105673_0_clamp_false, 0.0, 1.0);
float o105673_0_2_f = o105673_0_clamp_false;
float o105672_0_clamp_false = (1.0-step(o105673_0_2_f,p_o105672_default_in1));
float o105672_0_clamp_true = clamp(o105672_0_clamp_false, 0.0, 1.0);
float o105672_0_2_f = o105672_0_clamp_false;
float o105680_0_clamp_false = fract((o105684_speed * -elapsed_time));
float o105680_0_clamp_true = clamp(o105680_0_clamp_false, 0.0, 1.0);
float o105680_0_2_f = o105680_0_clamp_false;
float o105681_0_clamp_false = o105672_0_2_f*o105680_0_2_f;
float o105681_0_clamp_true = clamp(o105681_0_clamp_false, 0.0, 1.0);
float o105681_0_1_f = o105681_0_clamp_false;
float o105679_0_clamp_false = cos(o105681_0_1_f*p_o105679_default_in2);
float o105679_0_clamp_true = clamp(o105679_0_clamp_false, 0.0, 1.0);
float o105679_0_2_f = o105679_0_clamp_false;
float o105674_0_clamp_false = o105679_0_2_f*p_o105674_default_in2;
float o105674_0_clamp_true = clamp(o105674_0_clamp_false, 0.0, 1.0);
float o105674_0_2_f = o105674_0_clamp_false;

return o105674_0_2_f;
}
const float p_o105675_default_in1 = 0.000000000;
const float p_o105675_default_in2 = 0.010000000;
const float p_o105678_default_in1 = 0.000000000;
const float p_o105678_default_in2 = 6.280000000;
float o105736_input_by_o(vec2 uv, float _seed_variation_) {
float o105673_0_clamp_false = fract((o105684_speed * elapsed_time / 2.0));
float o105673_0_clamp_true = clamp(o105673_0_clamp_false, 0.0, 1.0);
float o105673_0_2_f = o105673_0_clamp_false;
float o105672_0_clamp_false = (1.0-step(o105673_0_2_f,p_o105672_default_in1));
float o105672_0_clamp_true = clamp(o105672_0_clamp_false, 0.0, 1.0);
float o105672_0_2_f = o105672_0_clamp_false;
float o105680_0_clamp_false = fract((o105684_speed * -elapsed_time));
float o105680_0_clamp_true = clamp(o105680_0_clamp_false, 0.0, 1.0);
float o105680_0_2_f = o105680_0_clamp_false;
float o105681_0_clamp_false = o105672_0_2_f*o105680_0_2_f;
float o105681_0_clamp_true = clamp(o105681_0_clamp_false, 0.0, 1.0);
float o105681_0_1_f = o105681_0_clamp_false;
float o105678_0_clamp_false = sin(o105681_0_1_f*p_o105678_default_in2);
float o105678_0_clamp_true = clamp(o105678_0_clamp_false, 0.0, 1.0);
float o105678_0_2_f = o105678_0_clamp_false;
float o105675_0_clamp_false = o105678_0_2_f*p_o105675_default_in2;
float o105675_0_clamp_true = clamp(o105675_0_clamp_false, 0.0, 1.0);
float o105675_0_2_f = o105675_0_clamp_false;

return o105675_0_2_f;
}
const float p_o105677_default_in1 = 0.000000000;
const float p_o105677_default_in2 = 0.035000000;
float o105736_input_cx_o(vec2 uv, float _seed_variation_) {
float o105673_0_clamp_false = fract((o105684_speed * elapsed_time / 2.0));
float o105673_0_clamp_true = clamp(o105673_0_clamp_false, 0.0, 1.0);
float o105673_0_2_f = o105673_0_clamp_false;
float o105672_0_clamp_false = (1.0-step(o105673_0_2_f,p_o105672_default_in1));
float o105672_0_clamp_true = clamp(o105672_0_clamp_false, 0.0, 1.0);
float o105672_0_2_f = o105672_0_clamp_false;
float o105680_0_clamp_false = fract((o105684_speed * -elapsed_time));
float o105680_0_clamp_true = clamp(o105680_0_clamp_false, 0.0, 1.0);
float o105680_0_2_f = o105680_0_clamp_false;
float o105681_0_clamp_false = o105672_0_2_f*o105680_0_2_f;
float o105681_0_clamp_true = clamp(o105681_0_clamp_false, 0.0, 1.0);
float o105681_0_1_f = o105681_0_clamp_false;
float o105679_0_clamp_false = cos(o105681_0_1_f*p_o105679_default_in2);
float o105679_0_clamp_true = clamp(o105679_0_clamp_false, 0.0, 1.0);
float o105679_0_2_f = o105679_0_clamp_false;
float o105677_0_clamp_false = o105679_0_2_f*p_o105677_default_in2;
float o105677_0_clamp_true = clamp(o105677_0_clamp_false, 0.0, 1.0);
float o105677_0_2_f = o105677_0_clamp_false;

return o105677_0_2_f;
}
const float p_o105676_default_in1 = 0.000000000;
const float p_o105676_default_in2 = 0.035000000;
float o105736_input_cy_o(vec2 uv, float _seed_variation_) {
float o105673_0_clamp_false = fract((o105684_speed * elapsed_time / 2.0));
float o105673_0_clamp_true = clamp(o105673_0_clamp_false, 0.0, 1.0);
float o105673_0_2_f = o105673_0_clamp_false;
float o105672_0_clamp_false = (1.0-step(o105673_0_2_f,p_o105672_default_in1));
float o105672_0_clamp_true = clamp(o105672_0_clamp_false, 0.0, 1.0);
float o105672_0_2_f = o105672_0_clamp_false;
float o105680_0_clamp_false = fract((o105684_speed * -elapsed_time));
float o105680_0_clamp_true = clamp(o105680_0_clamp_false, 0.0, 1.0);
float o105680_0_2_f = o105680_0_clamp_false;
float o105681_0_clamp_false = o105672_0_2_f*o105680_0_2_f;
float o105681_0_clamp_true = clamp(o105681_0_clamp_false, 0.0, 1.0);
float o105681_0_1_f = o105681_0_clamp_false;
float o105678_0_clamp_false = sin(o105681_0_1_f*p_o105678_default_in2);
float o105678_0_clamp_true = clamp(o105678_0_clamp_false, 0.0, 1.0);
float o105678_0_2_f = o105678_0_clamp_false;
float o105676_0_clamp_false = o105678_0_2_f*p_o105676_default_in2;
float o105676_0_clamp_true = clamp(o105676_0_clamp_false, 0.0, 1.0);
float o105676_0_2_f = o105676_0_clamp_false;

return o105676_0_2_f;
}
const float p_o105735_ax = -0.050000000;
const float p_o105735_ay = 0.120000000;
const float p_o105735_bx = -0.390000000;
const float p_o105735_by = 0.150000000;
const float p_o105735_cx = -0.150000000;
const float p_o105735_cy = 0.420000000;
const float p_o105735_width = 0.050000000;
const float p_o105735_repeat = 1.000000000;
vec4 o105735_input_in(vec2 uv, float _seed_variation_) {
vec4 o105899_0 = textureLod(texture_3, uv, 0.0);

return o105899_0;
}
float o105735_input_bx_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105582_0_clamp_false = cos(o105584_0_1_f*p_o105582_default_in2);
float o105582_0_clamp_true = clamp(o105582_0_clamp_false, 0.0, 1.0);
float o105582_0_2_f = o105582_0_clamp_false;
float o105577_0_clamp_false = o105582_0_2_f*p_o105577_default_in2;
float o105577_0_clamp_true = clamp(o105577_0_clamp_false, 0.0, 1.0);
float o105577_0_2_f = o105577_0_clamp_false;

return o105577_0_2_f;
}
float o105735_input_by_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105581_0_clamp_false = sin(o105584_0_1_f*p_o105581_default_in2);
float o105581_0_clamp_true = clamp(o105581_0_clamp_false, 0.0, 1.0);
float o105581_0_2_f = o105581_0_clamp_false;
float o105578_0_clamp_false = o105581_0_2_f*p_o105578_default_in2;
float o105578_0_clamp_true = clamp(o105578_0_clamp_false, 0.0, 1.0);
float o105578_0_2_f = o105578_0_clamp_false;

return o105578_0_2_f;
}
float o105735_input_cx_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105582_0_clamp_false = cos(o105584_0_1_f*p_o105582_default_in2);
float o105582_0_clamp_true = clamp(o105582_0_clamp_false, 0.0, 1.0);
float o105582_0_2_f = o105582_0_clamp_false;
float o105580_0_clamp_false = o105582_0_2_f*p_o105580_default_in2;
float o105580_0_clamp_true = clamp(o105580_0_clamp_false, 0.0, 1.0);
float o105580_0_2_f = o105580_0_clamp_false;

return o105580_0_2_f;
}
float o105735_input_cy_o(vec2 uv, float _seed_variation_) {
float o105575_0_clamp_false = fract((o105587_speed * elapsed_time / 2.0));
float o105575_0_clamp_true = clamp(o105575_0_clamp_false, 0.0, 1.0);
float o105575_0_2_f = o105575_0_clamp_false;
float o105576_0_clamp_false = (1.0-step(p_o105576_default_in2,o105575_0_2_f));
float o105576_0_clamp_true = clamp(o105576_0_clamp_false, 0.0, 1.0);
float o105576_0_2_f = o105576_0_clamp_false;
float o105583_0_clamp_false = fract((o105587_speed * -elapsed_time));
float o105583_0_clamp_true = clamp(o105583_0_clamp_false, 0.0, 1.0);
float o105583_0_2_f = o105583_0_clamp_false;
float o105584_0_clamp_false = o105576_0_2_f*o105583_0_2_f;
float o105584_0_clamp_true = clamp(o105584_0_clamp_false, 0.0, 1.0);
float o105584_0_1_f = o105584_0_clamp_false;
float o105581_0_clamp_false = sin(o105584_0_1_f*p_o105581_default_in2);
float o105581_0_clamp_true = clamp(o105581_0_clamp_false, 0.0, 1.0);
float o105581_0_2_f = o105581_0_clamp_false;
float o105579_0_clamp_false = o105581_0_2_f*p_o105579_default_in2;
float o105579_0_clamp_true = clamp(o105579_0_clamp_false, 0.0, 1.0);
float o105579_0_2_f = o105579_0_clamp_false;

return o105579_0_2_f;
}
float o104193_input_in(vec2 uv, float _seed_variation_) {
vec2 o104198_0_c = vec2(0.5+p_o104198_cx, 0.5+p_o104198_cy);vec2 o104188_0_c = vec2(0.5+p_o104188_cx, 0.5+p_o104188_cy);vec4 o104186_0 = textureLod(texture_2, (rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), 0.0);
vec2 o105897_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105897_ax+0.5, p_o105897_ay+0.5), vec2(p_o105897_bx+0.5+o105897_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105897_by+0.5+o105897_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105897_cx+0.5+o105897_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105897_cy+0.5+o105897_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105897_0_uv = vec2(o105897_0_bezier.x, o105897_0_bezier.y/p_o105897_width+0.5);
vec2 o105897_0_uvtest = step(vec2(0.5), abs(o105897_0_uv-vec2(0.5)));
o105897_0_uv = mix(vec2(fract(p_o105897_repeat*o105897_0_uv.x), o105897_0_uv.y), vec2(0.0), max(o105897_0_uvtest.x, o105897_0_uvtest.y));
vec4 o105897_0_1_rgba = o105897_input_in(o105897_0_uv, _seed_variation_);
vec2 o105898_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105898_ax+0.5, p_o105898_ay+0.5), vec2(p_o105898_bx+0.5+o105898_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105898_by+0.5+o105898_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105898_cx+0.5+o105898_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105898_cy+0.5+o105898_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105898_0_uv = vec2(o105898_0_bezier.x, o105898_0_bezier.y/p_o105898_width+0.5);
vec2 o105898_0_uvtest = step(vec2(0.5), abs(o105898_0_uv-vec2(0.5)));
o105898_0_uv = mix(vec2(fract(p_o105898_repeat*o105898_0_uv.x), o105898_0_uv.y), vec2(0.0), max(o105898_0_uvtest.x, o105898_0_uvtest.y));
vec4 o105898_0_1_rgba = o105898_input_in(o105898_0_uv, _seed_variation_);
float o105570_0_clamp_false = max((dot((o105897_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o105898_0_1_rgba).rgb, vec3(1.0))/3.0));
float o105570_0_clamp_true = clamp(o105570_0_clamp_false, 0.0, 1.0);
float o105570_0_1_f = o105570_0_clamp_true;
vec2 o105906_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105906_ax+0.5, p_o105906_ay+0.5), vec2(p_o105906_bx+0.5+o105906_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105906_by+0.5+o105906_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105906_cx+0.5+o105906_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105906_cy+0.5+o105906_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105906_0_uv = vec2(o105906_0_bezier.x, o105906_0_bezier.y/p_o105906_width+0.5);
vec2 o105906_0_uvtest = step(vec2(0.5), abs(o105906_0_uv-vec2(0.5)));
o105906_0_uv = mix(vec2(fract(p_o105906_repeat*o105906_0_uv.x), o105906_0_uv.y), vec2(0.0), max(o105906_0_uvtest.x, o105906_0_uvtest.y));
vec4 o105906_0_1_rgba = o105906_input_in(o105906_0_uv, _seed_variation_);
float o105571_0_clamp_false = max(o105570_0_1_f,(dot((o105906_0_1_rgba).rgb, vec3(1.0))/3.0));
float o105571_0_clamp_true = clamp(o105571_0_clamp_false, 0.0, 1.0);
float o105571_0_1_f = o105571_0_clamp_true;
vec2 o105734_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105734_ax+0.5, p_o105734_ay+0.5), vec2(p_o105734_bx+0.5+o105734_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105734_by+0.5+o105734_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105734_cx+0.5+o105734_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105734_cy+0.5+o105734_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105734_0_uv = vec2(o105734_0_bezier.x, o105734_0_bezier.y/p_o105734_width+0.5);
vec2 o105734_0_uvtest = step(vec2(0.5), abs(o105734_0_uv-vec2(0.5)));
o105734_0_uv = mix(vec2(fract(p_o105734_repeat*o105734_0_uv.x), o105734_0_uv.y), vec2(0.0), max(o105734_0_uvtest.x, o105734_0_uvtest.y));
vec4 o105734_0_1_rgba = o105734_input_in(o105734_0_uv, _seed_variation_);
vec2 o105736_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105736_ax+0.5, p_o105736_ay+0.5), vec2(p_o105736_bx+0.5+o105736_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105736_by+0.5+o105736_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105736_cx+0.5+o105736_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105736_cy+0.5+o105736_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105736_0_uv = vec2(o105736_0_bezier.x, o105736_0_bezier.y/p_o105736_width+0.5);
vec2 o105736_0_uvtest = step(vec2(0.5), abs(o105736_0_uv-vec2(0.5)));
o105736_0_uv = mix(vec2(fract(p_o105736_repeat*o105736_0_uv.x), o105736_0_uv.y), vec2(0.0), max(o105736_0_uvtest.x, o105736_0_uvtest.y));
vec4 o105736_0_1_rgba = o105736_input_in(o105736_0_uv, _seed_variation_);
float o105573_0_clamp_false = max((dot((o105734_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o105736_0_1_rgba).rgb, vec3(1.0))/3.0));
float o105573_0_clamp_true = clamp(o105573_0_clamp_false, 0.0, 1.0);
float o105573_0_1_f = o105573_0_clamp_true;
vec2 o105735_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), vec2(p_o105735_ax+0.5, p_o105735_ay+0.5), vec2(p_o105735_bx+0.5+o105735_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105735_by+0.5+o105735_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)), vec2(p_o105735_cx+0.5+o105735_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_), p_o105735_cy+0.5+o105735_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), _seed_variation_)));
vec2 o105735_0_uv = vec2(o105735_0_bezier.x, o105735_0_bezier.y/p_o105735_width+0.5);
vec2 o105735_0_uvtest = step(vec2(0.5), abs(o105735_0_uv-vec2(0.5)));
o105735_0_uv = mix(vec2(fract(p_o105735_repeat*o105735_0_uv.x), o105735_0_uv.y), vec2(0.0), max(o105735_0_uvtest.x, o105735_0_uvtest.y));
vec4 o105735_0_1_rgba = o105735_input_in(o105735_0_uv, _seed_variation_);
float o105572_0_clamp_false = max(o105573_0_1_f,(dot((o105735_0_1_rgba).rgb, vec3(1.0))/3.0));
float o105572_0_clamp_true = clamp(o105572_0_clamp_false, 0.0, 1.0);
float o105572_0_1_f = o105572_0_clamp_true;
float o105907_0_clamp_false = max(o105571_0_1_f,o105572_0_1_f);
float o105907_0_clamp_true = clamp(o105907_0_clamp_false, 0.0, 1.0);
float o105907_0_1_f = o105907_0_clamp_true;
float o105908_0_clamp_false = o105907_0_1_f*p_o105908_default_in2;
float o105908_0_clamp_true = clamp(o105908_0_clamp_false, 0.0, 1.0);
float o105908_0_2_f = o105908_0_clamp_false;
vec4 o104185_0_s1 = o104186_0;
vec4 o104185_0_s2 = vec4(vec3(o105908_0_2_f), 1.0);
float o104185_0_a = p_o104185_amount*1.0;
vec4 o104185_0_2_rgba = vec4(blend_lighten((rotate((transform2_clamp(transform2((rotate((uv)-o104198_0_c, (-elapsed_time * 80.0)*0.01745329251)+o104198_0_c), vec2(p_o104197_translate_x*(2.0*1.0-1.0), p_o104197_translate_y*(2.0*1.0-1.0)), p_o104197_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o104197_scale_x*(2.0*1.0-1.0), p_o104197_scale_y*(2.0*1.0-1.0)))))-o104188_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o104188_0_c), o104185_0_s1.rgb, o104185_0_s2.rgb, o104185_0_a*o104185_0_s1.a), min(1.0, o104185_0_s2.a+o104185_0_a*o104185_0_s1.a));
vec4 o104188_0_1_rgba = o104185_0_2_rgba;
vec4 o104197_0_1_rgba = o104188_0_1_rgba;
vec4 o104198_0_1_rgba = o104197_0_1_rgba;

return (dot((o104198_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o104193_input_mask(vec2 uv, float _seed_variation_) {

return 1.0;
}
vec4 splatter_o104193(vec2 uv, int count, vec2 seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int i = 0; i < count; ++i) {
		seed = rand2(seed);
		rc1 = rand3(seed);
		float mask = o104193_input_mask(fract(seed+vec2(0.5)), _seed_variation_);
		if (mask > 0.01) {
			vec2 pv = fract(uv - seed)-vec2(0.5);
			seed = rand2(seed);
			float angle = (seed.x * 2.0 - 1.0) * p_o104193_rotate * 0.01745329251;
			float ca = cos(angle);
			float sa = sin(angle);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv *= (seed.y-0.5)*2.0*p_o104193_scale+1.0;
			pv /= vec2(p_o104193_scale_x, p_o104193_scale_y);
			pv += vec2(0.5);
			seed = rand2(seed);
			if (pv != clamp(pv, vec2(0.0), vec2(1.0))) {
				continue;
			}
			 
			float c1 = o104193_input_in(pv, _seed_variation_)*mask*(1.0-p_o104193_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
		}
	}
	return vec4(rc, c);
}
const float p_o105294_amount = 1.000000000;
const float p_o105295_color = 0.100000000;
const float p_o104189_amount = 1.000000000;
const float p_o104199_amount = 2.000000000;
float o104199_input_in(vec2 uv, float _seed_variation_) {
vec4 o104193_0_rch = splatter_o104193((uv), int(p_o104193_count), vec2(float(seed_o104193)), _seed_variation_);float o104193_0_1_f = o104193_0_rch.a;

return o104193_0_1_f;
}
vec3 o104199_fct(vec2 uv, float _seed_variation_) {
	vec3 e = vec3(1.0/1024.000000000, -1.0/1024.000000000, 0);
	vec2 rv = vec2(1.0, -1.0)*o104199_input_in(uv+e.xy, _seed_variation_);
	rv += vec2(-1.0, 1.0)*o104199_input_in(uv-e.xy, _seed_variation_);
	rv += vec2(1.0, 1.0)*o104199_input_in(uv+e.xx, _seed_variation_);
	rv += vec2(-1.0, -1.0)*o104199_input_in(uv-e.xx, _seed_variation_);
	//rv += vec2(2.0, 0.0)*o104199_input_in(uv+e.xz, _seed_variation_);
	//rv += vec2(-2.0, 0.0)*o104199_input_in(uv-e.xz, _seed_variation_);
	//rv += vec2(0.0, 2.0)*o104199_input_in(uv+e.zx, _seed_variation_);
	//rv += vec2(0.0, -2.0)*o104199_input_in(uv-e.zx, _seed_variation_);
	return vec3(rv, 0.0);
}

void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec4 o104192_0_1_rgba = vec4(p_o104192_color_r, p_o104192_color_g, p_o104192_color_b, p_o104192_color_a);
vec4 o105290_0 = textureLod(texture_1, (uv), 0.0);
vec4 o104193_0_rch = splatter_o104193((uv), int(p_o104193_count), vec2(float(seed_o104193)), _seed_variation_);float o104193_0_1_f = o104193_0_rch.a;
vec3 o104190_0_false = clamp((vec4(vec3(o104193_0_1_f), 1.0).rgb-vec3(p_o104190_value))/max(0.0001, p_o104190_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o104190_0_true = vec3(1.0)-o104190_0_false;vec4 o104190_0_1_rgba = vec4(o104190_0_false, vec4(vec3(o104193_0_1_f), 1.0).a);
vec4 o104191_0_s1 = o104192_0_1_rgba;
vec4 o104191_0_s2 = o105290_0;
float o104191_0_a = p_o104191_amount*(dot((o104190_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o104191_0_1_rgba = vec4(blend_normal((uv), o104191_0_s1.rgb, o104191_0_s2.rgb, o104191_0_a*o104191_0_s1.a), min(1.0, o104191_0_s2.a+o104191_0_a*o104191_0_s1.a));
float o105295_0_1_f = p_o105295_color;
vec4 o105292_0 = textureLod(texture_4, (uv), 0.0);
vec4 o105294_0_s1 = vec4(vec3(o105295_0_1_f), 1.0);
vec4 o105294_0_s2 = o105292_0;
float o105294_0_a = p_o105294_amount*(dot((o104190_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o105294_0_1_rgba = vec4(blend_normal((uv), o105294_0_s1.rgb, o105294_0_s2.rgb, o105294_0_a*o105294_0_s1.a), min(1.0, o105294_0_s2.a+o105294_0_a*o105294_0_s1.a));
vec3 o104199_0_1_rgb = process_normal_opengl(o104199_fct((uv), _seed_variation_), p_o104199_amount*1024.000000000/128.0);
vec4 o105296_0 = textureLod(texture_5, (uv), 0.0);
vec4 o104189_0_s1 = vec4(o104199_0_1_rgb, 1.0);
vec4 o104189_0_s2 = o105296_0;
float o104189_0_a = p_o104189_amount*(dot((o104190_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o104189_0_1_rgba = vec4(blend_normal((uv), o104189_0_s1.rgb, o104189_0_s2.rgb, o104189_0_a*o104189_0_s1.a), min(1.0, o104189_0_s2.a+o104189_0_a*o104189_0_s1.a));

	vec3 albedo_tex = ((o104191_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o104184_albedo_color_r, p_o104184_albedo_color_g, p_o104184_albedo_color_b, p_o104184_albedo_color_a).rgb;
	METALLIC = 1.0*p_o104184_metallic;
	ROUGHNESS = (dot((o105294_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o104184_roughness;
	NORMAL = ((o104189_0_1_rgba).rgb);
	EMISSION = vec3(0.0)*p_o104184_emission_energy;

}



