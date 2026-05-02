shader_type canvas_item;

render_mode unshaded, blend_mix;

uniform vec3 uv1_scale = vec3(1.0, 1.0, 1.0);
uniform vec3 uv1_offset = vec3(0.0, 0.0, 0.0);
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
const float seed_o3157035847033 = 0.695477247;
const float p_o3157035847033_sx = 1.132400000;
const float p_o3157035847033_sy = 1.121000000;
const float p_o3157035847033_rotate = 0.000000000;
const float p_o3157035847033_scale = 0.000000000;
const float p_o3156633193528_default_in1 = 0.000000000;
const float p_o3156633193528_default_in2 = 0.000000000;
const float p_o3156616417090_sides = 4.000000000;
const float p_o3156616417090_radius = 0.971400000;
const float p_o3156616417090_edge = 0.000000000;
const float p_o3156532530243_translate_x = 0.000000000;
const float p_o3156532530243_translate_y = 0.500000000;
const float p_o3156532530243_rotate = 0.000000000;
const float p_o3156532530243_scale_x = 4.000000000;
const float p_o3156532530243_scale_y = 4.000000000;
const float p_o3156666747717_default_in1 = 0.000000000;
const float p_o3156666747717_default_in2 = 0.059200000;
const float p_o3156683524518_default_in1 = 0.000000000;
const float p_o3156683524518_default_in2 = 0.000000000;
const float p_o3156700302338_curve_0_x = 0.000000000;
const float p_o3156700302338_curve_0_y = 0.000000000;
const float p_o3156700302338_curve_0_ls = 0.000000000;
const float p_o3156700302338_curve_0_rs = 0.000000000;
const float p_o3156700302338_curve_1_x = 0.500000000;
const float p_o3156700302338_curve_1_y = 0.500000000;
const float p_o3156700302338_curve_1_ls = 3.000000000;
const float p_o3156700302338_curve_1_rs = 3.000000000;
const float p_o3156700302338_curve_2_x = 1.000000000;
const float p_o3156700302338_curve_2_y = 1.000000000;
const float p_o3156700302338_curve_2_ls = 0.000000000;
const float p_o3156700302338_curve_2_rs = 0.000000000;
const float p_o3156985514444_default_in1 = 0.000000000;
const float p_o3156985514444_default_in2 = 0.000000000;
const float p_o3157321058933_default_in1 = 0.000000000;
const float p_o3157321058933_default_in2 = 0.000000000;
const float seed_o3157354613116 = 0.436773062;
const float p_o3156649970067_default_in1 = 0.000000000;
const float p_o3156649970067_default_in2 = 0.000000000;
const float seed_o3156549306928 = 0.223256305;
const float p_o3156549306928_tx = 1.000000000;
const float p_o3156549306928_ty = 4.000000000;
const float p_o3156549306928_overlap = 2.000000000;
const float p_o3156549306928_scale_x = 0.300000000;
const float p_o3156549306928_scale_y = 0.300000000;
const float p_o3156549306928_fixed_offset = 0.000000000;
const float p_o3156549306928_offset = 0.000000000;
const float p_o3156549306928_rotate = 0.000000000;
const float p_o3156549306928_scale = 0.000000000;
const float p_o3156549306928_value = 0.000000000;
const float p_o3157304281990_amount1 = 1.000000000;
const float p_o3157304281990_amount2 = 1.000000000;
const float p_o3156180208442_translate_x = 10.000000000;
const float p_o3156180208442_translate_y = -0.057500000;
const float p_o3156180208442_rotate = 0.000000000;
const float p_o3156180208442_scale_x = 18.000000000;
const float p_o3156180208442_scale_y = 18.000000000;
const float p_o3156431866381_default_in1 = 0.000000000;
const float p_o3156431866381_default_in2 = 25.000000000;
const float seed_o3156163431446 = 0.514440417;
uniform sampler2D texture_1;
const float p_o3156465421172_amount1 = 1.000000000;
const float p_o3156448644089_value = 8.000000000;
const float p_o3156448644089_width = 1.000000000;
const float p_o3156448644089_contrast = 1.000000000;
const float p_o3156498975143_translate_x = 0.282500000;
const float p_o3156498975143_translate_y = 0.228750000;
const float p_o3156498975143_rotate = 0.000000000;
const float p_o3156498975143_scale_x = 0.500000000;
const float p_o3156498975143_scale_y = 0.500000000;
const float p_o3156482198526_sides = 4.000000000;
const float p_o3156482198526_radius = 0.850000000;
const float p_o3156482198526_edge = 0.000000000;
const float p_o3156515753255_color = 0.000000000;
const float p_o3156415089555_value = 0.298100000;
const float p_o3156415089555_width = 0.000000000;
const float p_o3156196985387_repeat = 1.000000000;
const float p_o3156196985387_rotate = 0.000000000;
const float p_o3156196985387_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o3156196985387_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float seed_o3157019068905 = 0.000000000;
const float p_o3157002292443_repeat = 1.000000000;
const float p_o3157002292443_rows = 4.000000000;
const float p_o3157002292443_columns = 4.000000000;
const float p_o3157002292443_row_offset = 0.000000000;
const float p_o3157002292443_mortar = 0.050000000;
const float p_o3157002292443_bevel = 0.050000000;
const float p_o3157002292443_round = 0.000000000;
const float p_o3157002292443_corner = 0.300000000;
// #globals: math_5 (o3156633193528)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: shape_2 (o3156616417090)
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
// #globals: transform2_3 (o3156532530243)
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
// #globals: tonality (o3156700302338)
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
// #globals: blend2_2 (o3157304281990)
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
// #globals: shader_1 (o3157388169259)
vec4 o953482752540_gradient_gradient_fct(float x) {
  float p_o953482752540_gradient_pos[26] = float[]( 0.000000000, 0.038597342, 0.076765217, 0.111116365, 0.155009493, 0.183635443, 0.214169800, 0.256154537, 0.303864449, 0.338215590, 0.378291935, 0.414551467, 0.460353017, 0.515696526, 0.553864479, 0.592032373, 0.618749976, 0.649284303, 0.687452257, 0.721803367, 0.763788104, 0.805772841, 0.840124011, 0.884017110, 0.926001847, 0.969895005 );
  vec4 p_o953482752540_gradient_col[26] = vec4[]( vec4(0.906250000, 0.906250000, 0.906250000, 1.000000000), vec4(0.871093750, 0.871093750, 0.871093750, 1.000000000), vec4(0.835937500, 0.835937500, 0.835937500, 1.000000000), vec4(0.802734375, 0.802734375, 0.802734375, 1.000000000), vec4(0.767578125, 0.767578125, 0.767578125, 1.000000000), vec4(0.738281250, 0.738281250, 0.738281250, 1.000000000), vec4(0.705078125, 0.705078125, 0.705078125, 1.000000000), vec4(0.667968750, 0.667968750, 0.667968750, 1.000000000), vec4(0.638671875, 0.638671875, 0.638671875, 1.000000000), vec4(0.619140625, 0.619140625, 0.619140625, 1.000000000), vec4(0.589843750, 0.589843750, 0.589843750, 1.000000000), vec4(0.558593750, 0.558593750, 0.558593750, 1.000000000), vec4(0.521484375, 0.521484375, 0.521484375, 1.000000000), vec4(0.480468750, 0.480468750, 0.480468750, 1.000000000), vec4(0.441406250, 0.441406250, 0.441406250, 1.000000000), vec4(0.404296875, 0.404296875, 0.404296875, 1.000000000), vec4(0.369140625, 0.369140625, 0.369140625, 1.000000000), vec4(0.332031250, 0.332031250, 0.332031250, 1.000000000), vec4(0.300781250, 0.300781250, 0.300781250, 1.000000000), vec4(0.271484375, 0.271484375, 0.271484375, 1.000000000), vec4(0.236328125, 0.236328125, 0.236328125, 1.000000000), vec4(0.201171875, 0.201171875, 0.201171875, 1.000000000), vec4(0.164062500, 0.164062500, 0.164062500, 1.000000000), vec4(0.125000000, 0.125000000, 0.125000000, 1.000000000), vec4(0.091796875, 0.091796875, 0.091796875, 1.000000000), vec4(0.050781250, 0.050781250, 0.050781250, 1.000000000) );
  if (x < p_o953482752540_gradient_pos[1]) {
    return p_o953482752540_gradient_col[0];
  } else if (x < p_o953482752540_gradient_pos[2]) {
    return p_o953482752540_gradient_col[1];
  } else if (x < p_o953482752540_gradient_pos[3]) {
    return p_o953482752540_gradient_col[2];
  } else if (x < p_o953482752540_gradient_pos[4]) {
    return p_o953482752540_gradient_col[3];
  } else if (x < p_o953482752540_gradient_pos[5]) {
    return p_o953482752540_gradient_col[4];
  } else if (x < p_o953482752540_gradient_pos[6]) {
    return p_o953482752540_gradient_col[5];
  } else if (x < p_o953482752540_gradient_pos[7]) {
    return p_o953482752540_gradient_col[6];
  } else if (x < p_o953482752540_gradient_pos[8]) {
    return p_o953482752540_gradient_col[7];
  } else if (x < p_o953482752540_gradient_pos[9]) {
    return p_o953482752540_gradient_col[8];
  } else if (x < p_o953482752540_gradient_pos[10]) {
    return p_o953482752540_gradient_col[9];
  } else if (x < p_o953482752540_gradient_pos[11]) {
    return p_o953482752540_gradient_col[10];
  } else if (x < p_o953482752540_gradient_pos[12]) {
    return p_o953482752540_gradient_col[11];
  } else if (x < p_o953482752540_gradient_pos[13]) {
    return p_o953482752540_gradient_col[12];
  } else if (x < p_o953482752540_gradient_pos[14]) {
    return p_o953482752540_gradient_col[13];
  } else if (x < p_o953482752540_gradient_pos[15]) {
    return p_o953482752540_gradient_col[14];
  } else if (x < p_o953482752540_gradient_pos[16]) {
    return p_o953482752540_gradient_col[15];
  } else if (x < p_o953482752540_gradient_pos[17]) {
    return p_o953482752540_gradient_col[16];
  } else if (x < p_o953482752540_gradient_pos[18]) {
    return p_o953482752540_gradient_col[17];
  } else if (x < p_o953482752540_gradient_pos[19]) {
    return p_o953482752540_gradient_col[18];
  } else if (x < p_o953482752540_gradient_pos[20]) {
    return p_o953482752540_gradient_col[19];
  } else if (x < p_o953482752540_gradient_pos[21]) {
    return p_o953482752540_gradient_col[20];
  } else if (x < p_o953482752540_gradient_pos[22]) {
    return p_o953482752540_gradient_col[21];
  } else if (x < p_o953482752540_gradient_pos[23]) {
    return p_o953482752540_gradient_col[22];
  } else if (x < p_o953482752540_gradient_pos[24]) {
    return p_o953482752540_gradient_col[23];
  } else if (x < p_o953482752540_gradient_pos[25]) {
    return p_o953482752540_gradient_col[24];
  }
  return p_o953482752540_gradient_col[25];
}
// #globals: custom_uv
vec2 get_from_tileset(float count, float seed, vec2 uv) {
	return clamp((uv+floor(rand2(vec2(seed))*count))/count, vec2(0.0), vec2(1.0));
}
vec2 old_custom_uv_transform(vec2 uv, vec2 cst_scale, float rnd_rotate, float rnd_scale, vec2 seed) {
	seed = rand2(seed);
	uv -= vec2(0.5);
	float angle = (seed.x * 2.0 - 1.0) * rnd_rotate;
	float ca = cos(angle);
	float sa = sin(angle);
	uv = vec2(ca*uv.x+sa*uv.y, -sa*uv.x+ca*uv.y);
	uv *= (seed.y-0.5)*2.0*rnd_scale+1.0;
	uv /= cst_scale;
	uv += vec2(0.5);
	return uv;
}
// #globals: custom_uv2 (o3157035847033)
vec2 get_from_tileset_extend(float count, float seed, vec2 uv) {
	return (uv+floor(rand2(vec2(seed))*count))/count;
}
vec2 get_from_tileset_clamp(float count, float seed, vec2 uv) {
	return clamp((uv+floor(rand2(vec2(seed))*count))/count, vec2(0.0), vec2(1.0));
}
vec2 get_from_tileset_repeat(float count, float seed, vec2 uv) {
	return fract(uv+floor(rand2(vec2(seed))*count))/count;
}
vec2 custom_uv_transform(vec2 uv, vec2 cst_scale, float rnd_rotate, float rnd_scale, vec2 seed) {
	seed = rand2(seed);
	uv -= vec2(0.5);
	float angle = (seed.x * 2.0 - 1.0) * rnd_rotate;
	float ca = cos(angle);
	float sa = sin(angle);
	uv = vec2(ca*uv.x+sa*uv.y, -sa*uv.x+ca*uv.y);
	uv *= (seed.y-0.5)*2.0*rnd_scale+1.0;
	uv /= cst_scale;
	uv += vec2(0.5);
	return uv;
}
// #globals: fill_to_uv (o3157019068905)
vec3 fill_to_uv_stretch(vec2 coord, vec4 bb, float seed) {
	vec2 uv_islands = fract(coord-bb.xy)/bb.zw;
	float random_value = rand(vec2(seed)+bb.xy+bb.zw);
	return vec3(uv_islands, random_value);
}
vec3 fill_to_uv_square(vec2 coord, vec4 bb, float seed) {
	vec2 uv_islands;
	if (bb.z > bb.w) {
		vec2 adjusted_coord = coord + vec2(0.0, (bb.z - bb.w) / 2.0);
		uv_islands = fract(adjusted_coord-bb.xy)/bb.zz;
	} else {
		vec2 adjusted_coord = coord + vec2((bb.w - bb.z) / 2.0, 0.0);
		uv_islands = fract(adjusted_coord-bb.xy)/bb.ww;
	}
	float random_value = rand(vec2(seed)+bb.xy+bb.zw);
	return vec3(uv_islands, random_value);
}
// #globals: bricks3 (o3157002292443)
vec4 brick(vec2 uv, vec2 bmin, vec2 bmax, float mortar, float round_radius, float bevel, float brick_height) {
	float color;
	vec2 size = bmax - bmin;
	float min_size = min(size.x, size.y);
	mortar *= brick_height;
	bevel *= brick_height;
	round_radius *= brick_height;
	vec2 center = 0.5*(bmin+bmax);
	vec2 d = abs(uv-center)-0.5*(size)+vec2(round_radius+mortar);
	color = length(max(d,vec2(0))) + min(max(d.x,d.y),0.0)-round_radius;
	color = clamp(-color/bevel, 0.0, 1.0);
	vec2 tiled_brick_pos = mod(bmin, vec2(1.0, 1.0));
	return vec4(color, center, tiled_brick_pos.x+7.0*tiled_brick_pos.y);
}
vec4 brick_corner_bb(vec2 uv, vec2 bmin, vec2 bmax, float mortar, float corner, float brick_height) {
	vec2 center = 0.5*(bmin + bmax);
	vec2 size = bmax - bmin;
	float max_size = max(size.x, size.y);
	float min_size = min(size.x, size.y);
	mortar *= brick_height;
	corner *= brick_height;
	
	vec2 corner1 = vec2(bmin + mortar);
	vec2 corner2 = vec2(bmax.x - mortar - corner, bmin.y + mortar);
	vec2 corner3 = vec2(bmin.x + mortar, bmax.y - mortar - corner);
	vec2 corner4 = vec2(bmax - mortar - corner);
	vec2 top = uv.x < center.x ? corner1 : corner2;
	vec2 bottom = uv.x < center.x ? corner3 : corner4;
	vec2 positions = uv.y < center.y ? top : bottom;
	return vec4(round(fract(positions)*4096.0)/4096.0, corner, corner);
}
vec4 bricks_rb(vec2 uv, vec2 count, float repeat, float offset) {
	count *= repeat;
	float x_offset = offset*step(0.5, fract(uv.y*count.y*0.5));
	vec2 bmin = floor(vec2(uv.x*count.x-x_offset, uv.y*count.y));
	bmin.x += x_offset;
	bmin /= count;
	return vec4(bmin, bmin+vec2(1.0)/count);
}
vec4 bricks_rb2(vec2 uv, vec2 count, float repeat, float offset) {
	count *= repeat;
	float x_offset = offset*step(0.5, fract(uv.y*count.y*0.5));
	count.x = count.x*(1.0+step(0.5, fract(uv.y*count.y*0.5)));
	vec2 bmin = floor(vec2(uv.x*count.x-x_offset, uv.y*count.y));
	bmin.x += x_offset;
	bmin /= count;
	return vec4(bmin, bmin+vec2(1.0)/count);
}
vec4 bricks_rb3(vec2 uv, vec2 count, float repeat, float offset) {
	vec4 bb = bricks_rb(uv, count, repeat, offset);
	
	if ( (uv.x - bb.x) / (bb.z - bb.x) < 1.0/3.0) {
		bb.z = bb.x + (bb.z - bb.x) / 3.0;
	} else {
		bb.x = bb.x + (bb.z - bb.x) / 3.0;
	}
	return bb;
}
vec4 bricks_hb(vec2 uv, vec2 count, float repeat, float offset) {
	float pc = count.x+count.y;
	float c = pc*repeat;
	vec2 corner = floor(uv*c);
	float cdiff = mod(corner.x-corner.y, pc);
	if (cdiff < count.x) {
		return vec4((corner-vec2(cdiff, 0.0))/c, (corner-vec2(cdiff, 0.0)+vec2(count.x, 1.0))/c);
	} else {
		return vec4((corner-vec2(0.0, pc-cdiff-1.0))/c, (corner-vec2(0.0, pc-cdiff-1.0)+vec2(1.0, count.y))/c);
	}
}
vec4 bricks_bw(vec2 uv, vec2 count, float repeat, float offset) {
	vec2 c = 2.0*count*repeat;
	float mc = max(c.x, c.y);
	vec2 corner1 = floor(uv*c);
	vec2 corner2 = count*floor(repeat*2.0*uv);
	float cdiff = mod(dot(floor(repeat*2.0*uv), vec2(1.0)), 2.0);
	vec2 corner;
	vec2 size;
	if (cdiff == 0.0) {
		corner = vec2(corner1.x, corner2.y);
		size = vec2(1.0, count.y);
	} else {
		corner = vec2(corner2.x, corner1.y);
		size = vec2(count.x, 1.0);
	}
	return vec4(corner/c, (corner+size)/c);
}
vec4 bricks_sb(vec2 uv, vec2 count, float repeat, float offset) {
	vec2 c = (count+vec2(1.0)) * repeat;
	float mc = max(c.x, c.y);
	vec2 corner1 = floor(uv*c);
	vec2 corner2 = (count+vec2(1.0))*floor(repeat*uv);
	vec2 rcorner = corner1 - corner2;
	vec2 corner;
	vec2 size;
	if (rcorner.x == 0.0 && rcorner.y < count.y) {
		corner = corner2;
		size = vec2(1.0, count.y);
	} else if (rcorner.y == 0.0) {
		corner = corner2+vec2(1.0, 0.0);
		size = vec2(count.x, 1.0);
	} else if (rcorner.x == count.x) {
		corner = corner2+vec2(count.x, 1.0);
		size = vec2(1.0, count.y);
	} else if (rcorner.y == count.y) {
		corner = corner2+vec2(0.0, count.y);
		size = vec2(count.x, 1.0);
	} else {
		corner = corner2+vec2(1.0);
		size = vec2(count.x-1.0, count.y-1.0);
	}
	return vec4(corner/c, (corner+size)/c);
}
float o3156700302338_curve_curve_fct(float x) {
if (x <= p_o3156700302338_curve_1_x) {
float dx = x - p_o3156700302338_curve_0_x;
float d = p_o3156700302338_curve_1_x - p_o3156700302338_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o3156700302338_curve_0_y;
float yac = p_o3156700302338_curve_0_y + d*p_o3156700302338_curve_0_rs;
float ybc = p_o3156700302338_curve_1_y - d*p_o3156700302338_curve_1_ls;
float y2 = p_o3156700302338_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o3156700302338_curve_1_x;
float d = p_o3156700302338_curve_2_x - p_o3156700302338_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o3156700302338_curve_1_y;
float yac = p_o3156700302338_curve_1_y + d*p_o3156700302338_curve_1_rs;
float ybc = p_o3156700302338_curve_2_y - d*p_o3156700302338_curve_2_ls;
float y2 = p_o3156700302338_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
vec4 o3156196985387_gradient_gradient_fct(float x) {
  if (x < p_o3156196985387_gradient_pos[0]) {
    return p_o3156196985387_gradient_col[0];
  } else if (x < p_o3156196985387_gradient_pos[1]) {
    return mix(p_o3156196985387_gradient_col[0], p_o3156196985387_gradient_col[1], ((x-p_o3156196985387_gradient_pos[0])/(p_o3156196985387_gradient_pos[1]-p_o3156196985387_gradient_pos[0])));
  }
  return p_o3156196985387_gradient_col[1];
}
float o3156549306928_input_in(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: uniform_greyscale (o3156163431446)
float o3156163431446_0_1_f = (param_rndi(0.0,24.0, (seed_o3156163431446+fract(_seed_variation_))+0.000000));
// #code: math_2 (o3156431866381)
float o3156431866381_0_clamp_false = o3156163431446_0_1_f/p_o3156431866381_default_in2;
float o3156431866381_0_clamp_true = clamp(o3156431866381_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o3156431866381)
float o3156431866381_0_1_f = o3156431866381_0_clamp_false;
// #output0: shader_1 (o3157388169259)
float o3157388169259_0_1_f = o953482752540_gradient_gradient_fct(o3156431866381_0_1_f).x;
vec4 o3155072912056_0 = textureLod(texture_1, (transform2((uv), vec2(p_o3156180208442_translate_x*(2.0*o3157388169259_0_1_f-1.0), p_o3156180208442_translate_y*(2.0*1.0-1.0)), p_o3156180208442_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o3156180208442_scale_x*(2.0*1.0-1.0), p_o3156180208442_scale_y*(2.0*1.0-1.0)))), 0.0);
// #output0: transform2 (o3156180208442)
vec4 o3156180208442_0_1_rgba = o3155072912056_0;
// #code: tones_range (o3156448644089)
float o3156448644089_0_step = clamp((o3156163431446_0_1_f - (p_o3156448644089_value))/max(0.0001, p_o3156448644089_width)+0.5, 0.0, 1.0);
float o3156448644089_0_false = clamp((min(o3156448644089_0_step, 1.0-o3156448644089_0_step) * 2.0) / (1.0 - p_o3156448644089_contrast), 0.0, 1.0);
float o3156448644089_0_true = 1.0-o3156448644089_0_false;
// #output0: tones_range (o3156448644089)
float o3156448644089_0_1_f = o3156448644089_0_false;
// #output0: shape (o3156482198526)
float o3156482198526_0_1_f = shape_polygon((transform2((uv), vec2(p_o3156498975143_translate_x*(2.0*1.0-1.0), p_o3156498975143_translate_y*(2.0*1.0-1.0)), p_o3156498975143_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o3156498975143_scale_x*(2.0*1.0-1.0), p_o3156498975143_scale_y*(2.0*1.0-1.0)))), p_o3156482198526_sides+1.0e-5, p_o3156482198526_radius*1.0, p_o3156482198526_edge*1.0);
// #output0: transform2_2 (o3156498975143)
vec4 o3156498975143_0_1_rgba = vec4(vec3(o3156482198526_0_1_f), 1.0);
// #output0: uniform_greyscale_2 (o3156515753255)
float o3156515753255_0_1_f = p_o3156515753255_color;
// #code: blend2 (o3156465421172)
vec4 o3156465421172_0_b = vec4(vec3(o3156515753255_0_1_f), 1.0);
vec4 o3156465421172_0_l;
float o3156465421172_0_a;
o3156465421172_0_l = o3156498975143_0_1_rgba;
o3156465421172_0_a = p_o3156465421172_amount1*o3156448644089_0_1_f;
o3156465421172_0_b = vec4(blend_normal((uv), o3156465421172_0_l.rgb, o3156465421172_0_b.rgb, o3156465421172_0_a*o3156465421172_0_l.a), min(1.0, o3156465421172_0_b.a+o3156465421172_0_a*o3156465421172_0_l.a));
// #output0: blend2 (o3156465421172)
vec4 o3156465421172_0_1_rgba = o3156465421172_0_b;
// #code: gradient (o3156196985387)
float o3156196985387_0_r = 0.5+(cos(p_o3156196985387_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o3156196985387_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o3156196985387_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient (o3156196985387)
vec4 o3156196985387_0_1_rgba = o3156196985387_gradient_gradient_fct(true ? 2.0*(0.5-abs(fract(o3156196985387_0_r*p_o3156196985387_repeat)-0.5)) : fract(o3156196985387_0_r*p_o3156196985387_repeat));
// #code: tones_step (o3156415089555)
vec3 o3156415089555_0_false = clamp((o3156196985387_0_1_rgba.rgb-vec3(p_o3156415089555_value))/max(0.0001, p_o3156415089555_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o3156415089555_0_true = vec3(1.0)-o3156415089555_0_false;
// #output0: tones_step (o3156415089555)
vec4 o3156415089555_0_1_rgba = vec4(o3156415089555_0_false, o3156196985387_0_1_rgba.a);
// #code: blend2_2 (o3157304281990)
vec4 o3157304281990_0_b = o3156415089555_0_1_rgba;
vec4 o3157304281990_0_l;
float o3157304281990_0_a;
o3157304281990_0_l = o3156465421172_0_1_rgba;
o3157304281990_0_a = p_o3157304281990_amount1*1.0;
o3157304281990_0_b = vec4(blend_difference(uv, o3157304281990_0_l.rgb, o3157304281990_0_b.rgb, o3157304281990_0_a*o3157304281990_0_l.a), min(1.0, o3157304281990_0_b.a+o3157304281990_0_a*o3157304281990_0_l.a));
o3157304281990_0_l = o3156180208442_0_1_rgba;
o3157304281990_0_a = p_o3157304281990_amount2*1.0;
o3157304281990_0_b = vec4(blend_multiply(uv, o3157304281990_0_l.rgb, o3157304281990_0_b.rgb, o3157304281990_0_a*o3157304281990_0_l.a), min(1.0, o3157304281990_0_b.a+o3157304281990_0_a*o3157304281990_0_l.a));
// #output0: blend2_2 (o3157304281990)
vec4 o3157304281990_0_1_rgba = o3157304281990_0_b;
return (dot((o3157304281990_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: tiler (o3156549306928)
vec4 tiler_o3156549306928(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_, vec4 _controlled_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o3156549306928_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o3156549306928_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o3156549306928_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o3156549306928_scale+1.0;
				pv /= vec2(p_o3156549306928_scale_x, p_o3156549306928_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o3156549306928_input_in(pv, true ? seed.x : 0.0, _controlled_variation_)*mask*(1.0-p_o3156549306928_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
vec4 o3157035847033_input_in1(vec2 uv, float _seed_variation_, vec4 _controlled_variation_) {
// #output0: shape_2 (o3156616417090)
float o3156616417090_0_1_f = shape_polygon((uv), p_o3156616417090_sides+1.0e-5, p_o3156616417090_radius*1.0, p_o3156616417090_edge*1.0);
// #output0: uniform_greyscale_5 (o3157354613116)
float o3157354613116_0_1_f = (param_rnd(-3.0,2.0, (seed_o3157354613116+fract(_seed_variation_))+0.500000));
// #output0: uniform_greyscale_4 (o3157337835726)
float o3157337835726_0_1_f = (elapsed_time*0.5);
// #code: math (o3157321058933)
float o3157321058933_0_clamp_false = o3157337835726_0_1_f*o3157354613116_0_1_f;
float o3157321058933_0_clamp_true = clamp(o3157321058933_0_clamp_false, 0.0, 1.0);
// #output0: math (o3157321058933)
float o3157321058933_0_1_f = o3157321058933_0_clamp_false;
// #code: math_8 (o3156985514444)
float o3156985514444_0_clamp_false = fract(o3157321058933_0_1_f);
float o3156985514444_0_clamp_true = clamp(o3156985514444_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o3156985514444)
float o3156985514444_0_1_f = o3156985514444_0_clamp_false;
// #output0: tonality (o3156700302338)
float o3156700302338_0_1_f = o3156700302338_curve_curve_fct(o3156985514444_0_1_f);
// #code: math_4 (o3156649970067)
float o3156649970067_0_clamp_false = floor(o3157321058933_0_1_f);
float o3156649970067_0_clamp_true = clamp(o3156649970067_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o3156649970067)
float o3156649970067_0_1_f = o3156649970067_0_clamp_false;
// #code: math_7 (o3156683524518)
float o3156683524518_0_clamp_false = o3156649970067_0_1_f+o3156700302338_0_1_f;
float o3156683524518_0_clamp_true = clamp(o3156683524518_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o3156683524518)
float o3156683524518_0_1_f = o3156683524518_0_clamp_false;
// #code: math_6 (o3156666747717)
float o3156666747717_0_clamp_false = o3156683524518_0_1_f+p_o3156666747717_default_in2;
float o3156666747717_0_clamp_true = clamp(o3156666747717_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o3156666747717)
float o3156666747717_0_1_f = o3156666747717_0_clamp_false;
// #code: tiler (o3156549306928)
vec3 o3156549306928_0_instance_uv = vec3(0.0);
vec4 o3156549306928_0_rch = tiler_o3156549306928((fract(transform2((uv), vec2(p_o3156532530243_translate_x*(2.0*1.0-1.0), p_o3156532530243_translate_y*(2.0*o3156666747717_0_1_f-1.0)), p_o3156532530243_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o3156532530243_scale_x*(2.0*1.0-1.0), p_o3156532530243_scale_y*(2.0*1.0-1.0))))), vec2(p_o3156549306928_tx, p_o3156549306928_ty), int(p_o3156549306928_overlap), o3156549306928_0_instance_uv, vec2(float((seed_o3156549306928+fract(_seed_variation_)))), _seed_variation_, _controlled_variation_);
// #output0: tiler (o3156549306928)
float o3156549306928_0_1_f = o3156549306928_0_rch.a;
// #output0: transform2_3 (o3156532530243)
vec4 o3156532530243_0_1_rgba = vec4(vec3(o3156549306928_0_1_f), 1.0);
// #code: math_5 (o3156633193528)
float o3156633193528_0_clamp_false = (dot((o3156532530243_0_1_rgba).rgb, vec3(1.0))/3.0)*o3156616417090_0_1_f;
float o3156633193528_0_clamp_true = clamp(o3156633193528_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o3156633193528)
float o3156633193528_0_1_f = o3156633193528_0_clamp_false;
return vec4(vec3(o3156633193528_0_1_f), 1.0);
}
void fragment() {
	float _seed_variation_ = variation;
	vec4 _controlled_variation_ = vec4(0.0);
	vec2 uv = fract(UV);

// #code: bricks3 (o3157002292443)
vec4 o3157002292443_0_rect = bricks_rb((uv), vec2(p_o3157002292443_columns, p_o3157002292443_rows), p_o3157002292443_repeat, p_o3157002292443_row_offset);
vec4 o3157002292443_0 = brick((uv), o3157002292443_0_rect.xy, o3157002292443_0_rect.zw, p_o3157002292443_mortar*1.0, p_o3157002292443_round*1.0, max(0.001, p_o3157002292443_bevel*1.0), 1.0 / p_o3157002292443_rows);
// #output1: bricks3 (o3157002292443)
vec4 o3157002292443_1_1_fill = round(vec4(fract(o3157002292443_0_rect.xy), o3157002292443_0_rect.zw - o3157002292443_0_rect.xy)*4096.0)/4096.0;

// #code: fill_to_uv (o3157019068905)
vec4 o3157019068905_0_bb = o3157002292443_1_1_fill;
// #output0: fill_to_uv (o3157019068905)
vec3 o3157019068905_0_1_rgb = fill_to_uv_stretch((uv), o3157019068905_0_bb, float((seed_o3157019068905+fract(_seed_variation_))));

// #code: custom_uv2 (o3157035847033)
vec3 o3157035847033_0_map = o3157019068905_0_1_rgb;
float o3157035847033_0_rnd =  float((seed_o3157035847033+fract(_seed_variation_)))+o3157035847033_0_map.z;
// #output0: custom_uv2 (o3157035847033)
vec4 o3157035847033_0_1_rgba = o3157035847033_input_in1(get_from_tileset_clamp(1.0, o3157035847033_0_rnd, custom_uv_transform(o3157035847033_0_map.xy, vec2(p_o3157035847033_sx, p_o3157035847033_sy), p_o3157035847033_rotate*0.01745329251, p_o3157035847033_scale, vec2(o3157035847033_0_map.z, float((seed_o3157035847033+fract(_seed_variation_)))))), true ? o3157035847033_0_rnd : 0.0, _controlled_variation_);

	vec4 color_tex = o3157035847033_0_1_rgba;
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	COLOR = color_tex;
}



