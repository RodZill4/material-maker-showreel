shader_type spatial;
render_mode blend_mix,cull_back,diffuse_burley,specular_schlick_ggx
;
uniform vec3 uv1_offset = vec3(0.0, 0.0, 0.0);
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

const float o512488_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
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

const float o512551_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

const float o512325_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

const float o512422_speed = 8.0; // {default:0.5, label:Speed, max:1, min:0, name:speed, step:0.01, type:named_parameter}

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

const float p_o510949_albedo_color_r = 1.000000000;
const float p_o510949_albedo_color_g = 1.000000000;
const float p_o510949_albedo_color_b = 1.000000000;
const float p_o510949_albedo_color_a = 1.000000000;
const float p_o510949_metallic = 0.000000000;
const float p_o510949_roughness = 1.000000000;
const float p_o510949_emission_energy = 1.000000000;
const float p_o510949_normal = 1.000000000;
const float p_o510949_ao = 1.000000000;
const float p_o510949_depth_scale = 0.500000000;
float o510949_input_depth_tex(vec2 uv, float _seed_variation_) {

return 0.0;
}
const float p_o510956_amount = 1.000000000;
const float p_o510957_color_r = 0.082030997;
const float p_o510957_color_g = 0.082030997;
const float p_o510957_color_b = 0.082030997;
const float p_o510957_color_a = 1.000000000;
const float p_o510955_value = 0.010000000;
const float p_o510955_width = 0.000000000;
const float seed_o510958 = 27301.000000000;
const float p_o510958_count = 8.000000000;
const float p_o510958_scale_x = 1.000000000;
const float p_o510958_scale_y = 1.000000000;
const float p_o510958_rotate = 180.000000000;
const float p_o510958_scale = 0.100000000;
const float p_o510958_value = 0.000000000;
const float p_o510963_cx = 0.000000000;
const float p_o510963_cy = 0.000000000;
const float p_o510962_translate_x = 0.340000000;
const float p_o510962_translate_y = 0.000000000;
const float p_o510962_rotate = 0.000000000;
const float p_o510962_scale_x = 0.200000000;
const float p_o510962_scale_y = 0.200000000;
const float p_o510953_cx = 0.000000000;
const float p_o510953_cy = 0.000000000;
const float p_o510950_amount = 1.000000000;
const float p_o512646_default_in1 = 0.000000000;
const float p_o512646_default_in2 = 0.200000000;
const float p_o512645_default_in1 = 0.000000000;
const float p_o512645_default_in2 = 0.000000000;
const float p_o512309_default_in1 = 0.000000000;
const float p_o512309_default_in2 = 0.000000000;
const float p_o512308_default_in1 = 0.000000000;
const float p_o512308_default_in2 = 0.000000000;
const float p_o512635_ax = 0.085000000;
const float p_o512635_ay = -0.130000000;
const float p_o512635_bx = 0.320000000;
const float p_o512635_by = -0.260000000;
const float p_o512635_cx = 0.046000000;
const float p_o512635_cy = -0.410000000;
const float p_o512635_width = 0.050000000;
const float p_o512635_repeat = 1.000000000;
vec4 o512635_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
const float p_o512478_default_in1 = 0.000000000;
const float p_o512478_default_in2 = 0.010000000;
const float p_o512483_default_in1 = 0.000000000;
const float p_o512483_default_in2 = 6.280000000;
const float p_o512485_default_in1 = 0.000000000;
const float p_o512485_default_in2 = 0.500000000;
const float p_o512476_default_in1 = 0.500000000;
const float p_o512476_default_in2 = 0.000000000;
float o512635_input_bx_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512483_0_clamp_false = cos(o512485_0_1_f*p_o512483_default_in2);
float o512483_0_clamp_true = clamp(o512483_0_clamp_false, 0.0, 1.0);
float o512483_0_2_f = o512483_0_clamp_false;
float o512478_0_clamp_false = o512483_0_2_f*p_o512478_default_in2;
float o512478_0_clamp_true = clamp(o512478_0_clamp_false, 0.0, 1.0);
float o512478_0_2_f = o512478_0_clamp_false;

return o512478_0_2_f;
}
const float p_o512479_default_in1 = 0.000000000;
const float p_o512479_default_in2 = 0.010000000;
const float p_o512482_default_in1 = 0.000000000;
const float p_o512482_default_in2 = 6.280000000;
float o512635_input_by_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512482_0_clamp_false = sin(o512485_0_1_f*p_o512482_default_in2);
float o512482_0_clamp_true = clamp(o512482_0_clamp_false, 0.0, 1.0);
float o512482_0_2_f = o512482_0_clamp_false;
float o512479_0_clamp_false = o512482_0_2_f*p_o512479_default_in2;
float o512479_0_clamp_true = clamp(o512479_0_clamp_false, 0.0, 1.0);
float o512479_0_2_f = o512479_0_clamp_false;

return o512479_0_2_f;
}
const float p_o512481_default_in1 = 0.000000000;
const float p_o512481_default_in2 = 0.035000000;
float o512635_input_cx_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512483_0_clamp_false = cos(o512485_0_1_f*p_o512483_default_in2);
float o512483_0_clamp_true = clamp(o512483_0_clamp_false, 0.0, 1.0);
float o512483_0_2_f = o512483_0_clamp_false;
float o512481_0_clamp_false = o512483_0_2_f*p_o512481_default_in2;
float o512481_0_clamp_true = clamp(o512481_0_clamp_false, 0.0, 1.0);
float o512481_0_2_f = o512481_0_clamp_false;

return o512481_0_2_f;
}
const float p_o512480_default_in1 = 0.000000000;
const float p_o512480_default_in2 = 0.035000000;
float o512635_input_cy_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512482_0_clamp_false = sin(o512485_0_1_f*p_o512482_default_in2);
float o512482_0_clamp_true = clamp(o512482_0_clamp_false, 0.0, 1.0);
float o512482_0_2_f = o512482_0_clamp_false;
float o512480_0_clamp_false = o512482_0_2_f*p_o512480_default_in2;
float o512480_0_clamp_true = clamp(o512480_0_clamp_false, 0.0, 1.0);
float o512480_0_2_f = o512480_0_clamp_false;

return o512480_0_2_f;
}
const float p_o512636_ax = 0.120000000;
const float p_o512636_ay = 0.003300000;
const float p_o512636_bx = 0.340000000;
const float p_o512636_by = -0.126000000;
const float p_o512636_cx = 0.350000000;
const float p_o512636_cy = 0.120000000;
const float p_o512636_width = 0.050000000;
const float p_o512636_repeat = 1.000000000;
vec4 o512636_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
const float p_o512541_default_in1 = 0.000000000;
const float p_o512541_default_in2 = 0.010000000;
const float p_o512546_default_in1 = 0.000000000;
const float p_o512546_default_in2 = 6.280000000;
const float p_o512548_default_in1 = 0.000000000;
const float p_o512548_default_in2 = 0.500000000;
const float p_o512540_default_in1 = 0.000000000;
const float p_o512540_default_in2 = 0.500000000;
float o512636_input_bx_o(vec2 uv, float _seed_variation_) {
float o512539_0_clamp_false = fract((o512551_speed * elapsed_time / 2.0));
float o512539_0_clamp_true = clamp(o512539_0_clamp_false, 0.0, 1.0);
float o512539_0_2_f = o512539_0_clamp_false;
float o512540_0_clamp_false = (1.0-step(p_o512540_default_in2,o512539_0_2_f));
float o512540_0_clamp_true = clamp(o512540_0_clamp_false, 0.0, 1.0);
float o512540_0_2_f = o512540_0_clamp_false;
float o512547_0_clamp_false = fract((o512551_speed * elapsed_time));
float o512547_0_clamp_true = clamp(o512547_0_clamp_false, 0.0, 1.0);
float o512547_0_2_f = o512547_0_clamp_false;
float o512548_0_clamp_false = o512540_0_2_f*o512547_0_2_f;
float o512548_0_clamp_true = clamp(o512548_0_clamp_false, 0.0, 1.0);
float o512548_0_1_f = o512548_0_clamp_false;
float o512546_0_clamp_false = cos(o512548_0_1_f*p_o512546_default_in2);
float o512546_0_clamp_true = clamp(o512546_0_clamp_false, 0.0, 1.0);
float o512546_0_2_f = o512546_0_clamp_false;
float o512541_0_clamp_false = o512546_0_2_f*p_o512541_default_in2;
float o512541_0_clamp_true = clamp(o512541_0_clamp_false, 0.0, 1.0);
float o512541_0_2_f = o512541_0_clamp_false;

return o512541_0_2_f;
}
const float p_o512542_default_in1 = 0.000000000;
const float p_o512542_default_in2 = 0.010000000;
const float p_o512545_default_in1 = 0.000000000;
const float p_o512545_default_in2 = 6.280000000;
float o512636_input_by_o(vec2 uv, float _seed_variation_) {
float o512539_0_clamp_false = fract((o512551_speed * elapsed_time / 2.0));
float o512539_0_clamp_true = clamp(o512539_0_clamp_false, 0.0, 1.0);
float o512539_0_2_f = o512539_0_clamp_false;
float o512540_0_clamp_false = (1.0-step(p_o512540_default_in2,o512539_0_2_f));
float o512540_0_clamp_true = clamp(o512540_0_clamp_false, 0.0, 1.0);
float o512540_0_2_f = o512540_0_clamp_false;
float o512547_0_clamp_false = fract((o512551_speed * elapsed_time));
float o512547_0_clamp_true = clamp(o512547_0_clamp_false, 0.0, 1.0);
float o512547_0_2_f = o512547_0_clamp_false;
float o512548_0_clamp_false = o512540_0_2_f*o512547_0_2_f;
float o512548_0_clamp_true = clamp(o512548_0_clamp_false, 0.0, 1.0);
float o512548_0_1_f = o512548_0_clamp_false;
float o512545_0_clamp_false = sin(o512548_0_1_f*p_o512545_default_in2);
float o512545_0_clamp_true = clamp(o512545_0_clamp_false, 0.0, 1.0);
float o512545_0_2_f = o512545_0_clamp_false;
float o512542_0_clamp_false = o512545_0_2_f*p_o512542_default_in2;
float o512542_0_clamp_true = clamp(o512542_0_clamp_false, 0.0, 1.0);
float o512542_0_2_f = o512542_0_clamp_false;

return o512542_0_2_f;
}
const float p_o512544_default_in1 = 0.000000000;
const float p_o512544_default_in2 = 0.035000000;
float o512636_input_cx_o(vec2 uv, float _seed_variation_) {
float o512539_0_clamp_false = fract((o512551_speed * elapsed_time / 2.0));
float o512539_0_clamp_true = clamp(o512539_0_clamp_false, 0.0, 1.0);
float o512539_0_2_f = o512539_0_clamp_false;
float o512540_0_clamp_false = (1.0-step(p_o512540_default_in2,o512539_0_2_f));
float o512540_0_clamp_true = clamp(o512540_0_clamp_false, 0.0, 1.0);
float o512540_0_2_f = o512540_0_clamp_false;
float o512547_0_clamp_false = fract((o512551_speed * elapsed_time));
float o512547_0_clamp_true = clamp(o512547_0_clamp_false, 0.0, 1.0);
float o512547_0_2_f = o512547_0_clamp_false;
float o512548_0_clamp_false = o512540_0_2_f*o512547_0_2_f;
float o512548_0_clamp_true = clamp(o512548_0_clamp_false, 0.0, 1.0);
float o512548_0_1_f = o512548_0_clamp_false;
float o512546_0_clamp_false = cos(o512548_0_1_f*p_o512546_default_in2);
float o512546_0_clamp_true = clamp(o512546_0_clamp_false, 0.0, 1.0);
float o512546_0_2_f = o512546_0_clamp_false;
float o512544_0_clamp_false = o512546_0_2_f*p_o512544_default_in2;
float o512544_0_clamp_true = clamp(o512544_0_clamp_false, 0.0, 1.0);
float o512544_0_2_f = o512544_0_clamp_false;

return o512544_0_2_f;
}
const float p_o512543_default_in1 = 0.000000000;
const float p_o512543_default_in2 = 0.035000000;
float o512636_input_cy_o(vec2 uv, float _seed_variation_) {
float o512539_0_clamp_false = fract((o512551_speed * elapsed_time / 2.0));
float o512539_0_clamp_true = clamp(o512539_0_clamp_false, 0.0, 1.0);
float o512539_0_2_f = o512539_0_clamp_false;
float o512540_0_clamp_false = (1.0-step(p_o512540_default_in2,o512539_0_2_f));
float o512540_0_clamp_true = clamp(o512540_0_clamp_false, 0.0, 1.0);
float o512540_0_2_f = o512540_0_clamp_false;
float o512547_0_clamp_false = fract((o512551_speed * elapsed_time));
float o512547_0_clamp_true = clamp(o512547_0_clamp_false, 0.0, 1.0);
float o512547_0_2_f = o512547_0_clamp_false;
float o512548_0_clamp_false = o512540_0_2_f*o512547_0_2_f;
float o512548_0_clamp_true = clamp(o512548_0_clamp_false, 0.0, 1.0);
float o512548_0_1_f = o512548_0_clamp_false;
float o512545_0_clamp_false = sin(o512548_0_1_f*p_o512545_default_in2);
float o512545_0_clamp_true = clamp(o512545_0_clamp_false, 0.0, 1.0);
float o512545_0_2_f = o512545_0_clamp_false;
float o512543_0_clamp_false = o512545_0_2_f*p_o512543_default_in2;
float o512543_0_clamp_true = clamp(o512543_0_clamp_false, 0.0, 1.0);
float o512543_0_2_f = o512543_0_clamp_false;

return o512543_0_2_f;
}
const float p_o512644_ax = 0.050000000;
const float p_o512644_ay = 0.120000000;
const float p_o512644_bx = 0.390000000;
const float p_o512644_by = 0.150000000;
const float p_o512644_cx = 0.150000000;
const float p_o512644_cy = 0.420000000;
const float p_o512644_width = 0.050000000;
const float p_o512644_repeat = 1.000000000;
vec4 o512644_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
float o512644_input_bx_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512483_0_clamp_false = cos(o512485_0_1_f*p_o512483_default_in2);
float o512483_0_clamp_true = clamp(o512483_0_clamp_false, 0.0, 1.0);
float o512483_0_2_f = o512483_0_clamp_false;
float o512478_0_clamp_false = o512483_0_2_f*p_o512478_default_in2;
float o512478_0_clamp_true = clamp(o512478_0_clamp_false, 0.0, 1.0);
float o512478_0_2_f = o512478_0_clamp_false;

return o512478_0_2_f;
}
float o512644_input_by_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512482_0_clamp_false = sin(o512485_0_1_f*p_o512482_default_in2);
float o512482_0_clamp_true = clamp(o512482_0_clamp_false, 0.0, 1.0);
float o512482_0_2_f = o512482_0_clamp_false;
float o512479_0_clamp_false = o512482_0_2_f*p_o512479_default_in2;
float o512479_0_clamp_true = clamp(o512479_0_clamp_false, 0.0, 1.0);
float o512479_0_2_f = o512479_0_clamp_false;

return o512479_0_2_f;
}
float o512644_input_cx_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512483_0_clamp_false = cos(o512485_0_1_f*p_o512483_default_in2);
float o512483_0_clamp_true = clamp(o512483_0_clamp_false, 0.0, 1.0);
float o512483_0_2_f = o512483_0_clamp_false;
float o512481_0_clamp_false = o512483_0_2_f*p_o512481_default_in2;
float o512481_0_clamp_true = clamp(o512481_0_clamp_false, 0.0, 1.0);
float o512481_0_2_f = o512481_0_clamp_false;

return o512481_0_2_f;
}
float o512644_input_cy_o(vec2 uv, float _seed_variation_) {
float o512477_0_clamp_false = fract((o512488_speed * elapsed_time / 2.0));
float o512477_0_clamp_true = clamp(o512477_0_clamp_false, 0.0, 1.0);
float o512477_0_2_f = o512477_0_clamp_false;
float o512476_0_clamp_false = (1.0-step(o512477_0_2_f,p_o512476_default_in1));
float o512476_0_clamp_true = clamp(o512476_0_clamp_false, 0.0, 1.0);
float o512476_0_2_f = o512476_0_clamp_false;
float o512484_0_clamp_false = fract((o512488_speed * elapsed_time));
float o512484_0_clamp_true = clamp(o512484_0_clamp_false, 0.0, 1.0);
float o512484_0_2_f = o512484_0_clamp_false;
float o512485_0_clamp_false = o512476_0_2_f*o512484_0_2_f;
float o512485_0_clamp_true = clamp(o512485_0_clamp_false, 0.0, 1.0);
float o512485_0_1_f = o512485_0_clamp_false;
float o512482_0_clamp_false = sin(o512485_0_1_f*p_o512482_default_in2);
float o512482_0_clamp_true = clamp(o512482_0_clamp_false, 0.0, 1.0);
float o512482_0_2_f = o512482_0_clamp_false;
float o512480_0_clamp_false = o512482_0_2_f*p_o512480_default_in2;
float o512480_0_clamp_true = clamp(o512480_0_clamp_false, 0.0, 1.0);
float o512480_0_2_f = o512480_0_clamp_false;

return o512480_0_2_f;
}
const float p_o512310_default_in1 = 0.000000000;
const float p_o512310_default_in2 = 0.000000000;
const float p_o512311_default_in1 = 0.000000000;
const float p_o512311_default_in2 = 0.000000000;
const float p_o512472_ax = -0.085000000;
const float p_o512472_ay = -0.130000000;
const float p_o512472_bx = -0.320000000;
const float p_o512472_by = -0.260000000;
const float p_o512472_cx = -0.046000000;
const float p_o512472_cy = -0.410000000;
const float p_o512472_width = 0.050000000;
const float p_o512472_repeat = 1.000000000;
vec4 o512472_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
const float p_o512315_default_in1 = 0.000000000;
const float p_o512315_default_in2 = 0.010000000;
const float p_o512320_default_in1 = 0.000000000;
const float p_o512320_default_in2 = 6.280000000;
const float p_o512322_default_in1 = 0.000000000;
const float p_o512322_default_in2 = 0.500000000;
const float p_o512314_default_in1 = 0.000000000;
const float p_o512314_default_in2 = 0.500000000;
float o512472_input_bx_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512320_0_clamp_false = cos(o512322_0_1_f*p_o512320_default_in2);
float o512320_0_clamp_true = clamp(o512320_0_clamp_false, 0.0, 1.0);
float o512320_0_2_f = o512320_0_clamp_false;
float o512315_0_clamp_false = o512320_0_2_f*p_o512315_default_in2;
float o512315_0_clamp_true = clamp(o512315_0_clamp_false, 0.0, 1.0);
float o512315_0_2_f = o512315_0_clamp_false;

return o512315_0_2_f;
}
const float p_o512316_default_in1 = 0.000000000;
const float p_o512316_default_in2 = 0.010000000;
const float p_o512319_default_in1 = 0.000000000;
const float p_o512319_default_in2 = 6.280000000;
float o512472_input_by_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512319_0_clamp_false = sin(o512322_0_1_f*p_o512319_default_in2);
float o512319_0_clamp_true = clamp(o512319_0_clamp_false, 0.0, 1.0);
float o512319_0_2_f = o512319_0_clamp_false;
float o512316_0_clamp_false = o512319_0_2_f*p_o512316_default_in2;
float o512316_0_clamp_true = clamp(o512316_0_clamp_false, 0.0, 1.0);
float o512316_0_2_f = o512316_0_clamp_false;

return o512316_0_2_f;
}
const float p_o512318_default_in1 = 0.000000000;
const float p_o512318_default_in2 = 0.035000000;
float o512472_input_cx_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512320_0_clamp_false = cos(o512322_0_1_f*p_o512320_default_in2);
float o512320_0_clamp_true = clamp(o512320_0_clamp_false, 0.0, 1.0);
float o512320_0_2_f = o512320_0_clamp_false;
float o512318_0_clamp_false = o512320_0_2_f*p_o512318_default_in2;
float o512318_0_clamp_true = clamp(o512318_0_clamp_false, 0.0, 1.0);
float o512318_0_2_f = o512318_0_clamp_false;

return o512318_0_2_f;
}
const float p_o512317_default_in1 = 0.000000000;
const float p_o512317_default_in2 = 0.035000000;
float o512472_input_cy_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512319_0_clamp_false = sin(o512322_0_1_f*p_o512319_default_in2);
float o512319_0_clamp_true = clamp(o512319_0_clamp_false, 0.0, 1.0);
float o512319_0_2_f = o512319_0_clamp_false;
float o512317_0_clamp_false = o512319_0_2_f*p_o512317_default_in2;
float o512317_0_clamp_true = clamp(o512317_0_clamp_false, 0.0, 1.0);
float o512317_0_2_f = o512317_0_clamp_false;

return o512317_0_2_f;
}
const float p_o512474_ax = -0.120000000;
const float p_o512474_ay = 0.003300000;
const float p_o512474_bx = -0.340000000;
const float p_o512474_by = -0.126000000;
const float p_o512474_cx = -0.350000000;
const float p_o512474_cy = 0.120000000;
const float p_o512474_width = 0.050000000;
const float p_o512474_repeat = 1.000000000;
vec4 o512474_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
const float p_o512412_default_in1 = 0.000000000;
const float p_o512412_default_in2 = 0.010000000;
const float p_o512417_default_in1 = 0.000000000;
const float p_o512417_default_in2 = 6.280000000;
const float p_o512419_default_in1 = 0.000000000;
const float p_o512419_default_in2 = 0.500000000;
const float p_o512410_default_in1 = 0.500000000;
const float p_o512410_default_in2 = 0.000000000;
float o512474_input_bx_o(vec2 uv, float _seed_variation_) {
float o512411_0_clamp_false = fract((o512422_speed * elapsed_time / 2.0));
float o512411_0_clamp_true = clamp(o512411_0_clamp_false, 0.0, 1.0);
float o512411_0_2_f = o512411_0_clamp_false;
float o512410_0_clamp_false = (1.0-step(o512411_0_2_f,p_o512410_default_in1));
float o512410_0_clamp_true = clamp(o512410_0_clamp_false, 0.0, 1.0);
float o512410_0_2_f = o512410_0_clamp_false;
float o512418_0_clamp_false = fract((o512422_speed * -elapsed_time));
float o512418_0_clamp_true = clamp(o512418_0_clamp_false, 0.0, 1.0);
float o512418_0_2_f = o512418_0_clamp_false;
float o512419_0_clamp_false = o512410_0_2_f*o512418_0_2_f;
float o512419_0_clamp_true = clamp(o512419_0_clamp_false, 0.0, 1.0);
float o512419_0_1_f = o512419_0_clamp_false;
float o512417_0_clamp_false = cos(o512419_0_1_f*p_o512417_default_in2);
float o512417_0_clamp_true = clamp(o512417_0_clamp_false, 0.0, 1.0);
float o512417_0_2_f = o512417_0_clamp_false;
float o512412_0_clamp_false = o512417_0_2_f*p_o512412_default_in2;
float o512412_0_clamp_true = clamp(o512412_0_clamp_false, 0.0, 1.0);
float o512412_0_2_f = o512412_0_clamp_false;

return o512412_0_2_f;
}
const float p_o512413_default_in1 = 0.000000000;
const float p_o512413_default_in2 = 0.010000000;
const float p_o512416_default_in1 = 0.000000000;
const float p_o512416_default_in2 = 6.280000000;
float o512474_input_by_o(vec2 uv, float _seed_variation_) {
float o512411_0_clamp_false = fract((o512422_speed * elapsed_time / 2.0));
float o512411_0_clamp_true = clamp(o512411_0_clamp_false, 0.0, 1.0);
float o512411_0_2_f = o512411_0_clamp_false;
float o512410_0_clamp_false = (1.0-step(o512411_0_2_f,p_o512410_default_in1));
float o512410_0_clamp_true = clamp(o512410_0_clamp_false, 0.0, 1.0);
float o512410_0_2_f = o512410_0_clamp_false;
float o512418_0_clamp_false = fract((o512422_speed * -elapsed_time));
float o512418_0_clamp_true = clamp(o512418_0_clamp_false, 0.0, 1.0);
float o512418_0_2_f = o512418_0_clamp_false;
float o512419_0_clamp_false = o512410_0_2_f*o512418_0_2_f;
float o512419_0_clamp_true = clamp(o512419_0_clamp_false, 0.0, 1.0);
float o512419_0_1_f = o512419_0_clamp_false;
float o512416_0_clamp_false = sin(o512419_0_1_f*p_o512416_default_in2);
float o512416_0_clamp_true = clamp(o512416_0_clamp_false, 0.0, 1.0);
float o512416_0_2_f = o512416_0_clamp_false;
float o512413_0_clamp_false = o512416_0_2_f*p_o512413_default_in2;
float o512413_0_clamp_true = clamp(o512413_0_clamp_false, 0.0, 1.0);
float o512413_0_2_f = o512413_0_clamp_false;

return o512413_0_2_f;
}
const float p_o512415_default_in1 = 0.000000000;
const float p_o512415_default_in2 = 0.035000000;
float o512474_input_cx_o(vec2 uv, float _seed_variation_) {
float o512411_0_clamp_false = fract((o512422_speed * elapsed_time / 2.0));
float o512411_0_clamp_true = clamp(o512411_0_clamp_false, 0.0, 1.0);
float o512411_0_2_f = o512411_0_clamp_false;
float o512410_0_clamp_false = (1.0-step(o512411_0_2_f,p_o512410_default_in1));
float o512410_0_clamp_true = clamp(o512410_0_clamp_false, 0.0, 1.0);
float o512410_0_2_f = o512410_0_clamp_false;
float o512418_0_clamp_false = fract((o512422_speed * -elapsed_time));
float o512418_0_clamp_true = clamp(o512418_0_clamp_false, 0.0, 1.0);
float o512418_0_2_f = o512418_0_clamp_false;
float o512419_0_clamp_false = o512410_0_2_f*o512418_0_2_f;
float o512419_0_clamp_true = clamp(o512419_0_clamp_false, 0.0, 1.0);
float o512419_0_1_f = o512419_0_clamp_false;
float o512417_0_clamp_false = cos(o512419_0_1_f*p_o512417_default_in2);
float o512417_0_clamp_true = clamp(o512417_0_clamp_false, 0.0, 1.0);
float o512417_0_2_f = o512417_0_clamp_false;
float o512415_0_clamp_false = o512417_0_2_f*p_o512415_default_in2;
float o512415_0_clamp_true = clamp(o512415_0_clamp_false, 0.0, 1.0);
float o512415_0_2_f = o512415_0_clamp_false;

return o512415_0_2_f;
}
const float p_o512414_default_in1 = 0.000000000;
const float p_o512414_default_in2 = 0.035000000;
float o512474_input_cy_o(vec2 uv, float _seed_variation_) {
float o512411_0_clamp_false = fract((o512422_speed * elapsed_time / 2.0));
float o512411_0_clamp_true = clamp(o512411_0_clamp_false, 0.0, 1.0);
float o512411_0_2_f = o512411_0_clamp_false;
float o512410_0_clamp_false = (1.0-step(o512411_0_2_f,p_o512410_default_in1));
float o512410_0_clamp_true = clamp(o512410_0_clamp_false, 0.0, 1.0);
float o512410_0_2_f = o512410_0_clamp_false;
float o512418_0_clamp_false = fract((o512422_speed * -elapsed_time));
float o512418_0_clamp_true = clamp(o512418_0_clamp_false, 0.0, 1.0);
float o512418_0_2_f = o512418_0_clamp_false;
float o512419_0_clamp_false = o512410_0_2_f*o512418_0_2_f;
float o512419_0_clamp_true = clamp(o512419_0_clamp_false, 0.0, 1.0);
float o512419_0_1_f = o512419_0_clamp_false;
float o512416_0_clamp_false = sin(o512419_0_1_f*p_o512416_default_in2);
float o512416_0_clamp_true = clamp(o512416_0_clamp_false, 0.0, 1.0);
float o512416_0_2_f = o512416_0_clamp_false;
float o512414_0_clamp_false = o512416_0_2_f*p_o512414_default_in2;
float o512414_0_clamp_true = clamp(o512414_0_clamp_false, 0.0, 1.0);
float o512414_0_2_f = o512414_0_clamp_false;

return o512414_0_2_f;
}
const float p_o512473_ax = -0.050000000;
const float p_o512473_ay = 0.120000000;
const float p_o512473_bx = -0.390000000;
const float p_o512473_by = 0.150000000;
const float p_o512473_cx = -0.150000000;
const float p_o512473_cy = 0.420000000;
const float p_o512473_width = 0.050000000;
const float p_o512473_repeat = 1.000000000;
vec4 o512473_input_in(vec2 uv, float _seed_variation_) {
vec4 o512637_0 = textureLod(texture_3, uv, 0.0);

return o512637_0;
}
float o512473_input_bx_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512320_0_clamp_false = cos(o512322_0_1_f*p_o512320_default_in2);
float o512320_0_clamp_true = clamp(o512320_0_clamp_false, 0.0, 1.0);
float o512320_0_2_f = o512320_0_clamp_false;
float o512315_0_clamp_false = o512320_0_2_f*p_o512315_default_in2;
float o512315_0_clamp_true = clamp(o512315_0_clamp_false, 0.0, 1.0);
float o512315_0_2_f = o512315_0_clamp_false;

return o512315_0_2_f;
}
float o512473_input_by_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512319_0_clamp_false = sin(o512322_0_1_f*p_o512319_default_in2);
float o512319_0_clamp_true = clamp(o512319_0_clamp_false, 0.0, 1.0);
float o512319_0_2_f = o512319_0_clamp_false;
float o512316_0_clamp_false = o512319_0_2_f*p_o512316_default_in2;
float o512316_0_clamp_true = clamp(o512316_0_clamp_false, 0.0, 1.0);
float o512316_0_2_f = o512316_0_clamp_false;

return o512316_0_2_f;
}
float o512473_input_cx_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512320_0_clamp_false = cos(o512322_0_1_f*p_o512320_default_in2);
float o512320_0_clamp_true = clamp(o512320_0_clamp_false, 0.0, 1.0);
float o512320_0_2_f = o512320_0_clamp_false;
float o512318_0_clamp_false = o512320_0_2_f*p_o512318_default_in2;
float o512318_0_clamp_true = clamp(o512318_0_clamp_false, 0.0, 1.0);
float o512318_0_2_f = o512318_0_clamp_false;

return o512318_0_2_f;
}
float o512473_input_cy_o(vec2 uv, float _seed_variation_) {
float o512313_0_clamp_false = fract((o512325_speed * elapsed_time / 2.0));
float o512313_0_clamp_true = clamp(o512313_0_clamp_false, 0.0, 1.0);
float o512313_0_2_f = o512313_0_clamp_false;
float o512314_0_clamp_false = (1.0-step(p_o512314_default_in2,o512313_0_2_f));
float o512314_0_clamp_true = clamp(o512314_0_clamp_false, 0.0, 1.0);
float o512314_0_2_f = o512314_0_clamp_false;
float o512321_0_clamp_false = fract((o512325_speed * -elapsed_time));
float o512321_0_clamp_true = clamp(o512321_0_clamp_false, 0.0, 1.0);
float o512321_0_2_f = o512321_0_clamp_false;
float o512322_0_clamp_false = o512314_0_2_f*o512321_0_2_f;
float o512322_0_clamp_true = clamp(o512322_0_clamp_false, 0.0, 1.0);
float o512322_0_1_f = o512322_0_clamp_false;
float o512319_0_clamp_false = sin(o512322_0_1_f*p_o512319_default_in2);
float o512319_0_clamp_true = clamp(o512319_0_clamp_false, 0.0, 1.0);
float o512319_0_2_f = o512319_0_clamp_false;
float o512317_0_clamp_false = o512319_0_2_f*p_o512317_default_in2;
float o512317_0_clamp_true = clamp(o512317_0_clamp_false, 0.0, 1.0);
float o512317_0_2_f = o512317_0_clamp_false;

return o512317_0_2_f;
}
float o510958_input_in(vec2 uv, float _seed_variation_) {
vec2 o510963_0_c = vec2(0.5+p_o510963_cx, 0.5+p_o510963_cy);vec2 o510953_0_c = vec2(0.5+p_o510953_cx, 0.5+p_o510953_cy);vec4 o510951_0 = textureLod(texture_2, (rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), 0.0);
vec2 o512635_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512635_ax+0.5, p_o512635_ay+0.5), vec2(p_o512635_bx+0.5+o512635_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512635_by+0.5+o512635_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512635_cx+0.5+o512635_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512635_cy+0.5+o512635_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512635_0_uv = vec2(o512635_0_bezier.x, o512635_0_bezier.y/p_o512635_width+0.5);
vec2 o512635_0_uvtest = step(vec2(0.5), abs(o512635_0_uv-vec2(0.5)));
o512635_0_uv = mix(vec2(fract(p_o512635_repeat*o512635_0_uv.x), o512635_0_uv.y), vec2(0.0), max(o512635_0_uvtest.x, o512635_0_uvtest.y));
vec4 o512635_0_1_rgba = o512635_input_in(o512635_0_uv, _seed_variation_);
vec2 o512636_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512636_ax+0.5, p_o512636_ay+0.5), vec2(p_o512636_bx+0.5+o512636_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512636_by+0.5+o512636_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512636_cx+0.5+o512636_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512636_cy+0.5+o512636_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512636_0_uv = vec2(o512636_0_bezier.x, o512636_0_bezier.y/p_o512636_width+0.5);
vec2 o512636_0_uvtest = step(vec2(0.5), abs(o512636_0_uv-vec2(0.5)));
o512636_0_uv = mix(vec2(fract(p_o512636_repeat*o512636_0_uv.x), o512636_0_uv.y), vec2(0.0), max(o512636_0_uvtest.x, o512636_0_uvtest.y));
vec4 o512636_0_1_rgba = o512636_input_in(o512636_0_uv, _seed_variation_);
float o512308_0_clamp_false = max((dot((o512635_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o512636_0_1_rgba).rgb, vec3(1.0))/3.0));
float o512308_0_clamp_true = clamp(o512308_0_clamp_false, 0.0, 1.0);
float o512308_0_1_f = o512308_0_clamp_true;
vec2 o512644_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512644_ax+0.5, p_o512644_ay+0.5), vec2(p_o512644_bx+0.5+o512644_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512644_by+0.5+o512644_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512644_cx+0.5+o512644_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512644_cy+0.5+o512644_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512644_0_uv = vec2(o512644_0_bezier.x, o512644_0_bezier.y/p_o512644_width+0.5);
vec2 o512644_0_uvtest = step(vec2(0.5), abs(o512644_0_uv-vec2(0.5)));
o512644_0_uv = mix(vec2(fract(p_o512644_repeat*o512644_0_uv.x), o512644_0_uv.y), vec2(0.0), max(o512644_0_uvtest.x, o512644_0_uvtest.y));
vec4 o512644_0_1_rgba = o512644_input_in(o512644_0_uv, _seed_variation_);
float o512309_0_clamp_false = max(o512308_0_1_f,(dot((o512644_0_1_rgba).rgb, vec3(1.0))/3.0));
float o512309_0_clamp_true = clamp(o512309_0_clamp_false, 0.0, 1.0);
float o512309_0_1_f = o512309_0_clamp_true;
vec2 o512472_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512472_ax+0.5, p_o512472_ay+0.5), vec2(p_o512472_bx+0.5+o512472_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512472_by+0.5+o512472_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512472_cx+0.5+o512472_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512472_cy+0.5+o512472_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512472_0_uv = vec2(o512472_0_bezier.x, o512472_0_bezier.y/p_o512472_width+0.5);
vec2 o512472_0_uvtest = step(vec2(0.5), abs(o512472_0_uv-vec2(0.5)));
o512472_0_uv = mix(vec2(fract(p_o512472_repeat*o512472_0_uv.x), o512472_0_uv.y), vec2(0.0), max(o512472_0_uvtest.x, o512472_0_uvtest.y));
vec4 o512472_0_1_rgba = o512472_input_in(o512472_0_uv, _seed_variation_);
vec2 o512474_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512474_ax+0.5, p_o512474_ay+0.5), vec2(p_o512474_bx+0.5+o512474_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512474_by+0.5+o512474_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512474_cx+0.5+o512474_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512474_cy+0.5+o512474_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512474_0_uv = vec2(o512474_0_bezier.x, o512474_0_bezier.y/p_o512474_width+0.5);
vec2 o512474_0_uvtest = step(vec2(0.5), abs(o512474_0_uv-vec2(0.5)));
o512474_0_uv = mix(vec2(fract(p_o512474_repeat*o512474_0_uv.x), o512474_0_uv.y), vec2(0.0), max(o512474_0_uvtest.x, o512474_0_uvtest.y));
vec4 o512474_0_1_rgba = o512474_input_in(o512474_0_uv, _seed_variation_);
float o512311_0_clamp_false = max((dot((o512472_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o512474_0_1_rgba).rgb, vec3(1.0))/3.0));
float o512311_0_clamp_true = clamp(o512311_0_clamp_false, 0.0, 1.0);
float o512311_0_1_f = o512311_0_clamp_true;
vec2 o512473_0_bezier = sdBezier((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), vec2(p_o512473_ax+0.5, p_o512473_ay+0.5), vec2(p_o512473_bx+0.5+o512473_input_bx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512473_by+0.5+o512473_input_by_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)), vec2(p_o512473_cx+0.5+o512473_input_cx_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_), p_o512473_cy+0.5+o512473_input_cy_o((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), _seed_variation_)));
vec2 o512473_0_uv = vec2(o512473_0_bezier.x, o512473_0_bezier.y/p_o512473_width+0.5);
vec2 o512473_0_uvtest = step(vec2(0.5), abs(o512473_0_uv-vec2(0.5)));
o512473_0_uv = mix(vec2(fract(p_o512473_repeat*o512473_0_uv.x), o512473_0_uv.y), vec2(0.0), max(o512473_0_uvtest.x, o512473_0_uvtest.y));
vec4 o512473_0_1_rgba = o512473_input_in(o512473_0_uv, _seed_variation_);
float o512310_0_clamp_false = max(o512311_0_1_f,(dot((o512473_0_1_rgba).rgb, vec3(1.0))/3.0));
float o512310_0_clamp_true = clamp(o512310_0_clamp_false, 0.0, 1.0);
float o512310_0_1_f = o512310_0_clamp_true;
float o512645_0_clamp_false = max(o512309_0_1_f,o512310_0_1_f);
float o512645_0_clamp_true = clamp(o512645_0_clamp_false, 0.0, 1.0);
float o512645_0_1_f = o512645_0_clamp_true;
float o512646_0_clamp_false = o512645_0_1_f*p_o512646_default_in2;
float o512646_0_clamp_true = clamp(o512646_0_clamp_false, 0.0, 1.0);
float o512646_0_2_f = o512646_0_clamp_false;
vec4 o510950_0_s1 = o510951_0;
vec4 o510950_0_s2 = vec4(vec3(o512646_0_2_f), 1.0);
float o510950_0_a = p_o510950_amount*1.0;
vec4 o510950_0_2_rgba = vec4(blend_lighten((rotate((transform2_clamp(transform2((rotate((uv)-o510963_0_c, (-elapsed_time * 80.0)*0.01745329251)+o510963_0_c), vec2(p_o510962_translate_x*(2.0*1.0-1.0), p_o510962_translate_y*(2.0*1.0-1.0)), p_o510962_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o510962_scale_x*(2.0*1.0-1.0), p_o510962_scale_y*(2.0*1.0-1.0)))))-o510953_0_c, (-sin(elapsed_time * 3.14 * 8.0) * 4.0)*0.01745329251)+o510953_0_c), o510950_0_s1.rgb, o510950_0_s2.rgb, o510950_0_a*o510950_0_s1.a), min(1.0, o510950_0_s2.a+o510950_0_a*o510950_0_s1.a));
vec4 o510953_0_1_rgba = o510950_0_2_rgba;
vec4 o510962_0_1_rgba = o510953_0_1_rgba;
vec4 o510963_0_1_rgba = o510962_0_1_rgba;

return (dot((o510963_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o510958_input_mask(vec2 uv, float _seed_variation_) {

return 1.0;
}
vec4 splatter_o510958(vec2 uv, int count, vec2 seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int i = 0; i < count; ++i) {
		seed = rand2(seed);
		rc1 = rand3(seed);
		float mask = o510958_input_mask(fract(seed+vec2(0.5)), _seed_variation_);
		if (mask > 0.01) {
			vec2 pv = fract(uv - seed)-vec2(0.5);
			seed = rand2(seed);
			float angle = (seed.x * 2.0 - 1.0) * p_o510958_rotate * 0.01745329251;
			float ca = cos(angle);
			float sa = sin(angle);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv *= (seed.y-0.5)*2.0*p_o510958_scale+1.0;
			pv /= vec2(p_o510958_scale_x, p_o510958_scale_y);
			pv += vec2(0.5);
			seed = rand2(seed);
			if (pv != clamp(pv, vec2(0.0), vec2(1.0))) {
				continue;
			}
			 
			float c1 = o510958_input_in(pv, _seed_variation_)*mask*(1.0-p_o510958_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
		}
	}
	return vec4(rc, c);
}
const float p_o512038_amount = 1.000000000;
const float p_o512039_color = 0.100000000;
const float p_o510954_amount = 1.000000000;
const float p_o510964_amount = 2.000000000;
float o510964_input_in(vec2 uv, float _seed_variation_) {
vec4 o510958_0_rch = splatter_o510958((uv), int(p_o510958_count), vec2(float(seed_o510958)), _seed_variation_);float o510958_0_1_f = o510958_0_rch.a;

return o510958_0_1_f;
}
vec3 o510964_fct(vec2 uv, float _seed_variation_) {
	vec3 e = vec3(1.0/1024.000000000, -1.0/1024.000000000, 0);
	vec2 rv = vec2(1.0, -1.0)*o510964_input_in(uv+e.xy, _seed_variation_);
	rv += vec2(-1.0, 1.0)*o510964_input_in(uv-e.xy, _seed_variation_);
	rv += vec2(1.0, 1.0)*o510964_input_in(uv+e.xx, _seed_variation_);
	rv += vec2(-1.0, -1.0)*o510964_input_in(uv-e.xx, _seed_variation_);
	//rv += vec2(2.0, 0.0)*o510964_input_in(uv+e.xz, _seed_variation_);
	//rv += vec2(-2.0, 0.0)*o510964_input_in(uv-e.xz, _seed_variation_);
	//rv += vec2(0.0, 2.0)*o510964_input_in(uv+e.zx, _seed_variation_);
	//rv += vec2(0.0, -2.0)*o510964_input_in(uv-e.zx, _seed_variation_);
	return vec3(rv, 0.0);
}

void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec4 o510957_0_1_rgba = vec4(p_o510957_color_r, p_o510957_color_g, p_o510957_color_b, p_o510957_color_a);
vec4 o512034_0 = textureLod(texture_1, (uv), 0.0);
vec4 o510958_0_rch = splatter_o510958((uv), int(p_o510958_count), vec2(float(seed_o510958)), _seed_variation_);float o510958_0_1_f = o510958_0_rch.a;
vec3 o510955_0_false = clamp((vec4(vec3(o510958_0_1_f), 1.0).rgb-vec3(p_o510955_value))/max(0.0001, p_o510955_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o510955_0_true = vec3(1.0)-o510955_0_false;vec4 o510955_0_1_rgba = vec4(o510955_0_false, vec4(vec3(o510958_0_1_f), 1.0).a);
vec4 o510956_0_s1 = o510957_0_1_rgba;
vec4 o510956_0_s2 = o512034_0;
float o510956_0_a = p_o510956_amount*(dot((o510955_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o510956_0_1_rgba = vec4(blend_normal((uv), o510956_0_s1.rgb, o510956_0_s2.rgb, o510956_0_a*o510956_0_s1.a), min(1.0, o510956_0_s2.a+o510956_0_a*o510956_0_s1.a));
float o512039_0_1_f = p_o512039_color;
vec4 o512036_0 = textureLod(texture_4, (uv), 0.0);
vec4 o512038_0_s1 = vec4(vec3(o512039_0_1_f), 1.0);
vec4 o512038_0_s2 = o512036_0;
float o512038_0_a = p_o512038_amount*(dot((o510955_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o512038_0_1_rgba = vec4(blend_normal((uv), o512038_0_s1.rgb, o512038_0_s2.rgb, o512038_0_a*o512038_0_s1.a), min(1.0, o512038_0_s2.a+o512038_0_a*o512038_0_s1.a));
vec3 o510964_0_1_rgb = process_normal_opengl(o510964_fct((uv), _seed_variation_), p_o510964_amount*1024.000000000/128.0);
vec4 o512040_0 = textureLod(texture_5, (uv), 0.0);
vec4 o510954_0_s1 = vec4(o510964_0_1_rgb, 1.0);
vec4 o510954_0_s2 = o512040_0;
float o510954_0_a = p_o510954_amount*(dot((o510955_0_1_rgba).rgb, vec3(1.0))/3.0);
vec4 o510954_0_1_rgba = vec4(blend_normal((uv), o510954_0_s1.rgb, o510954_0_s2.rgb, o510954_0_a*o510954_0_s1.a), min(1.0, o510954_0_s2.a+o510954_0_a*o510954_0_s1.a));

	vec3 albedo_tex = ((o510956_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o510949_albedo_color_r, p_o510949_albedo_color_g, p_o510949_albedo_color_b, p_o510949_albedo_color_a).rgb;
	METALLIC = 1.0*p_o510949_metallic;
	ROUGHNESS = (dot((o512038_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o510949_roughness;
	NORMAL = ((o510954_0_1_rgba).rgb);
	EMISSION = vec3(0.0)*p_o510949_emission_energy;

}



