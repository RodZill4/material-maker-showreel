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
const float o732577150150_r1 = 0.004600000;
const float o732577150150_r0 = 0.436800000;
const float o732577150150_r2 = 0.012100000;
const float o732577150150_r1b = -0.001000000;
const float o732577150150_r1a = 0.006400000;
const vec4 p_o732392600761_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o732392600761_metallic = 1.000000000;
const float p_o732392600761_roughness = 1.000000000;
const float p_o732392600761_emission_energy = 1.000000000;
const float p_o732392600761_normal = 1.000000000;
const float p_o732392600761_ao = 1.000000000;
const float p_o732392600761_depth_scale = 0.000000000;
const float p_o754337199664_amount = 0.018800000;
const float p_o754337199664_eps = 0.090000000;
uniform sampler2D texture_1;
const float texture_1_size = 512.000000000;
const float p_o754135873066_amount = 0.057800000;
const float p_o754135873066_eps = 0.100000000;
const float seed_o752407819768 = 0.888865709;
const float p_o752407819768_sx = 1.000000000;
const float p_o752407819768_sy = 1.000000000;
const float p_o752407819768_rotate = 0.000000000;
const float p_o752407819768_scale = 0.000000000;
uniform sampler2D texture_2;
const float texture_2_size = 512.000000000;
const float p_o747290768829_amount = 2.000000000;
const float p_o752072275440_default_in1 = 0.000000000;
const float p_o752072275440_default_in2 = 0.000000000;
const float p_o752055498223_sides = 6.000000000;
const float p_o752055498223_radius = 0.057900000;
const float p_o752055498223_edge = 0.210000000;
const float p_o745663378826_translate_x = 0.000000000;
const float p_o745663378826_translate_y = 0.000000000;
const float p_o745663378826_rotate = 0.000000000;
const float p_o745663378826_scale_x = 0.900000000;
const float p_o745663378826_scale_y = 0.900000000;
const float p_o747190105527_amount1 = 1.000000000;
const float seed_o747122996659 = 0.137725145;
const float p_o747122996659_cx = 0.000000000;
const float p_o747122996659_cy = 0.000000000;
const float p_o744992290157_translate_x = 0.000000000;
const float p_o744992290157_translate_y = -0.159450000;
const float p_o744992290157_rotate = 0.000000000;
const float p_o744992290157_scale_x = 0.500000000;
const float p_o744992290157_scale_y = 0.500000000;
uniform sampler2D texture_3;
const float texture_3_size = 2048.000000000;
const float seed_o754320422447 = 0.137725145;
const float p_o754320422447_cx = 0.000000000;
const float p_o754320422447_cy = 0.000000000;
const float p_o742324712763_translate_x = 0.000000000;
const float p_o742324712763_translate_y = -0.131800000;
const float p_o742324712763_rotate = 0.000000000;
const float p_o742324712763_scale_x = 0.300000000;
const float p_o742324712763_scale_y = 0.300000000;
uniform sampler2D texture_4;
const float texture_4_size = 2048.000000000;
const float p_o754572080696_amount1 = 1.000000000;
const float p_o752089052654_color = 0.820000000;
const float p_o754555303479_default_in1 = 0.000000000;
const float p_o754555303479_default_in2 = 0.253200000;
const float p_o745713710475_amount1 = 1.000000000;
const float p_o745696933256_bevel = 0.000000000;
const float p_o745696933256_base = 0.000000000;
const float p_o745730487692_r = 0.027800000;
const float p_o745730487692_ripples = 1.000000000;
const float p_o745680156041_r = 0.453100000;
const float p_o745680156041_cx = 0.000000000;
const float p_o745680156041_cy = 0.000000000;
const float p_o752441374201_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o752441374201_gradient_col[2] = vec4[]( vec4(0.781250000, 0.781250000, 0.781250000, 1.000000000), vec4(0.810546875, 0.673757195, 0.367279053, 1.000000000) );
const float seed_o752659478013 = 0.701378524;
const float p_o753565447699_amount1 = 1.000000000;
const float p_o754102318632_amount1 = 0.440000000;
const float seed_o754085541415 = 0.028313069;
const float p_o754085541415_scale_x = 4.000000000;
const float p_o754085541415_scale_y = 4.000000000;
const float p_o754085541415_folds = 0.000000000;
const float p_o754085541415_iterations = 8.000000000;
const float p_o754085541415_persistence = 1.000000000;
const float p_o754085541415_offset = 0.000000000;
const vec4 p_o754119095849_color = vec4(0.783203125, 0.783203125, 0.783203125, 1.000000000);
const float p_o753313789454_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o753313789454_gradient_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.958984375, 0.905252218, 0.767936707, 1.000000000) );
const float seed_o753531893266 = 0.518876672;
const float p_o742291158334_amount1 = 1.000000000;
const float p_o747106219441_amount1 = 1.000000000;
const float p_o747089442226_amount1 = 0.770000000;
uniform sampler2D texture_5;
const float texture_5_size = 2048.000000000;
const float p_o750210004447_d = 0.002800000;
uniform sampler2D texture_6;
const float texture_6_size = 1024.000000000;
uniform sampler2D texture_7;
const float texture_7_size = 1024.000000000;
uniform sampler2D texture_8;
const float texture_8_size = 1024.000000000;
const float p_o745797596560_amount1 = 1.000000000;
uniform sampler2D texture_9;
const float texture_9_size = 2048.000000000;
const float p_o748213515721_d = 0.009600000;
uniform sampler2D texture_10;
const float texture_10_size = 1024.000000000;
uniform sampler2D texture_11;
const float texture_11_size = 1024.000000000;
uniform sampler2D texture_12;
const float texture_12_size = 1024.000000000;
const vec4 p_o742307935545_color = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
uniform sampler2D texture_13;
const float texture_13_size = 1024.000000000;
const float p_o752105829873_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o752105829873_gradient_col[2] = vec4[]( vec4(0.503906250, 0.503906250, 0.503906250, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o753582224917_amount1 = 0.500000000;
const float p_o753615779351_color = 0.140000000;
const float p_o753699665436_amount1 = 1.000000000;
const float p_o754068764197_default_in1 = 0.000000000;
const float p_o754068764197_default_in2 = 0.000000000;
const float p_o753716442653_sides = 6.000000000;
const float p_o753716442653_radius = 0.730000000;
const float p_o753716442653_edge = 0.000000000;
const float p_o753733219870_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o753733219870_gradient_col[2] = vec4[]( vec4(0.531250000, 0.531250000, 0.531250000, 1.000000000), vec4(0.347656250, 0.347656250, 0.347656250, 1.000000000) );
const float seed_o753951323682 = 0.972015023;
const float p_o753951323682_sx = 1.000000000;
const float p_o753951323682_sy = 1.000000000;
const float p_o753951323682_rotate = 0.000000000;
const float p_o753951323682_scale = 0.000000000;
uniform sampler2D texture_14;
const float texture_14_size = 1024.000000000;
const float p_o753968100900_translate_x = 0.000000000;
const float p_o753968100900_translate_y = 0.000000000;
const float p_o753968100900_rotate = 0.000000000;
const float p_o753968100900_scale_x = 1.000000000;
const float p_o753968100900_scale_y = 1.000000000;
const float p_o753599002134_color = 0.070000000;
uniform sampler2D texture_15;
const float texture_15_size = 1024.000000000;
const float p_o752424596982_amount1 = 1.000000000;
// #globals: invert_4 (o752676255231)
// #globals: math_3 (o752072275440)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: shape_5 (o752055498223)
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
// #globals: transform2_2 (o745663378826)
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
// #globals: blend2_8 (o747190105527)
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
// #globals: rotate_2 (o747122996659)
vec2 rotate(vec2 uv, float rotate) {
 	vec2 rv;
	rv.x = cos(rotate)*uv.x + sin(rotate)*uv.y;
	rv.y = -sin(rotate)*uv.x + cos(rotate)*uv.y;
	return rv;	
}
// #globals: sdannularshape_4 (o745730487692)
float sdRipples(float d, float w, int r) {
	for (int i = 0; i < r; ++i) {
		d = abs(d)-w;
	}
	return d;
}
// #globals: fbm3 (o754085541415)
float value_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float p00 = rand(mod(o, size));
	float p01 = rand(mod(o + vec2(0.0, 1.0), size));
	float p10 = rand(mod(o + vec2(1.0, 0.0), size));
	float p11 = rand(mod(o + vec2(1.0, 1.0), size));
	p00 = sin(p00 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p01 = sin(p01 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p10 = sin(p10 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	p11 = sin(p11 * 6.28318530718 + offset * 6.28318530718) / 2.0 + 0.5;
	vec2 t =  f * f * f * (f * (f * 6.0 - 15.0) + 10.0);
	return mix(mix(p00, p10, t.x), mix(p01, p11, t.x), t.y);
}
float fbm_2d_value(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = value_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float perlin_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float a00 = rand(mod(o, size)) * 6.28318530718 + offset * 6.28318530718;
	float a01 = rand(mod(o + vec2(0.0, 1.0), size)) * 6.28318530718 + offset * 6.28318530718;
	float a10 = rand(mod(o + vec2(1.0, 0.0), size)) * 6.28318530718 + offset * 6.28318530718;
	float a11 = rand(mod(o + vec2(1.0, 1.0), size)) * 6.28318530718 + offset * 6.28318530718;
	vec2 v00 = vec2(cos(a00), sin(a00));
	vec2 v01 = vec2(cos(a01), sin(a01));
	vec2 v10 = vec2(cos(a10), sin(a10));
	vec2 v11 = vec2(cos(a11), sin(a11));
	float p00 = dot(v00, f);
	float p01 = dot(v01, f - vec2(0.0, 1.0));
	float p10 = dot(v10, f - vec2(1.0, 0.0));
	float p11 = dot(v11, f - vec2(1.0, 1.0));
	vec2 t =  f * f * f * (f * (f * 6.0 - 15.0) + 10.0);
	return 0.5 + mix(mix(p00, p10, t.x), mix(p01, p11, t.x), t.y);
}
float fbm_2d_perlin(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = perlin_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float perlinabs_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	return abs(2.0*perlin_noise_2d(coord, size, offset, seed)-1.0);
}
float fbm_2d_perlinabs(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = perlinabs_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float fbm_2d_mod289(float x) {
	return x - floor(x * (1.0 / 289.0)) * 289.0;
}
float fbm_2d_permute(float x) {
	return fbm_2d_mod289(((x * 34.0) + 1.0) * x);
}
vec2 fbm_2d_rgrad2(vec2 p, float rot, float seed) {
	float u = fbm_2d_permute(fbm_2d_permute(p.x) + p.y) * 0.0243902439 + rot; // Rotate by shift
	u = fract(u+seed) * 6.28318530718; // 2*pi
	return vec2(cos(u), sin(u));
}
float simplex_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	coord *= 2.0; // needed for it to tile
	coord += rand2(vec2(seed, 1.0-seed)) + size;
	size *= 2.0; // needed for it to tile
	coord.y += 0.001;
	vec2 uv = vec2(coord.x + coord.y*0.5, coord.y);
	vec2 i0 = floor(uv);
	vec2 f0 = fract(uv);
	vec2 i1 = (f0.x > f0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
	vec2 p0 = vec2(i0.x - i0.y * 0.5, i0.y);
	vec2 p1 = vec2(p0.x + i1.x - i1.y * 0.5, p0.y + i1.y);
	vec2 p2 = vec2(p0.x + 0.5, p0.y + 1.0);
	i1 = i0 + i1;
	vec2 i2 = i0 + vec2(1.0, 1.0);
	vec2 d0 = coord - p0;
	vec2 d1 = coord - p1;
	vec2 d2 = coord - p2;
	vec3 xw = mod(vec3(p0.x, p1.x, p2.x), size.x);
	vec3 yw = mod(vec3(p0.y, p1.y, p2.y), size.y);
	vec3 iuw = xw + 0.5 * yw;
	vec3 ivw = yw;
	vec2 g0 = fbm_2d_rgrad2(vec2(iuw.x, ivw.x), offset, seed);
	vec2 g1 = fbm_2d_rgrad2(vec2(iuw.y, ivw.y), offset, seed);
	vec2 g2 = fbm_2d_rgrad2(vec2(iuw.z, ivw.z), offset, seed);
	vec3 w = vec3(dot(g0, d0), dot(g1, d1), dot(g2, d2));
	vec3 t = 0.8 - vec3(dot(d0, d0), dot(d1, d1), dot(d2, d2));
	t = max(t, vec3(0.0));
	vec3 t2 = t * t;
	vec3 t4 = t2 * t2;
	float n = dot(t4, w);
	return 0.5 + 5.5 * n;
}
float fbm_2d_simplex(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = simplex_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node =  0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718 * node);
			vec2 diff = neighbor + node - f;
			float dist = length(diff);
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float fbm_2d_cellular(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular2_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = length(diff);
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float fbm_2d_cellular2(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular2_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular3_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = abs((diff).x) + abs((diff).y);
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float fbm_2d_cellular3(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular3_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular4_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = abs((diff).x) + abs((diff).y);
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float fbm_2d_cellular4(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular4_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular5_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.5 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = max(abs((diff).x), abs((diff).y));
			min_dist = min(min_dist, dist);
		}
	}
	return min_dist;
}
float fbm_2d_cellular5(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular5_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float cellular6_noise_2d(vec2 coord, vec2 size, float offset, float seed) {
	vec2 o = floor(coord)+rand2(vec2(seed, 1.0-seed))+size;
	vec2 f = fract(coord);
	float min_dist1 = 2.0;
	float min_dist2 = 2.0;
	for(float x = -1.0; x <= 1.0; x++) {
		for(float y = -1.0; y <= 1.0; y++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 node = rand2(mod(o + vec2(x, y), size)) + vec2(x, y);
			node = 0.5 + 0.25 * sin(offset * 6.28318530718 + 6.28318530718*node);
			vec2 diff = neighbor + node - f;
			float dist = max(abs((diff).x), abs((diff).y));
			if (min_dist1 > dist) {
				min_dist2 = min_dist1;
				min_dist1 = dist;
			} else if (min_dist2 > dist) {
				min_dist2 = dist;
			}
		}
	}
	return min_dist2-min_dist1;
}
float fbm_2d_cellular6(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = cellular6_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
// MIT License Inigo Quilez - https://www.shadertoy.com/view/Xd23Dh
float voronoise_noise_2d( vec2 coord, vec2 size, float offset, float seed) {
	vec2 i = floor(coord) + rand2(vec2(seed, 1.0-seed)) + size;
	vec2 f = fract(coord);
	
	vec2 a = vec2(0.0);
	
	for( int y=-2; y<=2; y++ ) {
		for( int x=-2; x<=2; x++ ) {
			vec2  g = vec2( float(x), float(y) );
			vec3  o = rand3( mod(i + g, size) + vec2(seed) );
			o.xy += 0.25 * sin(offset * 6.28318530718 + 6.28318530718*o.xy);
			vec2  d = g - f + o.xy;
			float w = pow( 1.0-smoothstep(0.0, 1.414, length(d)), 1.0 );
			a += vec2(o.z*w,w);
		}
	}
	
	return a.x/a.y;
}
float fbm_2d_voronoise(vec2 coord, vec2 size, int folds, int octaves, float persistence, float offset, float seed) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	for (int i = 0; i < octaves; i++) {
		float noise = voronoise_noise_2d(coord*size, size, offset, seed+float(i));
		for (int f = 0; f < folds; ++f) {
			noise = abs(2.0*noise-1.0);
		}
		value += noise * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
// #globals: pack_1x32_to_2x16
const float pack_size = 256.0;
vec2 pack_1x32_to_2x16(float s) {
	return vec2(s - mod(s, 1.0/pack_size), mod(s, 1.0/pack_size)*pack_size);
}
float pack_2x16_to_1x32(vec2 s) {
	return s.x + s.y/pack_size;
}
vec4 pack_2x32_to_4x16(vec2 s) {
	return vec4(s.xy - vec2(mod(s.x, 1.0/pack_size), mod(s.y, 1.0/pack_size)) , vec2(mod(s.x, 1.0/pack_size), mod(s.y, 1.0/pack_size))*pack_size);
}
vec2 pack_4x16_to_2x32(vec4 s) {
	return s.rg + s.ba/pack_size;
}
// #globals: custom_uv2_3 (o753951323682)
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
// #globals: normal_blend_2 (o752424596982)
vec3 normal_blend(vec2 uv, vec3 n1, vec3 n2, float opacity) {
	n1.z = 1.0 - n1.z; // inverting z channel before calculations
	n2.z = 1.0 - n2.z; // inverting z channel before calculations
	vec3 t = n1*vec3( 2,  2, 2) + vec3(-1, -1,  0);
	vec3 u = n2*vec3(-2, -2, 2) + vec3( 1,  1, -1);
	vec3 r = mix(n2 * 2.0 - 1.0, t * dot(t, u) / t.z - u, opacity);
	r.z = r.z * -1.0; // inverting z channel after calculations
	return r * 0.5 + 0.5;
}
float o754337199664_input_d(vec2 uv, float _seed_variation_) {
vec4 o754488194611_0 = textureLod(texture_1, fract((uv)), 0.0);
// #output1: decompose (o754538526262)
float o754538526262_1_1_f = o754488194611_0.g;
return o754538526262_1_1_f;
}
// #instance: warp_2 (o754337199664)
vec2 o754337199664_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o754337199664_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o754337199664_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o754337199664_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o754337199664_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
float o754135873066_input_d(vec2 uv, float _seed_variation_) {
vec4 o754488194611_0 = textureLod(texture_1, fract((uv)), 0.0);
// #output0: decompose (o754538526262)
float o754538526262_0_1_f = o754488194611_0.r;
return o754538526262_0_1_f;
}
// #instance: warp (o754135873066)
vec2 o754135873066_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o754135873066_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o754135873066_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o754135873066_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o754135873066_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec4 o752407819768_input_in1(vec2 uv, float _seed_variation_) {
vec4 o747139773876_0 = textureLod(texture_2, fract(uv), 0.0);
return o747139773876_0;
}
float o747290768829_input_in(vec2 uv, float _seed_variation_) {
// #output0: shape_5 (o752055498223)
float o752055498223_0_1_f = shape_circle((uv), p_o752055498223_sides+1.0e-5, p_o752055498223_radius*1.0, p_o752055498223_edge*1.0);
// #code: rotate_2 (o747122996659)
vec2 o747122996659_0_c = vec2(0.5+p_o747122996659_cx, 0.5+p_o747122996659_cy);vec4 o744002434406_0 = textureLod(texture_3, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c), vec2(p_o744992290157_translate_x*(2.0*1.0-1.0), p_o744992290157_translate_y*(2.0*1.0-1.0)), p_o744992290157_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o744992290157_scale_x*(2.0*1.0-1.0), p_o744992290157_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_6 (o744992290157)
vec4 o744992290157_1_1_rgba = o744002434406_0;
// #output1: rotate_2 (o747122996659)
vec4 o747122996659_1_1_rgba = o744992290157_1_1_rgba;
// #code: rotate_3 (o754320422447)
vec2 o754320422447_0_c = vec2(0.5+p_o754320422447_cx, 0.5+p_o754320422447_cy);vec4 o742643479886_0 = textureLod(texture_4, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c), vec2(p_o742324712763_translate_x*(2.0*1.0-1.0), p_o742324712763_translate_y*(2.0*1.0-1.0)), p_o742324712763_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o742324712763_scale_x*(2.0*1.0-1.0), p_o742324712763_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_4 (o742324712763)
vec4 o742324712763_1_1_rgba = o742643479886_0;
// #output1: rotate_3 (o754320422447)
vec4 o754320422447_1_1_rgba = o742324712763_1_1_rgba;
// #code: blend2_8 (o747190105527)
vec4 o747190105527_0_b = o754320422447_1_1_rgba;
vec4 o747190105527_0_l;
float o747190105527_0_a;
o747190105527_0_l = o747122996659_1_1_rgba;
o747190105527_0_a = p_o747190105527_amount1*1.0;
o747190105527_0_b = vec4(blend_lighten((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0))))), o747190105527_0_l.rgb, o747190105527_0_b.rgb, o747190105527_0_a*o747190105527_0_l.a), min(1.0, o747190105527_0_b.a+o747190105527_0_a*o747190105527_0_l.a));
// #output0: blend2_8 (o747190105527)
vec4 o747190105527_0_1_rgba = o747190105527_0_b;
// #output1: transform2_2 (o745663378826)
vec4 o745663378826_1_1_rgba = o747190105527_0_1_rgba;
// #code: math_3 (o752072275440)
float o752072275440_0_clamp_false = max((dot((o745663378826_1_1_rgba).rgb, vec3(1.0))/3.0),o752055498223_0_1_f);
float o752072275440_0_clamp_true = clamp(o752072275440_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o752072275440)
float o752072275440_0_1_f = o752072275440_0_clamp_false;
return o752072275440_0_1_f;
}
// #instance: normal_map2/edge_detect_1 (o747290768829)
vec3 nm_o747290768829(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o747290768829_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o747290768829_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o747290768829_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o747290768829_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o747290768829_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o747290768829_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o747290768829_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o747290768829_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o747290768829_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o747290768829_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o747290768829_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o747290768829_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o747290768829_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o747290768829_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o747290768829_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o747290768829_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o747290768829_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o747290768829_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o747290768829_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o747290768829_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o747290768829_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o747290768829_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o747290768829_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
vec4 o752407819768_input_in2(vec2 uv, float _seed_variation_) {
// #output0: normal_map2/edge_detect_1 (o747290768829)
vec3 o747290768829_0_1_rgb = nm_o747290768829(uv, p_o747290768829_amount, 1024.0, _seed_variation_);
return vec4(o747290768829_0_1_rgb, 1.0);
}
vec4 o752407819768_input_in3(vec2 uv, float _seed_variation_) {
// #output0: shape_5 (o752055498223)
float o752055498223_0_1_f = shape_circle((uv), p_o752055498223_sides+1.0e-5, p_o752055498223_radius*1.0, p_o752055498223_edge*1.0);
// #output0: uniform_greyscale_3 (o752089052654)
float o752089052654_0_1_f = p_o752089052654_color;
// #code: rotate_2 (o747122996659)
vec2 o747122996659_0_c = vec2(0.5+p_o747122996659_cx, 0.5+p_o747122996659_cy);vec4 o744002434406_0 = textureLod(texture_3, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c), vec2(p_o744992290157_translate_x*(2.0*1.0-1.0), p_o744992290157_translate_y*(2.0*1.0-1.0)), p_o744992290157_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o744992290157_scale_x*(2.0*1.0-1.0), p_o744992290157_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_6 (o744992290157)
vec4 o744992290157_1_1_rgba = o744002434406_0;
// #output1: rotate_2 (o747122996659)
vec4 o747122996659_1_1_rgba = o744992290157_1_1_rgba;
// #code: rotate_3 (o754320422447)
vec2 o754320422447_0_c = vec2(0.5+p_o754320422447_cx, 0.5+p_o754320422447_cy);vec4 o742643479886_0 = textureLod(texture_4, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c), vec2(p_o742324712763_translate_x*(2.0*1.0-1.0), p_o742324712763_translate_y*(2.0*1.0-1.0)), p_o742324712763_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o742324712763_scale_x*(2.0*1.0-1.0), p_o742324712763_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_4 (o742324712763)
vec4 o742324712763_1_1_rgba = o742643479886_0;
// #output1: rotate_3 (o754320422447)
vec4 o754320422447_1_1_rgba = o742324712763_1_1_rgba;
// #code: blend2_8 (o747190105527)
vec4 o747190105527_0_b = o754320422447_1_1_rgba;
vec4 o747190105527_0_l;
float o747190105527_0_a;
o747190105527_0_l = o747122996659_1_1_rgba;
o747190105527_0_a = p_o747190105527_amount1*1.0;
o747190105527_0_b = vec4(blend_lighten((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0))))), o747190105527_0_l.rgb, o747190105527_0_b.rgb, o747190105527_0_a*o747190105527_0_l.a), min(1.0, o747190105527_0_b.a+o747190105527_0_a*o747190105527_0_l.a));
// #output0: blend2_8 (o747190105527)
vec4 o747190105527_0_1_rgba = o747190105527_0_b;
// #output1: transform2_2 (o745663378826)
vec4 o745663378826_1_1_rgba = o747190105527_0_1_rgba;
// #code: math_5 (o754555303479)
float o754555303479_0_clamp_false = (dot((o745663378826_1_1_rgba).rgb, vec3(1.0))/3.0)*p_o754555303479_default_in2;
float o754555303479_0_clamp_true = clamp(o754555303479_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o754555303479)
float o754555303479_0_1_f = o754555303479_0_clamp_false;
// #code: blend2_13 (o754572080696)
vec4 o754572080696_0_b = vec4(vec3(o754555303479_0_1_f), 1.0);
vec4 o754572080696_0_l;
float o754572080696_0_a;
o754572080696_0_l = vec4(vec3(o752089052654_0_1_f), 1.0);
o754572080696_0_a = p_o754572080696_amount1*o752055498223_0_1_f;
o754572080696_0_b = vec4(blend_normal(uv, o754572080696_0_l.rgb, o754572080696_0_b.rgb, o754572080696_0_a*o754572080696_0_l.a), min(1.0, o754572080696_0_b.a+o754572080696_0_a*o754572080696_0_l.a));
// #output0: blend2_13 (o754572080696)
vec4 o754572080696_0_1_rgba = o754572080696_0_b;
return o754572080696_0_1_rgba;
}
vec4 o752441374201_gradient_gradient_fct(float x) {
  if (x < p_o752441374201_gradient_pos[0]) {
    return p_o752441374201_gradient_col[0];
  } else if (x < p_o752441374201_gradient_pos[1]) {
    return mix(p_o752441374201_gradient_col[0], p_o752441374201_gradient_col[1], ((x-p_o752441374201_gradient_pos[0])/(p_o752441374201_gradient_pos[1]-p_o752441374201_gradient_pos[0])));
  }
  return p_o752441374201_gradient_col[1];
}
vec4 o753313789454_gradient_gradient_fct(float x) {
  if (x < p_o753313789454_gradient_pos[0]) {
    return p_o753313789454_gradient_col[0];
  } else if (x < p_o753313789454_gradient_pos[1]) {
    return mix(p_o753313789454_gradient_col[0], p_o753313789454_gradient_col[1], ((x-p_o753313789454_gradient_pos[0])/(p_o753313789454_gradient_pos[1]-p_o753313789454_gradient_pos[0])));
  }
  return p_o753313789454_gradient_col[1];
}
vec4 o750344222179_input_source(vec2 uv, float _seed_variation_) {
vec4 o750293890526_0 = textureLod(texture_6, ((floor(fract(uv) * texture_6_size)+vec2(0.5))/texture_6_size), 0.0);
return o750293890526_0;
}
vec3 o750210004447_input_inx(vec2 uv, float _seed_variation_) {
// #output0: uniform_greyscale_2/uniform_greyscale_2 (o750344222179)
vec3 o750344222179_0_1_rgb = vec3(pack_4x16_to_2x32(o750344222179_input_source((uv), _seed_variation_)), 0.0);
return o750344222179_0_1_rgb;
}
vec4 o750495217132_input_source(vec2 uv, float _seed_variation_) {
vec4 o750444885481_0 = textureLod(texture_7, ((floor(fract(uv) * texture_7_size)+vec2(0.5))/texture_7_size), 0.0);
return o750444885481_0;
}
vec3 o750210004447_input_iny(vec2 uv, float _seed_variation_) {
// #output0: uniform_greyscale_2/uniform_greyscale_4 (o750495217132)
vec3 o750495217132_0_1_rgb = vec3(pack_4x16_to_2x32(o750495217132_input_source((uv), _seed_variation_)), 0.0);
return o750495217132_0_1_rgb;
}
// #instance: uniform_greyscale_2/shape_3 (o750210004447)
vec3 o750210004447_dilate(vec2 uv, float _seed_variation_) {
	float e = 1.0/1024.0;
	float dx = floor(p_o750210004447_d/e)*e;
	float v = 0.0;
	vec2 bestuv = uv;
	for (float x = 0.0; x < dx; x += e) {
		vec2 input_dist = o750210004447_input_inx((uv+vec2(0.0, x)), _seed_variation_).xy;
		if (v < input_dist.x && p_o750210004447_d >= length(vec2(input_dist.y-uv.x, x))) {
			v = input_dist.x;
			bestuv = vec2(input_dist.y, uv.y+x);
		}
		input_dist = o750210004447_input_inx((uv-vec2(0.0, x)), _seed_variation_).xy;
		if (v < input_dist.x && p_o750210004447_d >= length(vec2(input_dist.y-uv.x, x))) {
			v = input_dist.x;
			bestuv = vec2(input_dist.y, uv.y-x);
		}
		input_dist = o750210004447_input_iny((uv+vec2(x, 0.0)), _seed_variation_).xy;
		if (v < input_dist.x && p_o750210004447_d >= length(vec2(input_dist.y-uv.y, x))) {
			v = input_dist.x;
			bestuv = vec2(uv.x+x, input_dist.y);
		}
		input_dist = o750210004447_input_iny((uv-vec2(x, 0.0)), _seed_variation_).xy;
		if (v < input_dist.x && p_o750210004447_d >= length(vec2(input_dist.y-uv.y, x))) {
			v = input_dist.x;
			bestuv = vec2(uv.x-x, input_dist.y);
		}
	}
	return vec3(v, bestuv);
}
vec4 o748347733453_input_source(vec2 uv, float _seed_variation_) {
vec4 o748297401800_0 = textureLod(texture_10, ((floor(fract(uv) * texture_10_size)+vec2(0.5))/texture_10_size), 0.0);
return o748297401800_0;
}
vec3 o748213515721_input_inx(vec2 uv, float _seed_variation_) {
// #output0: uniform_greyscale/uniform_greyscale_2 (o748347733453)
vec3 o748347733453_0_1_rgb = vec3(pack_4x16_to_2x32(o748347733453_input_source((uv), _seed_variation_)), 0.0);
return o748347733453_0_1_rgb;
}
vec4 o748498728406_input_source(vec2 uv, float _seed_variation_) {
vec4 o748448396755_0 = textureLod(texture_11, ((floor(fract(uv) * texture_11_size)+vec2(0.5))/texture_11_size), 0.0);
return o748448396755_0;
}
vec3 o748213515721_input_iny(vec2 uv, float _seed_variation_) {
// #output0: uniform_greyscale/uniform_greyscale_4 (o748498728406)
vec3 o748498728406_0_1_rgb = vec3(pack_4x16_to_2x32(o748498728406_input_source((uv), _seed_variation_)), 0.0);
return o748498728406_0_1_rgb;
}
// #instance: uniform_greyscale/shape_3 (o748213515721)
vec3 o748213515721_dilate(vec2 uv, float _seed_variation_) {
	float e = 1.0/1024.0;
	float dx = floor(p_o748213515721_d/e)*e;
	float v = 0.0;
	vec2 bestuv = uv;
	for (float x = 0.0; x < dx; x += e) {
		vec2 input_dist = o748213515721_input_inx((uv+vec2(0.0, x)), _seed_variation_).xy;
		if (v < input_dist.x && p_o748213515721_d >= length(vec2(input_dist.y-uv.x, x))) {
			v = input_dist.x;
			bestuv = vec2(input_dist.y, uv.y+x);
		}
		input_dist = o748213515721_input_inx((uv-vec2(0.0, x)), _seed_variation_).xy;
		if (v < input_dist.x && p_o748213515721_d >= length(vec2(input_dist.y-uv.x, x))) {
			v = input_dist.x;
			bestuv = vec2(input_dist.y, uv.y-x);
		}
		input_dist = o748213515721_input_iny((uv+vec2(x, 0.0)), _seed_variation_).xy;
		if (v < input_dist.x && p_o748213515721_d >= length(vec2(input_dist.y-uv.y, x))) {
			v = input_dist.x;
			bestuv = vec2(uv.x+x, input_dist.y);
		}
		input_dist = o748213515721_input_iny((uv-vec2(x, 0.0)), _seed_variation_).xy;
		if (v < input_dist.x && p_o748213515721_d >= length(vec2(input_dist.y-uv.y, x))) {
			v = input_dist.x;
			bestuv = vec2(uv.x-x, input_dist.y);
		}
	}
	return vec3(v, bestuv);
}
vec4 o752407819768_input_in4(vec2 uv, float _seed_variation_) {
// #output0: sdcircle_5 (o745680156041)
float o745680156041_0_1_sdf2d = length((uv)-vec2(p_o745680156041_cx+0.5, p_o745680156041_cy+0.5))-p_o745680156041_r;
// #output0: sdannularshape_4 (o745730487692)
float o745730487692_0_1_sdf2d = sdRipples(o745680156041_0_1_sdf2d, p_o745730487692_r, int(p_o745730487692_ripples));
// #output0: sdshow_5 (o745696933256)
float o745696933256_0_1_f = clamp(p_o745696933256_base-o745730487692_0_1_sdf2d/max(p_o745696933256_bevel, 0.00001), 0.0, 1.0);
// #output0: uniform_greyscale_4 (o752659478013)
float o752659478013_0_1_f = (param_rnd(0.0,1.0, (seed_o752659478013+fract(_seed_variation_))+0.500000));
// #output0: colorize_3 (o752441374201)
vec4 o752441374201_0_1_rgba = o752441374201_gradient_gradient_fct(o752659478013_0_1_f);
// #output0: fbm3 (o754085541415)
float o754085541415_0_1_f = fbm_2d_perlin((uv), vec2(p_o754085541415_scale_x, p_o754085541415_scale_y), int(p_o754085541415_folds), int(p_o754085541415_iterations), p_o754085541415_persistence, p_o754085541415_offset, (seed_o754085541415+fract(_seed_variation_)));
// #output0: uniform_4 (o754119095849)
vec4 o754119095849_0_1_rgba = p_o754119095849_color;
// #output0: uniform_greyscale_5 (o753531893266)
float o753531893266_0_1_f = (param_rnd(0.0,1.0, (seed_o753531893266+fract(_seed_variation_))+0.500000));
// #output0: colorize_4 (o753313789454)
vec4 o753313789454_0_1_rgba = o753313789454_gradient_gradient_fct(o753531893266_0_1_f);
// #code: blend2_14 (o754102318632)
vec4 o754102318632_0_b = o753313789454_0_1_rgba;
vec4 o754102318632_0_l;
float o754102318632_0_a;
o754102318632_0_l = o754119095849_0_1_rgba;
o754102318632_0_a = p_o754102318632_amount1*o754085541415_0_1_f;
o754102318632_0_b = vec4(blend_normal((uv), o754102318632_0_l.rgb, o754102318632_0_b.rgb, o754102318632_0_a*o754102318632_0_l.a), min(1.0, o754102318632_0_b.a+o754102318632_0_a*o754102318632_0_l.a));
// #output0: blend2_14 (o754102318632)
vec4 o754102318632_0_1_rgba = o754102318632_0_b;
// #code: rotate_2 (o747122996659)
vec2 o747122996659_0_c = vec2(0.5+p_o747122996659_cx, 0.5+p_o747122996659_cy);vec4 o746703566250_0 = textureLod(texture_5, fract((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c)), 0.0);
// #output0: invert_3 (o747072665008)
vec4 o747072665008_0_1_rgba = vec4(vec3(1.0)-o746703566250_0.rgb, o746703566250_0.a);
vec4 o750075786714_0 = textureLod(texture_8, ((floor(fract((fract(o750210004447_dilate((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c), vec2(p_o744992290157_translate_x*(2.0*1.0-1.0), p_o744992290157_translate_y*(2.0*1.0-1.0)), p_o744992290157_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o744992290157_scale_x*(2.0*1.0-1.0), p_o744992290157_scale_y*(2.0*1.0-1.0))))), _seed_variation_).yz))) * texture_8_size)+vec2(0.5))/texture_8_size), 0.0);
// #output0: uniform_greyscale_2/shape_3 (o750210004447)
vec4 o750210004447_0_1_rgba = o750075786714_0;
// #output0: transform2_6 (o744992290157)
vec4 o744992290157_0_1_rgba = o750210004447_0_1_rgba;
// #code: blend2_6 (o747089442226)
vec4 o747089442226_0_b = o744992290157_0_1_rgba;
vec4 o747089442226_0_l;
float o747089442226_0_a;
o747089442226_0_l = o747072665008_0_1_rgba;
o747089442226_0_a = p_o747089442226_amount1*1.0;
o747089442226_0_b = vec4(blend_lighten((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c), o747089442226_0_l.rgb, o747089442226_0_b.rgb, o747089442226_0_a*o747089442226_0_l.a), min(1.0, o747089442226_0_b.a+o747089442226_0_a*o747089442226_0_l.a));
// #output0: blend2_6 (o747089442226)
vec4 o747089442226_0_1_rgba = o747089442226_0_b;
// #output0: rotate_2 (o747122996659)
vec4 o747122996659_0_1_rgba = o747089442226_0_1_rgba;
// #code: rotate_3 (o754320422447)
vec2 o754320422447_0_c = vec2(0.5+p_o754320422447_cx, 0.5+p_o754320422447_cy);vec4 o746082809243_0 = textureLod(texture_9, fract((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c)), 0.0);
// #output0: invert_2 (o745814373777)
vec4 o745814373777_0_1_rgba = vec4(vec3(1.0)-o746082809243_0.rgb, o746082809243_0.a);
vec4 o748079297987_0 = textureLod(texture_12, ((floor(fract((fract(o748213515721_dilate((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c), vec2(p_o742324712763_translate_x*(2.0*1.0-1.0), p_o742324712763_translate_y*(2.0*1.0-1.0)), p_o742324712763_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o742324712763_scale_x*(2.0*1.0-1.0), p_o742324712763_scale_y*(2.0*1.0-1.0))))), _seed_variation_).yz))) * texture_12_size)+vec2(0.5))/texture_12_size), 0.0);
// #output0: uniform_greyscale/shape_3 (o748213515721)
vec4 o748213515721_0_1_rgba = o748079297987_0;
// #output0: transform2_4 (o742324712763)
vec4 o742324712763_0_1_rgba = o748213515721_0_1_rgba;
// #code: blend2_5 (o745797596560)
vec4 o745797596560_0_b = o742324712763_0_1_rgba;
vec4 o745797596560_0_l;
float o745797596560_0_a;
o745797596560_0_l = o745814373777_0_1_rgba;
o745797596560_0_a = p_o745797596560_amount1*1.0;
o745797596560_0_b = vec4(blend_lighten((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c), o745797596560_0_l.rgb, o745797596560_0_b.rgb, o745797596560_0_a*o745797596560_0_l.a), min(1.0, o745797596560_0_b.a+o745797596560_0_a*o745797596560_0_l.a));
// #output0: blend2_5 (o745797596560)
vec4 o745797596560_0_1_rgba = o745797596560_0_b;
// #output0: rotate_3 (o754320422447)
vec4 o754320422447_0_1_rgba = o745797596560_0_1_rgba;
// #code: blend2_7 (o747106219441)
vec4 o747106219441_0_b = o754320422447_0_1_rgba;
vec4 o747106219441_0_l;
float o747106219441_0_a;
o747106219441_0_l = o747122996659_0_1_rgba;
o747106219441_0_a = p_o747106219441_amount1*1.0;
o747106219441_0_b = vec4(blend_lighten((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0))))), o747106219441_0_l.rgb, o747106219441_0_b.rgb, o747106219441_0_a*o747106219441_0_l.a), min(1.0, o747106219441_0_b.a+o747106219441_0_a*o747106219441_0_l.a));
// #output0: blend2_7 (o747106219441)
vec4 o747106219441_0_1_rgba = o747106219441_0_b;
// #output0: uniform_3 (o742307935545)
vec4 o742307935545_0_1_rgba = p_o742307935545_color;
vec4 o745747264909_0 = textureLod(texture_13, fract((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #code: blend2_3 (o742291158334)
vec4 o742291158334_0_b = o745747264909_0;
vec4 o742291158334_0_l;
float o742291158334_0_a;
o742291158334_0_l = o742307935545_0_1_rgba;
o742291158334_0_a = p_o742291158334_amount1*(dot((o747106219441_0_1_rgba).rgb, vec3(1.0))/3.0);
o742291158334_0_b = vec4(blend_normal((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0))))), o742291158334_0_l.rgb, o742291158334_0_b.rgb, o742291158334_0_a*o742291158334_0_l.a), min(1.0, o742291158334_0_b.a+o742291158334_0_a*o742291158334_0_l.a));
// #output0: blend2_3 (o742291158334)
vec4 o742291158334_0_1_rgba = o742291158334_0_b;
// #output0: transform2_2 (o745663378826)
vec4 o745663378826_0_1_rgba = o742291158334_0_1_rgba;
// #code: blend2_10 (o753565447699)
vec4 o753565447699_0_b = o745663378826_0_1_rgba;
vec4 o753565447699_0_l;
float o753565447699_0_a;
o753565447699_0_l = o754102318632_0_1_rgba;
o753565447699_0_a = p_o753565447699_amount1*1.0;
o753565447699_0_b = vec4(blend_multiply((uv), o753565447699_0_l.rgb, o753565447699_0_b.rgb, o753565447699_0_a*o753565447699_0_l.a), min(1.0, o753565447699_0_b.a+o753565447699_0_a*o753565447699_0_l.a));
// #output0: blend2_10 (o753565447699)
vec4 o753565447699_0_1_rgba = o753565447699_0_b;
// #code: blend2_4 (o745713710475)
vec4 o745713710475_0_b = o753565447699_0_1_rgba;
vec4 o745713710475_0_l;
float o745713710475_0_a;
o745713710475_0_l = o752441374201_0_1_rgba;
o745713710475_0_a = p_o745713710475_amount1*o745696933256_0_1_f;
o745713710475_0_b = vec4(blend_normal(uv, o745713710475_0_l.rgb, o745713710475_0_b.rgb, o745713710475_0_a*o745713710475_0_l.a), min(1.0, o745713710475_0_b.a+o745713710475_0_a*o745713710475_0_l.a));
// #output0: blend2_4 (o745713710475)
vec4 o745713710475_0_1_rgba = o745713710475_0_b;
return o745713710475_0_1_rgba;
}
vec4 o752105829873_gradient_gradient_fct(float x) {
  if (x < p_o752105829873_gradient_pos[0]) {
    return p_o752105829873_gradient_col[0];
  } else if (x < p_o752105829873_gradient_pos[1]) {
    return mix(p_o752105829873_gradient_col[0], p_o752105829873_gradient_col[1], ((x-p_o752105829873_gradient_pos[0])/(p_o752105829873_gradient_pos[1]-p_o752105829873_gradient_pos[0])));
  }
  return p_o752105829873_gradient_col[1];
}
vec4 o752407819768_input_in5(vec2 uv, float _seed_variation_) {
// #output0: sdcircle_5 (o745680156041)
float o745680156041_0_1_sdf2d = length((uv)-vec2(p_o745680156041_cx+0.5, p_o745680156041_cy+0.5))-p_o745680156041_r;
// #output0: sdannularshape_4 (o745730487692)
float o745730487692_0_1_sdf2d = sdRipples(o745680156041_0_1_sdf2d, p_o745730487692_r, int(p_o745730487692_ripples));
// #output0: sdshow_5 (o745696933256)
float o745696933256_0_1_f = clamp(p_o745696933256_base-o745730487692_0_1_sdf2d/max(p_o745696933256_bevel, 0.00001), 0.0, 1.0);
// #output0: colorize (o752105829873)
vec4 o752105829873_0_1_rgba = o752105829873_gradient_gradient_fct(o745696933256_0_1_f);
return o752105829873_0_1_rgba;
}
vec4 o753733219870_gradient_gradient_fct(float x) {
  if (x < p_o753733219870_gradient_pos[0]) {
    return p_o753733219870_gradient_col[0];
  } else if (x < p_o753733219870_gradient_pos[1]) {
    return mix(p_o753733219870_gradient_col[0], p_o753733219870_gradient_col[1], ((x-p_o753733219870_gradient_pos[0])/(p_o753733219870_gradient_pos[1]-p_o753733219870_gradient_pos[0])));
  }
  return p_o753733219870_gradient_col[1];
}
vec4 o753951323682_input_in1(vec2 uv, float _seed_variation_) {
float o753649333785_0 = textureLod(texture_14, fract(uv), 0.0).r;
return vec4(vec3(o753649333785_0), 1.0);
}
vec4 o752407819768_input_in6(vec2 uv, float _seed_variation_) {
// #output0: sdcircle_5 (o745680156041)
float o745680156041_0_1_sdf2d = length((uv)-vec2(p_o745680156041_cx+0.5, p_o745680156041_cy+0.5))-p_o745680156041_r;
// #output0: sdannularshape_4 (o745730487692)
float o745730487692_0_1_sdf2d = sdRipples(o745680156041_0_1_sdf2d, p_o745730487692_r, int(p_o745730487692_ripples));
// #output0: sdshow_5 (o745696933256)
float o745696933256_0_1_f = clamp(p_o745696933256_base-o745730487692_0_1_sdf2d/max(p_o745696933256_bevel, 0.00001), 0.0, 1.0);
// #output0: uniform_greyscale_7 (o753615779351)
float o753615779351_0_1_f = p_o753615779351_color;
// #output0: shape_5 (o752055498223)
float o752055498223_0_1_f = shape_circle((uv), p_o752055498223_sides+1.0e-5, p_o752055498223_radius*1.0, p_o752055498223_edge*1.0);
// #code: rotate_2 (o747122996659)
vec2 o747122996659_0_c = vec2(0.5+p_o747122996659_cx, 0.5+p_o747122996659_cy);vec4 o744002434406_0 = textureLod(texture_3, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o747122996659_0_c, (param_rnd(0.0,360.0, (seed_o747122996659+fract(_seed_variation_))+0.764541)+elapsed_time*30.0)*0.01745329251)+o747122996659_0_c), vec2(p_o744992290157_translate_x*(2.0*1.0-1.0), p_o744992290157_translate_y*(2.0*1.0-1.0)), p_o744992290157_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o744992290157_scale_x*(2.0*1.0-1.0), p_o744992290157_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_6 (o744992290157)
vec4 o744992290157_1_1_rgba = o744002434406_0;
// #output1: rotate_2 (o747122996659)
vec4 o747122996659_1_1_rgba = o744992290157_1_1_rgba;
// #code: rotate_3 (o754320422447)
vec2 o754320422447_0_c = vec2(0.5+p_o754320422447_cx, 0.5+p_o754320422447_cy);vec4 o742643479886_0 = textureLod(texture_4, fract((transform2_clamp(transform2((rotate((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0)))))-o754320422447_0_c, (param_rnd(0.0,360.0, (seed_o754320422447+fract(_seed_variation_))+0.764541)+elapsed_time*50.0)*0.01745329251)+o754320422447_0_c), vec2(p_o742324712763_translate_x*(2.0*1.0-1.0), p_o742324712763_translate_y*(2.0*1.0-1.0)), p_o742324712763_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o742324712763_scale_x*(2.0*1.0-1.0), p_o742324712763_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output1: transform2_4 (o742324712763)
vec4 o742324712763_1_1_rgba = o742643479886_0;
// #output1: rotate_3 (o754320422447)
vec4 o754320422447_1_1_rgba = o742324712763_1_1_rgba;
// #code: blend2_8 (o747190105527)
vec4 o747190105527_0_b = o754320422447_1_1_rgba;
vec4 o747190105527_0_l;
float o747190105527_0_a;
o747190105527_0_l = o747122996659_1_1_rgba;
o747190105527_0_a = p_o747190105527_amount1*1.0;
o747190105527_0_b = vec4(blend_lighten((transform2_clamp(transform2((uv), vec2(p_o745663378826_translate_x*(2.0*1.0-1.0), p_o745663378826_translate_y*(2.0*1.0-1.0)), p_o745663378826_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o745663378826_scale_x*(2.0*1.0-1.0), p_o745663378826_scale_y*(2.0*1.0-1.0))))), o747190105527_0_l.rgb, o747190105527_0_b.rgb, o747190105527_0_a*o747190105527_0_l.a), min(1.0, o747190105527_0_b.a+o747190105527_0_a*o747190105527_0_l.a));
// #output0: blend2_8 (o747190105527)
vec4 o747190105527_0_1_rgba = o747190105527_0_b;
// #output1: transform2_2 (o745663378826)
vec4 o745663378826_1_1_rgba = o747190105527_0_1_rgba;
// #code: math_3 (o752072275440)
float o752072275440_0_clamp_false = max((dot((o745663378826_1_1_rgba).rgb, vec3(1.0))/3.0),o752055498223_0_1_f);
float o752072275440_0_clamp_true = clamp(o752072275440_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o752072275440)
float o752072275440_0_1_f = o752072275440_0_clamp_false;
// #output0: shape_6 (o753716442653)
float o753716442653_0_1_f = shape_circle((uv), p_o753716442653_sides+1.0e-5, p_o753716442653_radius*1.0, p_o753716442653_edge*1.0);
// #code: math_4 (o754068764197)
float o754068764197_0_clamp_false = o753716442653_0_1_f-o752072275440_0_1_f;
float o754068764197_0_clamp_true = clamp(o754068764197_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o754068764197)
float o754068764197_0_1_f = o754068764197_0_clamp_true;
// #output0: transform2_8 (o753968100900)
vec4 o753968100900_0_1_rgba = vec4((transform2_clamp(transform2((uv), vec2(p_o753968100900_translate_x*(2.0*1.0-1.0), p_o753968100900_translate_y*(2.0*1.0-1.0)), p_o753968100900_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o753968100900_scale_x*(2.0*1.0-1.0), p_o753968100900_scale_y*(2.0*1.0-1.0))))), 0.0, 1.0);
// #code: custom_uv2_3 (o753951323682)
vec3 o753951323682_0_map = ((o753968100900_0_1_rgba).rgb);
float o753951323682_0_rnd =  float((seed_o753951323682+fract(_seed_variation_)))+o753951323682_0_map.z;
// #output0: custom_uv2_3 (o753951323682)
vec4 o753951323682_0_1_rgba = o753951323682_input_in1(get_from_tileset_clamp(2.0, o753951323682_0_rnd, custom_uv_transform(o753951323682_0_map.xy, vec2(p_o753951323682_sx, p_o753951323682_sy), p_o753951323682_rotate*0.01745329251, p_o753951323682_scale, vec2(o753951323682_0_map.z, float((seed_o753951323682+fract(_seed_variation_)))))), true ? o753951323682_0_rnd : 0.0);
// #output0: colorize_2 (o753733219870)
vec4 o753733219870_0_1_rgba = o753733219870_gradient_gradient_fct((dot((o753951323682_0_1_rgba).rgb, vec3(1.0))/3.0));
// #output0: uniform_greyscale_6 (o753599002134)
float o753599002134_0_1_f = p_o753599002134_color;
// #code: blend2_12 (o753699665436)
vec4 o753699665436_0_b = vec4(vec3(o753599002134_0_1_f), 1.0);
vec4 o753699665436_0_l;
float o753699665436_0_a;
o753699665436_0_l = o753733219870_0_1_rgba;
o753699665436_0_a = p_o753699665436_amount1*o754068764197_0_1_f;
o753699665436_0_b = vec4(blend_normal((uv), o753699665436_0_l.rgb, o753699665436_0_b.rgb, o753699665436_0_a*o753699665436_0_l.a), min(1.0, o753699665436_0_b.a+o753699665436_0_a*o753699665436_0_l.a));
// #output0: blend2_12 (o753699665436)
vec4 o753699665436_0_1_rgba = o753699665436_0_b;
// #code: blend2_11 (o753582224917)
vec4 o753582224917_0_b = o753699665436_0_1_rgba;
vec4 o753582224917_0_l;
float o753582224917_0_a;
o753582224917_0_l = vec4(vec3(o753615779351_0_1_f), 1.0);
o753582224917_0_a = p_o753582224917_amount1*o745696933256_0_1_f;
o753582224917_0_b = vec4(blend_normal(uv, o753582224917_0_l.rgb, o753582224917_0_b.rgb, o753582224917_0_a*o753582224917_0_l.a), min(1.0, o753582224917_0_b.a+o753582224917_0_a*o753582224917_0_l.a));
// #output0: blend2_11 (o753582224917)
vec4 o753582224917_0_1_rgba = o753582224917_0_b;
return o753582224917_0_1_rgba;
}
float o732392600761_input_depth_tex(vec2 uv, float _seed_variation_) {
// #code: warp_2 (o754337199664)
vec2 o754337199664_0_slope = o754337199664_slope((uv), p_o754337199664_eps, _seed_variation_);
vec2 o754337199664_0_warp = o754337199664_0_slope;
// #code: warp (o754135873066)
vec2 o754135873066_0_slope = o754135873066_slope(((uv)+p_o754337199664_amount*1.0*o754337199664_0_warp), p_o754135873066_eps, _seed_variation_);
vec2 o754135873066_0_warp = o754135873066_0_slope;vec4 o754270090796_0 = textureLod(texture_15, fract((((uv)+p_o754337199664_amount*1.0*o754337199664_0_warp)+p_o754135873066_amount*1.0*o754135873066_0_warp)), 0.0);
// #code: custom_uv2 (o752407819768)
vec3 o752407819768_0_map = ((o754270090796_0).rgb);
float o752407819768_0_rnd =  float((seed_o752407819768+fract(_seed_variation_)))+o752407819768_0_map.z;
// #output2: custom_uv2 (o752407819768)
vec4 o752407819768_2_1_rgba = o752407819768_input_in3(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);
// #output2: warp (o754135873066)
vec4 o754135873066_2_1_rgba = o752407819768_2_1_rgba;
// #output2: warp_2 (o754337199664)
vec4 o754337199664_2_1_rgba = o754135873066_2_1_rgba;
// #output0: invert_4 (o752676255231)
vec4 o752676255231_0_1_rgba = vec4(vec3(1.0)-o754337199664_2_1_rgba.rgb, o754337199664_2_1_rgba.a);
return (dot((o752676255231_0_1_rgba).rgb, vec3(1.0))/3.0);
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o732392600761_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o732392600761_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o732392600761_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o732392600761_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #code: warp_2 (o754337199664)
vec2 o754337199664_0_slope = o754337199664_slope((uv), p_o754337199664_eps, _seed_variation_);
vec2 o754337199664_0_warp = o754337199664_0_slope;
// #code: warp (o754135873066)
vec2 o754135873066_0_slope = o754135873066_slope(((uv)+p_o754337199664_amount*1.0*o754337199664_0_warp), p_o754135873066_eps, _seed_variation_);
vec2 o754135873066_0_warp = o754135873066_0_slope;vec4 o754270090796_0 = textureLod(texture_15, fract((((uv)+p_o754337199664_amount*1.0*o754337199664_0_warp)+p_o754135873066_amount*1.0*o754135873066_0_warp)), 0.0);

// #code: custom_uv2 (o752407819768)
vec3 o752407819768_0_map = ((o754270090796_0).rgb);
float o752407819768_0_rnd =  float((seed_o752407819768+fract(_seed_variation_)))+o752407819768_0_map.z;
// #output1: custom_uv2 (o752407819768)
vec4 o752407819768_1_1_rgba = o752407819768_input_in2(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);

// #output1: warp (o754135873066)
vec4 o754135873066_1_1_rgba = o752407819768_1_1_rgba;

// #output1: warp_2 (o754337199664)
vec4 o754337199664_1_1_rgba = o754135873066_1_1_rgba;

// #output0: custom_uv2 (o752407819768)
vec4 o752407819768_0_2_rgba = o752407819768_input_in1(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);

// #output0: warp (o754135873066)
vec4 o754135873066_0_2_rgba = o752407819768_0_2_rgba;

// #output0: warp_2 (o754337199664)
vec4 o754337199664_0_2_rgba = o754135873066_0_2_rgba;

// #code: normal_blend_2 (o752424596982)
vec3 o752424596982_0_b = ((o754337199664_0_2_rgba).rgb);
vec3 o752424596982_0_l;
float o752424596982_0_a;

o752424596982_0_l = ((o754337199664_1_1_rgba).rgb);
o752424596982_0_a = p_o752424596982_amount1 * 1.0;
o752424596982_0_b = normal_blend((uv), o752424596982_0_l, o752424596982_0_b, o752424596982_0_a);
// #output0: normal_blend_2 (o752424596982)
vec3 o752424596982_0_1_rgb = o752424596982_0_b;

// #output5: custom_uv2 (o752407819768)
vec4 o752407819768_5_3_rgba = o752407819768_input_in6(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);

// #output5: warp (o754135873066)
vec4 o754135873066_5_3_rgba = o752407819768_5_3_rgba;

// #output5: warp_2 (o754337199664)
vec4 o754337199664_5_3_rgba = o754135873066_5_3_rgba;

// #output4: custom_uv2 (o752407819768)
vec4 o752407819768_4_4_rgba = o752407819768_input_in5(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);

// #output4: warp (o754135873066)
vec4 o754135873066_4_4_rgba = o752407819768_4_4_rgba;

// #output4: warp_2 (o754337199664)
vec4 o754337199664_4_4_rgba = o754135873066_4_4_rgba;

// #output3: custom_uv2 (o752407819768)
vec4 o752407819768_3_5_rgba = o752407819768_input_in4(get_from_tileset_clamp(1.0, o752407819768_0_rnd, custom_uv_transform(o752407819768_0_map.xy, vec2(p_o752407819768_sx, p_o752407819768_sy), p_o752407819768_rotate*0.01745329251, p_o752407819768_scale, vec2(o752407819768_0_map.z, float((seed_o752407819768+fract(_seed_variation_)))))), true ? o752407819768_0_rnd : 0.0);

// #output3: warp (o754135873066)
vec4 o754135873066_3_5_rgba = o752407819768_3_5_rgba;

// #output3: warp_2 (o754337199664)
vec4 o754337199664_3_5_rgba = o754135873066_3_5_rgba;

	vec3 albedo_tex = ((o754337199664_3_5_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o732392600761_albedo_color.rgb;
	METALLIC = (dot((o754337199664_4_4_rgba).rgb, vec3(1.0))/3.0)*p_o732392600761_metallic;
	ROUGHNESS = (dot((o754337199664_5_3_rgba).rgb, vec3(1.0))/3.0)*p_o732392600761_roughness;
	NORMAL_MAP = o752424596982_0_1_rgb;
	NORMAL_MAP_DEPTH = p_o732392600761_normal;
	EMISSION = vec3(0.0)*p_o732392600761_emission_energy;
}



