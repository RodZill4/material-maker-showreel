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
const float texture_1_size = 512.0;

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
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
    return rv;	
}
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
float sd_box(vec2 uv, vec2 size) {
	vec2 d = abs(uv)-size;
	return length(max(d, vec2(0)))+min(max(d.x, d.y), 0.0);
}
float sdSmoothUnion( float d1, float d2, float k ) {
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h); }

float sdSmoothSubtraction( float d1, float d2, float k ) {
    float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
    return mix( d2, -d1, h ) + k*h*(1.0-h); }

float sdSmoothIntersection( float d1, float d2, float k ) {
    float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) + k*h*(1.0-h); }

float beehive_dist(vec2 p){
	vec2 s = vec2(1.0, 1.73205080757);
    p = abs(p);
    return max(dot(p, s*.5), p.x);
}

vec4 beehive_center(vec2 p) {
	vec2 s = vec2(1.0, 1.73205080757);
    vec4 hC = floor(vec4(p, p - vec2(.5, 1))/vec4(s,s)) + .5;
    vec4 h = vec4(p - hC.xy*s, p - (hC.zw + .5)*s);
    return dot(h.xy, h.xy)<dot(h.zw, h.zw) ? vec4(h.xy, hC.xy) : vec4(h.zw, hC.zw + 9.73);
}

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
vec3 process_normal_default(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, -1.0))+vec3(0.5);
}

vec3 process_normal_opengl(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}

vec3 process_normal_directx(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*vec3(1.0, -1.0, 1.0)*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}

const float p_o348103_albedo_color_r = 1.000000000;
const float p_o348103_albedo_color_g = 1.000000000;
const float p_o348103_albedo_color_b = 1.000000000;
const float p_o348103_albedo_color_a = 1.000000000;
const float p_o348103_metallic = 1.000000000;
const float p_o348103_roughness = 1.000000000;
const float p_o348103_emission_energy = 1.000000000;
const float p_o348103_normal = 1.000000000;
const float p_o348103_ao = 1.000000000;
const float p_o348103_depth_scale = 0.200000000;
const float p_o348215_default_in1 = 0.000000000;
const float p_o348215_default_in2 = 0.000000000;
const float p_o348265_default_in1 = 0.000000000;
const float p_o348265_default_in2 = 0.000000000;
const float p_o348246_default_in1 = 0.000000000;
const float p_o348246_default_in2 = 0.000000000;
const float p_o348214_default_in1 = 0.000000000;
const float p_o348214_default_in2 = 0.800000000;
const float p_o348211_default_in1 = 0.000000000;
const float p_o348211_default_in2 = 0.000000000;
const float p_o348245_default_in1 = 0.000000000;
const float p_o348245_default_in2 = 0.000000000;
const float p_o348213_translate_x = 0.135000000;
const float p_o348213_translate_y = -0.335000000;
const float p_o348212_cx = 0.000000000;
const float p_o348212_cy = 0.000000000;
const float p_o348263_translate_x = 0.000000000;
const float p_o348263_translate_y = 0.000000000;
const float p_o348263_rotate = 0.000000000;
const float p_o348263_scale_x = 1.000000000;
const float p_o348263_scale_y = 1.000000000;
const float p_o348243_translate_x = -0.309000000;
const float p_o348243_translate_y = 0.421000000;
const float p_o348244_cx = 0.000000000;
const float p_o348244_cy = 0.000000000;
const float p_o348210_value = 0.500000000;
const float p_o348210_width = 0.030000000;
const float p_o348107_bevel = 0.150000000;
const float p_o348106_k = 0.070000000;
const float p_o348104_w = 0.300000000;
const float p_o348104_h = 0.290000000;
const float p_o348104_cx = 0.000000000;
const float p_o348104_cy = 0.000000000;
const float p_o348105_r = 0.574303000;
const float p_o348105_cx = -0.282000000;
const float p_o348105_cy = -0.186000000;
const float p_o348108_gradient_0_pos = 0.000000000;
const float p_o348108_gradient_0_r = 0.000000000;
const float p_o348108_gradient_0_g = 0.000000000;
const float p_o348108_gradient_0_b = 0.000000000;
const float p_o348108_gradient_0_a = 1.000000000;
const float p_o348108_gradient_1_pos = 0.078713000;
const float p_o348108_gradient_1_r = 1.000000000;
const float p_o348108_gradient_1_g = 1.000000000;
const float p_o348108_gradient_1_b = 1.000000000;
const float p_o348108_gradient_1_a = 1.000000000;
const float p_o348108_gradient_2_pos = 0.142350000;
const float p_o348108_gradient_2_r = 0.929687977;
const float p_o348108_gradient_2_g = 0.929687977;
const float p_o348108_gradient_2_b = 0.929687977;
const float p_o348108_gradient_2_a = 1.000000000;
const float p_o348108_gradient_3_pos = 0.205986000;
const float p_o348108_gradient_3_r = 1.000000000;
const float p_o348108_gradient_3_g = 1.000000000;
const float p_o348108_gradient_3_b = 1.000000000;
const float p_o348108_gradient_3_a = 1.000000000;
vec4 o348108_gradient_gradient_fct(float x) {
  if (x < p_o348108_gradient_0_pos) {
    return vec4(p_o348108_gradient_0_r,p_o348108_gradient_0_g,p_o348108_gradient_0_b,p_o348108_gradient_0_a);
  } else if (x < p_o348108_gradient_1_pos) {
    return mix(vec4(p_o348108_gradient_0_r,p_o348108_gradient_0_g,p_o348108_gradient_0_b,p_o348108_gradient_0_a), vec4(p_o348108_gradient_1_r,p_o348108_gradient_1_g,p_o348108_gradient_1_b,p_o348108_gradient_1_a), ((x-p_o348108_gradient_0_pos)/(p_o348108_gradient_1_pos-p_o348108_gradient_0_pos)));
  } else if (x < p_o348108_gradient_2_pos) {
    return mix(vec4(p_o348108_gradient_1_r,p_o348108_gradient_1_g,p_o348108_gradient_1_b,p_o348108_gradient_1_a), vec4(p_o348108_gradient_2_r,p_o348108_gradient_2_g,p_o348108_gradient_2_b,p_o348108_gradient_2_a), ((x-p_o348108_gradient_1_pos)/(p_o348108_gradient_2_pos-p_o348108_gradient_1_pos)));
  } else if (x < p_o348108_gradient_3_pos) {
    return mix(vec4(p_o348108_gradient_2_r,p_o348108_gradient_2_g,p_o348108_gradient_2_b,p_o348108_gradient_2_a), vec4(p_o348108_gradient_3_r,p_o348108_gradient_3_g,p_o348108_gradient_3_b,p_o348108_gradient_3_a), ((x-p_o348108_gradient_2_pos)/(p_o348108_gradient_3_pos-p_o348108_gradient_2_pos)));
  }
  return vec4(p_o348108_gradient_3_r,p_o348108_gradient_3_g,p_o348108_gradient_3_b,p_o348108_gradient_3_a);
}
const float p_o348266_gradient_0_pos = 0.000000000;
const float p_o348266_gradient_0_r = 0.000000000;
const float p_o348266_gradient_0_g = 0.000000000;
const float p_o348266_gradient_0_b = 0.000000000;
const float p_o348266_gradient_0_a = 1.000000000;
const float p_o348266_gradient_1_pos = 1.000000000;
const float p_o348266_gradient_1_r = 0.058594000;
const float p_o348266_gradient_1_g = 0.058594000;
const float p_o348266_gradient_1_b = 0.058594000;
const float p_o348266_gradient_1_a = 1.000000000;
vec4 o348266_gradient_gradient_fct(float x) {
  if (x < p_o348266_gradient_0_pos) {
    return vec4(p_o348266_gradient_0_r,p_o348266_gradient_0_g,p_o348266_gradient_0_b,p_o348266_gradient_0_a);
  } else if (x < p_o348266_gradient_1_pos) {
    return mix(vec4(p_o348266_gradient_0_r,p_o348266_gradient_0_g,p_o348266_gradient_0_b,p_o348266_gradient_0_a), vec4(p_o348266_gradient_1_r,p_o348266_gradient_1_g,p_o348266_gradient_1_b,p_o348266_gradient_1_a), ((x-p_o348266_gradient_0_pos)/(p_o348266_gradient_1_pos-p_o348266_gradient_0_pos)));
  }
  return vec4(p_o348266_gradient_1_r,p_o348266_gradient_1_g,p_o348266_gradient_1_b,p_o348266_gradient_1_a);
}
const float seed_o348264 = -16292.000000000;
const float p_o348264_sx = 16.000000000;
const float p_o348264_sy = 9.000000000;
const float p_o348248_gradient_0_pos = 0.518182000;
const float p_o348248_gradient_0_r = 1.000000000;
const float p_o348248_gradient_0_g = 1.000000000;
const float p_o348248_gradient_0_b = 1.000000000;
const float p_o348248_gradient_0_a = 1.000000000;
const float p_o348248_gradient_1_pos = 1.000000000;
const float p_o348248_gradient_1_r = 0.941406012;
const float p_o348248_gradient_1_g = 0.941406012;
const float p_o348248_gradient_1_b = 0.941406012;
const float p_o348248_gradient_1_a = 1.000000000;
vec4 o348248_gradient_gradient_fct(float x) {
  if (x < p_o348248_gradient_0_pos) {
    return vec4(p_o348248_gradient_0_r,p_o348248_gradient_0_g,p_o348248_gradient_0_b,p_o348248_gradient_0_a);
  } else if (x < p_o348248_gradient_1_pos) {
    return mix(vec4(p_o348248_gradient_0_r,p_o348248_gradient_0_g,p_o348248_gradient_0_b,p_o348248_gradient_0_a), vec4(p_o348248_gradient_1_r,p_o348248_gradient_1_g,p_o348248_gradient_1_b,p_o348248_gradient_1_a), ((x-p_o348248_gradient_0_pos)/(p_o348248_gradient_1_pos-p_o348248_gradient_0_pos)));
  }
  return vec4(p_o348248_gradient_1_r,p_o348248_gradient_1_g,p_o348248_gradient_1_b,p_o348248_gradient_1_a);
}
const float p_o348247_x_scale = 32.000000000;
const float p_o348247_y_scale = 32.000000000;
float o348103_input_depth_tex(vec2 uv, float _seed_variation_) {
vec2 o348212_0_c = vec2(0.5+p_o348212_cx, 0.5+p_o348212_cy);vec4 o348261_0 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348213_translate_x, p_o348213_translate_y))-o348212_0_c, (elapsed_time*20.0)*0.01745329251)+o348212_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_1_rgba = o348261_0;
vec4 o348212_0_1_rgba = o348263_0_1_rgba;
vec4 o348213_0_1_rgba = o348212_0_1_rgba;
vec2 o348244_0_c = vec2(0.5+p_o348244_cx, 0.5+p_o348244_cy);vec4 o348261_1 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348243_translate_x, p_o348243_translate_y))-o348244_0_c, (-elapsed_time*20.0)*0.01745329251)+o348244_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_4_rgba = o348261_1;
vec4 o348244_0_1_rgba = o348263_0_4_rgba;
vec4 o348243_0_1_rgba = o348244_0_1_rgba;
float o348245_0_clamp_false = max((dot((o348213_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o348243_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348245_0_clamp_true = clamp(o348245_0_clamp_false, 0.0, 1.0);
float o348245_0_1_f = o348245_0_clamp_true;
float o348104_0_1_sdf2d = sd_box((uv)-vec2(p_o348104_cx+0.5, p_o348104_cy+0.5), vec2(p_o348104_w, p_o348104_h));
float o348105_0_1_sdf2d = length((uv)-vec2(p_o348105_cx+0.5, p_o348105_cy+0.5))-p_o348105_r;
float o348106_0_1_sdf2d = sdSmoothIntersection(o348104_0_1_sdf2d, o348105_0_1_sdf2d, p_o348106_k);
float o348107_0_1_f = clamp(o348106_0_1_sdf2d/max(p_o348107_bevel, 0.00001), 0.0, 1.0);
vec3 o348210_0_false = clamp((vec4(vec3(o348107_0_1_f), 1.0).rgb-vec3(p_o348210_value))/max(0.0001, p_o348210_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o348210_0_true = vec3(1.0)-o348210_0_false;vec4 o348210_0_1_rgba = vec4(o348210_0_true, vec4(vec3(o348107_0_1_f), 1.0).a);
float o348211_0_clamp_false = o348245_0_1_f*(dot((o348210_0_1_rgba).rgb, vec3(1.0))/3.0);
float o348211_0_clamp_true = clamp(o348211_0_clamp_false, 0.0, 1.0);
float o348211_0_1_f = o348211_0_clamp_false;
float o348214_0_clamp_false = o348211_0_1_f*p_o348214_default_in2;
float o348214_0_clamp_true = clamp(o348214_0_clamp_false, 0.0, 1.0);
float o348214_0_2_f = o348214_0_clamp_false;
vec4 o348108_0_1_rgba = o348108_gradient_gradient_fct(o348107_0_1_f);
float o348246_0_clamp_false = max(o348214_0_2_f,(dot((o348108_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348246_0_clamp_true = clamp(o348246_0_clamp_false, 0.0, 1.0);
float o348246_0_1_f = o348246_0_clamp_false;
vec2 o348264_0_uv = (uv)*vec2(p_o348264_sx, p_o348264_sy*1.73205080757);
vec4 o348264_0_center = beehive_center(o348264_0_uv);float o348264_0_1_f = 1.0-2.0*beehive_dist(o348264_0_center.xy);
vec4 o348266_0_1_rgba = o348266_gradient_gradient_fct(o348264_0_1_f);
float o348265_0_clamp_false = max(o348246_0_1_f,(dot((o348266_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348265_0_clamp_true = clamp(o348265_0_clamp_false, 0.0, 1.0);
float o348265_0_1_f = o348265_0_clamp_false;
float o348247_0_1_f = mix_mul(wave_sine(p_o348247_x_scale*(uv).x), wave_sine(p_o348247_y_scale*(uv).y));
vec4 o348248_0_1_rgba = o348248_gradient_gradient_fct(o348247_0_1_f);
float o348215_0_clamp_false = min(o348265_0_1_f,(dot((o348248_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348215_0_clamp_true = clamp(o348215_0_clamp_false, 0.0, 1.0);
float o348215_0_1_f = o348215_0_clamp_false;
vec4 o348150_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o348215_0_1_f), 1.0).rgb, vec4(vec3(o348215_0_1_f), 1.0).a);

return (dot((o348150_0_1_rgba).rgb, vec3(1.0))/3.0);
}
const float p_o348151_gradient_0_pos = 0.000000000;
const float p_o348151_gradient_0_r = 0.425781012;
const float p_o348151_gradient_0_g = 0.425781012;
const float p_o348151_gradient_0_b = 0.425781012;
const float p_o348151_gradient_0_a = 1.000000000;
const float p_o348151_gradient_1_pos = 0.021062000;
const float p_o348151_gradient_1_r = 0.472656012;
const float p_o348151_gradient_1_g = 0.472656012;
const float p_o348151_gradient_1_b = 0.472656012;
const float p_o348151_gradient_1_a = 1.000000000;
const float p_o348151_gradient_2_pos = 0.757425000;
const float p_o348151_gradient_2_r = 0.545313001;
const float p_o348151_gradient_2_g = 0.545313001;
const float p_o348151_gradient_2_b = 0.545313001;
const float p_o348151_gradient_2_a = 1.000000000;
const float p_o348151_gradient_3_pos = 0.940864000;
const float p_o348151_gradient_3_r = 0.256296992;
const float p_o348151_gradient_3_g = 0.347656012;
const float p_o348151_gradient_3_b = 0.199631006;
const float p_o348151_gradient_3_a = 1.000000000;
vec4 o348151_gradient_gradient_fct(float x) {
  if (x < 0.5*(p_o348151_gradient_0_pos+p_o348151_gradient_1_pos)) {
    return vec4(p_o348151_gradient_0_r,p_o348151_gradient_0_g,p_o348151_gradient_0_b,p_o348151_gradient_0_a);
  } else if (x < 0.5*(p_o348151_gradient_1_pos+p_o348151_gradient_2_pos)) {
    return vec4(p_o348151_gradient_1_r,p_o348151_gradient_1_g,p_o348151_gradient_1_b,p_o348151_gradient_1_a);
  } else if (x < 0.5*(p_o348151_gradient_2_pos+p_o348151_gradient_3_pos)) {
    return vec4(p_o348151_gradient_2_r,p_o348151_gradient_2_g,p_o348151_gradient_2_b,p_o348151_gradient_2_a);
  }
  return vec4(p_o348151_gradient_3_r,p_o348151_gradient_3_g,p_o348151_gradient_3_b,p_o348151_gradient_3_a);
}
const float p_o348216_gradient_0_pos = 0.789199000;
const float p_o348216_gradient_0_r = 1.000000000;
const float p_o348216_gradient_0_g = 1.000000000;
const float p_o348216_gradient_0_b = 1.000000000;
const float p_o348216_gradient_0_a = 1.000000000;
const float p_o348216_gradient_1_pos = 1.000000000;
const float p_o348216_gradient_1_r = 0.000000000;
const float p_o348216_gradient_1_g = 0.000000000;
const float p_o348216_gradient_1_b = 0.000000000;
const float p_o348216_gradient_1_a = 1.000000000;
vec4 o348216_gradient_gradient_fct(float x) {
  if (x < 0.5*(p_o348216_gradient_0_pos+p_o348216_gradient_1_pos)) {
    return vec4(p_o348216_gradient_0_r,p_o348216_gradient_0_g,p_o348216_gradient_0_b,p_o348216_gradient_0_a);
  }
  return vec4(p_o348216_gradient_1_r,p_o348216_gradient_1_g,p_o348216_gradient_1_b,p_o348216_gradient_1_a);
}
const float p_o348229_gradient_0_pos = 0.295409000;
const float p_o348229_gradient_0_r = 1.000000000;
const float p_o348229_gradient_0_g = 1.000000000;
const float p_o348229_gradient_0_b = 1.000000000;
const float p_o348229_gradient_0_a = 1.000000000;
const float p_o348229_gradient_1_pos = 0.695409000;
const float p_o348229_gradient_1_r = 0.140625000;
const float p_o348229_gradient_1_g = 0.140625000;
const float p_o348229_gradient_1_b = 0.140625000;
const float p_o348229_gradient_1_a = 1.000000000;
const float p_o348229_gradient_2_pos = 0.940864000;
const float p_o348229_gradient_2_r = 0.582031012;
const float p_o348229_gradient_2_g = 0.582031012;
const float p_o348229_gradient_2_b = 0.582031012;
const float p_o348229_gradient_2_a = 1.000000000;
vec4 o348229_gradient_gradient_fct(float x) {
  if (x < 0.5*(p_o348229_gradient_0_pos+p_o348229_gradient_1_pos)) {
    return vec4(p_o348229_gradient_0_r,p_o348229_gradient_0_g,p_o348229_gradient_0_b,p_o348229_gradient_0_a);
  } else if (x < 0.5*(p_o348229_gradient_1_pos+p_o348229_gradient_2_pos)) {
    return vec4(p_o348229_gradient_1_r,p_o348229_gradient_1_g,p_o348229_gradient_1_b,p_o348229_gradient_1_a);
  }
  return vec4(p_o348229_gradient_2_r,p_o348229_gradient_2_g,p_o348229_gradient_2_b,p_o348229_gradient_2_a);
}
const float p_o348130_amount = 1.000000000;
float o348130_input_in(vec2 uv, float _seed_variation_) {
vec2 o348212_0_c = vec2(0.5+p_o348212_cx, 0.5+p_o348212_cy);vec4 o348261_0 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348213_translate_x, p_o348213_translate_y))-o348212_0_c, (elapsed_time*20.0)*0.01745329251)+o348212_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_1_rgba = o348261_0;
vec4 o348212_0_1_rgba = o348263_0_1_rgba;
vec4 o348213_0_1_rgba = o348212_0_1_rgba;
vec2 o348244_0_c = vec2(0.5+p_o348244_cx, 0.5+p_o348244_cy);vec4 o348261_1 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348243_translate_x, p_o348243_translate_y))-o348244_0_c, (-elapsed_time*20.0)*0.01745329251)+o348244_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_4_rgba = o348261_1;
vec4 o348244_0_1_rgba = o348263_0_4_rgba;
vec4 o348243_0_1_rgba = o348244_0_1_rgba;
float o348245_0_clamp_false = max((dot((o348213_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o348243_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348245_0_clamp_true = clamp(o348245_0_clamp_false, 0.0, 1.0);
float o348245_0_1_f = o348245_0_clamp_true;
float o348104_0_1_sdf2d = sd_box((uv)-vec2(p_o348104_cx+0.5, p_o348104_cy+0.5), vec2(p_o348104_w, p_o348104_h));
float o348105_0_1_sdf2d = length((uv)-vec2(p_o348105_cx+0.5, p_o348105_cy+0.5))-p_o348105_r;
float o348106_0_1_sdf2d = sdSmoothIntersection(o348104_0_1_sdf2d, o348105_0_1_sdf2d, p_o348106_k);
float o348107_0_1_f = clamp(o348106_0_1_sdf2d/max(p_o348107_bevel, 0.00001), 0.0, 1.0);
vec3 o348210_0_false = clamp((vec4(vec3(o348107_0_1_f), 1.0).rgb-vec3(p_o348210_value))/max(0.0001, p_o348210_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o348210_0_true = vec3(1.0)-o348210_0_false;vec4 o348210_0_1_rgba = vec4(o348210_0_true, vec4(vec3(o348107_0_1_f), 1.0).a);
float o348211_0_clamp_false = o348245_0_1_f*(dot((o348210_0_1_rgba).rgb, vec3(1.0))/3.0);
float o348211_0_clamp_true = clamp(o348211_0_clamp_false, 0.0, 1.0);
float o348211_0_1_f = o348211_0_clamp_false;
float o348214_0_clamp_false = o348211_0_1_f*p_o348214_default_in2;
float o348214_0_clamp_true = clamp(o348214_0_clamp_false, 0.0, 1.0);
float o348214_0_2_f = o348214_0_clamp_false;
vec4 o348108_0_1_rgba = o348108_gradient_gradient_fct(o348107_0_1_f);
float o348246_0_clamp_false = max(o348214_0_2_f,(dot((o348108_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348246_0_clamp_true = clamp(o348246_0_clamp_false, 0.0, 1.0);
float o348246_0_1_f = o348246_0_clamp_false;
vec2 o348264_0_uv = (uv)*vec2(p_o348264_sx, p_o348264_sy*1.73205080757);
vec4 o348264_0_center = beehive_center(o348264_0_uv);float o348264_0_1_f = 1.0-2.0*beehive_dist(o348264_0_center.xy);
vec4 o348266_0_1_rgba = o348266_gradient_gradient_fct(o348264_0_1_f);
float o348265_0_clamp_false = max(o348246_0_1_f,(dot((o348266_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348265_0_clamp_true = clamp(o348265_0_clamp_false, 0.0, 1.0);
float o348265_0_1_f = o348265_0_clamp_false;
float o348247_0_1_f = mix_mul(wave_sine(p_o348247_x_scale*(uv).x), wave_sine(p_o348247_y_scale*(uv).y));
vec4 o348248_0_1_rgba = o348248_gradient_gradient_fct(o348247_0_1_f);
float o348215_0_clamp_false = min(o348265_0_1_f,(dot((o348248_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348215_0_clamp_true = clamp(o348215_0_clamp_false, 0.0, 1.0);
float o348215_0_1_f = o348215_0_clamp_false;

return o348215_0_1_f;
}
vec3 o348130_fct(vec2 uv, float _seed_variation_) {
	vec3 e = vec3(1.0/1024.000000000, -1.0/1024.000000000, 0);
	vec2 rv = vec2(1.0, -1.0)*o348130_input_in(uv+e.xy, _seed_variation_);
	rv += vec2(-1.0, 1.0)*o348130_input_in(uv-e.xy, _seed_variation_);
	rv += vec2(1.0, 1.0)*o348130_input_in(uv+e.xx, _seed_variation_);
	rv += vec2(-1.0, -1.0)*o348130_input_in(uv-e.xx, _seed_variation_);
	rv += vec2(2.0, 0.0)*o348130_input_in(uv+e.xz, _seed_variation_);
	rv += vec2(-2.0, 0.0)*o348130_input_in(uv-e.xz, _seed_variation_);
	rv += vec2(0.0, 2.0)*o348130_input_in(uv+e.zx, _seed_variation_);
	rv += vec2(0.0, -2.0)*o348130_input_in(uv-e.zx, _seed_variation_);
	return vec3(rv, 0.0);
}

void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o348103_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o348103_input_depth_tex(ofs, _seed_variation_);

		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o348103_input_depth_tex(ofs, _seed_variation_);

			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o348103_input_depth_tex(prev_ofs, _seed_variation_) - current_depth + layer_depth;

		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}
vec2 o348212_0_c = vec2(0.5+p_o348212_cx, 0.5+p_o348212_cy);vec4 o348261_0 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348213_translate_x, p_o348213_translate_y))-o348212_0_c, (elapsed_time*20.0)*0.01745329251)+o348212_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_1_rgba = o348261_0;
vec4 o348212_0_1_rgba = o348263_0_1_rgba;
vec4 o348213_0_1_rgba = o348212_0_1_rgba;
vec2 o348244_0_c = vec2(0.5+p_o348244_cx, 0.5+p_o348244_cy);vec4 o348261_1 = textureLod(texture_1, transform2_clamp(transform2((rotate(((uv)-vec2(p_o348243_translate_x, p_o348243_translate_y))-o348244_0_c, (-elapsed_time*20.0)*0.01745329251)+o348244_0_c), vec2(p_o348263_translate_x*(2.0*1.0-1.0), p_o348263_translate_y*(2.0*1.0-1.0)), p_o348263_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o348263_scale_x*(2.0*1.0-1.0), p_o348263_scale_y*(2.0*1.0-1.0)))), 0.0);
vec4 o348263_0_4_rgba = o348261_1;
vec4 o348244_0_1_rgba = o348263_0_4_rgba;
vec4 o348243_0_1_rgba = o348244_0_1_rgba;
float o348245_0_clamp_false = max((dot((o348213_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o348243_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348245_0_clamp_true = clamp(o348245_0_clamp_false, 0.0, 1.0);
float o348245_0_1_f = o348245_0_clamp_true;
float o348104_0_1_sdf2d = sd_box((uv)-vec2(p_o348104_cx+0.5, p_o348104_cy+0.5), vec2(p_o348104_w, p_o348104_h));
float o348105_0_1_sdf2d = length((uv)-vec2(p_o348105_cx+0.5, p_o348105_cy+0.5))-p_o348105_r;
float o348106_0_1_sdf2d = sdSmoothIntersection(o348104_0_1_sdf2d, o348105_0_1_sdf2d, p_o348106_k);
float o348107_0_1_f = clamp(o348106_0_1_sdf2d/max(p_o348107_bevel, 0.00001), 0.0, 1.0);
vec3 o348210_0_false = clamp((vec4(vec3(o348107_0_1_f), 1.0).rgb-vec3(p_o348210_value))/max(0.0001, p_o348210_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o348210_0_true = vec3(1.0)-o348210_0_false;vec4 o348210_0_1_rgba = vec4(o348210_0_true, vec4(vec3(o348107_0_1_f), 1.0).a);
float o348211_0_clamp_false = o348245_0_1_f*(dot((o348210_0_1_rgba).rgb, vec3(1.0))/3.0);
float o348211_0_clamp_true = clamp(o348211_0_clamp_false, 0.0, 1.0);
float o348211_0_1_f = o348211_0_clamp_false;
float o348214_0_clamp_false = o348211_0_1_f*p_o348214_default_in2;
float o348214_0_clamp_true = clamp(o348214_0_clamp_false, 0.0, 1.0);
float o348214_0_2_f = o348214_0_clamp_false;
vec4 o348108_0_1_rgba = o348108_gradient_gradient_fct(o348107_0_1_f);
float o348246_0_clamp_false = max(o348214_0_2_f,(dot((o348108_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348246_0_clamp_true = clamp(o348246_0_clamp_false, 0.0, 1.0);
float o348246_0_1_f = o348246_0_clamp_false;
vec2 o348264_0_uv = (uv)*vec2(p_o348264_sx, p_o348264_sy*1.73205080757);
vec4 o348264_0_center = beehive_center(o348264_0_uv);float o348264_0_1_f = 1.0-2.0*beehive_dist(o348264_0_center.xy);
vec4 o348266_0_1_rgba = o348266_gradient_gradient_fct(o348264_0_1_f);
float o348265_0_clamp_false = max(o348246_0_1_f,(dot((o348266_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348265_0_clamp_true = clamp(o348265_0_clamp_false, 0.0, 1.0);
float o348265_0_1_f = o348265_0_clamp_false;
float o348247_0_1_f = mix_mul(wave_sine(p_o348247_x_scale*(uv).x), wave_sine(p_o348247_y_scale*(uv).y));
vec4 o348248_0_1_rgba = o348248_gradient_gradient_fct(o348247_0_1_f);
float o348215_0_clamp_false = min(o348265_0_1_f,(dot((o348248_0_1_rgba).rgb, vec3(1.0))/3.0));
float o348215_0_clamp_true = clamp(o348215_0_clamp_false, 0.0, 1.0);
float o348215_0_1_f = o348215_0_clamp_false;
vec4 o348151_0_1_rgba = o348151_gradient_gradient_fct(o348215_0_1_f);
vec4 o348216_0_1_rgba = o348216_gradient_gradient_fct(o348215_0_1_f);
vec4 o348229_0_1_rgba = o348229_gradient_gradient_fct(o348215_0_1_f);
vec3 o348130_0_1_rgb = process_normal_default(o348130_fct((uv), _seed_variation_), p_o348130_amount*1024.000000000/128.0);

	vec3 albedo_tex = ((o348151_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*vec4(p_o348103_albedo_color_r, p_o348103_albedo_color_g, p_o348103_albedo_color_b, p_o348103_albedo_color_a).rgb;
	METALLIC = (dot((o348216_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o348103_metallic;
	ROUGHNESS = (dot((o348229_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o348103_roughness;
	NORMAL = o348130_0_1_rgb;
	EMISSION = vec3(0.0)*p_o348103_emission_energy;

}



