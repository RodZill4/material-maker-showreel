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
const vec4 p_o29352595034878_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o29352595034878_metallic = 0.000000000;
const float p_o29352595034878_roughness = 1.000000000;
const float p_o29352595034878_emission_energy = 1.000000000;
const float p_o29352595034878_normal = 1.000000000;
const float p_o29352595034878_ao = 1.000000000;
const float p_o29352595034878_depth_scale = 0.500000000;
const float p_o29354306314711_gradient_pos[5] = float[]( 0.000000000, 0.252640814, 0.428213328, 0.907220960, 1.000000000 );
const vec4 p_o29354306314711_gradient_col[5] = vec4[]( vec4(0.035624981, 0.355468750, 0.030548096, 1.000000000), vec4(0.048004150, 0.314820856, 0.472656250, 1.000000000), vec4(0.067749023, 0.578125000, 0.076047800, 1.000000000), vec4(0.842981219, 0.906250000, 0.113281250, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o29354289539172_amount1 = 0.250000000;
const float p_o29354574751221_translate_x = 0.000000000;
const float p_o29354574751221_translate_y = 0.025000000;
const float p_o29354574751221_rotate = 0.000000000;
const float p_o29354574751221_scale_x = 1.000000000;
const float p_o29354574751221_scale_y = 1.000000000;
const float p_o29354239202777_angle = 90.000000000;
const float p_o29354239202777_strength = 0.200000000;
const float p_o29354222422762_translate_x = 0.000000000;
const float p_o29354222422762_translate_y = 0.000000000;
const float p_o29354222422762_rotate = 90.000000000;
const float p_o29354222422762_scale_x = 1.000000000;
const float p_o29354222422762_scale_y = 1.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 1024.000000000;
const float p_o29354255982630_translate_x = 0.000000000;
const float p_o29354255982630_translate_y = -0.150000000;
const float p_o29354255982630_rotate = 0.000000000;
const float p_o29354255982630_scale_x = 1.000000000;
const float p_o29354255982630_scale_y = 1.000000000;
const float p_o29354591528576_default_in2 = -0.500000000;
const float p_o29352611813586_repeat = 5.000000000;
const float p_o29352611813586_rotate = 90.000000000;
const float p_o29352611813586_gradient_pos[2] = float[]( 0.000000000, 0.983388424 );
const vec4 p_o29352611813586_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float seed_o29354272758813 = 0.000000000;
const float p_o29354272758813_density = 0.350000000;
// #globals: colorize (o29354306314711)
// #globals: blend
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
// #globals: adjust_hsv
vec3 rgb_to_hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
	vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
vec3 hsv_to_rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
// #globals: blend2 (o29354289539172)
float blend_linear_light_f(float c1, float c2) {
	return (c1 + 2.0 * c2) - 1.0;
}
vec3 blend_linear_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
return opacity*vec3(blend_linear_light_f(c1.x, c2.x), blend_linear_light_f(c1.y, c2.y), blend_linear_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_vivid_light_f(float c1, float c2) {
	return (c1 < 0.5) ? 1.0 - (1.0 - c2) / (2.0 * c1) : c2 / (2.0 * (1.0 - c1));
}
vec3 blend_vivid_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_vivid_light_f(c1.x, c2.x), blend_vivid_light_f(c1.y, c2.y), blend_vivid_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_pin_light_f( float c1, float c2) {
	return (2.0 * c1 - 1.0 > c2) ? 2.0 * c1 - 1.0 : ((c1 < 0.5 * c2) ? 2.0 * c1 : c2);
}
vec3 blend_pin_light(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_pin_light_f(c1.x, c2.x), blend_pin_light_f(c1.y, c2.y), blend_pin_light_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_hard_mix_f(float c1, float c2) {
	return floor(c1 + c2);
}
vec3 blend_hard_mix(vec2 uv, vec3 c1, vec3 c2, float opacity) {
		return opacity*vec3(blend_hard_mix_f(c1.x, c2.x), blend_hard_mix_f(c1.y, c2.y), blend_hard_mix_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
float blend_exclusion_f(float c1, float c2) {
	return c1 + c2 - 2.0 * c1 * c2;
}
vec3 blend_exclusion(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	return opacity*vec3(blend_exclusion_f(c1.x, c2.x), blend_exclusion_f(c1.y, c2.y), blend_exclusion_f(c1.z, c2.z)) + (1.0-opacity)*c2;
}
vec3 blend_hue(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	vec3 outcol = c2;
	vec3 hsv, hsv2, tmp;
	hsv2 = rgb_to_hsv(c1);
	if (hsv2.y != 0.0) {
		hsv = rgb_to_hsv(outcol);
		hsv.x = hsv2.x;
		tmp = hsv_to_rgb(hsv);
		outcol = mix(outcol, tmp, opacity);
	}
	return outcol;
}
vec3 blend_saturation(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 outcol = c2;
	vec3 hsv, hsv2;
	hsv = rgb_to_hsv(outcol);
	if (hsv.y != 0.0) {
		hsv2 = rgb_to_hsv(c1);
		hsv.y = facm * hsv.y + opacity * hsv2.y;
		outcol = hsv_to_rgb(hsv);
	}
	return outcol;
}
vec3 blend_color(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 outcol = c2;
	vec3 hsv, hsv2, tmp;
	hsv2 = rgb_to_hsv(c1);
	if (hsv2.y != 0.0) {
		hsv = rgb_to_hsv(outcol);
		hsv.x = hsv2.x;
		hsv.y = hsv2.y;
		tmp = hsv_to_rgb(hsv);
		outcol = mix(outcol, tmp, opacity);
	}
	return outcol;
}
vec3 blend_value(vec2 uv, vec3 c1, vec3 c2, float opacity) {
	float facm = 1.0 - opacity;
	vec3 hsv, hsv2;
	hsv = rgb_to_hsv(c2);
	hsv2 = rgb_to_hsv(c1);
	hsv.z = facm * hsv.z + opacity * hsv2.z;
	return hsv_to_rgb(hsv);
}
// #globals: transform2_3 (o29354574751221)
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
// #globals: math (o29354591528576)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
vec4 o29354306314711_gradient_gradient_fct(float x) {
  if (x < p_o29354306314711_gradient_pos[0]) {
    return p_o29354306314711_gradient_col[0];
  } else if (x < p_o29354306314711_gradient_pos[1]) {
    return mix(p_o29354306314711_gradient_col[0], p_o29354306314711_gradient_col[1], ((x-p_o29354306314711_gradient_pos[0])/(p_o29354306314711_gradient_pos[1]-p_o29354306314711_gradient_pos[0])));
  } else if (x < p_o29354306314711_gradient_pos[2]) {
    return mix(p_o29354306314711_gradient_col[1], p_o29354306314711_gradient_col[2], ((x-p_o29354306314711_gradient_pos[1])/(p_o29354306314711_gradient_pos[2]-p_o29354306314711_gradient_pos[1])));
  } else if (x < p_o29354306314711_gradient_pos[3]) {
    return mix(p_o29354306314711_gradient_col[2], p_o29354306314711_gradient_col[3], ((x-p_o29354306314711_gradient_pos[2])/(p_o29354306314711_gradient_pos[3]-p_o29354306314711_gradient_pos[2])));
  } else if (x < p_o29354306314711_gradient_pos[4]) {
    return mix(p_o29354306314711_gradient_col[3], p_o29354306314711_gradient_col[4], ((x-p_o29354306314711_gradient_pos[3])/(p_o29354306314711_gradient_pos[4]-p_o29354306314711_gradient_pos[3])));
  }
  return p_o29354306314711_gradient_col[4];
}
vec4 o29352611813586_gradient_gradient_fct(float x) {
  if (x < p_o29352611813586_gradient_pos[0]) {
    return p_o29352611813586_gradient_col[0];
  } else if (x < p_o29352611813586_gradient_pos[1]) {
    return mix(p_o29352611813586_gradient_col[0], p_o29352611813586_gradient_col[1], ((x-p_o29352611813586_gradient_pos[0])/(p_o29352611813586_gradient_pos[1]-p_o29352611813586_gradient_pos[0])));
  }
  return p_o29352611813586_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
vec4 o29353182239007_0 = textureLod(texture_1, ((floor(fract((fract(transform2((uv), vec2(p_o29354222422762_translate_x*(2.0*1.0-1.0), p_o29354222422762_translate_y*(2.0*1.0-1.0)), p_o29354222422762_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29354222422762_scale_x*(2.0*1.0-1.0), p_o29354222422762_scale_y*(2.0*1.0-1.0)))))) * texture_1_size)+vec2(0.5))/texture_1_size), 0.0);

// #output0: transform2 (o29354222422762)
vec4 o29354222422762_0_1_rgba = o29353182239007_0;

// #code: math (o29354591528576)
float o29354591528576_0_clamp_false = (elapsed_time)*p_o29354591528576_default_in2;
float o29354591528576_0_clamp_true = clamp(o29354591528576_0_clamp_false, 0.0, 1.0);
// #output0: math (o29354591528576)
float o29354591528576_0_1_f = o29354591528576_0_clamp_false;

// #code: gradient (o29352611813586)
float o29352611813586_0_r = 0.5+(cos(p_o29352611813586_rotate*0.01745329251)*((transform2(((uv) + vec2(cos(p_o29354239202777_angle * 1.0 * 0.01745329251), sin(p_o29354239202777_angle * 1.0 * 0.01745329251)) * ((dot((o29354222422762_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o29354239202777_strength ), vec2(p_o29354255982630_translate_x*(2.0*1.0-1.0), p_o29354255982630_translate_y*(2.0*o29354591528576_0_1_f-1.0)), p_o29354255982630_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29354255982630_scale_x*(2.0*1.0-1.0), p_o29354255982630_scale_y*(2.0*1.0-1.0)))).x-0.5)+sin(p_o29352611813586_rotate*0.01745329251)*((transform2(((uv) + vec2(cos(p_o29354239202777_angle * 1.0 * 0.01745329251), sin(p_o29354239202777_angle * 1.0 * 0.01745329251)) * ((dot((o29354222422762_0_1_rgba).rgb, vec3(1.0))/3.0) - 0.5) * p_o29354239202777_strength ), vec2(p_o29354255982630_translate_x*(2.0*1.0-1.0), p_o29354255982630_translate_y*(2.0*o29354591528576_0_1_f-1.0)), p_o29354255982630_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29354255982630_scale_x*(2.0*1.0-1.0), p_o29354255982630_scale_y*(2.0*1.0-1.0)))).y-0.5))/(cos(abs(mod(p_o29352611813586_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient (o29352611813586)
vec4 o29352611813586_0_1_rgba = o29352611813586_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o29352611813586_0_r*p_o29352611813586_repeat)-0.5)) : fract(o29352611813586_0_r*p_o29352611813586_repeat));

// #output0: transform2_2 (o29354255982630)
vec4 o29354255982630_0_1_rgba = o29352611813586_0_1_rgba;

// #output0: directional_warp (o29354239202777)
vec4 o29354239202777_0_1_rgba = o29354255982630_0_1_rgba;

// #code: noise2 (o29354272758813)
vec2 o29354272758813_0_uv = floor((transform2((uv), vec2(p_o29354574751221_translate_x*(2.0*1.0-1.0), p_o29354574751221_translate_y*(2.0*(dot((o29354239202777_0_1_rgba).rgb, vec3(1.0))/3.0)-1.0)), p_o29354574751221_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29354574751221_scale_x*(2.0*1.0-1.0), p_o29354574751221_scale_y*(2.0*1.0-1.0))))*128.0);
// #output0: noise2 (o29354272758813)
float o29354272758813_0_1_f = step(rand(o29354272758813_0_uv+vec2((seed_o29354272758813+fract(_seed_variation_)))), p_o29354272758813_density);

// #output0: transform2_3 (o29354574751221)
vec4 o29354574751221_0_1_rgba = vec4(vec3(o29354272758813_0_1_f), 1.0);

// #code: blend2 (o29354289539172)
vec4 o29354289539172_0_b = o29354239202777_0_1_rgba;
vec4 o29354289539172_0_l;
float o29354289539172_0_a;

o29354289539172_0_l = o29354574751221_0_1_rgba;
o29354289539172_0_a = p_o29354289539172_amount1*1.0;
o29354289539172_0_b = vec4(blend_overlay((uv), o29354289539172_0_l.rgb, o29354289539172_0_b.rgb, o29354289539172_0_a*o29354289539172_0_l.a), min(1.0, o29354289539172_0_b.a+o29354289539172_0_a*o29354289539172_0_l.a));
// #output0: blend2 (o29354289539172)
vec4 o29354289539172_0_1_rgba = o29354289539172_0_b;

// #output0: colorize (o29354306314711)
vec4 o29354306314711_0_1_rgba = o29354306314711_gradient_gradient_fct((dot((o29354289539172_0_1_rgba).rgb, vec3(1.0))/3.0));

	vec3 albedo_tex = ((o29354306314711_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o29352595034878_albedo_color.rgb;
	METALLIC = 1.0*p_o29352595034878_metallic;
	ROUGHNESS = 1.0*p_o29352595034878_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o29352595034878_normal;
	EMISSION = vec3(0.0)*p_o29352595034878_emission_energy;
}



