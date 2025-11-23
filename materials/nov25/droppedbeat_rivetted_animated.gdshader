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
const vec4 p_o31692295248767_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o31692295248767_metallic = 0.880000000;
const float p_o31692295248767_roughness = 0.700000000;
const float p_o31692295248767_emission_energy = 0.000000000;
const float p_o31692295248767_normal = 1.000000000;
const float p_o31692295248767_ao = 1.000000000;
const float p_o31692295248767_depth_scale = 0.150000000;
const float p_o31863892613867_amount1 = 1.000000000;
const float p_o31863892613867_amount2 = 1.000000000;
const float p_o31863892613867_amount3 = 0.330000000;
const float p_o31751686592302_amount1 = 1.000000000;
const float p_o31751636258209_translate_x = 0.000000000;
const float p_o31751636258209_translate_y = 1.000000000;
const float p_o31751619485186_default_in1 = 0.000000000;
const float p_o31751619485186_default_in2 = 0.000000000;
const float p_o31751585930041_translate_x = 1.000000000;
const float p_o31751585930041_translate_y = 0.000000000;
const float p_o31750176642362_translate_x = -0.394450000;
const float p_o31750176642362_translate_y = -0.393100000;
const float p_o31750176642362_scale_x = 0.723100000;
const float p_o31751502041438_sides = 2.000000000;
const float p_o31751502041438_radius = 0.940000000;
const float p_o31751502041438_edge = 0.000000000;
const float p_o31751669815218_translate_x = 0.000000000;
const float p_o31751669815218_translate_y = 1.000000000;
const float p_o31751653037261_amount1 = 1.000000000;
const float p_o31751602704132_translate_x = 1.000000000;
const float p_o31751602704132_translate_y = 0.000000000;
const float p_o31754756823579_translate_x = 0.000000000;
const float p_o31754756823579_translate_y = 0.000000000;
const float p_o31754756823579_rotate = 0.000000000;
const float p_o31754756823579_scale_x = 1.000000000;
const float p_o31754756823579_scale_y = 1.000000000;
const float p_o31754773600934_cx = 0.000000000;
const float p_o31754773600934_cy = 0.000000000;
const float p_o31754773600934_scale_x = 1.025000000;
const float p_o31754773600934_scale_y = 1.025000000;
const float seed_o31754672934067 = 0.000000000;
const float p_o31754672934067_sx = 1.000000000;
const float p_o31754672934067_sy = 1.000000000;
const float p_o31754672934067_rotate = 0.000000000;
const float p_o31754672934067_scale = 0.000000000;
const float p_o31911942560243_translate_x = 0.000000000;
const float p_o31911942560243_translate_y = 0.000000000;
const float p_o31911942560243_rotate = 0.000000000;
const float p_o31911942560243_scale_x = 1.000000000;
const float p_o31911942560243_scale_y = 1.000000000;
const float p_o31911959332650_cx = 0.000000000;
const float p_o31911959332650_cy = 0.000000000;
const float p_o31911959332650_scale_x = 1.000000000;
const float p_o31911959332650_scale_y = 1.000000000;
const float seed_o31911858673510 = 0.000000000;
const float p_o31911858673510_sx = 1.000000000;
const float p_o31911858673510_sy = 1.000000000;
const float p_o31911858673510_rotate = 0.000000000;
const float p_o31911858673510_scale = 0.000000000;
const float p_o31905936319714_translate_x = 0.000000000;
const float p_o31905936319714_translate_y = 0.000000000;
const float p_o31905936319714_rotate = 0.000000000;
const float p_o31905936319714_scale_x = 1.000000000;
const float p_o31905936319714_scale_y = 1.000000000;
const float p_o31905953091090_cx = 0.000000000;
const float p_o31905953091090_cy = 0.000000000;
const float p_o31905953091090_scale_x = 1.001000000;
const float p_o31905953091090_scale_y = 1.001000000;
const float seed_o31905852431616 = 0.000000000;
const float p_o31905852431616_sx = 1.000000000;
const float p_o31905852431616_sy = 1.000000000;
const float p_o31905852431616_rotate = 0.000000000;
const float p_o31905852431616_scale = 0.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 2048.000000000;
const float p_o31905835649606_translate_x = 0.000000000;
const float p_o31905835649606_translate_y = 0.000000000;
const float p_o31911841900219_translate_x = 0.000000000;
const float p_o31911841900219_translate_y = 0.000000000;
const float p_o31754656158694_translate_x = 0.000000000;
const float p_o31754656158694_translate_y = 0.000000000;
const float p_o31750159861723_default_in1 = 0.000000000;
const float p_o31750159861723_default_in2 = 0.000000000;
const float p_o31750126307234_value = 0.160000000;
const float p_o31750126307234_width = 0.020000000;
const float p_o31750310859723_default_in1 = 0.000000000;
const float p_o31750310859723_default_in2 = 0.000000000;
const float p_o31750260526526_translate_x = 1.000000000;
const float p_o31750260526526_translate_y = 0.000000000;
const float p_o31750294081982_default_in1 = 0.000000000;
const float p_o31750294081982_default_in2 = 0.000000000;
const float p_o31750277304134_translate_x = 0.000000000;
const float p_o31750277304134_translate_y = 1.000000000;
const float p_o31750210197337_translate_x = 0.000000000;
const float p_o31750210197337_translate_y = 0.000000000;
const float p_o31750210197337_rotate = 0.000000000;
const float p_o31750210197337_scale_x = 0.900000000;
const float p_o31750210197337_scale_y = 0.900000000;
const float p_o31908972989206_translate_x = 0.000000000;
const float p_o31908972989206_translate_y = 0.000000000;
const float p_o31908972989206_rotate = 0.000000000;
const float p_o31908972989206_scale_x = 1.000000000;
const float p_o31908972989206_scale_y = 1.000000000;
const float p_o31908989769596_cx = 0.000000000;
const float p_o31908989769596_cy = 0.000000000;
const float p_o31908989769596_scale_x = 1.020000000;
const float p_o31908989769596_scale_y = 1.020000000;
const float seed_o31908788445038 = 0.000000000;
const float p_o31908788445038_sx = 1.000000000;
const float p_o31908788445038_sy = 1.000000000;
const float p_o31908788445038_rotate = 0.000000000;
const float p_o31908788445038_scale = 0.000000000;
const float p_o31908771662505_translate_x = 1.000000000;
const float p_o31908771662505_translate_y = 1.000000000;
const float seed_o31905785317785 = 0.000000000;
const float p_o31905785317785_sx = 1.000000000;
const float p_o31905785317785_sy = 1.000000000;
const float p_o31905785317785_rotate = 0.000000000;
const float p_o31905785317785_scale = 0.000000000;
const float p_o31905768541001_translate_x = 0.000000000;
const float p_o31905768541001_translate_y = 1.000000000;
const float p_o31750109531339_default_in1 = 0.000000000;
const float p_o31750109531339_default_in2 = 0.000000000;
const float p_o31753246875094_default_in1 = 0.000000000;
const float p_o31753246875094_default_in2 = 0.000000000;
const float p_o31753196541747_translate_x = 1.000000000;
const float p_o31753196541747_translate_y = 0.000000000;
const float p_o31753230092593_default_in1 = 0.000000000;
const float p_o31753230092593_default_in2 = 0.000000000;
const float p_o31753213322715_translate_x = 0.000000000;
const float p_o31753213322715_translate_y = 1.000000000;
const float seed_o31908821994467 = 0.000000000;
const float p_o31908821994467_sx = 1.000000000;
const float p_o31908821994467_sy = 1.000000000;
const float p_o31908821994467_rotate = 0.000000000;
const float p_o31908821994467_scale = 0.000000000;
const float p_o31908805216554_translate_x = 0.000000000;
const float p_o31908805216554_translate_y = 1.000000000;
const float p_o31749052565965_default_in1 = 0.000000000;
const float p_o31749052565965_default_in2 = 0.000000000;
const float p_o31749035792280_value = 0.160000000;
const float p_o31749035792280_width = 0.020000000;
const float p_o31748096264988_translate_x = -0.153500000;
const float p_o31748096264988_translate_y = 0.269300000;
const float p_o31748096264988_scale_x = 0.269700000;
const float p_o31748012378028_default_in1 = 0.000000000;
const float p_o31748012378028_default_in2 = 0.000000000;
const float p_o31747995608743_value = 0.160000000;
const float p_o31747995608743_width = 0.020000000;
const float p_o31747072854001_amount1 = 1.000000000;
const float p_o31747056078311_translate_x = -0.492450000;
const float p_o31747056078311_translate_y = 0.111550000;
const float p_o31747056078311_scale_x = 0.500000000;
const float p_o31747039303226_translate_x = -0.153500000;
const float p_o31747039303226_translate_y = 0.269300000;
const float p_o31747039303226_scale_x = 0.500000000;
const float p_o31747962047891_default_in1 = 0.000000000;
const float p_o31747962047891_default_in2 = 0.240000000;
const float p_o31863875834366_amount1 = 1.000000000;
const float p_o31863875834366_amount2 = 1.000000000;
const float p_o31863875834366_amount3 = 1.000000000;
const float p_o31749287450919_amount = 1.000000000;
const float p_o31748247260145_amount = 1.000000000;
const float p_o31747173519623_amount = 1.000000000;
const float seed_o31905818875749 = 0.000000000;
const float p_o31905818875749_sx = 1.000000000;
const float p_o31905818875749_sy = 1.000000000;
const float p_o31905818875749_rotate = 0.000000000;
const float p_o31905818875749_scale = 0.000000000;
const float p_o31905802096554_translate_x = 1.000000000;
const float p_o31905802096554_translate_y = 0.000000000;
const float p_o31863942942110_amount1 = 1.000000000;
const float p_o31863942942110_amount2 = 1.000000000;
const float p_o31863942942110_amount3 = 1.000000000;
const float p_o31748062714247_default_in1 = 0.000000000;
const float p_o31748062714247_default_in2 = 0.000000000;
const float p_o31748045937289_amount1 = 1.000000000;
const float p_o31748045937289_amount2 = 1.000000000;
const float p_o31863976500000_amount1 = 1.000000000;
const float p_o31911707679278_translate_x = 0.000000000;
const float p_o31911707679278_translate_y = 0.000000000;
const float p_o31911707679278_rotate = 0.000000000;
const float p_o31911707679278_scale_x = 1.000000000;
const float p_o31911707679278_scale_y = 1.000000000;
const float seed_o31908855554222 = 0.000000000;
const float p_o31908855554222_sx = 1.000000000;
const float p_o31908855554222_sy = 1.000000000;
const float p_o31908855554222_rotate = 0.000000000;
const float p_o31908855554222_scale = 0.000000000;
const float p_o31908838774795_translate_x = 1.000000000;
const float p_o31908838774795_translate_y = 0.000000000;
const float p_o31863859060446_amount1 = 1.000000000;
const float p_o31863859060446_amount2 = 1.000000000;
const float p_o31863859060446_amount3 = 0.710000000;
const float p_o31863859060446_amount4 = 1.000000000;
const float p_o31752491896591_amount1 = 1.000000000;
const float p_o31752441567381_translate_x = 0.000000000;
const float p_o31752441567381_translate_y = 1.000000000;
const float p_o31752424789690_default_in1 = 0.000000000;
const float p_o31752424789690_default_in2 = 0.000000000;
const float p_o31752391233543_translate_x = 1.000000000;
const float p_o31752391233543_translate_y = 0.000000000;
const float p_o31752475119837_translate_x = 0.000000000;
const float p_o31752475119837_translate_y = 1.000000000;
const float p_o31752458342207_amount1 = 1.000000000;
const float p_o31752408013769_translate_x = 1.000000000;
const float p_o31752408013769_translate_y = 0.000000000;
const float seed_o31754639382731 = 0.000000000;
const float p_o31754639382731_sx = 1.000000000;
const float p_o31754639382731_sy = 1.000000000;
const float p_o31754639382731_rotate = 0.000000000;
const float p_o31754639382731_scale = 0.000000000;
const float p_o31754622604577_translate_x = 1.000000000;
const float p_o31754622604577_translate_y = 0.000000000;
const float p_o31864999905969_color = 0.000000000;
const float p_o31749069348985_default_in1 = 0.000000000;
const float p_o31749069348985_default_in2 = 0.000000000;
const float seed_o31754605825776 = 0.000000000;
const float p_o31754605825776_sx = 1.000000000;
const float p_o31754605825776_sy = 1.000000000;
const float p_o31754605825776_rotate = 0.000000000;
const float p_o31754605825776_scale = 0.000000000;
const float p_o31754589047544_translate_x = 0.000000000;
const float p_o31754589047544_translate_y = 1.000000000;
const float p_o31748079488968_amount1 = 1.000000000;
const float seed_o31754572270951 = 0.000000000;
const float p_o31754572270951_sx = 1.000000000;
const float p_o31754572270951_sy = 1.000000000;
const float p_o31754572270951_rotate = 0.000000000;
const float p_o31754572270951_scale = 0.000000000;
const float p_o31754555494521_translate_x = 1.000000000;
const float p_o31754555494521_translate_y = 1.000000000;
const float p_o31863909391287_amount1 = 0.770000000;
const float p_o31748029157889_default_in1 = 0.000000000;
const float p_o31748029157889_default_in2 = 0.000000000;
const float p_o31747978828694_amount1 = 1.000000000;
const float seed_o31905751769100 = 0.000000000;
const float p_o31905751769100_sx = 1.000000000;
const float p_o31905751769100_sy = 1.000000000;
const float p_o31905751769100_rotate = 0.000000000;
const float p_o31905751769100_scale = 0.000000000;
const float p_o31905734987756_translate_x = 1.000000000;
const float p_o31905734987756_translate_y = 1.000000000;
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
// #globals: graph_4/blend2_17 (o31863892613867)
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
// #globals: graph_4/decompose (o31863993278209)
// #globals: graph_4/graph_3/graph_3/math_2 (o31751619485186)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: graph_4/graph_3/transform2_4 (o31750176642362)
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
// #globals: graph_4/graph_3/shape (o31751502041438)
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
// #globals: graph_4/graph_3/graph_6/scale (o31754773600934)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: graph_4/graph_4/custom_uv_7 (o31905852431616)
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
vec4 o31905852431616_input_in(vec2 uv, float _seed_variation_) {
vec4 o31905667877013_0 = textureLod(texture_1, fract(uv), 0.0);
return o31905667877013_0;
}
vec4 o31911858673510_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o31905835649606)
vec4 o31905835649606_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905835649606_translate_x, p_o31905835649606_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec3 o31905852431616_0_map = ((o31905835649606_0_1_rgba).rgb);
float o31905852431616_0_rnd =  float((seed_o31905852431616+fract(_seed_variation_)))+o31905852431616_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec4 o31905852431616_0_1_rgba = o31905852431616_input_in(get_from_tileset(2.0, o31905852431616_0_rnd, old_custom_uv_transform(o31905852431616_0_map.xy, vec2(p_o31905852431616_sx, p_o31905852431616_sy), p_o31905852431616_rotate*0.01745329251, p_o31905852431616_scale, vec2(o31905852431616_0_map.z, float((seed_o31905852431616+fract(_seed_variation_)))))), false ? o31905852431616_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_3_1_rgba = o31905852431616_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_3_1_rgba = o31905953091090_3_1_rgba;
return o31905936319714_3_1_rgba;
}
vec4 o31754672934067_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o31911841900219)
vec4 o31911841900219_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31911942560243_translate_x*(2.0*1.0-1.0), p_o31911942560243_translate_y*(2.0*1.0-1.0)), p_o31911942560243_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31911942560243_scale_x*(2.0*1.0-1.0), p_o31911942560243_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31911959332650_cx, 0.5+p_o31911959332650_cy), vec2(p_o31911959332650_scale_x, p_o31911959332650_scale_y)))-vec2(p_o31911841900219_translate_x, p_o31911841900219_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec3 o31911858673510_0_map = ((o31911841900219_0_1_rgba).rgb);
float o31911858673510_0_rnd =  float((seed_o31911858673510+fract(_seed_variation_)))+o31911858673510_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec4 o31911858673510_0_1_rgba = o31911858673510_input_in(get_from_tileset(2.0, o31911858673510_0_rnd, old_custom_uv_transform(o31911858673510_0_map.xy, vec2(p_o31911858673510_sx, p_o31911858673510_sy), p_o31911858673510_rotate*0.01745329251, p_o31911858673510_scale, vec2(o31911858673510_0_map.z, float((seed_o31911858673510+fract(_seed_variation_)))))), false ? o31911858673510_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o31911959332650)
vec4 o31911959332650_3_1_rgba = o31911858673510_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o31911942560243)
vec4 o31911942560243_3_1_rgba = o31911959332650_3_1_rgba;
return o31911942560243_3_1_rgba;
}
vec4 o31908788445038_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o31905835649606)
vec4 o31905835649606_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905835649606_translate_x, p_o31905835649606_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec3 o31905852431616_0_map = ((o31905835649606_0_1_rgba).rgb);
float o31905852431616_0_rnd =  float((seed_o31905852431616+fract(_seed_variation_)))+o31905852431616_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec4 o31905852431616_0_1_rgba = o31905852431616_input_in(get_from_tileset(2.0, o31905852431616_0_rnd, old_custom_uv_transform(o31905852431616_0_map.xy, vec2(p_o31905852431616_sx, p_o31905852431616_sy), p_o31905852431616_rotate*0.01745329251, p_o31905852431616_scale, vec2(o31905852431616_0_map.z, float((seed_o31905852431616+fract(_seed_variation_)))))), false ? o31905852431616_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_3_1_rgba = o31905852431616_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_3_1_rgba = o31905953091090_3_1_rgba;
return o31905936319714_3_1_rgba;
}
vec4 o31905785317785_input_in(vec2 uv, float _seed_variation_) {
vec4 o31905667877013_0 = textureLod(texture_1, fract(uv), 0.0);
return o31905667877013_0;
}
vec4 o31908821994467_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o31905835649606)
vec4 o31905835649606_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905835649606_translate_x, p_o31905835649606_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec3 o31905852431616_0_map = ((o31905835649606_0_1_rgba).rgb);
float o31905852431616_0_rnd =  float((seed_o31905852431616+fract(_seed_variation_)))+o31905852431616_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec4 o31905852431616_0_1_rgba = o31905852431616_input_in(get_from_tileset(2.0, o31905852431616_0_rnd, old_custom_uv_transform(o31905852431616_0_map.xy, vec2(p_o31905852431616_sx, p_o31905852431616_sy), p_o31905852431616_rotate*0.01745329251, p_o31905852431616_scale, vec2(o31905852431616_0_map.z, float((seed_o31905852431616+fract(_seed_variation_)))))), false ? o31905852431616_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_3_1_rgba = o31905852431616_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_3_1_rgba = o31905953091090_3_1_rgba;
return o31905936319714_3_1_rgba;
}
float o31692295248767_input_depth_tex(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_1_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31751636258209_translate_x, p_o31751636258209_translate_y))-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_1_rgba = vec4(vec3(o31751502041438_0_1_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_1_rgba = o31750176642362_4_1_rgba;
// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_3_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31751636258209_translate_x, p_o31751636258209_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_3_rgba = vec4(vec3(o31751502041438_0_3_f), 1.0);
// #code: graph_4/graph_3/graph_3/math_2 (o31751619485186)
float o31751619485186_0_clamp_false = max((dot((o31750176642362_4_3_rgba).rgb, vec3(1.0))/3.0),(dot((o31751585930041_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31751619485186_0_clamp_true = clamp(o31751619485186_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_3/math_2 (o31751619485186)
float o31751619485186_0_1_f = o31751619485186_0_clamp_false;
// #output0: graph_4/graph_3/graph_3/translate_5 (o31751636258209)
vec4 o31751636258209_0_1_rgba = vec4(vec3(o31751619485186_0_1_f), 1.0);
// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_5_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y))-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_5_rgba = vec4(vec3(o31751502041438_0_5_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_3_rgba = o31750176642362_4_5_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y))-vec2(p_o31751602704132_translate_x, p_o31751602704132_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_0_map = ((o31754656158694_0_1_rgba).rgb);
float o31754672934067_0_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_1_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_0_rnd, old_custom_uv_transform(o31754672934067_0_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_0_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_0_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_1_rgba = o31754672934067_0_1_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_1_rgba = o31754773600934_3_1_rgba;
// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_7_rgba = o31754756823579_3_1_rgba;
// #output0: graph_4/graph_3/graph_3/translate_3 (o31751602704132)
vec4 o31751602704132_0_1_rgba = o31750176642362_2_7_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_2_map = ((o31754656158694_0_3_rgba).rgb);
float o31754672934067_2_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_3_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_2_rnd, old_custom_uv_transform(o31754672934067_2_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_2_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_2_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_3_rgba = o31754672934067_0_3_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_3_rgba = o31754773600934_3_3_rgba;
// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_9_rgba = o31754756823579_3_3_rgba;
// #code: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_b = o31750176642362_2_9_rgba;
vec4 o31751653037261_0_l;
float o31751653037261_0_a;
o31751653037261_0_l = o31751602704132_0_1_rgba;
o31751653037261_0_a = p_o31751653037261_amount1*(dot((o31751585930041_0_3_rgba).rgb, vec3(1.0))/3.0);
o31751653037261_0_b = vec4(blend_normal(((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y)), o31751653037261_0_l.rgb, o31751653037261_0_b.rgb, o31751653037261_0_a*o31751653037261_0_l.a), min(1.0, o31751653037261_0_b.a+o31751653037261_0_a*o31751653037261_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_1_rgba = o31751653037261_0_b;
// #output0: graph_4/graph_3/graph_3/translate_4 (o31751669815218)
vec4 o31751669815218_0_1_rgba = o31751653037261_0_1_rgba;
// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_7_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_11_rgba = vec4(vec3(o31751502041438_0_7_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_5_rgba = o31750176642362_4_11_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31751602704132_translate_x, p_o31751602704132_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_4_map = ((o31754656158694_0_5_rgba).rgb);
float o31754672934067_4_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_5_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_4_rnd, old_custom_uv_transform(o31754672934067_4_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_4_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_4_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_5_rgba = o31754672934067_0_5_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_5_rgba = o31754773600934_3_5_rgba;
// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_13_rgba = o31754756823579_3_5_rgba;
// #output0: graph_4/graph_3/graph_3/translate_3 (o31751602704132)
vec4 o31751602704132_0_3_rgba = o31750176642362_2_13_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_6_map = ((o31754656158694_0_7_rgba).rgb);
float o31754672934067_6_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_7_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_6_rnd, old_custom_uv_transform(o31754672934067_6_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_6_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_6_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_7_rgba = o31754672934067_0_7_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_7_rgba = o31754773600934_3_7_rgba;
// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_15_rgba = o31754756823579_3_7_rgba;
// #code: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_2_b = o31750176642362_2_15_rgba;
vec4 o31751653037261_2_l;
float o31751653037261_2_a;
o31751653037261_2_l = o31751602704132_0_3_rgba;
o31751653037261_2_a = p_o31751653037261_amount1*(dot((o31751585930041_0_5_rgba).rgb, vec3(1.0))/3.0);
o31751653037261_2_b = vec4(blend_normal((uv), o31751653037261_2_l.rgb, o31751653037261_2_b.rgb, o31751653037261_2_a*o31751653037261_2_l.a), min(1.0, o31751653037261_2_b.a+o31751653037261_2_a*o31751653037261_2_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_3_rgba = o31751653037261_2_b;
// #code: graph_4/graph_3/graph_3/blend2_2 (o31751686592302)
vec4 o31751686592302_0_b = o31751653037261_0_3_rgba;
vec4 o31751686592302_0_l;
float o31751686592302_0_a;
o31751686592302_0_l = o31751669815218_0_1_rgba;
o31751686592302_0_a = p_o31751686592302_amount1*(dot((o31751636258209_0_1_rgba).rgb, vec3(1.0))/3.0);
o31751686592302_0_b = vec4(blend_normal((uv), o31751686592302_0_l.rgb, o31751686592302_0_b.rgb, o31751686592302_0_a*o31751686592302_0_l.a), min(1.0, o31751686592302_0_b.a+o31751686592302_0_a*o31751686592302_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2_2 (o31751686592302)
vec4 o31751686592302_0_1_rgba = o31751686592302_0_b;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y))-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_0_map = ((o31908771662505_0_1_rgba).rgb);
float o31908788445038_0_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_1_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_0_rnd, old_custom_uv_transform(o31908788445038_0_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_0_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_1_rgba = o31908788445038_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_1_rgba = o31908989769596_0_1_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_1_f = o31908972989206_0_1_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_1_rgba = vec4(vec3(o31748113046165_0_1_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_17_rgba = o31750210197337_0_1_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_1_rgba = o31750176642362_0_17_rgba;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_2_map = ((o31908771662505_0_3_rgba).rgb);
float o31908788445038_2_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_3_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_2_rnd, old_custom_uv_transform(o31908788445038_2_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_2_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_3_rgba = o31908788445038_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_3_rgba = o31908989769596_0_3_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_3_f = o31908972989206_0_3_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_3_rgba = vec4(vec3(o31748113046165_0_3_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_19_rgba = o31750210197337_0_3_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_clamp_false = max((dot((o31750176642362_0_19_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_0_clamp_true = clamp(o31750294081982_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_1_f = o31750294081982_0_clamp_false;
// #output0: graph_4/graph_3/graph_2/translate_2 (o31750260526526)
vec4 o31750260526526_0_1_rgba = vec4(vec3(o31750294081982_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_4_map = ((o31908771662505_0_5_rgba).rgb);
float o31908788445038_4_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_5_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_4_rnd, old_custom_uv_transform(o31908788445038_4_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_4_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_4_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_5_rgba = o31908788445038_0_5_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_5_rgba = o31908989769596_0_5_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_5_f = o31908972989206_0_5_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_5_rgba = vec4(vec3(o31748113046165_0_5_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_21_rgba = o31750210197337_0_5_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_3_rgba = o31750176642362_0_21_rgba;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_6_map = ((o31908771662505_0_7_rgba).rgb);
float o31908788445038_6_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_7_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_6_rnd, old_custom_uv_transform(o31908788445038_6_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_6_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_6_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_7_rgba = o31908788445038_0_7_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_7_rgba = o31908989769596_0_7_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_7_f = o31908972989206_0_7_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_7_rgba = vec4(vec3(o31748113046165_0_7_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_22_rgba = o31750210197337_0_7_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_2_clamp_false = max((dot((o31750176642362_0_22_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_3_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_2_clamp_true = clamp(o31750294081982_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_3_f = o31750294081982_2_clamp_false;
// #code: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_clamp_false = max(o31750294081982_0_3_f,(dot((o31750260526526_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750310859723_0_clamp_true = clamp(o31750310859723_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_1_f = o31750310859723_0_clamp_false;
// #code: graph_4/graph_3/tones_step_3 (o31750126307234)
vec3 o31750126307234_0_false = clamp((vec4(vec3(o31750310859723_0_1_f), 1.0).rgb-vec3(p_o31750126307234_value))/max(0.0001, p_o31750126307234_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31750126307234_0_true = vec3(1.0)-o31750126307234_0_false;
// #output0: graph_4/graph_3/tones_step_3 (o31750126307234)
vec4 o31750126307234_0_1_rgba = vec4(o31750126307234_0_false, vec4(vec3(o31750310859723_0_1_f), 1.0).a);
// #output0: graph_4/graph_4/translate_2 (o31905768541001)
vec4 o31905768541001_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905768541001_translate_x, p_o31905768541001_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_5 (o31905785317785)
vec3 o31905785317785_0_map = ((o31905768541001_0_1_rgba).rgb);
float o31905785317785_0_rnd =  float((seed_o31905785317785+fract(_seed_variation_)))+o31905785317785_0_map.z;
// #output0: graph_4/graph_4/custom_uv_5 (o31905785317785)
vec4 o31905785317785_0_1_rgba = o31905785317785_input_in(get_from_tileset(2.0, o31905785317785_0_rnd, old_custom_uv_transform(o31905785317785_0_map.xy, vec2(p_o31905785317785_sx, p_o31905785317785_sy), p_o31905785317785_rotate*0.01745329251, p_o31905785317785_scale, vec2(o31905785317785_0_map.z, float((seed_o31905785317785+fract(_seed_variation_)))))), false ? o31905785317785_0_rnd : 0.0);
// #output1: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_1_1_rgba = o31905785317785_0_1_rgba;
// #output1: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_1_1_rgba = o31905953091090_1_1_rgba;
// #output3: graph_4/decompose_2 (o31746938642637)
float o31746938642637_3_1_f = o31905936319714_1_1_rgba.a;
// #code: graph_4/graph_3/math_9 (o31750159861723)
float o31750159861723_0_clamp_false = o31746938642637_3_1_f*(dot((o31750126307234_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31750159861723_0_clamp_true = clamp(o31750159861723_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_9 (o31750159861723)
float o31750159861723_0_1_f = o31750159861723_0_clamp_false;
// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31753196541747_translate_x, p_o31753196541747_translate_y))-vec2(p_o31753213322715_translate_x, p_o31753213322715_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_0_map = ((o31908805216554_0_1_rgba).rgb);
float o31908821994467_0_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_0_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_1_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_0_rnd, old_custom_uv_transform(o31908821994467_0_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_0_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_0_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_9_rgba = o31908821994467_0_1_rgba;
// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_9_rgba = o31908989769596_1_9_rgba;
// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_1_f = o31908972989206_1_9_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_24_rgba = vec4(vec3(o31753162985330_2_1_f), 1.0);
// #output0: graph_4/graph_3/graph_5/translate (o31753213322715)
vec4 o31753213322715_0_1_rgba = o31750176642362_1_24_rgba;
// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31753196541747_translate_x, p_o31753196541747_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_2_map = ((o31908805216554_0_3_rgba).rgb);
float o31908821994467_2_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_2_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_3_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_2_rnd, old_custom_uv_transform(o31908821994467_2_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_2_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_2_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_11_rgba = o31908821994467_0_3_rgba;
// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_11_rgba = o31908989769596_1_11_rgba;
// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_3_f = o31908972989206_1_11_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_26_rgba = vec4(vec3(o31753162985330_2_3_f), 1.0);
// #code: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_clamp_false = max((dot((o31750176642362_1_26_rgba).rgb, vec3(1.0))/3.0),(dot((o31753213322715_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31753230092593_0_clamp_true = clamp(o31753230092593_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_1_f = o31753230092593_0_clamp_false;
// #output0: graph_4/graph_3/graph_5/translate_2 (o31753196541747)
vec4 o31753196541747_0_1_rgba = vec4(vec3(o31753230092593_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31753213322715_translate_x, p_o31753213322715_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_4_map = ((o31908805216554_0_5_rgba).rgb);
float o31908821994467_4_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_4_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_5_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_4_rnd, old_custom_uv_transform(o31908821994467_4_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_4_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_4_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_13_rgba = o31908821994467_0_5_rgba;
// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_13_rgba = o31908989769596_1_13_rgba;
// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_5_f = o31908972989206_1_13_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_28_rgba = vec4(vec3(o31753162985330_2_5_f), 1.0);
// #output0: graph_4/graph_3/graph_5/translate (o31753213322715)
vec4 o31753213322715_0_3_rgba = o31750176642362_1_28_rgba;
// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_6_map = ((o31908805216554_0_7_rgba).rgb);
float o31908821994467_6_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_6_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_7_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_6_rnd, old_custom_uv_transform(o31908821994467_6_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_6_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_6_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_15_rgba = o31908821994467_0_7_rgba;
// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_15_rgba = o31908989769596_1_15_rgba;
// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_7_f = o31908972989206_1_15_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_29_rgba = vec4(vec3(o31753162985330_2_7_f), 1.0);
// #code: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_2_clamp_false = max((dot((o31750176642362_1_29_rgba).rgb, vec3(1.0))/3.0),(dot((o31753213322715_0_3_rgba).rgb, vec3(1.0))/3.0));
float o31753230092593_2_clamp_true = clamp(o31753230092593_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_3_f = o31753230092593_2_clamp_false;
// #code: graph_4/graph_3/graph_5/math_12 (o31753246875094)
float o31753246875094_0_clamp_false = max(o31753230092593_0_3_f,(dot((o31753196541747_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31753246875094_0_clamp_true = clamp(o31753246875094_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_12 (o31753246875094)
float o31753246875094_0_1_f = o31753246875094_0_clamp_false;
// #code: graph_4/graph_3/math_8 (o31750109531339)
float o31750109531339_0_clamp_false = o31753246875094_0_1_f*o31746938642637_3_1_f;
float o31750109531339_0_clamp_true = clamp(o31750109531339_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_8 (o31750109531339)
float o31750109531339_0_1_f = o31750109531339_0_clamp_false;
// #output0: graph_4/graph_3/invert_3 (o31750059202292)
vec4 o31750059202292_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o31750310859723_0_1_f), 1.0).rgb, vec4(vec3(o31750310859723_0_1_f), 1.0).a);
// #output0: graph_4/graph_3/combine (o31750193416561)
vec4 o31750193416561_0_1_rgba = vec4((dot((o31750059202292_0_1_rgba).rgb, vec3(1.0))/3.0), o31750109531339_0_1_f, o31750159861723_0_1_f, (dot((o31751686592302_0_1_rgba).rgb, vec3(1.0))/3.0));
// #output2: graph_4/decompose (o31863993278209)
float o31863993278209_2_1_f = o31750193416561_0_1_rgba.b;
// #output0: graph_4/decompose (o31863993278209)
float o31863993278209_0_2_f = o31750193416561_0_1_rgba.r;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_8_map = ((o31908771662505_0_9_rgba).rgb);
float o31908788445038_8_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_8_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_9_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_8_rnd, old_custom_uv_transform(o31908788445038_8_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_8_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_8_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_17_rgba = o31908788445038_0_9_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_17_rgba = o31908989769596_0_17_rgba;
// #output3: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_3_9_f = o31908972989206_0_17_rgba.a;
// #output0: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_0_1_rgba = vec4(vec3(o31748113046165_3_9_f), 1.0);
// #code: graph_4/graph_3/tones_step_2 (o31749035792280)
vec3 o31749035792280_0_false = clamp((o31748096264988_0_1_rgba.rgb-vec3(p_o31749035792280_value))/max(0.0001, p_o31749035792280_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31749035792280_0_true = vec3(1.0)-o31749035792280_0_false;
// #output0: graph_4/graph_3/tones_step_2 (o31749035792280)
vec4 o31749035792280_0_1_rgba = vec4(o31749035792280_0_false, o31748096264988_0_1_rgba.a);
// #code: graph_4/graph_3/math_6 (o31749052565965)
float o31749052565965_0_clamp_false = o31746938642637_3_1_f*(dot((o31749035792280_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31749052565965_0_clamp_true = clamp(o31749052565965_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_6 (o31749052565965)
float o31749052565965_0_1_f = o31749052565965_0_clamp_false;
// #output0: graph_4/graph_3/invert_2 (o31749019015071)
vec4 o31749019015071_0_1_rgba = vec4(vec3(1.0)-o31748096264988_0_1_rgba.rgb, o31748096264988_0_1_rgba.a);
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_10_map = ((o31908771662505_0_11_rgba).rgb);
float o31908788445038_10_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_10_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_11_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_10_rnd, old_custom_uv_transform(o31908788445038_10_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_10_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_10_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_19_rgba = o31908788445038_0_11_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_19_rgba = o31908989769596_0_19_rgba;
// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_11_f = o31908972989206_0_19_rgba.b;
// #output0: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_0_1_rgba = vec4(vec3(o31748113046165_2_11_f), 1.0);
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_12_map = ((o31908771662505_0_13_rgba).rgb);
float o31908788445038_12_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_12_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_13_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_12_rnd, old_custom_uv_transform(o31908788445038_12_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_12_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_12_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_21_rgba = o31908788445038_0_13_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_21_rgba = o31908989769596_0_21_rgba;
// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_13_f = o31908972989206_0_21_rgba.b;
// #output0: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_0_1_rgba = vec4(vec3(o31748113046165_2_13_f), 1.0);
// #code: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_b = o31747039303226_0_1_rgba;
vec4 o31747072854001_0_l;
float o31747072854001_0_a;
o31747072854001_0_l = o31747056078311_0_1_rgba;
o31747072854001_0_a = p_o31747072854001_amount1*1.0;
o31747072854001_0_b = vec4(blend_lighten((uv), o31747072854001_0_l.rgb, o31747072854001_0_b.rgb, o31747072854001_0_a*o31747072854001_0_l.a), min(1.0, o31747072854001_0_b.a+o31747072854001_0_a*o31747072854001_0_l.a));
// #output0: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_1_rgba = o31747072854001_0_b;
// #code: graph_4/graph_3/tones_step (o31747995608743)
vec3 o31747995608743_0_false = clamp((o31747072854001_0_1_rgba.rgb-vec3(p_o31747995608743_value))/max(0.0001, p_o31747995608743_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31747995608743_0_true = vec3(1.0)-o31747995608743_0_false;
// #output0: graph_4/graph_3/tones_step (o31747995608743)
vec4 o31747995608743_0_1_rgba = vec4(o31747995608743_0_false, o31747072854001_0_1_rgba.a);
// #code: graph_4/graph_3/math_2 (o31748012378028)
float o31748012378028_0_clamp_false = (dot((o31747995608743_0_1_rgba).rgb, vec3(1.0))/3.0)*o31746938642637_3_1_f;
float o31748012378028_0_clamp_true = clamp(o31748012378028_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_2 (o31748012378028)
float o31748012378028_0_1_f = o31748012378028_0_clamp_false;
// #code: graph_4/graph_3/math (o31747962047891)
float o31747962047891_0_clamp_false = (dot((o31747072854001_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o31747962047891_default_in2;
float o31747962047891_0_clamp_true = clamp(o31747962047891_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math (o31747962047891)
float o31747962047891_0_1_f = o31747962047891_0_clamp_false;
// #output0: graph_4/graph_3/invert (o31747945274069)
vec4 o31747945274069_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o31747962047891_0_1_f), 1.0).rgb, vec4(vec3(o31747962047891_0_1_f), 1.0).a);
// #output2: graph_4/decompose_2 (o31746938642637)
float o31746938642637_2_2_f = o31905936319714_1_1_rgba.b;
// #code: graph_4/blend2_17 (o31863892613867)
vec4 o31863892613867_0_b = vec4(vec3(o31746938642637_2_2_f), 1.0);
vec4 o31863892613867_0_l;
float o31863892613867_0_a;
o31863892613867_0_l = o31747945274069_0_1_rgba;
o31863892613867_0_a = p_o31863892613867_amount1*o31748012378028_0_1_f;
o31863892613867_0_b = vec4(blend_normal(uv, o31863892613867_0_l.rgb, o31863892613867_0_b.rgb, o31863892613867_0_a*o31863892613867_0_l.a), min(1.0, o31863892613867_0_b.a+o31863892613867_0_a*o31863892613867_0_l.a));
o31863892613867_0_l = o31749019015071_0_1_rgba;
o31863892613867_0_a = p_o31863892613867_amount2*o31749052565965_0_1_f;
o31863892613867_0_b = vec4(blend_normal(uv, o31863892613867_0_l.rgb, o31863892613867_0_b.rgb, o31863892613867_0_a*o31863892613867_0_l.a), min(1.0, o31863892613867_0_b.a+o31863892613867_0_a*o31863892613867_0_l.a));
o31863892613867_0_l = vec4(vec3(o31863993278209_0_2_f), 1.0);
o31863892613867_0_a = p_o31863892613867_amount3*o31863993278209_2_1_f;
o31863892613867_0_b = vec4(blend_normal(uv, o31863892613867_0_l.rgb, o31863892613867_0_b.rgb, o31863892613867_0_a*o31863892613867_0_l.a), min(1.0, o31863892613867_0_b.a+o31863892613867_0_a*o31863892613867_0_l.a));
// #output0: graph_4/blend2_17 (o31863892613867)
vec4 o31863892613867_0_1_rgba = o31863892613867_0_b;
return (dot((o31863892613867_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o31749287450919_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y))-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_0_map = ((o31908771662505_0_1_rgba).rgb);
float o31908788445038_0_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_1_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_0_rnd, old_custom_uv_transform(o31908788445038_0_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_0_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_1_rgba = o31908788445038_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_1_rgba = o31908989769596_0_1_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_1_f = o31908972989206_0_1_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_1_rgba = vec4(vec3(o31748113046165_0_1_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_1_rgba = o31750210197337_0_1_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_1_rgba = o31750176642362_0_1_rgba;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_2_map = ((o31908771662505_0_3_rgba).rgb);
float o31908788445038_2_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_3_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_2_rnd, old_custom_uv_transform(o31908788445038_2_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_2_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_3_rgba = o31908788445038_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_3_rgba = o31908989769596_0_3_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_3_f = o31908972989206_0_3_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_3_rgba = vec4(vec3(o31748113046165_0_3_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_3_rgba = o31750210197337_0_3_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_clamp_false = max((dot((o31750176642362_0_3_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_0_clamp_true = clamp(o31750294081982_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_1_f = o31750294081982_0_clamp_false;
// #output0: graph_4/graph_3/graph_2/translate_2 (o31750260526526)
vec4 o31750260526526_0_1_rgba = vec4(vec3(o31750294081982_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_4_map = ((o31908771662505_0_5_rgba).rgb);
float o31908788445038_4_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_5_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_4_rnd, old_custom_uv_transform(o31908788445038_4_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_4_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_4_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_5_rgba = o31908788445038_0_5_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_5_rgba = o31908989769596_0_5_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_5_f = o31908972989206_0_5_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_5_rgba = vec4(vec3(o31748113046165_0_5_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_5_rgba = o31750210197337_0_5_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_3_rgba = o31750176642362_0_5_rgba;
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_6_map = ((o31908771662505_0_7_rgba).rgb);
float o31908788445038_6_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_7_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_6_rnd, old_custom_uv_transform(o31908788445038_6_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_6_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_6_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_7_rgba = o31908788445038_0_7_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_7_rgba = o31908989769596_0_7_rgba;
// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_7_f = o31908972989206_0_7_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_7_rgba = vec4(vec3(o31748113046165_0_7_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_7_rgba = o31750210197337_0_7_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_2_clamp_false = max((dot((o31750176642362_0_7_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_3_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_2_clamp_true = clamp(o31750294081982_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_3_f = o31750294081982_2_clamp_false;
// #code: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_clamp_false = max(o31750294081982_0_3_f,(dot((o31750260526526_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750310859723_0_clamp_true = clamp(o31750310859723_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_1_f = o31750310859723_0_clamp_false;
return o31750310859723_0_1_f;
}
// #instance: graph_4/graph_3/normal_map2_3/edge_detect_1 (o31749287450919)
vec3 nm_o31749287450919(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o31749287450919_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o31749287450919_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o31749287450919_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31749287450919_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o31749287450919_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31749287450919_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31749287450919_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31749287450919_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o31749287450919_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o31749287450919_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o31749287450919_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o31749287450919_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o31749287450919_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o31749287450919_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o31749287450919_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o31749287450919_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o31749287450919_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31749287450919_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31749287450919_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31749287450919_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o31749287450919_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o31749287450919_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31749287450919_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o31748247260145_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(uv, vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_0_map = ((o31908771662505_0_1_rgba).rgb);
float o31908788445038_0_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_1_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_0_rnd, old_custom_uv_transform(o31908788445038_0_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_0_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_1_rgba = o31908788445038_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_1_rgba = o31908989769596_0_1_rgba;
// #output3: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_3_1_f = o31908972989206_0_1_rgba.a;
// #output0: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_0_1_rgba = vec4(vec3(o31748113046165_3_1_f), 1.0);
return (dot((o31748096264988_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_4/graph_3/normal_map2_2/edge_detect_1 (o31748247260145)
vec3 nm_o31748247260145(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o31748247260145_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o31748247260145_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o31748247260145_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31748247260145_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o31748247260145_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31748247260145_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31748247260145_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31748247260145_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o31748247260145_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o31748247260145_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o31748247260145_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o31748247260145_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o31748247260145_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o31748247260145_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o31748247260145_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o31748247260145_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o31748247260145_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31748247260145_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31748247260145_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31748247260145_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o31748247260145_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o31748247260145_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31748247260145_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o31747173519623_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_0_map = ((o31908771662505_0_1_rgba).rgb);
float o31908788445038_0_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_1_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_0_rnd, old_custom_uv_transform(o31908788445038_0_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_0_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_1_rgba = o31908788445038_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_1_rgba = o31908989769596_0_1_rgba;
// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_1_f = o31908972989206_0_1_rgba.b;
// #output0: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_0_1_rgba = vec4(vec3(o31748113046165_2_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_2_map = ((o31908771662505_0_3_rgba).rgb);
float o31908788445038_2_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_3_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_2_rnd, old_custom_uv_transform(o31908788445038_2_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_2_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_3_rgba = o31908788445038_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_3_rgba = o31908989769596_0_3_rgba;
// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_3_f = o31908972989206_0_3_rgba.b;
// #output0: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_0_1_rgba = vec4(vec3(o31748113046165_2_3_f), 1.0);
// #code: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_b = o31747039303226_0_1_rgba;
vec4 o31747072854001_0_l;
float o31747072854001_0_a;
o31747072854001_0_l = o31747056078311_0_1_rgba;
o31747072854001_0_a = p_o31747072854001_amount1*1.0;
o31747072854001_0_b = vec4(blend_lighten(uv, o31747072854001_0_l.rgb, o31747072854001_0_b.rgb, o31747072854001_0_a*o31747072854001_0_l.a), min(1.0, o31747072854001_0_b.a+o31747072854001_0_a*o31747072854001_0_l.a));
// #output0: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_1_rgba = o31747072854001_0_b;
return (dot((o31747072854001_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_4/graph_3/normal_map2/edge_detect_1 (o31747173519623)
vec3 nm_o31747173519623(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o31747173519623_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o31747173519623_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o31747173519623_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31747173519623_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o31747173519623_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31747173519623_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31747173519623_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31747173519623_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o31747173519623_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o31747173519623_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o31747173519623_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o31747173519623_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o31747173519623_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o31747173519623_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o31747173519623_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o31747173519623_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o31747173519623_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o31747173519623_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o31747173519623_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o31747173519623_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o31747173519623_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o31747173519623_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o31747173519623_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
vec4 o31905818875749_input_in(vec2 uv, float _seed_variation_) {
vec4 o31905667877013_0 = textureLod(texture_1, fract(uv), 0.0);
return o31905667877013_0;
}
vec4 o31908855554222_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o31905835649606)
vec4 o31905835649606_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905835649606_translate_x, p_o31905835649606_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec3 o31905852431616_0_map = ((o31905835649606_0_1_rgba).rgb);
float o31905852431616_0_rnd =  float((seed_o31905852431616+fract(_seed_variation_)))+o31905852431616_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o31905852431616)
vec4 o31905852431616_0_1_rgba = o31905852431616_input_in(get_from_tileset(2.0, o31905852431616_0_rnd, old_custom_uv_transform(o31905852431616_0_map.xy, vec2(p_o31905852431616_sx, p_o31905852431616_sy), p_o31905852431616_rotate*0.01745329251, p_o31905852431616_scale, vec2(o31905852431616_0_map.z, float((seed_o31905852431616+fract(_seed_variation_)))))), false ? o31905852431616_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_3_1_rgba = o31905852431616_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_3_1_rgba = o31905953091090_3_1_rgba;
return o31905936319714_3_1_rgba;
}
vec4 o31754639382731_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o31911841900219)
vec4 o31911841900219_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31911942560243_translate_x*(2.0*1.0-1.0), p_o31911942560243_translate_y*(2.0*1.0-1.0)), p_o31911942560243_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31911942560243_scale_x*(2.0*1.0-1.0), p_o31911942560243_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31911959332650_cx, 0.5+p_o31911959332650_cy), vec2(p_o31911959332650_scale_x, p_o31911959332650_scale_y)))-vec2(p_o31911841900219_translate_x, p_o31911841900219_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec3 o31911858673510_0_map = ((o31911841900219_0_1_rgba).rgb);
float o31911858673510_0_rnd =  float((seed_o31911858673510+fract(_seed_variation_)))+o31911858673510_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec4 o31911858673510_0_1_rgba = o31911858673510_input_in(get_from_tileset(2.0, o31911858673510_0_rnd, old_custom_uv_transform(o31911858673510_0_map.xy, vec2(p_o31911858673510_sx, p_o31911858673510_sy), p_o31911858673510_rotate*0.01745329251, p_o31911858673510_scale, vec2(o31911858673510_0_map.z, float((seed_o31911858673510+fract(_seed_variation_)))))), false ? o31911858673510_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o31911959332650)
vec4 o31911959332650_3_1_rgba = o31911858673510_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o31911942560243)
vec4 o31911942560243_3_1_rgba = o31911959332650_3_1_rgba;
return o31911942560243_3_1_rgba;
}
vec4 o31754605825776_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o31911841900219)
vec4 o31911841900219_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31911942560243_translate_x*(2.0*1.0-1.0), p_o31911942560243_translate_y*(2.0*1.0-1.0)), p_o31911942560243_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31911942560243_scale_x*(2.0*1.0-1.0), p_o31911942560243_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31911959332650_cx, 0.5+p_o31911959332650_cy), vec2(p_o31911959332650_scale_x, p_o31911959332650_scale_y)))-vec2(p_o31911841900219_translate_x, p_o31911841900219_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec3 o31911858673510_0_map = ((o31911841900219_0_1_rgba).rgb);
float o31911858673510_0_rnd =  float((seed_o31911858673510+fract(_seed_variation_)))+o31911858673510_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec4 o31911858673510_0_1_rgba = o31911858673510_input_in(get_from_tileset(2.0, o31911858673510_0_rnd, old_custom_uv_transform(o31911858673510_0_map.xy, vec2(p_o31911858673510_sx, p_o31911858673510_sy), p_o31911858673510_rotate*0.01745329251, p_o31911858673510_scale, vec2(o31911858673510_0_map.z, float((seed_o31911858673510+fract(_seed_variation_)))))), false ? o31911858673510_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o31911959332650)
vec4 o31911959332650_3_1_rgba = o31911858673510_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o31911942560243)
vec4 o31911942560243_3_1_rgba = o31911959332650_3_1_rgba;
return o31911942560243_3_1_rgba;
}
vec4 o31754572270951_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o31911841900219)
vec4 o31911841900219_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o31911942560243_translate_x*(2.0*1.0-1.0), p_o31911942560243_translate_y*(2.0*1.0-1.0)), p_o31911942560243_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31911942560243_scale_x*(2.0*1.0-1.0), p_o31911942560243_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31911959332650_cx, 0.5+p_o31911959332650_cy), vec2(p_o31911959332650_scale_x, p_o31911959332650_scale_y)))-vec2(p_o31911841900219_translate_x, p_o31911841900219_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec3 o31911858673510_0_map = ((o31911841900219_0_1_rgba).rgb);
float o31911858673510_0_rnd =  float((seed_o31911858673510+fract(_seed_variation_)))+o31911858673510_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o31911858673510)
vec4 o31911858673510_0_1_rgba = o31911858673510_input_in(get_from_tileset(2.0, o31911858673510_0_rnd, old_custom_uv_transform(o31911858673510_0_map.xy, vec2(p_o31911858673510_sx, p_o31911858673510_sy), p_o31911858673510_rotate*0.01745329251, p_o31911858673510_scale, vec2(o31911858673510_0_map.z, float((seed_o31911858673510+fract(_seed_variation_)))))), false ? o31911858673510_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o31911959332650)
vec4 o31911959332650_3_1_rgba = o31911858673510_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o31911942560243)
vec4 o31911942560243_3_1_rgba = o31911959332650_3_1_rgba;
return o31911942560243_3_1_rgba;
}
vec4 o31905751769100_input_in(vec2 uv, float _seed_variation_) {
vec4 o31905667877013_0 = textureLod(texture_1, fract(uv), 0.0);
return o31905667877013_0;
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o31692295248767_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o31692295248767_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o31692295248767_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o31692295248767_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_1_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31751636258209_translate_x, p_o31751636258209_translate_y))-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_1_rgba = vec4(vec3(o31751502041438_0_1_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_1_rgba = o31750176642362_4_1_rgba;

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_3_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31751636258209_translate_x, p_o31751636258209_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_3_rgba = vec4(vec3(o31751502041438_0_3_f), 1.0);

// #code: graph_4/graph_3/graph_3/math_2 (o31751619485186)
float o31751619485186_0_clamp_false = max((dot((o31750176642362_4_3_rgba).rgb, vec3(1.0))/3.0),(dot((o31751585930041_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31751619485186_0_clamp_true = clamp(o31751619485186_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_3/math_2 (o31751619485186)
float o31751619485186_0_1_f = o31751619485186_0_clamp_false;

// #output0: graph_4/graph_3/graph_3/translate_5 (o31751636258209)
vec4 o31751636258209_0_1_rgba = vec4(vec3(o31751619485186_0_1_f), 1.0);

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_5_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y))-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_5_rgba = vec4(vec3(o31751502041438_0_5_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_3_rgba = o31750176642362_4_5_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y))-vec2(p_o31751602704132_translate_x, p_o31751602704132_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_0_map = ((o31754656158694_0_1_rgba).rgb);
float o31754672934067_0_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_1_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_0_rnd, old_custom_uv_transform(o31754672934067_0_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_0_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_0_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_1_rgba = o31754672934067_0_1_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_1_rgba = o31754773600934_3_1_rgba;

// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_7_rgba = o31754756823579_3_1_rgba;

// #output0: graph_4/graph_3/graph_3/translate_3 (o31751602704132)
vec4 o31751602704132_0_1_rgba = o31750176642362_2_7_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_2_map = ((o31754656158694_0_3_rgba).rgb);
float o31754672934067_2_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_3_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_2_rnd, old_custom_uv_transform(o31754672934067_2_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_2_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_2_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_3_rgba = o31754672934067_0_3_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_3_rgba = o31754773600934_3_3_rgba;

// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_9_rgba = o31754756823579_3_3_rgba;

// #code: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_b = o31750176642362_2_9_rgba;
vec4 o31751653037261_0_l;
float o31751653037261_0_a;

o31751653037261_0_l = o31751602704132_0_1_rgba;
o31751653037261_0_a = p_o31751653037261_amount1*(dot((o31751585930041_0_3_rgba).rgb, vec3(1.0))/3.0);
o31751653037261_0_b = vec4(blend_normal(((uv)-vec2(p_o31751669815218_translate_x, p_o31751669815218_translate_y)), o31751653037261_0_l.rgb, o31751653037261_0_b.rgb, o31751653037261_0_a*o31751653037261_0_l.a), min(1.0, o31751653037261_0_b.a+o31751653037261_0_a*o31751653037261_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_1_rgba = o31751653037261_0_b;

// #output0: graph_4/graph_3/graph_3/translate_4 (o31751669815218)
vec4 o31751669815218_0_1_rgba = o31751653037261_0_1_rgba;

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_7_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31751585930041_translate_x, p_o31751585930041_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_11_rgba = vec4(vec3(o31751502041438_0_7_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o31751585930041)
vec4 o31751585930041_0_5_rgba = o31750176642362_4_11_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31751602704132_translate_x, p_o31751602704132_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_4_map = ((o31754656158694_0_5_rgba).rgb);
float o31754672934067_4_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_5_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_4_rnd, old_custom_uv_transform(o31754672934067_4_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_4_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_4_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_5_rgba = o31754672934067_0_5_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_5_rgba = o31754773600934_3_5_rgba;

// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_13_rgba = o31754756823579_3_5_rgba;

// #output0: graph_4/graph_3/graph_3/translate_3 (o31751602704132)
vec4 o31751602704132_0_3_rgba = o31750176642362_2_13_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_6_map = ((o31754656158694_0_7_rgba).rgb);
float o31754672934067_6_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_7_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_6_rnd, old_custom_uv_transform(o31754672934067_6_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_6_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_6_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_7_rgba = o31754672934067_0_7_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_7_rgba = o31754773600934_3_7_rgba;

// #output2: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_2_15_rgba = o31754756823579_3_7_rgba;

// #code: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_2_b = o31750176642362_2_15_rgba;
vec4 o31751653037261_2_l;
float o31751653037261_2_a;

o31751653037261_2_l = o31751602704132_0_3_rgba;
o31751653037261_2_a = p_o31751653037261_amount1*(dot((o31751585930041_0_5_rgba).rgb, vec3(1.0))/3.0);
o31751653037261_2_b = vec4(blend_normal((uv), o31751653037261_2_l.rgb, o31751653037261_2_b.rgb, o31751653037261_2_a*o31751653037261_2_l.a), min(1.0, o31751653037261_2_b.a+o31751653037261_2_a*o31751653037261_2_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o31751653037261)
vec4 o31751653037261_0_3_rgba = o31751653037261_2_b;

// #code: graph_4/graph_3/graph_3/blend2_2 (o31751686592302)
vec4 o31751686592302_0_b = o31751653037261_0_3_rgba;
vec4 o31751686592302_0_l;
float o31751686592302_0_a;

o31751686592302_0_l = o31751669815218_0_1_rgba;
o31751686592302_0_a = p_o31751686592302_amount1*(dot((o31751636258209_0_1_rgba).rgb, vec3(1.0))/3.0);
o31751686592302_0_b = vec4(blend_normal((uv), o31751686592302_0_l.rgb, o31751686592302_0_b.rgb, o31751686592302_0_a*o31751686592302_0_l.a), min(1.0, o31751686592302_0_b.a+o31751686592302_0_a*o31751686592302_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2_2 (o31751686592302)
vec4 o31751686592302_0_1_rgba = o31751686592302_0_b;

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y))-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_0_map = ((o31908771662505_0_1_rgba).rgb);
float o31908788445038_0_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_1_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_0_rnd, old_custom_uv_transform(o31908788445038_0_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_0_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_0_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_1_rgba = o31908788445038_0_1_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_1_rgba = o31908989769596_0_1_rgba;

// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_1_f = o31908972989206_0_1_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_1_rgba = vec4(vec3(o31748113046165_0_1_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_17_rgba = o31750210197337_0_1_rgba;

// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_1_rgba = o31750176642362_0_17_rgba;

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750260526526_translate_x, p_o31750260526526_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_2_map = ((o31908771662505_0_3_rgba).rgb);
float o31908788445038_2_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_3_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_2_rnd, old_custom_uv_transform(o31908788445038_2_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_2_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_2_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_3_rgba = o31908788445038_0_3_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_3_rgba = o31908989769596_0_3_rgba;

// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_3_f = o31908972989206_0_3_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_3_rgba = vec4(vec3(o31748113046165_0_3_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_19_rgba = o31750210197337_0_3_rgba;

// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_clamp_false = max((dot((o31750176642362_0_19_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_0_clamp_true = clamp(o31750294081982_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_1_f = o31750294081982_0_clamp_false;

// #output0: graph_4/graph_3/graph_2/translate_2 (o31750260526526)
vec4 o31750260526526_0_1_rgba = vec4(vec3(o31750294081982_0_1_f), 1.0);

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31750277304134_translate_x, p_o31750277304134_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_4_map = ((o31908771662505_0_5_rgba).rgb);
float o31908788445038_4_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_5_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_4_rnd, old_custom_uv_transform(o31908788445038_4_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_4_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_4_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_5_rgba = o31908788445038_0_5_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_5_rgba = o31908989769596_0_5_rgba;

// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_5_f = o31908972989206_0_5_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_5_rgba = vec4(vec3(o31748113046165_0_5_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_21_rgba = o31750210197337_0_5_rgba;

// #output0: graph_4/graph_3/graph_2/translate (o31750277304134)
vec4 o31750277304134_0_3_rgba = o31750176642362_0_21_rgba;

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31750210197337_translate_x*(2.0*1.0-1.0), p_o31750210197337_translate_y*(2.0*1.0-1.0)), p_o31750210197337_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750210197337_scale_x*(2.0*1.0-1.0), p_o31750210197337_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_6_map = ((o31908771662505_0_7_rgba).rgb);
float o31908788445038_6_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_7_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_6_rnd, old_custom_uv_transform(o31908788445038_6_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_6_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_6_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_7_rgba = o31908788445038_0_7_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_7_rgba = o31908989769596_0_7_rgba;

// #output0: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_0_7_f = o31908972989206_0_7_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o31750210197337)
vec4 o31750210197337_0_7_rgba = vec4(vec3(o31748113046165_0_7_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_0_22_rgba = o31750210197337_0_7_rgba;

// #code: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_2_clamp_false = max((dot((o31750176642362_0_22_rgba).rgb, vec3(1.0))/3.0),(dot((o31750277304134_0_3_rgba).rgb, vec3(1.0))/3.0));
float o31750294081982_2_clamp_true = clamp(o31750294081982_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o31750294081982)
float o31750294081982_0_3_f = o31750294081982_2_clamp_false;

// #code: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_clamp_false = max(o31750294081982_0_3_f,(dot((o31750260526526_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31750310859723_0_clamp_true = clamp(o31750310859723_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o31750310859723)
float o31750310859723_0_1_f = o31750310859723_0_clamp_false;

// #code: graph_4/graph_3/tones_step_3 (o31750126307234)
vec3 o31750126307234_0_false = clamp((vec4(vec3(o31750310859723_0_1_f), 1.0).rgb-vec3(p_o31750126307234_value))/max(0.0001, p_o31750126307234_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31750126307234_0_true = vec3(1.0)-o31750126307234_0_false;
// #output0: graph_4/graph_3/tones_step_3 (o31750126307234)
vec4 o31750126307234_0_1_rgba = vec4(o31750126307234_0_false, vec4(vec3(o31750310859723_0_1_f), 1.0).a);

// #output0: graph_4/graph_4/translate_2 (o31905768541001)
vec4 o31905768541001_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905768541001_translate_x, p_o31905768541001_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_5 (o31905785317785)
vec3 o31905785317785_0_map = ((o31905768541001_0_1_rgba).rgb);
float o31905785317785_0_rnd =  float((seed_o31905785317785+fract(_seed_variation_)))+o31905785317785_0_map.z;
// #output0: graph_4/graph_4/custom_uv_5 (o31905785317785)
vec4 o31905785317785_0_1_rgba = o31905785317785_input_in(get_from_tileset(2.0, o31905785317785_0_rnd, old_custom_uv_transform(o31905785317785_0_map.xy, vec2(p_o31905785317785_sx, p_o31905785317785_sy), p_o31905785317785_rotate*0.01745329251, p_o31905785317785_scale, vec2(o31905785317785_0_map.z, float((seed_o31905785317785+fract(_seed_variation_)))))), false ? o31905785317785_0_rnd : 0.0);

// #output1: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_1_1_rgba = o31905785317785_0_1_rgba;

// #output1: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_1_1_rgba = o31905953091090_1_1_rgba;

// #output3: graph_4/decompose_2 (o31746938642637)
float o31746938642637_3_1_f = o31905936319714_1_1_rgba.a;

// #code: graph_4/graph_3/math_9 (o31750159861723)
float o31750159861723_0_clamp_false = o31746938642637_3_1_f*(dot((o31750126307234_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31750159861723_0_clamp_true = clamp(o31750159861723_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_9 (o31750159861723)
float o31750159861723_0_1_f = o31750159861723_0_clamp_false;

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31753196541747_translate_x, p_o31753196541747_translate_y))-vec2(p_o31753213322715_translate_x, p_o31753213322715_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_0_map = ((o31908805216554_0_1_rgba).rgb);
float o31908821994467_0_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_0_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_1_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_0_rnd, old_custom_uv_transform(o31908821994467_0_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_0_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_0_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_9_rgba = o31908821994467_0_1_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_9_rgba = o31908989769596_1_9_rgba;

// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_1_f = o31908972989206_1_9_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_24_rgba = vec4(vec3(o31753162985330_2_1_f), 1.0);

// #output0: graph_4/graph_3/graph_5/translate (o31753213322715)
vec4 o31753213322715_0_1_rgba = o31750176642362_1_24_rgba;

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31753196541747_translate_x, p_o31753196541747_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_2_map = ((o31908805216554_0_3_rgba).rgb);
float o31908821994467_2_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_2_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_3_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_2_rnd, old_custom_uv_transform(o31908821994467_2_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_2_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_2_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_11_rgba = o31908821994467_0_3_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_11_rgba = o31908989769596_1_11_rgba;

// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_3_f = o31908972989206_1_11_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_26_rgba = vec4(vec3(o31753162985330_2_3_f), 1.0);

// #code: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_clamp_false = max((dot((o31750176642362_1_26_rgba).rgb, vec3(1.0))/3.0),(dot((o31753213322715_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31753230092593_0_clamp_true = clamp(o31753230092593_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_1_f = o31753230092593_0_clamp_false;

// #output0: graph_4/graph_3/graph_5/translate_2 (o31753196541747)
vec4 o31753196541747_0_1_rgba = vec4(vec3(o31753230092593_0_1_f), 1.0);

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31753213322715_translate_x, p_o31753213322715_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_4_map = ((o31908805216554_0_5_rgba).rgb);
float o31908821994467_4_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_4_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_5_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_4_rnd, old_custom_uv_transform(o31908821994467_4_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_4_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_4_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_13_rgba = o31908821994467_0_5_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_13_rgba = o31908989769596_1_13_rgba;

// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_5_f = o31908972989206_1_13_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_28_rgba = vec4(vec3(o31753162985330_2_5_f), 1.0);

// #output0: graph_4/graph_3/graph_5/translate (o31753213322715)
vec4 o31753213322715_0_3_rgba = o31750176642362_1_28_rgba;

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_6_map = ((o31908805216554_0_7_rgba).rgb);
float o31908821994467_6_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_6_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_7_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_6_rnd, old_custom_uv_transform(o31908821994467_6_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_6_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_6_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_15_rgba = o31908821994467_0_7_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_15_rgba = o31908989769596_1_15_rgba;

// #output2: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_2_7_f = o31908972989206_1_15_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_1_29_rgba = vec4(vec3(o31753162985330_2_7_f), 1.0);

// #code: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_2_clamp_false = max((dot((o31750176642362_1_29_rgba).rgb, vec3(1.0))/3.0),(dot((o31753213322715_0_3_rgba).rgb, vec3(1.0))/3.0));
float o31753230092593_2_clamp_true = clamp(o31753230092593_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o31753230092593)
float o31753230092593_0_3_f = o31753230092593_2_clamp_false;

// #code: graph_4/graph_3/graph_5/math_12 (o31753246875094)
float o31753246875094_0_clamp_false = max(o31753230092593_0_3_f,(dot((o31753196541747_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31753246875094_0_clamp_true = clamp(o31753246875094_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_12 (o31753246875094)
float o31753246875094_0_1_f = o31753246875094_0_clamp_false;

// #code: graph_4/graph_3/math_8 (o31750109531339)
float o31750109531339_0_clamp_false = o31753246875094_0_1_f*o31746938642637_3_1_f;
float o31750109531339_0_clamp_true = clamp(o31750109531339_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_8 (o31750109531339)
float o31750109531339_0_1_f = o31750109531339_0_clamp_false;

// #output0: graph_4/graph_3/invert_3 (o31750059202292)
vec4 o31750059202292_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o31750310859723_0_1_f), 1.0).rgb, vec4(vec3(o31750310859723_0_1_f), 1.0).a);

// #output0: graph_4/graph_3/combine (o31750193416561)
vec4 o31750193416561_0_1_rgba = vec4((dot((o31750059202292_0_1_rgba).rgb, vec3(1.0))/3.0), o31750109531339_0_1_f, o31750159861723_0_1_f, (dot((o31751686592302_0_1_rgba).rgb, vec3(1.0))/3.0));

// #output2: graph_4/decompose (o31863993278209)
float o31863993278209_2_1_f = o31750193416561_0_1_rgba.b;

// #output0: graph_4/graph_3/normal_map2_3/edge_detect_1 (o31749287450919)
vec3 o31749287450919_0_1_rgb = nm_o31749287450919((uv), p_o31749287450919_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_8_map = ((o31908771662505_0_9_rgba).rgb);
float o31908788445038_8_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_8_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_9_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_8_rnd, old_custom_uv_transform(o31908788445038_8_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_8_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_8_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_17_rgba = o31908788445038_0_9_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_17_rgba = o31908989769596_0_17_rgba;

// #output3: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_3_9_f = o31908972989206_0_17_rgba.a;

// #output0: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_0_1_rgba = vec4(vec3(o31748113046165_3_9_f), 1.0);

// #code: graph_4/graph_3/tones_step_2 (o31749035792280)
vec3 o31749035792280_0_false = clamp((o31748096264988_0_1_rgba.rgb-vec3(p_o31749035792280_value))/max(0.0001, p_o31749035792280_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31749035792280_0_true = vec3(1.0)-o31749035792280_0_false;
// #output0: graph_4/graph_3/tones_step_2 (o31749035792280)
vec4 o31749035792280_0_1_rgba = vec4(o31749035792280_0_false, o31748096264988_0_1_rgba.a);

// #code: graph_4/graph_3/math_6 (o31749052565965)
float o31749052565965_0_clamp_false = o31746938642637_3_1_f*(dot((o31749035792280_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31749052565965_0_clamp_true = clamp(o31749052565965_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_6 (o31749052565965)
float o31749052565965_0_1_f = o31749052565965_0_clamp_false;

// #output0: graph_4/graph_3/normal_map2_2/edge_detect_1 (o31748247260145)
vec3 o31748247260145_0_1_rgb = nm_o31748247260145((uv), p_o31748247260145_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_10_map = ((o31908771662505_0_11_rgba).rgb);
float o31908788445038_10_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_10_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_11_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_10_rnd, old_custom_uv_transform(o31908788445038_10_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_10_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_10_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_19_rgba = o31908788445038_0_11_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_19_rgba = o31908989769596_0_19_rgba;

// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_11_f = o31908972989206_0_19_rgba.b;

// #output0: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_0_1_rgba = vec4(vec3(o31748113046165_2_11_f), 1.0);

// #output0: graph_4/graph_5/translate (o31908771662505)
vec4 o31908771662505_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908771662505_translate_x, p_o31908771662505_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec3 o31908788445038_12_map = ((o31908771662505_0_13_rgba).rgb);
float o31908788445038_12_rnd =  float((seed_o31908788445038+fract(_seed_variation_)))+o31908788445038_12_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o31908788445038)
vec4 o31908788445038_0_13_rgba = o31908788445038_input_in(get_from_tileset(2.0, o31908788445038_12_rnd, old_custom_uv_transform(o31908788445038_12_map.xy, vec2(p_o31908788445038_sx, p_o31908788445038_sy), p_o31908788445038_rotate*0.01745329251, p_o31908788445038_scale, vec2(o31908788445038_12_map.z, float((seed_o31908788445038+fract(_seed_variation_)))))), false ? o31908788445038_12_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_0_21_rgba = o31908788445038_0_13_rgba;

// #output0: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_0_21_rgba = o31908989769596_0_21_rgba;

// #output2: graph_4/graph_3/decompose_2 (o31748113046165)
float o31748113046165_2_13_f = o31908972989206_0_21_rgba.b;

// #output0: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_0_1_rgba = vec4(vec3(o31748113046165_2_13_f), 1.0);

// #code: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_b = o31747039303226_0_1_rgba;
vec4 o31747072854001_0_l;
float o31747072854001_0_a;

o31747072854001_0_l = o31747056078311_0_1_rgba;
o31747072854001_0_a = p_o31747072854001_amount1*1.0;
o31747072854001_0_b = vec4(blend_lighten((uv), o31747072854001_0_l.rgb, o31747072854001_0_b.rgb, o31747072854001_0_a*o31747072854001_0_l.a), min(1.0, o31747072854001_0_b.a+o31747072854001_0_a*o31747072854001_0_l.a));
// #output0: graph_4/graph_3/blend2 (o31747072854001)
vec4 o31747072854001_0_1_rgba = o31747072854001_0_b;

// #code: graph_4/graph_3/tones_step (o31747995608743)
vec3 o31747995608743_0_false = clamp((o31747072854001_0_1_rgba.rgb-vec3(p_o31747995608743_value))/max(0.0001, p_o31747995608743_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o31747995608743_0_true = vec3(1.0)-o31747995608743_0_false;
// #output0: graph_4/graph_3/tones_step (o31747995608743)
vec4 o31747995608743_0_1_rgba = vec4(o31747995608743_0_false, o31747072854001_0_1_rgba.a);

// #code: graph_4/graph_3/math_2 (o31748012378028)
float o31748012378028_0_clamp_false = (dot((o31747995608743_0_1_rgba).rgb, vec3(1.0))/3.0)*o31746938642637_3_1_f;
float o31748012378028_0_clamp_true = clamp(o31748012378028_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_2 (o31748012378028)
float o31748012378028_0_1_f = o31748012378028_0_clamp_false;

// #output0: graph_4/graph_3/normal_map2/edge_detect_1 (o31747173519623)
vec3 o31747173519623_0_1_rgb = nm_o31747173519623((uv), p_o31747173519623_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_4/translate_3 (o31905802096554)
vec4 o31905802096554_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905802096554_translate_x, p_o31905802096554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_6 (o31905818875749)
vec3 o31905818875749_0_map = ((o31905802096554_0_1_rgba).rgb);
float o31905818875749_0_rnd =  float((seed_o31905818875749+fract(_seed_variation_)))+o31905818875749_0_map.z;
// #output0: graph_4/graph_4/custom_uv_6 (o31905818875749)
vec4 o31905818875749_0_1_rgba = o31905818875749_input_in(get_from_tileset(2.0, o31905818875749_0_rnd, old_custom_uv_transform(o31905818875749_0_map.xy, vec2(p_o31905818875749_sx, p_o31905818875749_sy), p_o31905818875749_rotate*0.01745329251, p_o31905818875749_scale, vec2(o31905818875749_0_map.z, float((seed_o31905818875749+fract(_seed_variation_)))))), false ? o31905818875749_0_rnd : 0.0);

// #output2: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_2_2_rgba = o31905818875749_0_1_rgba;

// #output2: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_2_2_rgba = o31905953091090_2_2_rgba;

// #code: graph_4/blend2_16 (o31863875834366)
vec4 o31863875834366_0_b = o31905936319714_2_2_rgba;
vec4 o31863875834366_0_l;
float o31863875834366_0_a;

o31863875834366_0_l = vec4(o31747173519623_0_1_rgb, 1.0);
o31863875834366_0_a = p_o31863875834366_amount1*o31748012378028_0_1_f;
o31863875834366_0_b = vec4(blend_normal((uv), o31863875834366_0_l.rgb, o31863875834366_0_b.rgb, o31863875834366_0_a*o31863875834366_0_l.a), min(1.0, o31863875834366_0_b.a+o31863875834366_0_a*o31863875834366_0_l.a));

o31863875834366_0_l = vec4(o31748247260145_0_1_rgb, 1.0);
o31863875834366_0_a = p_o31863875834366_amount2*o31749052565965_0_1_f;
o31863875834366_0_b = vec4(blend_normal((uv), o31863875834366_0_l.rgb, o31863875834366_0_b.rgb, o31863875834366_0_a*o31863875834366_0_l.a), min(1.0, o31863875834366_0_b.a+o31863875834366_0_a*o31863875834366_0_l.a));

o31863875834366_0_l = vec4(o31749287450919_0_1_rgb, 1.0);
o31863875834366_0_a = p_o31863875834366_amount3*o31863993278209_2_1_f;
o31863875834366_0_b = vec4(blend_normal((uv), o31863875834366_0_l.rgb, o31863875834366_0_b.rgb, o31863875834366_0_a*o31863875834366_0_l.a), min(1.0, o31863875834366_0_b.a+o31863875834366_0_a*o31863875834366_0_l.a));
// #output0: graph_4/blend2_16 (o31863875834366)
vec4 o31863875834366_0_1_rgba = o31863875834366_0_b;

// #output3: graph_4/decompose (o31863993278209)
float o31863993278209_3_2_f = o31750193416561_0_1_rgba.a;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_9_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_8_map = ((o31754656158694_0_9_rgba).rgb);
float o31754672934067_8_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_8_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_9_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_8_rnd, old_custom_uv_transform(o31754672934067_8_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_8_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_8_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_9_rgba = o31754672934067_0_9_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_9_rgba = o31754773600934_3_9_rgba;

// #output2: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_2_2_rgba = o31754756823579_3_9_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_11_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_10_map = ((o31754656158694_0_11_rgba).rgb);
float o31754672934067_10_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_10_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_11_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_10_rnd, old_custom_uv_transform(o31754672934067_10_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_10_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_10_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_11_rgba = o31754672934067_0_11_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_11_rgba = o31754773600934_3_11_rgba;

// #output2: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_2_2_rgba = o31754756823579_3_11_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o31754656158694)
vec4 o31754656158694_0_13_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754656158694_translate_x, p_o31754656158694_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec3 o31754672934067_12_map = ((o31754656158694_0_13_rgba).rgb);
float o31754672934067_12_rnd =  float((seed_o31754672934067+fract(_seed_variation_)))+o31754672934067_12_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o31754672934067)
vec4 o31754672934067_0_13_rgba = o31754672934067_input_in(get_from_tileset(2.0, o31754672934067_12_rnd, old_custom_uv_transform(o31754672934067_12_map.xy, vec2(p_o31754672934067_sx, p_o31754672934067_sy), p_o31754672934067_rotate*0.01745329251, p_o31754672934067_scale, vec2(o31754672934067_12_map.z, float((seed_o31754672934067+fract(_seed_variation_)))))), false ? o31754672934067_12_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_3_13_rgba = o31754672934067_0_13_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_3_13_rgba = o31754773600934_3_13_rgba;

// #output2: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_2_2_rgba = o31754756823579_3_13_rgba;

// #code: graph_4/graph_3/blend2_3 (o31748045937289)
vec4 o31748045937289_0_b = o31747039303226_0_1_rgba;
vec4 o31748045937289_0_l;
float o31748045937289_0_a;

o31748045937289_0_l = o31747039303226_2_2_rgba;
o31748045937289_0_a = p_o31748045937289_amount1*1.0;
o31748045937289_0_b = vec4(blend_multiply((uv), o31748045937289_0_l.rgb, o31748045937289_0_b.rgb, o31748045937289_0_a*o31748045937289_0_l.a), min(1.0, o31748045937289_0_b.a+o31748045937289_0_a*o31748045937289_0_l.a));

o31748045937289_0_l = o31747056078311_2_2_rgba;
o31748045937289_0_a = p_o31748045937289_amount2*(dot((o31747056078311_0_1_rgba).rgb, vec3(1.0))/3.0);
o31748045937289_0_b = vec4(blend_normal((uv), o31748045937289_0_l.rgb, o31748045937289_0_b.rgb, o31748045937289_0_a*o31748045937289_0_l.a), min(1.0, o31748045937289_0_b.a+o31748045937289_0_a*o31748045937289_0_l.a));
// #output0: graph_4/graph_3/blend2_3 (o31748045937289)
vec4 o31748045937289_0_1_rgba = o31748045937289_0_b;

// #code: graph_4/graph_3/math_4 (o31748062714247)
float o31748062714247_0_clamp_false = o31746938642637_3_1_f*(dot((o31748045937289_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31748062714247_0_clamp_true = clamp(o31748062714247_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_4 (o31748062714247)
float o31748062714247_0_1_f = o31748062714247_0_clamp_false;

// #output1: graph_4/decompose_2 (o31746938642637)
float o31746938642637_1_2_f = o31905936319714_1_1_rgba.g;

// #code: graph_4/blend2_20 (o31863942942110)
vec4 o31863942942110_0_b = vec4(vec3(o31746938642637_1_2_f), 1.0);
vec4 o31863942942110_0_l;
float o31863942942110_0_a;

o31863942942110_0_l = vec4(vec3(o31748062714247_0_1_f), 1.0);
o31863942942110_0_a = p_o31863942942110_amount1*o31748012378028_0_1_f;
o31863942942110_0_b = vec4(blend_normal((uv), o31863942942110_0_l.rgb, o31863942942110_0_b.rgb, o31863942942110_0_a*o31863942942110_0_l.a), min(1.0, o31863942942110_0_b.a+o31863942942110_0_a*o31863942942110_0_l.a));

o31863942942110_0_l = o31748096264988_2_2_rgba;
o31863942942110_0_a = p_o31863942942110_amount2*o31749052565965_0_1_f;
o31863942942110_0_b = vec4(blend_normal((uv), o31863942942110_0_l.rgb, o31863942942110_0_b.rgb, o31863942942110_0_a*o31863942942110_0_l.a), min(1.0, o31863942942110_0_b.a+o31863942942110_0_a*o31863942942110_0_l.a));

o31863942942110_0_l = vec4(vec3(o31863993278209_3_2_f), 1.0);
o31863942942110_0_a = p_o31863942942110_amount3*o31863993278209_2_1_f;
o31863942942110_0_b = vec4(blend_normal((uv), o31863942942110_0_l.rgb, o31863942942110_0_b.rgb, o31863942942110_0_a*o31863942942110_0_l.a), min(1.0, o31863942942110_0_b.a+o31863942942110_0_a*o31863942942110_0_l.a));
// #output0: graph_4/blend2_20 (o31863942942110)
vec4 o31863942942110_0_1_rgba = o31863942942110_0_b;

// #output0: graph_4/graph_5/translate_3 (o31908838774795)
vec4 o31908838774795_0_1_rgba = vec4(((scale((transform2_clamp(transform2((fract(transform2((uv), vec2(p_o31911707679278_translate_x*(2.0*1.0-1.0), p_o31911707679278_translate_y*(2.0*1.0-1.0)), p_o31911707679278_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31911707679278_scale_x*(2.0*1.0-1.0), p_o31911707679278_scale_y*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908838774795_translate_x, p_o31908838774795_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_6 (o31908855554222)
vec3 o31908855554222_0_map = ((o31908838774795_0_1_rgba).rgb);
float o31908855554222_0_rnd =  float((seed_o31908855554222+fract(_seed_variation_)))+o31908855554222_0_map.z;
// #output0: graph_4/graph_5/custom_uv_6 (o31908855554222)
vec4 o31908855554222_0_1_rgba = o31908855554222_input_in(get_from_tileset(2.0, o31908855554222_0_rnd, old_custom_uv_transform(o31908855554222_0_map.xy, vec2(p_o31908855554222_sx, p_o31908855554222_sy), p_o31908855554222_rotate*0.01745329251, p_o31908855554222_scale, vec2(o31908855554222_0_map.z, float((seed_o31908855554222+fract(_seed_variation_)))))), false ? o31908855554222_0_rnd : 0.0);

// #output2: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_2_23_rgba = o31908855554222_0_1_rgba;

// #output2: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_2_23_rgba = o31908989769596_2_23_rgba;

// #output0: graph_4/transform2 (o31911707679278)
vec4 o31911707679278_0_1_rgba = o31908972989206_2_23_rgba;

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_9_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31752441567381_translate_x, p_o31752441567381_translate_y))-vec2(p_o31752391233543_translate_x, p_o31752391233543_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_31_rgba = vec4(vec3(o31751502041438_0_9_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o31752391233543)
vec4 o31752391233543_0_1_rgba = o31750176642362_4_31_rgba;

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_11_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31752441567381_translate_x, p_o31752441567381_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_33_rgba = vec4(vec3(o31751502041438_0_11_f), 1.0);

// #code: graph_4/graph_3/graph_4/math_2 (o31752424789690)
float o31752424789690_0_clamp_false = max((dot((o31750176642362_4_33_rgba).rgb, vec3(1.0))/3.0),(dot((o31752391233543_0_1_rgba).rgb, vec3(1.0))/3.0));
float o31752424789690_0_clamp_true = clamp(o31752424789690_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_4/math_2 (o31752424789690)
float o31752424789690_0_1_f = o31752424789690_0_clamp_false;

// #output0: graph_4/graph_3/graph_4/translate_5 (o31752441567381)
vec4 o31752441567381_0_1_rgba = vec4(vec3(o31752424789690_0_1_f), 1.0);

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_13_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o31752475119837_translate_x, p_o31752475119837_translate_y))-vec2(p_o31752391233543_translate_x, p_o31752391233543_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_35_rgba = vec4(vec3(o31751502041438_0_13_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o31752391233543)
vec4 o31752391233543_0_3_rgba = o31750176642362_4_35_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o31754622604577)
vec4 o31754622604577_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o31752475119837_translate_x, p_o31752475119837_translate_y))-vec2(p_o31752408013769_translate_x, p_o31752408013769_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754622604577_translate_x, p_o31754622604577_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec3 o31754639382731_0_map = ((o31754622604577_0_1_rgba).rgb);
float o31754639382731_0_rnd =  float((seed_o31754639382731+fract(_seed_variation_)))+o31754639382731_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec4 o31754639382731_0_1_rgba = o31754639382731_input_in(get_from_tileset(2.0, o31754639382731_0_rnd, old_custom_uv_transform(o31754639382731_0_map.xy, vec2(p_o31754639382731_sx, p_o31754639382731_sy), p_o31754639382731_rotate*0.01745329251, p_o31754639382731_scale, vec2(o31754639382731_0_map.z, float((seed_o31754639382731+fract(_seed_variation_)))))), false ? o31754639382731_0_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_2_15_rgba = o31754639382731_0_1_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_2_15_rgba = o31754773600934_2_15_rgba;

// #output3: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_3_37_rgba = o31754756823579_2_15_rgba;

// #output0: graph_4/graph_3/graph_4/translate_3 (o31752408013769)
vec4 o31752408013769_0_1_rgba = o31750176642362_3_37_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o31754622604577)
vec4 o31754622604577_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31752475119837_translate_x, p_o31752475119837_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754622604577_translate_x, p_o31754622604577_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec3 o31754639382731_2_map = ((o31754622604577_0_3_rgba).rgb);
float o31754639382731_2_rnd =  float((seed_o31754639382731+fract(_seed_variation_)))+o31754639382731_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec4 o31754639382731_0_3_rgba = o31754639382731_input_in(get_from_tileset(2.0, o31754639382731_2_rnd, old_custom_uv_transform(o31754639382731_2_map.xy, vec2(p_o31754639382731_sx, p_o31754639382731_sy), p_o31754639382731_rotate*0.01745329251, p_o31754639382731_scale, vec2(o31754639382731_2_map.z, float((seed_o31754639382731+fract(_seed_variation_)))))), false ? o31754639382731_2_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_2_17_rgba = o31754639382731_0_3_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_2_17_rgba = o31754773600934_2_17_rgba;

// #output3: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_3_39_rgba = o31754756823579_2_17_rgba;

// #code: graph_4/graph_3/graph_4/blend2 (o31752458342207)
vec4 o31752458342207_0_b = o31750176642362_3_39_rgba;
vec4 o31752458342207_0_l;
float o31752458342207_0_a;

o31752458342207_0_l = o31752408013769_0_1_rgba;
o31752458342207_0_a = p_o31752458342207_amount1*(dot((o31752391233543_0_3_rgba).rgb, vec3(1.0))/3.0);
o31752458342207_0_b = vec4(blend_normal(((uv)-vec2(p_o31752475119837_translate_x, p_o31752475119837_translate_y)), o31752458342207_0_l.rgb, o31752458342207_0_b.rgb, o31752458342207_0_a*o31752458342207_0_l.a), min(1.0, o31752458342207_0_b.a+o31752458342207_0_a*o31752458342207_0_l.a));
// #output0: graph_4/graph_3/graph_4/blend2 (o31752458342207)
vec4 o31752458342207_0_1_rgba = o31752458342207_0_b;

// #output0: graph_4/graph_3/graph_4/translate_4 (o31752475119837)
vec4 o31752475119837_0_1_rgba = o31752458342207_0_1_rgba;

// #output0: graph_4/graph_3/shape (o31751502041438)
float o31751502041438_0_15_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o31752391233543_translate_x, p_o31752391233543_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), p_o31751502041438_sides, p_o31751502041438_radius*1.0, p_o31751502041438_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_4_41_rgba = vec4(vec3(o31751502041438_0_15_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o31752391233543)
vec4 o31752391233543_0_5_rgba = o31750176642362_4_41_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o31754622604577)
vec4 o31754622604577_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o31752408013769_translate_x, p_o31752408013769_translate_y)), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754622604577_translate_x, p_o31754622604577_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec3 o31754639382731_4_map = ((o31754622604577_0_5_rgba).rgb);
float o31754639382731_4_rnd =  float((seed_o31754639382731+fract(_seed_variation_)))+o31754639382731_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec4 o31754639382731_0_5_rgba = o31754639382731_input_in(get_from_tileset(2.0, o31754639382731_4_rnd, old_custom_uv_transform(o31754639382731_4_map.xy, vec2(p_o31754639382731_sx, p_o31754639382731_sy), p_o31754639382731_rotate*0.01745329251, p_o31754639382731_scale, vec2(o31754639382731_4_map.z, float((seed_o31754639382731+fract(_seed_variation_)))))), false ? o31754639382731_4_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_2_19_rgba = o31754639382731_0_5_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_2_19_rgba = o31754773600934_2_19_rgba;

// #output3: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_3_43_rgba = o31754756823579_2_19_rgba;

// #output0: graph_4/graph_3/graph_4/translate_3 (o31752408013769)
vec4 o31752408013769_0_3_rgba = o31750176642362_3_43_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o31754622604577)
vec4 o31754622604577_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31750176642362_translate_x*(2.0*1.0-1.0), p_o31750176642362_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31750176642362_scale_x*(2.0*1.0-1.0), (p_o31750176642362_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754622604577_translate_x, p_o31754622604577_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec3 o31754639382731_6_map = ((o31754622604577_0_7_rgba).rgb);
float o31754639382731_6_rnd =  float((seed_o31754639382731+fract(_seed_variation_)))+o31754639382731_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o31754639382731)
vec4 o31754639382731_0_7_rgba = o31754639382731_input_in(get_from_tileset(2.0, o31754639382731_6_rnd, old_custom_uv_transform(o31754639382731_6_map.xy, vec2(p_o31754639382731_sx, p_o31754639382731_sy), p_o31754639382731_rotate*0.01745329251, p_o31754639382731_scale, vec2(o31754639382731_6_map.z, float((seed_o31754639382731+fract(_seed_variation_)))))), false ? o31754639382731_6_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_2_20_rgba = o31754639382731_0_7_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_2_20_rgba = o31754773600934_2_20_rgba;

// #output3: graph_4/graph_3/transform2_4 (o31750176642362)
vec4 o31750176642362_3_44_rgba = o31754756823579_2_20_rgba;

// #code: graph_4/graph_3/graph_4/blend2 (o31752458342207)
vec4 o31752458342207_2_b = o31750176642362_3_44_rgba;
vec4 o31752458342207_2_l;
float o31752458342207_2_a;

o31752458342207_2_l = o31752408013769_0_3_rgba;
o31752458342207_2_a = p_o31752458342207_amount1*(dot((o31752391233543_0_5_rgba).rgb, vec3(1.0))/3.0);
o31752458342207_2_b = vec4(blend_normal((uv), o31752458342207_2_l.rgb, o31752458342207_2_b.rgb, o31752458342207_2_a*o31752458342207_2_l.a), min(1.0, o31752458342207_2_b.a+o31752458342207_2_a*o31752458342207_2_l.a));
// #output0: graph_4/graph_3/graph_4/blend2 (o31752458342207)
vec4 o31752458342207_0_3_rgba = o31752458342207_2_b;

// #code: graph_4/graph_3/graph_4/blend2_2 (o31752491896591)
vec4 o31752491896591_0_b = o31752458342207_0_3_rgba;
vec4 o31752491896591_0_l;
float o31752491896591_0_a;

o31752491896591_0_l = o31752475119837_0_1_rgba;
o31752491896591_0_a = p_o31752491896591_amount1*(dot((o31752441567381_0_1_rgba).rgb, vec3(1.0))/3.0);
o31752491896591_0_b = vec4(blend_normal((uv), o31752491896591_0_l.rgb, o31752491896591_0_b.rgb, o31752491896591_0_a*o31752491896591_0_l.a), min(1.0, o31752491896591_0_b.a+o31752491896591_0_a*o31752491896591_0_l.a));
// #output0: graph_4/graph_3/graph_4/blend2_2 (o31752491896591)
vec4 o31752491896591_0_1_rgba = o31752491896591_0_b;

// #output1: graph_4/decompose (o31863993278209)
float o31863993278209_1_3_f = o31750193416561_0_1_rgba.g;

// #output0: graph_4/uniform_greyscale (o31864999905969)
float o31864999905969_0_1_f = p_o31864999905969_color;

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_8_map = ((o31908805216554_0_9_rgba).rgb);
float o31908821994467_8_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_8_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_9_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_8_rnd, old_custom_uv_transform(o31908821994467_8_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_8_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_8_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_24_rgba = o31908821994467_0_9_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_24_rgba = o31908989769596_1_24_rgba;

// #output1: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_1_9_f = o31908972989206_1_24_rgba.g;

// #output1: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_1_3_rgba = vec4(vec3(o31753162985330_1_9_f), 1.0);

// #code: graph_4/graph_3/math_7 (o31749069348985)
float o31749069348985_0_clamp_false = (dot((o31748096264988_1_3_rgba).rgb, vec3(1.0))/3.0)*o31746938642637_3_1_f;
float o31749069348985_0_clamp_true = clamp(o31749069348985_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_7 (o31749069348985)
float o31749069348985_0_1_f = o31749069348985_0_clamp_false;

// #output0: graph_4/graph_3/graph_6/translate_2 (o31754589047544)
vec4 o31754589047544_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31748096264988_translate_x*(2.0*1.0-1.0), p_o31748096264988_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31748096264988_scale_x*(2.0*1.0-1.0), (p_o31748096264988_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754589047544_translate_x, p_o31754589047544_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_5 (o31754605825776)
vec3 o31754605825776_0_map = ((o31754589047544_0_1_rgba).rgb);
float o31754605825776_0_rnd =  float((seed_o31754605825776+fract(_seed_variation_)))+o31754605825776_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_5 (o31754605825776)
vec4 o31754605825776_0_1_rgba = o31754605825776_input_in(get_from_tileset(2.0, o31754605825776_0_rnd, old_custom_uv_transform(o31754605825776_0_map.xy, vec2(p_o31754605825776_sx, p_o31754605825776_sy), p_o31754605825776_rotate*0.01745329251, p_o31754605825776_scale, vec2(o31754605825776_0_map.z, float((seed_o31754605825776+fract(_seed_variation_)))))), false ? o31754605825776_0_rnd : 0.0);

// #output1: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_1_21_rgba = o31754605825776_0_1_rgba;

// #output1: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_1_21_rgba = o31754773600934_1_21_rgba;

// #output3: graph_4/graph_3/transform2_3 (o31748096264988)
vec4 o31748096264988_3_4_rgba = o31754756823579_1_21_rgba;

// #output0: graph_4/graph_3/graph_6/translate (o31754555494521)
vec4 o31754555494521_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754555494521_translate_x, p_o31754555494521_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_4 (o31754572270951)
vec3 o31754572270951_0_map = ((o31754555494521_0_1_rgba).rgb);
float o31754572270951_0_rnd =  float((seed_o31754572270951+fract(_seed_variation_)))+o31754572270951_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_4 (o31754572270951)
vec4 o31754572270951_0_1_rgba = o31754572270951_input_in(get_from_tileset(2.0, o31754572270951_0_rnd, old_custom_uv_transform(o31754572270951_0_map.xy, vec2(p_o31754572270951_sx, p_o31754572270951_sy), p_o31754572270951_rotate*0.01745329251, p_o31754572270951_scale, vec2(o31754572270951_0_map.z, float((seed_o31754572270951+fract(_seed_variation_)))))), false ? o31754572270951_0_rnd : 0.0);

// #output0: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_0_22_rgba = o31754572270951_0_1_rgba;

// #output0: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_0_22_rgba = o31754773600934_0_22_rgba;

// #output3: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_3_3_rgba = o31754756823579_0_22_rgba;

// #output0: graph_4/graph_3/graph_6/translate (o31754555494521)
vec4 o31754555494521_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31754756823579_translate_x*(2.0*1.0-1.0), p_o31754756823579_translate_y*(2.0*1.0-1.0)), p_o31754756823579_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31754756823579_scale_x*(2.0*1.0-1.0), p_o31754756823579_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31754773600934_cx, 0.5+p_o31754773600934_cy), vec2(p_o31754773600934_scale_x, p_o31754773600934_scale_y)))-vec2(p_o31754555494521_translate_x, p_o31754555494521_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_4 (o31754572270951)
vec3 o31754572270951_2_map = ((o31754555494521_0_3_rgba).rgb);
float o31754572270951_2_rnd =  float((seed_o31754572270951+fract(_seed_variation_)))+o31754572270951_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_4 (o31754572270951)
vec4 o31754572270951_0_3_rgba = o31754572270951_input_in(get_from_tileset(2.0, o31754572270951_2_rnd, old_custom_uv_transform(o31754572270951_2_map.xy, vec2(p_o31754572270951_sx, p_o31754572270951_sy), p_o31754572270951_rotate*0.01745329251, p_o31754572270951_scale, vec2(o31754572270951_2_map.z, float((seed_o31754572270951+fract(_seed_variation_)))))), false ? o31754572270951_2_rnd : 0.0);

// #output0: graph_4/graph_3/graph_6/scale (o31754773600934)
vec4 o31754773600934_0_23_rgba = o31754572270951_0_3_rgba;

// #output0: graph_4/graph_3/graph_6/transform2_2 (o31754756823579)
vec4 o31754756823579_0_23_rgba = o31754773600934_0_23_rgba;

// #output3: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_3_3_rgba = o31754756823579_0_23_rgba;

// #code: graph_4/graph_3/blend2_5 (o31748079488968)
vec4 o31748079488968_0_b = o31747039303226_3_3_rgba;
vec4 o31748079488968_0_l;
float o31748079488968_0_a;

o31748079488968_0_l = o31747056078311_3_3_rgba;
o31748079488968_0_a = p_o31748079488968_amount1*1.0;
o31748079488968_0_b = vec4(blend_lighten((uv), o31748079488968_0_l.rgb, o31748079488968_0_b.rgb, o31748079488968_0_a*o31748079488968_0_l.a), min(1.0, o31748079488968_0_b.a+o31748079488968_0_a*o31748079488968_0_l.a));
// #output0: graph_4/graph_3/blend2_5 (o31748079488968)
vec4 o31748079488968_0_1_rgba = o31748079488968_0_b;

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747056078311_translate_x*(2.0*1.0-1.0), p_o31747056078311_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747056078311_scale_x*(2.0*1.0-1.0), (p_o31747056078311_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_10_map = ((o31908805216554_0_11_rgba).rgb);
float o31908821994467_10_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_10_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_11_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_10_rnd, old_custom_uv_transform(o31908821994467_10_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_10_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_10_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_25_rgba = o31908821994467_0_11_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_25_rgba = o31908989769596_1_25_rgba;

// #output0: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_0_11_f = o31908972989206_1_25_rgba.r;

// #output1: graph_4/graph_3/transform2_2 (o31747056078311)
vec4 o31747056078311_1_4_rgba = vec4(vec3(o31753162985330_0_11_f), 1.0);

// #output0: graph_4/graph_5/translate_2 (o31908805216554)
vec4 o31908805216554_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o31747039303226_translate_x*(2.0*1.0-1.0), p_o31747039303226_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o31747039303226_scale_x*(2.0*1.0-1.0), (p_o31747039303226_scale_x)*(2.0*1.0-1.0))))), vec2(p_o31908972989206_translate_x*(2.0*1.0-1.0), p_o31908972989206_translate_y*(2.0*1.0-1.0)), p_o31908972989206_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31908972989206_scale_x*(2.0*1.0-1.0), p_o31908972989206_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31908989769596_cx, 0.5+p_o31908989769596_cy), vec2(p_o31908989769596_scale_x, p_o31908989769596_scale_y)))-vec2(p_o31908805216554_translate_x, p_o31908805216554_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec3 o31908821994467_12_map = ((o31908805216554_0_13_rgba).rgb);
float o31908821994467_12_rnd =  float((seed_o31908821994467+fract(_seed_variation_)))+o31908821994467_12_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o31908821994467)
vec4 o31908821994467_0_13_rgba = o31908821994467_input_in(get_from_tileset(2.0, o31908821994467_12_rnd, old_custom_uv_transform(o31908821994467_12_map.xy, vec2(p_o31908821994467_sx, p_o31908821994467_sy), p_o31908821994467_rotate*0.01745329251, p_o31908821994467_scale, vec2(o31908821994467_12_map.z, float((seed_o31908821994467+fract(_seed_variation_)))))), false ? o31908821994467_12_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o31908989769596)
vec4 o31908989769596_1_26_rgba = o31908821994467_0_13_rgba;

// #output1: graph_4/graph_5/transform2_2 (o31908972989206)
vec4 o31908972989206_1_26_rgba = o31908989769596_1_26_rgba;

// #output0: graph_4/graph_3/decompose_4 (o31753162985330)
float o31753162985330_0_13_f = o31908972989206_1_26_rgba.r;

// #output1: graph_4/graph_3/transform2 (o31747039303226)
vec4 o31747039303226_1_4_rgba = vec4(vec3(o31753162985330_0_13_f), 1.0);

// #code: graph_4/graph_3/blend2_2 (o31747978828694)
vec4 o31747978828694_0_b = o31747039303226_1_4_rgba;
vec4 o31747978828694_0_l;
float o31747978828694_0_a;

o31747978828694_0_l = o31747056078311_1_4_rgba;
o31747978828694_0_a = p_o31747978828694_amount1*1.0;
o31747978828694_0_b = vec4(blend_lighten((uv), o31747978828694_0_l.rgb, o31747978828694_0_b.rgb, o31747978828694_0_a*o31747978828694_0_l.a), min(1.0, o31747978828694_0_b.a+o31747978828694_0_a*o31747978828694_0_l.a));
// #output0: graph_4/graph_3/blend2_2 (o31747978828694)
vec4 o31747978828694_0_1_rgba = o31747978828694_0_b;

// #code: graph_4/graph_3/math_3 (o31748029157889)
float o31748029157889_0_clamp_false = (dot((o31747978828694_0_1_rgba).rgb, vec3(1.0))/3.0)*o31746938642637_3_1_f;
float o31748029157889_0_clamp_true = clamp(o31748029157889_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_3 (o31748029157889)
float o31748029157889_0_1_f = o31748029157889_0_clamp_false;

// #output0: graph_4/graph_4/translate (o31905734987756)
vec4 o31905734987756_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o31905936319714_translate_x*(2.0*1.0-1.0), p_o31905936319714_translate_y*(2.0*1.0-1.0)), p_o31905936319714_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31905936319714_scale_x*(2.0*1.0-1.0), p_o31905936319714_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o31905953091090_cx, 0.5+p_o31905953091090_cy), vec2(p_o31905953091090_scale_x, p_o31905953091090_scale_y)))-vec2(p_o31905734987756_translate_x, p_o31905734987756_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_4 (o31905751769100)
vec3 o31905751769100_0_map = ((o31905734987756_0_1_rgba).rgb);
float o31905751769100_0_rnd =  float((seed_o31905751769100+fract(_seed_variation_)))+o31905751769100_0_map.z;
// #output0: graph_4/graph_4/custom_uv_4 (o31905751769100)
vec4 o31905751769100_0_1_rgba = o31905751769100_input_in(get_from_tileset(2.0, o31905751769100_0_rnd, old_custom_uv_transform(o31905751769100_0_map.xy, vec2(p_o31905751769100_sx, p_o31905751769100_sy), p_o31905751769100_rotate*0.01745329251, p_o31905751769100_scale, vec2(o31905751769100_0_map.z, float((seed_o31905751769100+fract(_seed_variation_)))))), false ? o31905751769100_0_rnd : 0.0);

// #output0: graph_4/graph_4/scale (o31905953091090)
vec4 o31905953091090_0_3_rgba = o31905751769100_0_1_rgba;

// #output0: graph_4/graph_4/transform2_2 (o31905936319714)
vec4 o31905936319714_0_3_rgba = o31905953091090_0_3_rgba;

// #code: graph_4/blend2_18 (o31863909391287)
vec4 o31863909391287_0_b = o31905936319714_0_3_rgba;
vec4 o31863909391287_0_l;
float o31863909391287_0_a;

o31863909391287_0_l = vec4(vec3(o31864999905969_0_1_f), 1.0);
o31863909391287_0_a = p_o31863909391287_amount1*o31748029157889_0_1_f;
o31863909391287_0_b = vec4(blend_normal((uv), o31863909391287_0_l.rgb, o31863909391287_0_b.rgb, o31863909391287_0_a*o31863909391287_0_l.a), min(1.0, o31863909391287_0_b.a+o31863909391287_0_a*o31863909391287_0_l.a));
// #output0: graph_4/blend2_18 (o31863909391287)
vec4 o31863909391287_0_1_rgba = o31863909391287_0_b;

// #code: graph_4/blend2_15 (o31863859060446)
vec4 o31863859060446_0_b = o31863909391287_0_1_rgba;
vec4 o31863859060446_0_l;
float o31863859060446_0_a;

o31863859060446_0_l = o31748079488968_0_1_rgba;
o31863859060446_0_a = p_o31863859060446_amount1*o31748012378028_0_1_f;
o31863859060446_0_b = vec4(blend_normal((uv), o31863859060446_0_l.rgb, o31863859060446_0_b.rgb, o31863859060446_0_a*o31863859060446_0_l.a), min(1.0, o31863859060446_0_b.a+o31863859060446_0_a*o31863859060446_0_l.a));

o31863859060446_0_l = o31748096264988_3_4_rgba;
o31863859060446_0_a = p_o31863859060446_amount2*o31749069348985_0_1_f;
o31863859060446_0_b = vec4(blend_normal((uv), o31863859060446_0_l.rgb, o31863859060446_0_b.rgb, o31863859060446_0_a*o31863859060446_0_l.a), min(1.0, o31863859060446_0_b.a+o31863859060446_0_a*o31863859060446_0_l.a));

o31863859060446_0_l = vec4(vec3(o31864999905969_0_1_f), 1.0);
o31863859060446_0_a = p_o31863859060446_amount3*o31863993278209_1_3_f;
o31863859060446_0_b = vec4(blend_normal((uv), o31863859060446_0_l.rgb, o31863859060446_0_b.rgb, o31863859060446_0_a*o31863859060446_0_l.a), min(1.0, o31863859060446_0_b.a+o31863859060446_0_a*o31863859060446_0_l.a));

o31863859060446_0_l = o31752491896591_0_1_rgba;
o31863859060446_0_a = p_o31863859060446_amount4*o31863993278209_2_1_f;
o31863859060446_0_b = vec4(blend_normal((uv), o31863859060446_0_l.rgb, o31863859060446_0_b.rgb, o31863859060446_0_a*o31863859060446_0_l.a), min(1.0, o31863859060446_0_b.a+o31863859060446_0_a*o31863859060446_0_l.a));
// #output0: graph_4/blend2_15 (o31863859060446)
vec4 o31863859060446_0_1_rgba = o31863859060446_0_b;

// #code: graph_4/blend2_21 (o31863976500000)
vec4 o31863976500000_0_b = o31863859060446_0_1_rgba;
vec4 o31863976500000_0_l;
float o31863976500000_0_a;

o31863976500000_0_l = o31911707679278_0_1_rgba;
o31863976500000_0_a = p_o31863976500000_amount1*o31746938642637_3_1_f;
o31863976500000_0_b = vec4(blend_multiply((uv), o31863976500000_0_l.rgb, o31863976500000_0_b.rgb, o31863976500000_0_a*o31863976500000_0_l.a), min(1.0, o31863976500000_0_b.a+o31863976500000_0_a*o31863976500000_0_l.a));
// #output0: graph_4/blend2_21 (o31863976500000)
vec4 o31863976500000_0_1_rgba = o31863976500000_0_b;

	vec3 albedo_tex = ((o31863976500000_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o31692295248767_albedo_color.rgb;
	METALLIC = 1.0*p_o31692295248767_metallic;
	ROUGHNESS = (dot((o31863942942110_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o31692295248767_roughness;
	NORMAL_MAP = ((o31863875834366_0_1_rgba).rgb);
	NORMAL_MAP_DEPTH = p_o31692295248767_normal;
	EMISSION = vec3(0.0)*p_o31692295248767_emission_energy;
}



