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
const vec4 p_o415974302519_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o415974302519_metallic = 1.000000000;
const float p_o415974302519_roughness = 1.000000000;
const float p_o415974302519_emission_energy = 1.000000000;
const float p_o415974302519_normal = 1.000000000;
const float p_o415974302519_ao = 1.000000000;
const float p_o415974302519_depth_scale = 0.200000000;
const float p_o418088231787_default_in1 = 0.000000000;
const float p_o418088231787_default_in2 = 0.000000000;
const float p_o418692211578_gradient_pos[2] = float[]( 0.518181980, 1.000000000 );
const vec4 p_o418692211578_gradient_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.941406012, 0.941406012, 0.941406012, 1.000000000) );
const float p_o418675434360_x_scale = 32.000000000;
const float p_o418675434360_y_scale = 32.000000000;
const float p_o418994201475_default_in1 = 0.000000000;
const float p_o418994201475_default_in2 = 0.000000000;
const float p_o419010978692_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o419010978692_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(0.058594000, 0.058594000, 0.058594000, 1.000000000) );
const float seed_o418977424258 = -16292.000000000;
const float p_o418977424258_sx = 16.000000000;
const float p_o418977424258_sy = 9.000000000;
const float p_o418658657137_default_in1 = 0.000000000;
const float p_o418658657137_default_in2 = 0.000000000;
const float p_o416058188604_gradient_pos[4] = float[]( 0.000000000, 0.078713000, 0.142350003, 0.205985993 );
const vec4 p_o416058188604_gradient_col[4] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.929687977, 0.929687977, 0.929687977, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o416041411387_bevel = 0.150000000;
const float p_o416024634170_k = 0.070000000;
const float p_o416007856953_r = 0.574303000;
const float p_o416007856953_cx = -0.282000000;
const float p_o416007856953_cy = -0.186000000;
const float p_o415991079736_w = 0.300000000;
const float p_o415991079736_h = 0.290000000;
const float p_o415991079736_cx = 0.000000000;
const float p_o415991079736_cy = 0.000000000;
const float p_o418071454570_default_in1 = 0.000000000;
const float p_o418071454570_default_in2 = 0.800000000;
const float p_o418021122919_default_in1 = 0.000000000;
const float p_o418021122919_default_in2 = 0.000000000;
const float p_o418004345702_value = 0.500000000;
const float p_o418004345702_width = 0.030000000;
const float p_o418641879925_default_in1 = 0.000000000;
const float p_o418641879925_default_in2 = 0.000000000;
const float p_o418608325492_translate_x = -0.309000000;
const float p_o418608325492_translate_y = 0.421000000;
const float p_o418625102710_cx = 0.000000000;
const float p_o418625102710_cy = 0.000000000;
const float p_o418960647041_translate_x = 0.000000000;
const float p_o418960647041_translate_y = 0.000000000;
const float p_o418960647041_rotate = 0.000000000;
const float p_o418960647041_scale_x = 1.000000000;
const float p_o418960647041_scale_y = 1.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 256.000000000;
const float p_o418054677353_translate_x = 0.135000000;
const float p_o418054677353_translate_y = -0.335000000;
const float p_o418037900136_cx = 0.000000000;
const float p_o418037900136_cy = 0.000000000;
const float p_o416444064586_amount = 1.000000000;
const float p_o418339890032_gradient_pos[3] = float[]( 0.000000000, 0.495409012, 0.818136513 );
const vec4 p_o418339890032_gradient_col[3] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.140625000, 0.140625000, 0.140625000, 1.000000000), vec4(0.582031012, 0.582031012, 0.582031012, 1.000000000) );
const float p_o418105009004_gradient_pos[2] = float[]( 0.000000000, 0.894599497 );
const vec4 p_o418105009004_gradient_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000) );
const float p_o416846717773_gradient_pos[4] = float[]( 0.000000000, 0.010531000, 0.389243513, 0.849144518 );
const vec4 p_o416846717773_gradient_col[4] = vec4[]( vec4(0.425781012, 0.425781012, 0.425781012, 1.000000000), vec4(0.472656012, 0.472656012, 0.472656012, 1.000000000), vec4(0.545313001, 0.545313001, 0.545313001, 1.000000000), vec4(0.256296992, 0.347656012, 0.199631006, 1.000000000) );
// #globals: invert (o416829940556)
// #globals: math_3 (o418088231787)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: pattern (o418675434360)
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
// #globals: beehive (o418977424258)
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
// #globals: sdsmoothboolean (o416024634170)
float sdSmoothUnion( float d1, float d2, float k ) {
	float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) - k*h*(1.0-h); }
float sdSmoothSubtraction( float d1, float d2, float k ) {
	float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
	return mix( d2, -d1, h ) + k*h*(1.0-h); }
float sdSmoothIntersection( float d1, float d2, float k ) {
	float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
	return mix( d2, d1, h ) + k*h*(1.0-h); }
// #globals: sdbox (o415991079736)
float sd_box(vec2 uv, vec2 size) {
	vec2 d = abs(uv)-size;
	return length(max(d, vec2(0)))+min(max(d.x, d.y), 0.0);
}
// #globals: rotate_2 (o418625102710)
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
	return rv;	
}
// #globals: transform2 (o418960647041)
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
// #globals: normal_map/edge_detect_1 (o416444064586)
vec3 process_normal_default(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, -1.0))+vec3(0.5);
}
vec3 process_normal_opengl(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}
vec3 process_normal_directx(vec3 v, float multiplier) {
	return 0.5*normalize(v.xyz*vec3(1.0, -1.0, 1.0)*multiplier+vec3(0.0, 0.0, 1.0))+vec3(0.5);
}
vec4 o418692211578_gradient_gradient_fct(float x) {
  if (x < p_o418692211578_gradient_pos[0]) {
    return p_o418692211578_gradient_col[0];
  } else if (x < p_o418692211578_gradient_pos[1]) {
    return mix(p_o418692211578_gradient_col[0], p_o418692211578_gradient_col[1], ((x-p_o418692211578_gradient_pos[0])/(p_o418692211578_gradient_pos[1]-p_o418692211578_gradient_pos[0])));
  }
  return p_o418692211578_gradient_col[1];
}
vec4 o419010978692_gradient_gradient_fct(float x) {
  if (x < p_o419010978692_gradient_pos[0]) {
    return p_o419010978692_gradient_col[0];
  } else if (x < p_o419010978692_gradient_pos[1]) {
    return mix(p_o419010978692_gradient_col[0], p_o419010978692_gradient_col[1], ((x-p_o419010978692_gradient_pos[0])/(p_o419010978692_gradient_pos[1]-p_o419010978692_gradient_pos[0])));
  }
  return p_o419010978692_gradient_col[1];
}
vec4 o416058188604_gradient_gradient_fct(float x) {
  if (x < p_o416058188604_gradient_pos[0]) {
    return p_o416058188604_gradient_col[0];
  } else if (x < p_o416058188604_gradient_pos[1]) {
    return mix(p_o416058188604_gradient_col[0], p_o416058188604_gradient_col[1], ((x-p_o416058188604_gradient_pos[0])/(p_o416058188604_gradient_pos[1]-p_o416058188604_gradient_pos[0])));
  } else if (x < p_o416058188604_gradient_pos[2]) {
    return mix(p_o416058188604_gradient_col[1], p_o416058188604_gradient_col[2], ((x-p_o416058188604_gradient_pos[1])/(p_o416058188604_gradient_pos[2]-p_o416058188604_gradient_pos[1])));
  } else if (x < p_o416058188604_gradient_pos[3]) {
    return mix(p_o416058188604_gradient_col[2], p_o416058188604_gradient_col[3], ((x-p_o416058188604_gradient_pos[2])/(p_o416058188604_gradient_pos[3]-p_o416058188604_gradient_pos[2])));
  }
  return p_o416058188604_gradient_col[3];
}
float o415974302519_input_depth_tex(vec2 uv, float _seed_variation_) {
// #output0: pattern (o418675434360)
float o418675434360_0_1_f = mix_mul(wave_sine(p_o418675434360_x_scale*(uv).x), wave_sine(p_o418675434360_y_scale*(uv).y));
// #output0: colorize_5 (o418692211578)
vec4 o418692211578_0_1_rgba = o418692211578_gradient_gradient_fct(o418675434360_0_1_f);
// #code: beehive (o418977424258)
vec2 o418977424258_0_uv = (uv)*vec2(p_o418977424258_sx, p_o418977424258_sy*1.73205080757);
vec4 o418977424258_0_center = beehive_center(o418977424258_0_uv);
// #output0: beehive (o418977424258)
float o418977424258_0_1_f = 1.0-2.0*beehive_dist(o418977424258_0_center.xy);
// #output0: colorize_6 (o419010978692)
vec4 o419010978692_0_1_rgba = o419010978692_gradient_gradient_fct(o418977424258_0_1_f);
// #output0: sdcircle (o416007856953)
float o416007856953_0_1_sdf2d = length((uv)-vec2(p_o416007856953_cx+0.5, p_o416007856953_cy+0.5))-p_o416007856953_r;
// #output0: sdbox (o415991079736)
float o415991079736_0_1_sdf2d = sd_box((uv)-vec2(p_o415991079736_cx+0.5, p_o415991079736_cy+0.5), vec2(p_o415991079736_w, p_o415991079736_h));
// #output0: sdsmoothboolean (o416024634170)
float o416024634170_0_1_sdf2d = sdSmoothIntersection(o415991079736_0_1_sdf2d, o416007856953_0_1_sdf2d, p_o416024634170_k);
// #output0: sdshow (o416041411387)
float o416041411387_0_1_f = clamp(o416024634170_0_1_sdf2d/max(p_o416041411387_bevel, 0.00001), 0.0, 1.0);
// #output0: colorize (o416058188604)
vec4 o416058188604_0_1_rgba = o416058188604_gradient_gradient_fct(o416041411387_0_1_f);
// #code: tones_step (o418004345702)
vec3 o418004345702_0_false = clamp((vec4(vec3(o416041411387_0_1_f), 1.0).rgb-vec3(p_o418004345702_value))/max(0.0001, p_o418004345702_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o418004345702_0_true = vec3(1.0)-o418004345702_0_false;
// #output0: tones_step (o418004345702)
vec4 o418004345702_0_1_rgba = vec4(o418004345702_0_true, vec4(vec3(o416041411387_0_1_f), 1.0).a);
// #code: rotate_2 (o418625102710)
vec2 o418625102710_0_c = vec2(0.5+p_o418625102710_cx, 0.5+p_o418625102710_cy);vec4 o418910315390_0 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418608325492_translate_x, p_o418608325492_translate_y))-o418625102710_0_c, (-elapsed_time*20.0)*0.01745329251)+o418625102710_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2 (o418960647041)
vec4 o418960647041_0_1_rgba = o418910315390_0;
// #output0: rotate_2 (o418625102710)
vec4 o418625102710_0_1_rgba = o418960647041_0_1_rgba;
// #output0: translate_2 (o418608325492)
vec4 o418608325492_0_1_rgba = o418625102710_0_1_rgba;
// #code: rotate (o418037900136)
vec2 o418037900136_0_c = vec2(0.5+p_o418037900136_cx, 0.5+p_o418037900136_cy);vec4 o418910315390_1 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418054677353_translate_x, p_o418054677353_translate_y))-o418037900136_0_c, (elapsed_time*20.0)*0.01745329251)+o418037900136_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2 (o418960647041)
vec4 o418960647041_0_3_rgba = o418910315390_1;
// #output0: rotate (o418037900136)
vec4 o418037900136_0_1_rgba = o418960647041_0_3_rgba;
// #output0: translate (o418054677353)
vec4 o418054677353_0_1_rgba = o418037900136_0_1_rgba;
// #code: math_4 (o418641879925)
float o418641879925_0_clamp_false = max((dot((o418054677353_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o418608325492_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418641879925_0_clamp_true = clamp(o418641879925_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o418641879925)
float o418641879925_0_1_f = o418641879925_0_clamp_true;
// #code: math (o418021122919)
float o418021122919_0_clamp_false = o418641879925_0_1_f*(dot((o418004345702_0_1_rgba).rgb, vec3(1.0))/3.0);
float o418021122919_0_clamp_true = clamp(o418021122919_0_clamp_false, 0.0, 1.0);
// #output0: math (o418021122919)
float o418021122919_0_1_f = o418021122919_0_clamp_false;
// #code: math_2 (o418071454570)
float o418071454570_0_clamp_false = o418021122919_0_1_f*p_o418071454570_default_in2;
float o418071454570_0_clamp_true = clamp(o418071454570_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o418071454570)
float o418071454570_0_1_f = o418071454570_0_clamp_false;
// #code: math_5 (o418658657137)
float o418658657137_0_clamp_false = max(o418071454570_0_1_f,(dot((o416058188604_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418658657137_0_clamp_true = clamp(o418658657137_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o418658657137)
float o418658657137_0_1_f = o418658657137_0_clamp_false;
// #code: math_6 (o418994201475)
float o418994201475_0_clamp_false = max(o418658657137_0_1_f,(dot((o419010978692_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418994201475_0_clamp_true = clamp(o418994201475_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o418994201475)
float o418994201475_0_1_f = o418994201475_0_clamp_false;
// #code: math_3 (o418088231787)
float o418088231787_0_clamp_false = min(o418994201475_0_1_f,(dot((o418692211578_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418088231787_0_clamp_true = clamp(o418088231787_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o418088231787)
float o418088231787_0_1_f = o418088231787_0_clamp_false;
// #output0: invert (o416829940556)
vec4 o416829940556_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o418088231787_0_1_f), 1.0).rgb, vec4(vec3(o418088231787_0_1_f), 1.0).a);
return (dot((o416829940556_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o416444064586_input_in(vec2 uv, float _seed_variation_) {
// #output0: pattern (o418675434360)
float o418675434360_0_1_f = mix_mul(wave_sine(p_o418675434360_x_scale*(uv).x), wave_sine(p_o418675434360_y_scale*(uv).y));
// #output0: colorize_5 (o418692211578)
vec4 o418692211578_0_1_rgba = o418692211578_gradient_gradient_fct(o418675434360_0_1_f);
// #code: beehive (o418977424258)
vec2 o418977424258_0_uv = (uv)*vec2(p_o418977424258_sx, p_o418977424258_sy*1.73205080757);
vec4 o418977424258_0_center = beehive_center(o418977424258_0_uv);
// #output0: beehive (o418977424258)
float o418977424258_0_1_f = 1.0-2.0*beehive_dist(o418977424258_0_center.xy);
// #output0: colorize_6 (o419010978692)
vec4 o419010978692_0_1_rgba = o419010978692_gradient_gradient_fct(o418977424258_0_1_f);
// #output0: sdcircle (o416007856953)
float o416007856953_0_1_sdf2d = length((uv)-vec2(p_o416007856953_cx+0.5, p_o416007856953_cy+0.5))-p_o416007856953_r;
// #output0: sdbox (o415991079736)
float o415991079736_0_1_sdf2d = sd_box((uv)-vec2(p_o415991079736_cx+0.5, p_o415991079736_cy+0.5), vec2(p_o415991079736_w, p_o415991079736_h));
// #output0: sdsmoothboolean (o416024634170)
float o416024634170_0_1_sdf2d = sdSmoothIntersection(o415991079736_0_1_sdf2d, o416007856953_0_1_sdf2d, p_o416024634170_k);
// #output0: sdshow (o416041411387)
float o416041411387_0_1_f = clamp(o416024634170_0_1_sdf2d/max(p_o416041411387_bevel, 0.00001), 0.0, 1.0);
// #output0: colorize (o416058188604)
vec4 o416058188604_0_1_rgba = o416058188604_gradient_gradient_fct(o416041411387_0_1_f);
// #code: tones_step (o418004345702)
vec3 o418004345702_0_false = clamp((vec4(vec3(o416041411387_0_1_f), 1.0).rgb-vec3(p_o418004345702_value))/max(0.0001, p_o418004345702_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o418004345702_0_true = vec3(1.0)-o418004345702_0_false;
// #output0: tones_step (o418004345702)
vec4 o418004345702_0_1_rgba = vec4(o418004345702_0_true, vec4(vec3(o416041411387_0_1_f), 1.0).a);
// #code: rotate_2 (o418625102710)
vec2 o418625102710_0_c = vec2(0.5+p_o418625102710_cx, 0.5+p_o418625102710_cy);vec4 o418910315390_0 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418608325492_translate_x, p_o418608325492_translate_y))-o418625102710_0_c, (-elapsed_time*20.0)*0.01745329251)+o418625102710_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2 (o418960647041)
vec4 o418960647041_0_1_rgba = o418910315390_0;
// #output0: rotate_2 (o418625102710)
vec4 o418625102710_0_1_rgba = o418960647041_0_1_rgba;
// #output0: translate_2 (o418608325492)
vec4 o418608325492_0_1_rgba = o418625102710_0_1_rgba;
// #code: rotate (o418037900136)
vec2 o418037900136_0_c = vec2(0.5+p_o418037900136_cx, 0.5+p_o418037900136_cy);vec4 o418910315390_1 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418054677353_translate_x, p_o418054677353_translate_y))-o418037900136_0_c, (elapsed_time*20.0)*0.01745329251)+o418037900136_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2 (o418960647041)
vec4 o418960647041_0_3_rgba = o418910315390_1;
// #output0: rotate (o418037900136)
vec4 o418037900136_0_1_rgba = o418960647041_0_3_rgba;
// #output0: translate (o418054677353)
vec4 o418054677353_0_1_rgba = o418037900136_0_1_rgba;
// #code: math_4 (o418641879925)
float o418641879925_0_clamp_false = max((dot((o418054677353_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o418608325492_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418641879925_0_clamp_true = clamp(o418641879925_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o418641879925)
float o418641879925_0_1_f = o418641879925_0_clamp_true;
// #code: math (o418021122919)
float o418021122919_0_clamp_false = o418641879925_0_1_f*(dot((o418004345702_0_1_rgba).rgb, vec3(1.0))/3.0);
float o418021122919_0_clamp_true = clamp(o418021122919_0_clamp_false, 0.0, 1.0);
// #output0: math (o418021122919)
float o418021122919_0_1_f = o418021122919_0_clamp_false;
// #code: math_2 (o418071454570)
float o418071454570_0_clamp_false = o418021122919_0_1_f*p_o418071454570_default_in2;
float o418071454570_0_clamp_true = clamp(o418071454570_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o418071454570)
float o418071454570_0_1_f = o418071454570_0_clamp_false;
// #code: math_5 (o418658657137)
float o418658657137_0_clamp_false = max(o418071454570_0_1_f,(dot((o416058188604_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418658657137_0_clamp_true = clamp(o418658657137_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o418658657137)
float o418658657137_0_1_f = o418658657137_0_clamp_false;
// #code: math_6 (o418994201475)
float o418994201475_0_clamp_false = max(o418658657137_0_1_f,(dot((o419010978692_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418994201475_0_clamp_true = clamp(o418994201475_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o418994201475)
float o418994201475_0_1_f = o418994201475_0_clamp_false;
// #code: math_3 (o418088231787)
float o418088231787_0_clamp_false = min(o418994201475_0_1_f,(dot((o418692211578_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418088231787_0_clamp_true = clamp(o418088231787_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o418088231787)
float o418088231787_0_1_f = o418088231787_0_clamp_false;
return o418088231787_0_1_f;
}
// #instance: normal_map/edge_detect_1 (o416444064586)
vec3 o416444064586_fct(vec2 uv, float _seed_variation_) {
	vec3 e = vec3(1.0/1024.0, -1.0/1024.0, 0);
	vec2 rv = vec2(1.0, -1.0)*o416444064586_input_in((uv+e.xy), _seed_variation_);
	rv += vec2(-1.0, 1.0)*o416444064586_input_in((uv-e.xy), _seed_variation_);
	rv += vec2(1.0, 1.0)*o416444064586_input_in((uv+e.xx), _seed_variation_);
	rv += vec2(-1.0, -1.0)*o416444064586_input_in((uv-e.xx), _seed_variation_);
	rv += vec2(2.0, 0.0)*o416444064586_input_in((uv+e.xz), _seed_variation_);
	rv += vec2(-2.0, 0.0)*o416444064586_input_in((uv-e.xz), _seed_variation_);
	rv += vec2(0.0, 2.0)*o416444064586_input_in((uv+e.zx), _seed_variation_);
	rv += vec2(0.0, -2.0)*o416444064586_input_in((uv-e.zx), _seed_variation_);
	return vec3(rv, 0.0);
}
vec4 o418339890032_gradient_gradient_fct(float x) {
  if (x < p_o418339890032_gradient_pos[1]) {
    return p_o418339890032_gradient_col[0];
  } else if (x < p_o418339890032_gradient_pos[2]) {
    return p_o418339890032_gradient_col[1];
  }
  return p_o418339890032_gradient_col[2];
}
vec4 o418105009004_gradient_gradient_fct(float x) {
  if (x < p_o418105009004_gradient_pos[1]) {
    return p_o418105009004_gradient_col[0];
  }
  return p_o418105009004_gradient_col[1];
}
vec4 o416846717773_gradient_gradient_fct(float x) {
  if (x < p_o416846717773_gradient_pos[1]) {
    return p_o416846717773_gradient_col[0];
  } else if (x < p_o416846717773_gradient_pos[2]) {
    return p_o416846717773_gradient_col[1];
  } else if (x < p_o416846717773_gradient_pos[3]) {
    return p_o416846717773_gradient_col[2];
  }
  return p_o416846717773_gradient_col[3];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o415974302519_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o415974302519_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o415974302519_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o415974302519_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #output0: normal_map/edge_detect_1 (o416444064586)
vec3 o416444064586_0_1_rgb = process_normal_default(o416444064586_fct((uv), _seed_variation_), p_o416444064586_amount*1024.0/128.0);

// #output0: pattern (o418675434360)
float o418675434360_0_1_f = mix_mul(wave_sine(p_o418675434360_x_scale*(uv).x), wave_sine(p_o418675434360_y_scale*(uv).y));

// #output0: colorize_5 (o418692211578)
vec4 o418692211578_0_1_rgba = o418692211578_gradient_gradient_fct(o418675434360_0_1_f);

// #code: beehive (o418977424258)
vec2 o418977424258_0_uv = (uv)*vec2(p_o418977424258_sx, p_o418977424258_sy*1.73205080757);
vec4 o418977424258_0_center = beehive_center(o418977424258_0_uv);
// #output0: beehive (o418977424258)
float o418977424258_0_1_f = 1.0-2.0*beehive_dist(o418977424258_0_center.xy);

// #output0: colorize_6 (o419010978692)
vec4 o419010978692_0_1_rgba = o419010978692_gradient_gradient_fct(o418977424258_0_1_f);

// #output0: sdcircle (o416007856953)
float o416007856953_0_1_sdf2d = length((uv)-vec2(p_o416007856953_cx+0.5, p_o416007856953_cy+0.5))-p_o416007856953_r;

// #output0: sdbox (o415991079736)
float o415991079736_0_1_sdf2d = sd_box((uv)-vec2(p_o415991079736_cx+0.5, p_o415991079736_cy+0.5), vec2(p_o415991079736_w, p_o415991079736_h));

// #output0: sdsmoothboolean (o416024634170)
float o416024634170_0_1_sdf2d = sdSmoothIntersection(o415991079736_0_1_sdf2d, o416007856953_0_1_sdf2d, p_o416024634170_k);

// #output0: sdshow (o416041411387)
float o416041411387_0_1_f = clamp(o416024634170_0_1_sdf2d/max(p_o416041411387_bevel, 0.00001), 0.0, 1.0);

// #output0: colorize (o416058188604)
vec4 o416058188604_0_1_rgba = o416058188604_gradient_gradient_fct(o416041411387_0_1_f);

// #code: tones_step (o418004345702)
vec3 o418004345702_0_false = clamp((vec4(vec3(o416041411387_0_1_f), 1.0).rgb-vec3(p_o418004345702_value))/max(0.0001, p_o418004345702_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o418004345702_0_true = vec3(1.0)-o418004345702_0_false;
// #output0: tones_step (o418004345702)
vec4 o418004345702_0_1_rgba = vec4(o418004345702_0_true, vec4(vec3(o416041411387_0_1_f), 1.0).a);

// #code: rotate_2 (o418625102710)
vec2 o418625102710_0_c = vec2(0.5+p_o418625102710_cx, 0.5+p_o418625102710_cy);vec4 o418910315390_0 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418608325492_translate_x, p_o418608325492_translate_y))-o418625102710_0_c, (-elapsed_time*20.0)*0.01745329251)+o418625102710_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o418960647041)
vec4 o418960647041_0_1_rgba = o418910315390_0;

// #output0: rotate_2 (o418625102710)
vec4 o418625102710_0_1_rgba = o418960647041_0_1_rgba;

// #output0: translate_2 (o418608325492)
vec4 o418608325492_0_1_rgba = o418625102710_0_1_rgba;

// #code: rotate (o418037900136)
vec2 o418037900136_0_c = vec2(0.5+p_o418037900136_cx, 0.5+p_o418037900136_cy);vec4 o418910315390_1 = textureLod(texture_1, fract((transform2_clamp(transform2((rotate(((uv)-vec2(p_o418054677353_translate_x, p_o418054677353_translate_y))-o418037900136_0_c, (elapsed_time*20.0)*0.01745329251)+o418037900136_0_c), vec2(p_o418960647041_translate_x*(2.0*1.0-1.0), p_o418960647041_translate_y*(2.0*1.0-1.0)), p_o418960647041_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o418960647041_scale_x*(2.0*1.0-1.0), p_o418960647041_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2 (o418960647041)
vec4 o418960647041_0_3_rgba = o418910315390_1;

// #output0: rotate (o418037900136)
vec4 o418037900136_0_1_rgba = o418960647041_0_3_rgba;

// #output0: translate (o418054677353)
vec4 o418054677353_0_1_rgba = o418037900136_0_1_rgba;

// #code: math_4 (o418641879925)
float o418641879925_0_clamp_false = max((dot((o418054677353_0_1_rgba).rgb, vec3(1.0))/3.0),(dot((o418608325492_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418641879925_0_clamp_true = clamp(o418641879925_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o418641879925)
float o418641879925_0_1_f = o418641879925_0_clamp_true;

// #code: math (o418021122919)
float o418021122919_0_clamp_false = o418641879925_0_1_f*(dot((o418004345702_0_1_rgba).rgb, vec3(1.0))/3.0);
float o418021122919_0_clamp_true = clamp(o418021122919_0_clamp_false, 0.0, 1.0);
// #output0: math (o418021122919)
float o418021122919_0_1_f = o418021122919_0_clamp_false;

// #code: math_2 (o418071454570)
float o418071454570_0_clamp_false = o418021122919_0_1_f*p_o418071454570_default_in2;
float o418071454570_0_clamp_true = clamp(o418071454570_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o418071454570)
float o418071454570_0_1_f = o418071454570_0_clamp_false;

// #code: math_5 (o418658657137)
float o418658657137_0_clamp_false = max(o418071454570_0_1_f,(dot((o416058188604_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418658657137_0_clamp_true = clamp(o418658657137_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o418658657137)
float o418658657137_0_1_f = o418658657137_0_clamp_false;

// #code: math_6 (o418994201475)
float o418994201475_0_clamp_false = max(o418658657137_0_1_f,(dot((o419010978692_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418994201475_0_clamp_true = clamp(o418994201475_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o418994201475)
float o418994201475_0_1_f = o418994201475_0_clamp_false;

// #code: math_3 (o418088231787)
float o418088231787_0_clamp_false = min(o418994201475_0_1_f,(dot((o418692211578_0_1_rgba).rgb, vec3(1.0))/3.0));
float o418088231787_0_clamp_true = clamp(o418088231787_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o418088231787)
float o418088231787_0_1_f = o418088231787_0_clamp_false;

// #output0: colorize_4 (o418339890032)
vec4 o418339890032_0_1_rgba = o418339890032_gradient_gradient_fct(o418088231787_0_1_f);

// #output0: colorize_3 (o418105009004)
vec4 o418105009004_0_1_rgba = o418105009004_gradient_gradient_fct(o418088231787_0_1_f);

// #output0: colorize_2 (o416846717773)
vec4 o416846717773_0_1_rgba = o416846717773_gradient_gradient_fct(o418088231787_0_1_f);

	vec3 albedo_tex = ((o416846717773_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o415974302519_albedo_color.rgb;
	METALLIC = (dot((o418105009004_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o415974302519_metallic;
	ROUGHNESS = (dot((o418339890032_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o415974302519_roughness;
	NORMAL = o416444064586_0_1_rgb;
	EMISSION = vec3(0.0)*p_o415974302519_emission_energy;
}



