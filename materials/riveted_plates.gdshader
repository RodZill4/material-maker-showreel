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
const vec4 p_o742307935352_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o742307935352_metallic = 0.880000000;
const float p_o742307935352_roughness = 0.700000000;
const float p_o742307935352_emission_energy = 0.000000000;
const float p_o742307935352_normal = 1.000000000;
const float p_o742307935352_ao = 1.000000000;
const float p_o742307935352_depth_scale = 0.150000000;
const float p_o913905301269_amount1 = 1.000000000;
const float p_o913905301269_amount2 = 1.000000000;
const float p_o913905301269_amount3 = 0.330000000;
const float p_o801699280613_amount1 = 1.000000000;
const float p_o801648948962_translate_x = 0.000000000;
const float p_o801648948962_translate_y = 1.000000000;
const float p_o801632171745_default_in1 = 0.000000000;
const float p_o801632171745_default_in2 = 0.000000000;
const float p_o801598617311_translate_x = 1.000000000;
const float p_o801598617311_translate_y = 0.000000000;
const float p_o800189331149_translate_x = -0.394450000;
const float p_o800189331149_translate_y = -0.393100000;
const float p_o800189331149_scale_x = 0.723100000;
const float p_o801514731226_sides = 2.000000000;
const float p_o801514731226_radius = 0.940000000;
const float p_o801514731226_edge = 0.000000000;
const float p_o801682503396_translate_x = 0.000000000;
const float p_o801682503396_translate_y = 1.000000000;
const float p_o801665726179_amount1 = 1.000000000;
const float p_o801615394528_translate_x = 1.000000000;
const float p_o801615394528_translate_y = 0.000000000;
const float p_o804769511184_translate_x = 0.000000000;
const float p_o804769511184_translate_y = 0.000000000;
const float p_o804769511184_rotate = 0.000000000;
const float p_o804769511184_scale_x = 1.000000000;
const float p_o804769511184_scale_y = 1.000000000;
const float p_o804786288401_cx = 0.000000000;
const float p_o804786288401_cy = 0.000000000;
const float p_o804786288401_scale_x = 1.025000000;
const float p_o804786288401_scale_y = 1.025000000;
const float seed_o804685625099 = 0.000000000;
const float p_o804685625099_sx = 1.000000000;
const float p_o804685625099_sy = 1.000000000;
const float p_o804685625099_rotate = 0.000000000;
const float p_o804685625099_scale = 0.000000000;
const float p_o961955248359_translate_x = 0.000000000;
const float p_o961955248359_translate_y = 0.000000000;
const float p_o961955248359_rotate = 0.000000000;
const float p_o961955248359_scale_x = 1.000000000;
const float p_o961955248359_scale_y = 1.000000000;
const float p_o961972025576_cx = 0.000000000;
const float p_o961972025576_cy = 0.000000000;
const float p_o961972025576_scale_x = 1.000000000;
const float p_o961972025576_scale_y = 1.000000000;
const float seed_o961871362274 = 0.000000000;
const float p_o961871362274_sx = 1.000000000;
const float p_o961871362274_sy = 1.000000000;
const float p_o961871362274_rotate = 0.000000000;
const float p_o961871362274_scale = 0.000000000;
const float p_o955949004995_translate_x = 0.000000000;
const float p_o955949004995_translate_y = 0.000000000;
const float p_o955949004995_rotate = 0.000000000;
const float p_o955949004995_scale_x = 1.000000000;
const float p_o955949004995_scale_y = 1.000000000;
const float p_o955965782212_cx = 0.000000000;
const float p_o955965782212_cy = 0.000000000;
const float p_o955965782212_scale_x = 1.001000000;
const float p_o955965782212_scale_y = 1.001000000;
const float seed_o955865118910 = 0.000000000;
const float p_o955865118910_sx = 1.000000000;
const float p_o955865118910_sy = 1.000000000;
const float p_o955865118910_rotate = 0.000000000;
const float p_o955865118910_scale = 0.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 2048.000000000;
const float p_o955848341693_translate_x = 0.000000000;
const float p_o955848341693_translate_y = 0.000000000;
const float p_o961854585049_translate_x = 0.000000000;
const float p_o961854585049_translate_y = 0.000000000;
const float p_o804668847882_translate_x = 0.000000000;
const float p_o804668847882_translate_y = 0.000000000;
const float p_o800172553932_default_in1 = 0.000000000;
const float p_o800172553932_default_in2 = 0.000000000;
const float p_o800138999498_value = 0.160000000;
const float p_o800138999498_width = 0.020000000;
const float p_o800323548885_default_in1 = 0.000000000;
const float p_o800323548885_default_in2 = 0.000000000;
const float p_o800273217234_translate_x = 1.000000000;
const float p_o800273217234_translate_y = 0.000000000;
const float p_o800306771668_default_in1 = 0.000000000;
const float p_o800306771668_default_in2 = 0.000000000;
const float p_o800289994451_translate_x = 0.000000000;
const float p_o800289994451_translate_y = 1.000000000;
const float p_o800222885583_translate_x = 0.000000000;
const float p_o800222885583_translate_y = 0.000000000;
const float p_o800222885583_rotate = 0.000000000;
const float p_o800222885583_scale_x = 0.900000000;
const float p_o800222885583_scale_y = 0.900000000;
const float p_o958985681111_translate_x = 0.000000000;
const float p_o958985681111_translate_y = 0.000000000;
const float p_o958985681111_rotate = 0.000000000;
const float p_o958985681111_scale_x = 1.000000000;
const float p_o958985681111_scale_y = 1.000000000;
const float p_o959002458328_cx = 0.000000000;
const float p_o959002458328_cy = 0.000000000;
const float p_o959002458328_scale_x = 1.020000000;
const float p_o959002458328_scale_y = 1.020000000;
const float seed_o958801131723 = 0.000000000;
const float p_o958801131723_sx = 1.000000000;
const float p_o958801131723_sy = 1.000000000;
const float p_o958801131723_rotate = 0.000000000;
const float p_o958801131723_scale = 0.000000000;
const float p_o958784354508_translate_x = 1.000000000;
const float p_o958784354508_translate_y = 1.000000000;
const float seed_o955798010042 = 0.000000000;
const float p_o955798010042_sx = 1.000000000;
const float p_o955798010042_sy = 1.000000000;
const float p_o955798010042_rotate = 0.000000000;
const float p_o955798010042_scale = 0.000000000;
const float p_o955781232825_translate_x = 0.000000000;
const float p_o955781232825_translate_y = 1.000000000;
const float p_o800122222281_default_in1 = 0.000000000;
const float p_o800122222281_default_in2 = 0.000000000;
const float p_o803259561720_default_in1 = 0.000000000;
const float p_o803259561720_default_in2 = 0.000000000;
const float p_o803209230069_translate_x = 1.000000000;
const float p_o803209230069_translate_y = 0.000000000;
const float p_o803242784503_default_in1 = 0.000000000;
const float p_o803242784503_default_in2 = 0.000000000;
const float p_o803226007286_translate_x = 0.000000000;
const float p_o803226007286_translate_y = 1.000000000;
const float seed_o958834686158 = 0.000000000;
const float p_o958834686158_sx = 1.000000000;
const float p_o958834686158_sy = 1.000000000;
const float p_o958834686158_rotate = 0.000000000;
const float p_o958834686158_scale = 0.000000000;
const float p_o958817908933_translate_x = 0.000000000;
const float p_o958817908933_translate_y = 1.000000000;
const float p_o799065257651_default_in1 = 0.000000000;
const float p_o799065257651_default_in2 = 0.000000000;
const float p_o799048480434_value = 0.160000000;
const float p_o799048480434_width = 0.020000000;
const float p_o798108956323_translate_x = -0.153500000;
const float p_o798108956323_translate_y = 0.269300000;
const float p_o798108956323_scale_x = 0.269700000;
const float p_o798025070238_default_in1 = 0.000000000;
const float p_o798025070238_default_in2 = 0.000000000;
const float p_o798008293021_value = 0.160000000;
const float p_o798008293021_width = 0.020000000;
const float p_o797085546127_amount1 = 1.000000000;
const float p_o797068768910_translate_x = -0.492450000;
const float p_o797068768910_translate_y = 0.111550000;
const float p_o797068768910_scale_x = 0.500000000;
const float p_o797051991693_translate_x = -0.153500000;
const float p_o797051991693_translate_y = 0.269300000;
const float p_o797051991693_scale_x = 0.500000000;
const float p_o797974738587_default_in1 = 0.000000000;
const float p_o797974738587_default_in2 = 0.240000000;
const float p_o913888524062_amount1 = 1.000000000;
const float p_o913888524062_amount2 = 1.000000000;
const float p_o913888524062_amount3 = 1.000000000;
const float p_o799300138689_amount = 1.000000000;
const float p_o798259951276_amount = 1.000000000;
const float p_o797186209429_amount = 1.000000000;
const float seed_o955831564476 = 0.000000000;
const float p_o955831564476_sx = 1.000000000;
const float p_o955831564476_sy = 1.000000000;
const float p_o955831564476_rotate = 0.000000000;
const float p_o955831564476_scale = 0.000000000;
const float p_o955814787259_translate_x = 1.000000000;
const float p_o955814787259_translate_y = 0.000000000;
const float p_o913955632922_amount1 = 1.000000000;
const float p_o913955632922_amount2 = 1.000000000;
const float p_o913955632922_amount3 = 1.000000000;
const float p_o798075401889_default_in1 = 0.000000000;
const float p_o798075401889_default_in2 = 0.000000000;
const float p_o798058624672_amount1 = 1.000000000;
const float p_o798058624672_amount2 = 1.000000000;
const float p_o913989187351_amount1 = 1.000000000;
const float p_o961720367326_translate_x = 0.000000000;
const float p_o961720367326_translate_y = 0.000000000;
const float p_o961720367326_rotate = 0.000000000;
const float p_o961720367326_scale_x = 1.000000000;
const float p_o961720367326_scale_y = 1.000000000;
const float seed_o958868240592 = 0.000000000;
const float p_o958868240592_sx = 1.000000000;
const float p_o958868240592_sy = 1.000000000;
const float p_o958868240592_rotate = 0.000000000;
const float p_o958868240592_scale = 0.000000000;
const float p_o958851463375_translate_x = 1.000000000;
const float p_o958851463375_translate_y = 0.000000000;
const float p_o913871746838_amount1 = 1.000000000;
const float p_o913871746838_amount2 = 1.000000000;
const float p_o913871746838_amount3 = 0.710000000;
const float p_o913871746838_amount4 = 1.000000000;
const float p_o802504586992_amount1 = 1.000000000;
const float p_o802454255341_translate_x = 0.000000000;
const float p_o802454255341_translate_y = 1.000000000;
const float p_o802437478124_default_in1 = 0.000000000;
const float p_o802437478124_default_in2 = 0.000000000;
const float p_o802403923690_translate_x = 1.000000000;
const float p_o802403923690_translate_y = 0.000000000;
const float p_o802487809775_translate_x = 0.000000000;
const float p_o802487809775_translate_y = 1.000000000;
const float p_o802471032558_amount1 = 1.000000000;
const float p_o802420700907_translate_x = 1.000000000;
const float p_o802420700907_translate_y = 0.000000000;
const float seed_o804652070665 = 0.000000000;
const float p_o804652070665_sx = 1.000000000;
const float p_o804652070665_sy = 1.000000000;
const float p_o804652070665_rotate = 0.000000000;
const float p_o804652070665_scale = 0.000000000;
const float p_o804635293448_translate_x = 1.000000000;
const float p_o804635293448_translate_y = 0.000000000;
const float p_o915012597547_color = 0.000000000;
const float p_o799082034868_default_in1 = 0.000000000;
const float p_o799082034868_default_in2 = 0.000000000;
const float seed_o804618516231 = 0.000000000;
const float p_o804618516231_sx = 1.000000000;
const float p_o804618516231_sy = 1.000000000;
const float p_o804618516231_rotate = 0.000000000;
const float p_o804618516231_scale = 0.000000000;
const float p_o804601739014_translate_x = 0.000000000;
const float p_o804601739014_translate_y = 1.000000000;
const float p_o798092179106_amount1 = 1.000000000;
const float seed_o804584961797 = 0.000000000;
const float p_o804584961797_sx = 1.000000000;
const float p_o804584961797_sy = 1.000000000;
const float p_o804584961797_rotate = 0.000000000;
const float p_o804584961797_scale = 0.000000000;
const float p_o804568184580_translate_x = 1.000000000;
const float p_o804568184580_translate_y = 1.000000000;
const float p_o913922078493_amount1 = 0.770000000;
const float p_o798041847455_default_in1 = 0.000000000;
const float p_o798041847455_default_in2 = 0.000000000;
const float p_o797991515804_amount1 = 1.000000000;
const float seed_o955764455608 = 0.000000000;
const float p_o955764455608_sx = 1.000000000;
const float p_o955764455608_sy = 1.000000000;
const float p_o955764455608_rotate = 0.000000000;
const float p_o955764455608_scale = 0.000000000;
const float p_o955747678391_translate_x = 1.000000000;
const float p_o955747678391_translate_y = 1.000000000;
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
// #globals: graph_4/blend2_17 (o913905301269)
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
// #globals: graph_4/decompose (o914005964572)
// #globals: graph_4/graph_3/graph_3/math_2 (o801632171745)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: graph_4/graph_3/transform2_4 (o800189331149)
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
// #globals: graph_4/graph_3/shape (o801514731226)
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
// #globals: graph_4/graph_3/graph_6/scale (o804786288401)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: graph_4/graph_4/custom_uv_7 (o955865118910)
vec2 get_from_tileset(float count, float seed, vec2 uv) {
	return clamp((uv+floor(rand2(vec2(seed))*count))/count, vec2(0.0), vec2(1.0));
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
vec4 o955865118910_input_in(vec2 uv, float _seed_variation_) {
vec4 o955680569523_0 = textureLod(texture_1, fract(uv), 0.0);
return o955680569523_0;
}
vec4 o961871362274_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o955848341693)
vec4 o955848341693_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955848341693_translate_x, p_o955848341693_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o955865118910)
vec3 o955865118910_0_map = ((o955848341693_0_1_rgba).rgb);
float o955865118910_0_rnd =  float((seed_o955865118910+fract(_seed_variation_)))+o955865118910_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o955865118910)
vec4 o955865118910_0_1_rgba = o955865118910_input_in(get_from_tileset(2.0, o955865118910_0_rnd, custom_uv_transform(o955865118910_0_map.xy, vec2(p_o955865118910_sx, p_o955865118910_sy), p_o955865118910_rotate*0.01745329251, p_o955865118910_scale, vec2(o955865118910_0_map.z, float((seed_o955865118910+fract(_seed_variation_)))))), false ? o955865118910_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_3_1_rgba = o955865118910_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_3_1_rgba = o955965782212_3_1_rgba;
return o955949004995_3_1_rgba;
}
vec4 o804685625099_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o961854585049)
vec4 o961854585049_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o961955248359_translate_x*(2.0*1.0-1.0), p_o961955248359_translate_y*(2.0*1.0-1.0)), p_o961955248359_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o961955248359_scale_x*(2.0*1.0-1.0), p_o961955248359_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o961972025576_cx, 0.5+p_o961972025576_cy), vec2(p_o961972025576_scale_x, p_o961972025576_scale_y)))-vec2(p_o961854585049_translate_x, p_o961854585049_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o961871362274)
vec3 o961871362274_0_map = ((o961854585049_0_1_rgba).rgb);
float o961871362274_0_rnd =  float((seed_o961871362274+fract(_seed_variation_)))+o961871362274_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o961871362274)
vec4 o961871362274_0_1_rgba = o961871362274_input_in(get_from_tileset(2.0, o961871362274_0_rnd, custom_uv_transform(o961871362274_0_map.xy, vec2(p_o961871362274_sx, p_o961871362274_sy), p_o961871362274_rotate*0.01745329251, p_o961871362274_scale, vec2(o961871362274_0_map.z, float((seed_o961871362274+fract(_seed_variation_)))))), false ? o961871362274_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o961972025576)
vec4 o961972025576_3_1_rgba = o961871362274_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o961955248359)
vec4 o961955248359_3_1_rgba = o961972025576_3_1_rgba;
return o961955248359_3_1_rgba;
}
vec4 o958801131723_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o955848341693)
vec4 o955848341693_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955848341693_translate_x, p_o955848341693_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o955865118910)
vec3 o955865118910_0_map = ((o955848341693_0_1_rgba).rgb);
float o955865118910_0_rnd =  float((seed_o955865118910+fract(_seed_variation_)))+o955865118910_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o955865118910)
vec4 o955865118910_0_1_rgba = o955865118910_input_in(get_from_tileset(2.0, o955865118910_0_rnd, custom_uv_transform(o955865118910_0_map.xy, vec2(p_o955865118910_sx, p_o955865118910_sy), p_o955865118910_rotate*0.01745329251, p_o955865118910_scale, vec2(o955865118910_0_map.z, float((seed_o955865118910+fract(_seed_variation_)))))), false ? o955865118910_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_3_1_rgba = o955865118910_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_3_1_rgba = o955965782212_3_1_rgba;
return o955949004995_3_1_rgba;
}
vec4 o955798010042_input_in(vec2 uv, float _seed_variation_) {
vec4 o955680569523_0 = textureLod(texture_1, fract(uv), 0.0);
return o955680569523_0;
}
vec4 o958834686158_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o955848341693)
vec4 o955848341693_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955848341693_translate_x, p_o955848341693_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o955865118910)
vec3 o955865118910_0_map = ((o955848341693_0_1_rgba).rgb);
float o955865118910_0_rnd =  float((seed_o955865118910+fract(_seed_variation_)))+o955865118910_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o955865118910)
vec4 o955865118910_0_1_rgba = o955865118910_input_in(get_from_tileset(2.0, o955865118910_0_rnd, custom_uv_transform(o955865118910_0_map.xy, vec2(p_o955865118910_sx, p_o955865118910_sy), p_o955865118910_rotate*0.01745329251, p_o955865118910_scale, vec2(o955865118910_0_map.z, float((seed_o955865118910+fract(_seed_variation_)))))), false ? o955865118910_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_3_1_rgba = o955865118910_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_3_1_rgba = o955965782212_3_1_rgba;
return o955949004995_3_1_rgba;
}
float o742307935352_input_depth_tex(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_1_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o801648948962_translate_x, p_o801648948962_translate_y))-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_1_rgba = vec4(vec3(o801514731226_0_1_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_1_rgba = o800189331149_4_1_rgba;
// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_3_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o801648948962_translate_x, p_o801648948962_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_3_rgba = vec4(vec3(o801514731226_0_3_f), 1.0);
// #code: graph_4/graph_3/graph_3/math_2 (o801632171745)
float o801632171745_0_clamp_false = max((dot((o800189331149_4_3_rgba).rgb, vec3(1.0))/3.0),(dot((o801598617311_0_1_rgba).rgb, vec3(1.0))/3.0));
float o801632171745_0_clamp_true = clamp(o801632171745_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_3/math_2 (o801632171745)
float o801632171745_0_1_f = o801632171745_0_clamp_false;
// #output0: graph_4/graph_3/graph_3/translate_5 (o801648948962)
vec4 o801648948962_0_1_rgba = vec4(vec3(o801632171745_0_1_f), 1.0);
// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_5_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y))-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_5_rgba = vec4(vec3(o801514731226_0_5_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_3_rgba = o800189331149_4_5_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y))-vec2(p_o801615394528_translate_x, p_o801615394528_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_0_map = ((o804668847882_0_1_rgba).rgb);
float o804685625099_0_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_1_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_0_rnd, custom_uv_transform(o804685625099_0_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_0_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_0_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_1_rgba = o804685625099_0_1_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_1_rgba = o804786288401_3_1_rgba;
// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_7_rgba = o804769511184_3_1_rgba;
// #output0: graph_4/graph_3/graph_3/translate_3 (o801615394528)
vec4 o801615394528_0_1_rgba = o800189331149_2_7_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_2_map = ((o804668847882_0_3_rgba).rgb);
float o804685625099_2_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_3_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_2_rnd, custom_uv_transform(o804685625099_2_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_2_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_2_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_3_rgba = o804685625099_0_3_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_3_rgba = o804786288401_3_3_rgba;
// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_9_rgba = o804769511184_3_3_rgba;
// #code: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_b = o800189331149_2_9_rgba;
vec4 o801665726179_0_l;
float o801665726179_0_a;
o801665726179_0_l = o801615394528_0_1_rgba;
o801665726179_0_a = p_o801665726179_amount1*(dot((o801598617311_0_3_rgba).rgb, vec3(1.0))/3.0);
o801665726179_0_b = vec4(blend_normal(((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y)), o801665726179_0_l.rgb, o801665726179_0_b.rgb, o801665726179_0_a*o801665726179_0_l.a), min(1.0, o801665726179_0_b.a+o801665726179_0_a*o801665726179_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_1_rgba = o801665726179_0_b;
// #output0: graph_4/graph_3/graph_3/translate_4 (o801682503396)
vec4 o801682503396_0_1_rgba = o801665726179_0_1_rgba;
// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_7_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);
// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_11_rgba = vec4(vec3(o801514731226_0_7_f), 1.0);
// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_5_rgba = o800189331149_4_11_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o801615394528_translate_x, p_o801615394528_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_4_map = ((o804668847882_0_5_rgba).rgb);
float o804685625099_4_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_5_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_4_rnd, custom_uv_transform(o804685625099_4_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_4_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_4_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_5_rgba = o804685625099_0_5_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_5_rgba = o804786288401_3_5_rgba;
// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_13_rgba = o804769511184_3_5_rgba;
// #output0: graph_4/graph_3/graph_3/translate_3 (o801615394528)
vec4 o801615394528_0_3_rgba = o800189331149_2_13_rgba;
// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_6_map = ((o804668847882_0_7_rgba).rgb);
float o804685625099_6_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_7_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_6_rnd, custom_uv_transform(o804685625099_6_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_6_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_6_rnd : 0.0);
// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_7_rgba = o804685625099_0_7_rgba;
// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_7_rgba = o804786288401_3_7_rgba;
// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_15_rgba = o804769511184_3_7_rgba;
// #code: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_2_b = o800189331149_2_15_rgba;
vec4 o801665726179_2_l;
float o801665726179_2_a;
o801665726179_2_l = o801615394528_0_3_rgba;
o801665726179_2_a = p_o801665726179_amount1*(dot((o801598617311_0_5_rgba).rgb, vec3(1.0))/3.0);
o801665726179_2_b = vec4(blend_normal((uv), o801665726179_2_l.rgb, o801665726179_2_b.rgb, o801665726179_2_a*o801665726179_2_l.a), min(1.0, o801665726179_2_b.a+o801665726179_2_a*o801665726179_2_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_3_rgba = o801665726179_2_b;
// #code: graph_4/graph_3/graph_3/blend2_2 (o801699280613)
vec4 o801699280613_0_b = o801665726179_0_3_rgba;
vec4 o801699280613_0_l;
float o801699280613_0_a;
o801699280613_0_l = o801682503396_0_1_rgba;
o801699280613_0_a = p_o801699280613_amount1*(dot((o801648948962_0_1_rgba).rgb, vec3(1.0))/3.0);
o801699280613_0_b = vec4(blend_normal((uv), o801699280613_0_l.rgb, o801699280613_0_b.rgb, o801699280613_0_a*o801699280613_0_l.a), min(1.0, o801699280613_0_b.a+o801699280613_0_a*o801699280613_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2_2 (o801699280613)
vec4 o801699280613_0_1_rgba = o801699280613_0_b;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y))-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_0_map = ((o958784354508_0_1_rgba).rgb);
float o958801131723_0_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_1_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_0_rnd, custom_uv_transform(o958801131723_0_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_0_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_1_rgba = o958801131723_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_1_rgba = o959002458328_0_1_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_1_f = o958985681111_0_1_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_1_rgba = vec4(vec3(o798125733540_0_1_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_17_rgba = o800222885583_0_1_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_1_rgba = o800189331149_0_17_rgba;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_2_map = ((o958784354508_0_3_rgba).rgb);
float o958801131723_2_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_3_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_2_rnd, custom_uv_transform(o958801131723_2_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_2_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_3_rgba = o958801131723_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_3_rgba = o959002458328_0_3_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_3_f = o958985681111_0_3_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_3_rgba = vec4(vec3(o798125733540_0_3_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_19_rgba = o800222885583_0_3_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_clamp_false = max((dot((o800189331149_0_19_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_0_clamp_true = clamp(o800306771668_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_1_f = o800306771668_0_clamp_false;
// #output0: graph_4/graph_3/graph_2/translate_2 (o800273217234)
vec4 o800273217234_0_1_rgba = vec4(vec3(o800306771668_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_4_map = ((o958784354508_0_5_rgba).rgb);
float o958801131723_4_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_5_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_4_rnd, custom_uv_transform(o958801131723_4_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_4_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_4_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_5_rgba = o958801131723_0_5_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_5_rgba = o959002458328_0_5_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_5_f = o958985681111_0_5_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_5_rgba = vec4(vec3(o798125733540_0_5_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_21_rgba = o800222885583_0_5_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_3_rgba = o800189331149_0_21_rgba;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_6_map = ((o958784354508_0_7_rgba).rgb);
float o958801131723_6_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_7_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_6_rnd, custom_uv_transform(o958801131723_6_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_6_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_6_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_7_rgba = o958801131723_0_7_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_7_rgba = o959002458328_0_7_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_7_f = o958985681111_0_7_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_7_rgba = vec4(vec3(o798125733540_0_7_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_22_rgba = o800222885583_0_7_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_2_clamp_false = max((dot((o800189331149_0_22_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_3_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_2_clamp_true = clamp(o800306771668_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_3_f = o800306771668_2_clamp_false;
// #code: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_clamp_false = max(o800306771668_0_3_f,(dot((o800273217234_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800323548885_0_clamp_true = clamp(o800323548885_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_1_f = o800323548885_0_clamp_false;
// #code: graph_4/graph_3/tones_step_3 (o800138999498)
vec3 o800138999498_0_false = clamp((vec4(vec3(o800323548885_0_1_f), 1.0).rgb-vec3(p_o800138999498_value))/max(0.0001, p_o800138999498_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o800138999498_0_true = vec3(1.0)-o800138999498_0_false;
// #output0: graph_4/graph_3/tones_step_3 (o800138999498)
vec4 o800138999498_0_1_rgba = vec4(o800138999498_0_false, vec4(vec3(o800323548885_0_1_f), 1.0).a);
// #output0: graph_4/graph_4/translate_2 (o955781232825)
vec4 o955781232825_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955781232825_translate_x, p_o955781232825_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_5 (o955798010042)
vec3 o955798010042_0_map = ((o955781232825_0_1_rgba).rgb);
float o955798010042_0_rnd =  float((seed_o955798010042+fract(_seed_variation_)))+o955798010042_0_map.z;
// #output0: graph_4/graph_4/custom_uv_5 (o955798010042)
vec4 o955798010042_0_1_rgba = o955798010042_input_in(get_from_tileset(2.0, o955798010042_0_rnd, custom_uv_transform(o955798010042_0_map.xy, vec2(p_o955798010042_sx, p_o955798010042_sy), p_o955798010042_rotate*0.01745329251, p_o955798010042_scale, vec2(o955798010042_0_map.z, float((seed_o955798010042+fract(_seed_variation_)))))), false ? o955798010042_0_rnd : 0.0);
// #output1: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_1_1_rgba = o955798010042_0_1_rgba;
// #output1: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_1_1_rgba = o955965782212_1_1_rgba;
// #output3: graph_4/decompose_2 (o796951328391)
float o796951328391_3_1_f = o955949004995_1_1_rgba.a;
// #code: graph_4/graph_3/math_9 (o800172553932)
float o800172553932_0_clamp_false = o796951328391_3_1_f*(dot((o800138999498_0_1_rgba).rgb, vec3(1.0))/3.0);
float o800172553932_0_clamp_true = clamp(o800172553932_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_9 (o800172553932)
float o800172553932_0_1_f = o800172553932_0_clamp_false;
// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o803209230069_translate_x, p_o803209230069_translate_y))-vec2(p_o803226007286_translate_x, p_o803226007286_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_0_map = ((o958817908933_0_1_rgba).rgb);
float o958834686158_0_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_0_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_1_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_0_rnd, custom_uv_transform(o958834686158_0_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_0_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_0_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_9_rgba = o958834686158_0_1_rgba;
// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_9_rgba = o959002458328_1_9_rgba;
// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_1_f = o958985681111_1_9_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_24_rgba = vec4(vec3(o803175675635_2_1_f), 1.0);
// #output0: graph_4/graph_3/graph_5/translate (o803226007286)
vec4 o803226007286_0_1_rgba = o800189331149_1_24_rgba;
// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o803209230069_translate_x, p_o803209230069_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_2_map = ((o958817908933_0_3_rgba).rgb);
float o958834686158_2_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_2_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_3_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_2_rnd, custom_uv_transform(o958834686158_2_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_2_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_2_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_11_rgba = o958834686158_0_3_rgba;
// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_11_rgba = o959002458328_1_11_rgba;
// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_3_f = o958985681111_1_11_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_26_rgba = vec4(vec3(o803175675635_2_3_f), 1.0);
// #code: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_clamp_false = max((dot((o800189331149_1_26_rgba).rgb, vec3(1.0))/3.0),(dot((o803226007286_0_1_rgba).rgb, vec3(1.0))/3.0));
float o803242784503_0_clamp_true = clamp(o803242784503_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_1_f = o803242784503_0_clamp_false;
// #output0: graph_4/graph_3/graph_5/translate_2 (o803209230069)
vec4 o803209230069_0_1_rgba = vec4(vec3(o803242784503_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o803226007286_translate_x, p_o803226007286_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_4_map = ((o958817908933_0_5_rgba).rgb);
float o958834686158_4_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_4_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_5_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_4_rnd, custom_uv_transform(o958834686158_4_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_4_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_4_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_13_rgba = o958834686158_0_5_rgba;
// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_13_rgba = o959002458328_1_13_rgba;
// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_5_f = o958985681111_1_13_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_28_rgba = vec4(vec3(o803175675635_2_5_f), 1.0);
// #output0: graph_4/graph_3/graph_5/translate (o803226007286)
vec4 o803226007286_0_3_rgba = o800189331149_1_28_rgba;
// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_6_map = ((o958817908933_0_7_rgba).rgb);
float o958834686158_6_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_6_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_7_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_6_rnd, custom_uv_transform(o958834686158_6_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_6_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_6_rnd : 0.0);
// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_15_rgba = o958834686158_0_7_rgba;
// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_15_rgba = o959002458328_1_15_rgba;
// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_7_f = o958985681111_1_15_rgba.b;
// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_29_rgba = vec4(vec3(o803175675635_2_7_f), 1.0);
// #code: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_2_clamp_false = max((dot((o800189331149_1_29_rgba).rgb, vec3(1.0))/3.0),(dot((o803226007286_0_3_rgba).rgb, vec3(1.0))/3.0));
float o803242784503_2_clamp_true = clamp(o803242784503_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_3_f = o803242784503_2_clamp_false;
// #code: graph_4/graph_3/graph_5/math_12 (o803259561720)
float o803259561720_0_clamp_false = max(o803242784503_0_3_f,(dot((o803209230069_0_1_rgba).rgb, vec3(1.0))/3.0));
float o803259561720_0_clamp_true = clamp(o803259561720_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_12 (o803259561720)
float o803259561720_0_1_f = o803259561720_0_clamp_false;
// #code: graph_4/graph_3/math_8 (o800122222281)
float o800122222281_0_clamp_false = o803259561720_0_1_f*o796951328391_3_1_f;
float o800122222281_0_clamp_true = clamp(o800122222281_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_8 (o800122222281)
float o800122222281_0_1_f = o800122222281_0_clamp_false;
// #output0: graph_4/graph_3/invert_3 (o800071890630)
vec4 o800071890630_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o800323548885_0_1_f), 1.0).rgb, vec4(vec3(o800323548885_0_1_f), 1.0).a);
// #output0: graph_4/graph_3/combine (o800206108366)
vec4 o800206108366_0_1_rgba = vec4((dot((o800071890630_0_1_rgba).rgb, vec3(1.0))/3.0), o800122222281_0_1_f, o800172553932_0_1_f, (dot((o801699280613_0_1_rgba).rgb, vec3(1.0))/3.0));
// #output2: graph_4/decompose (o914005964572)
float o914005964572_2_1_f = o800206108366_0_1_rgba.b;
// #output0: graph_4/decompose (o914005964572)
float o914005964572_0_2_f = o800206108366_0_1_rgba.r;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_8_map = ((o958784354508_0_9_rgba).rgb);
float o958801131723_8_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_8_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_9_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_8_rnd, custom_uv_transform(o958801131723_8_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_8_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_8_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_17_rgba = o958801131723_0_9_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_17_rgba = o959002458328_0_17_rgba;
// #output3: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_3_9_f = o958985681111_0_17_rgba.a;
// #output0: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_0_1_rgba = vec4(vec3(o798125733540_3_9_f), 1.0);
// #code: graph_4/graph_3/tones_step_2 (o799048480434)
vec3 o799048480434_0_false = clamp((o798108956323_0_1_rgba.rgb-vec3(p_o799048480434_value))/max(0.0001, p_o799048480434_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o799048480434_0_true = vec3(1.0)-o799048480434_0_false;
// #output0: graph_4/graph_3/tones_step_2 (o799048480434)
vec4 o799048480434_0_1_rgba = vec4(o799048480434_0_false, o798108956323_0_1_rgba.a);
// #code: graph_4/graph_3/math_6 (o799065257651)
float o799065257651_0_clamp_false = o796951328391_3_1_f*(dot((o799048480434_0_1_rgba).rgb, vec3(1.0))/3.0);
float o799065257651_0_clamp_true = clamp(o799065257651_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_6 (o799065257651)
float o799065257651_0_1_f = o799065257651_0_clamp_false;
// #output0: graph_4/graph_3/invert_2 (o799031703217)
vec4 o799031703217_0_1_rgba = vec4(vec3(1.0)-o798108956323_0_1_rgba.rgb, o798108956323_0_1_rgba.a);
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_10_map = ((o958784354508_0_11_rgba).rgb);
float o958801131723_10_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_10_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_11_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_10_rnd, custom_uv_transform(o958801131723_10_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_10_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_10_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_19_rgba = o958801131723_0_11_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_19_rgba = o959002458328_0_19_rgba;
// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_11_f = o958985681111_0_19_rgba.b;
// #output0: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_0_1_rgba = vec4(vec3(o798125733540_2_11_f), 1.0);
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_12_map = ((o958784354508_0_13_rgba).rgb);
float o958801131723_12_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_12_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_13_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_12_rnd, custom_uv_transform(o958801131723_12_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_12_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_12_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_21_rgba = o958801131723_0_13_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_21_rgba = o959002458328_0_21_rgba;
// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_13_f = o958985681111_0_21_rgba.b;
// #output0: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_0_1_rgba = vec4(vec3(o798125733540_2_13_f), 1.0);
// #code: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_b = o797051991693_0_1_rgba;
vec4 o797085546127_0_l;
float o797085546127_0_a;
o797085546127_0_l = o797068768910_0_1_rgba;
o797085546127_0_a = p_o797085546127_amount1*1.0;
o797085546127_0_b = vec4(blend_lighten((uv), o797085546127_0_l.rgb, o797085546127_0_b.rgb, o797085546127_0_a*o797085546127_0_l.a), min(1.0, o797085546127_0_b.a+o797085546127_0_a*o797085546127_0_l.a));
// #output0: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_1_rgba = o797085546127_0_b;
// #code: graph_4/graph_3/tones_step (o798008293021)
vec3 o798008293021_0_false = clamp((o797085546127_0_1_rgba.rgb-vec3(p_o798008293021_value))/max(0.0001, p_o798008293021_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o798008293021_0_true = vec3(1.0)-o798008293021_0_false;
// #output0: graph_4/graph_3/tones_step (o798008293021)
vec4 o798008293021_0_1_rgba = vec4(o798008293021_0_false, o797085546127_0_1_rgba.a);
// #code: graph_4/graph_3/math_2 (o798025070238)
float o798025070238_0_clamp_false = (dot((o798008293021_0_1_rgba).rgb, vec3(1.0))/3.0)*o796951328391_3_1_f;
float o798025070238_0_clamp_true = clamp(o798025070238_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_2 (o798025070238)
float o798025070238_0_1_f = o798025070238_0_clamp_false;
// #code: graph_4/graph_3/math (o797974738587)
float o797974738587_0_clamp_false = (dot((o797085546127_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o797974738587_default_in2;
float o797974738587_0_clamp_true = clamp(o797974738587_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math (o797974738587)
float o797974738587_0_1_f = o797974738587_0_clamp_false;
// #output0: graph_4/graph_3/invert (o797957961370)
vec4 o797957961370_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o797974738587_0_1_f), 1.0).rgb, vec4(vec3(o797974738587_0_1_f), 1.0).a);
// #output2: graph_4/decompose_2 (o796951328391)
float o796951328391_2_2_f = o955949004995_1_1_rgba.b;
// #code: graph_4/blend2_17 (o913905301269)
vec4 o913905301269_0_b = vec4(vec3(o796951328391_2_2_f), 1.0);
vec4 o913905301269_0_l;
float o913905301269_0_a;
o913905301269_0_l = o797957961370_0_1_rgba;
o913905301269_0_a = p_o913905301269_amount1*o798025070238_0_1_f;
o913905301269_0_b = vec4(blend_normal(uv, o913905301269_0_l.rgb, o913905301269_0_b.rgb, o913905301269_0_a*o913905301269_0_l.a), min(1.0, o913905301269_0_b.a+o913905301269_0_a*o913905301269_0_l.a));
o913905301269_0_l = o799031703217_0_1_rgba;
o913905301269_0_a = p_o913905301269_amount2*o799065257651_0_1_f;
o913905301269_0_b = vec4(blend_normal(uv, o913905301269_0_l.rgb, o913905301269_0_b.rgb, o913905301269_0_a*o913905301269_0_l.a), min(1.0, o913905301269_0_b.a+o913905301269_0_a*o913905301269_0_l.a));
o913905301269_0_l = vec4(vec3(o914005964572_0_2_f), 1.0);
o913905301269_0_a = p_o913905301269_amount3*o914005964572_2_1_f;
o913905301269_0_b = vec4(blend_normal(uv, o913905301269_0_l.rgb, o913905301269_0_b.rgb, o913905301269_0_a*o913905301269_0_l.a), min(1.0, o913905301269_0_b.a+o913905301269_0_a*o913905301269_0_l.a));
// #output0: graph_4/blend2_17 (o913905301269)
vec4 o913905301269_0_1_rgba = o913905301269_0_b;
return (dot((o913905301269_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o799300138689_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y))-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_0_map = ((o958784354508_0_1_rgba).rgb);
float o958801131723_0_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_1_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_0_rnd, custom_uv_transform(o958801131723_0_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_0_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_1_rgba = o958801131723_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_1_rgba = o959002458328_0_1_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_1_f = o958985681111_0_1_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_1_rgba = vec4(vec3(o798125733540_0_1_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_1_rgba = o800222885583_0_1_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_1_rgba = o800189331149_0_1_rgba;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_2_map = ((o958784354508_0_3_rgba).rgb);
float o958801131723_2_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_3_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_2_rnd, custom_uv_transform(o958801131723_2_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_2_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_3_rgba = o958801131723_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_3_rgba = o959002458328_0_3_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_3_f = o958985681111_0_3_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_3_rgba = vec4(vec3(o798125733540_0_3_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_3_rgba = o800222885583_0_3_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_clamp_false = max((dot((o800189331149_0_3_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_0_clamp_true = clamp(o800306771668_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_1_f = o800306771668_0_clamp_false;
// #output0: graph_4/graph_3/graph_2/translate_2 (o800273217234)
vec4 o800273217234_0_1_rgba = vec4(vec3(o800306771668_0_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_4_map = ((o958784354508_0_5_rgba).rgb);
float o958801131723_4_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_5_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_4_rnd, custom_uv_transform(o958801131723_4_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_4_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_4_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_5_rgba = o958801131723_0_5_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_5_rgba = o959002458328_0_5_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_5_f = o958985681111_0_5_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_5_rgba = vec4(vec3(o798125733540_0_5_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_5_rgba = o800222885583_0_5_rgba;
// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_3_rgba = o800189331149_0_5_rgba;
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_6_map = ((o958784354508_0_7_rgba).rgb);
float o958801131723_6_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_7_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_6_rnd, custom_uv_transform(o958801131723_6_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_6_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_6_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_7_rgba = o958801131723_0_7_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_7_rgba = o959002458328_0_7_rgba;
// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_7_f = o958985681111_0_7_rgba.r;
// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_7_rgba = vec4(vec3(o798125733540_0_7_f), 1.0);
// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_7_rgba = o800222885583_0_7_rgba;
// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_2_clamp_false = max((dot((o800189331149_0_7_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_3_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_2_clamp_true = clamp(o800306771668_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_3_f = o800306771668_2_clamp_false;
// #code: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_clamp_false = max(o800306771668_0_3_f,(dot((o800273217234_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800323548885_0_clamp_true = clamp(o800323548885_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_1_f = o800323548885_0_clamp_false;
return o800323548885_0_1_f;
}
// #instance: graph_4/graph_3/normal_map2_3/edge_detect_1 (o799300138689)
vec3 nm_o799300138689(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o799300138689_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o799300138689_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o799300138689_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o799300138689_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o799300138689_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o799300138689_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o799300138689_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o799300138689_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o799300138689_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o799300138689_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o799300138689_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o799300138689_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o799300138689_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o799300138689_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o799300138689_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o799300138689_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o799300138689_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o799300138689_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o799300138689_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o799300138689_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o799300138689_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o799300138689_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o799300138689_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o798259951276_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(uv, vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_0_map = ((o958784354508_0_1_rgba).rgb);
float o958801131723_0_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_1_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_0_rnd, custom_uv_transform(o958801131723_0_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_0_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_1_rgba = o958801131723_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_1_rgba = o959002458328_0_1_rgba;
// #output3: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_3_1_f = o958985681111_0_1_rgba.a;
// #output0: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_0_1_rgba = vec4(vec3(o798125733540_3_1_f), 1.0);
return (dot((o798108956323_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_4/graph_3/normal_map2_2/edge_detect_1 (o798259951276)
vec3 nm_o798259951276(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o798259951276_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o798259951276_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o798259951276_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o798259951276_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o798259951276_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o798259951276_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o798259951276_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o798259951276_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o798259951276_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o798259951276_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o798259951276_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o798259951276_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o798259951276_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o798259951276_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o798259951276_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o798259951276_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o798259951276_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o798259951276_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o798259951276_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o798259951276_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o798259951276_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o798259951276_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o798259951276_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o797186209429_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_0_map = ((o958784354508_0_1_rgba).rgb);
float o958801131723_0_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_1_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_0_rnd, custom_uv_transform(o958801131723_0_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_0_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_0_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_1_rgba = o958801131723_0_1_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_1_rgba = o959002458328_0_1_rgba;
// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_1_f = o958985681111_0_1_rgba.b;
// #output0: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_0_1_rgba = vec4(vec3(o798125733540_2_1_f), 1.0);
// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_2_map = ((o958784354508_0_3_rgba).rgb);
float o958801131723_2_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_3_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_2_rnd, custom_uv_transform(o958801131723_2_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_2_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_2_rnd : 0.0);
// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_3_rgba = o958801131723_0_3_rgba;
// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_3_rgba = o959002458328_0_3_rgba;
// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_3_f = o958985681111_0_3_rgba.b;
// #output0: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_0_1_rgba = vec4(vec3(o798125733540_2_3_f), 1.0);
// #code: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_b = o797051991693_0_1_rgba;
vec4 o797085546127_0_l;
float o797085546127_0_a;
o797085546127_0_l = o797068768910_0_1_rgba;
o797085546127_0_a = p_o797085546127_amount1*1.0;
o797085546127_0_b = vec4(blend_lighten(uv, o797085546127_0_l.rgb, o797085546127_0_b.rgb, o797085546127_0_a*o797085546127_0_l.a), min(1.0, o797085546127_0_b.a+o797085546127_0_a*o797085546127_0_l.a));
// #output0: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_1_rgba = o797085546127_0_b;
return (dot((o797085546127_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: graph_4/graph_3/normal_map2/edge_detect_1 (o797186209429)
vec3 nm_o797186209429(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (3 == 0) {
		rv = vec2(1.0, -1.0)*o797186209429_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o797186209429_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o797186209429_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o797186209429_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o797186209429_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o797186209429_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o797186209429_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o797186209429_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (3 == 1) {
		rv = vec2(3.0, -3.0)*o797186209429_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o797186209429_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o797186209429_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o797186209429_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o797186209429_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o797186209429_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o797186209429_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o797186209429_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (3 == 2) {
		rv = vec2(2.0, 0.0)*o797186209429_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o797186209429_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o797186209429_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o797186209429_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o797186209429_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o797186209429_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o797186209429_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
vec4 o955831564476_input_in(vec2 uv, float _seed_variation_) {
vec4 o955680569523_0 = textureLod(texture_1, fract(uv), 0.0);
return o955680569523_0;
}
vec4 o958868240592_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_4/translate_4 (o955848341693)
vec4 o955848341693_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955848341693_translate_x, p_o955848341693_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_4/custom_uv_7 (o955865118910)
vec3 o955865118910_0_map = ((o955848341693_0_1_rgba).rgb);
float o955865118910_0_rnd =  float((seed_o955865118910+fract(_seed_variation_)))+o955865118910_0_map.z;
// #output0: graph_4/graph_4/custom_uv_7 (o955865118910)
vec4 o955865118910_0_1_rgba = o955865118910_input_in(get_from_tileset(2.0, o955865118910_0_rnd, custom_uv_transform(o955865118910_0_map.xy, vec2(p_o955865118910_sx, p_o955865118910_sy), p_o955865118910_rotate*0.01745329251, p_o955865118910_scale, vec2(o955865118910_0_map.z, float((seed_o955865118910+fract(_seed_variation_)))))), false ? o955865118910_0_rnd : 0.0);
// #output3: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_3_1_rgba = o955865118910_0_1_rgba;
// #output3: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_3_1_rgba = o955965782212_3_1_rgba;
return o955949004995_3_1_rgba;
}
vec4 o804652070665_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o961854585049)
vec4 o961854585049_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o961955248359_translate_x*(2.0*1.0-1.0), p_o961955248359_translate_y*(2.0*1.0-1.0)), p_o961955248359_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o961955248359_scale_x*(2.0*1.0-1.0), p_o961955248359_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o961972025576_cx, 0.5+p_o961972025576_cy), vec2(p_o961972025576_scale_x, p_o961972025576_scale_y)))-vec2(p_o961854585049_translate_x, p_o961854585049_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o961871362274)
vec3 o961871362274_0_map = ((o961854585049_0_1_rgba).rgb);
float o961871362274_0_rnd =  float((seed_o961871362274+fract(_seed_variation_)))+o961871362274_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o961871362274)
vec4 o961871362274_0_1_rgba = o961871362274_input_in(get_from_tileset(2.0, o961871362274_0_rnd, custom_uv_transform(o961871362274_0_map.xy, vec2(p_o961871362274_sx, p_o961871362274_sy), p_o961871362274_rotate*0.01745329251, p_o961871362274_scale, vec2(o961871362274_0_map.z, float((seed_o961871362274+fract(_seed_variation_)))))), false ? o961871362274_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o961972025576)
vec4 o961972025576_3_1_rgba = o961871362274_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o961955248359)
vec4 o961955248359_3_1_rgba = o961972025576_3_1_rgba;
return o961955248359_3_1_rgba;
}
vec4 o804618516231_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o961854585049)
vec4 o961854585049_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o961955248359_translate_x*(2.0*1.0-1.0), p_o961955248359_translate_y*(2.0*1.0-1.0)), p_o961955248359_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o961955248359_scale_x*(2.0*1.0-1.0), p_o961955248359_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o961972025576_cx, 0.5+p_o961972025576_cy), vec2(p_o961972025576_scale_x, p_o961972025576_scale_y)))-vec2(p_o961854585049_translate_x, p_o961854585049_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o961871362274)
vec3 o961871362274_0_map = ((o961854585049_0_1_rgba).rgb);
float o961871362274_0_rnd =  float((seed_o961871362274+fract(_seed_variation_)))+o961871362274_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o961871362274)
vec4 o961871362274_0_1_rgba = o961871362274_input_in(get_from_tileset(2.0, o961871362274_0_rnd, custom_uv_transform(o961871362274_0_map.xy, vec2(p_o961871362274_sx, p_o961871362274_sy), p_o961871362274_rotate*0.01745329251, p_o961871362274_scale, vec2(o961871362274_0_map.z, float((seed_o961871362274+fract(_seed_variation_)))))), false ? o961871362274_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o961972025576)
vec4 o961972025576_3_1_rgba = o961871362274_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o961955248359)
vec4 o961955248359_3_1_rgba = o961972025576_3_1_rgba;
return o961955248359_3_1_rgba;
}
vec4 o804584961797_input_in(vec2 uv, float _seed_variation_) {
// #output0: graph_4/graph_6/translate_4 (o961854585049)
vec4 o961854585049_0_1_rgba = vec4(((scale((fract(transform2(uv, vec2(p_o961955248359_translate_x*(2.0*1.0-1.0), p_o961955248359_translate_y*(2.0*1.0-1.0)), p_o961955248359_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o961955248359_scale_x*(2.0*1.0-1.0), p_o961955248359_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o961972025576_cx, 0.5+p_o961972025576_cy), vec2(p_o961972025576_scale_x, p_o961972025576_scale_y)))-vec2(p_o961854585049_translate_x, p_o961854585049_translate_y)), 0.0, 1.0);
// #code: graph_4/graph_6/custom_uv_7 (o961871362274)
vec3 o961871362274_0_map = ((o961854585049_0_1_rgba).rgb);
float o961871362274_0_rnd =  float((seed_o961871362274+fract(_seed_variation_)))+o961871362274_0_map.z;
// #output0: graph_4/graph_6/custom_uv_7 (o961871362274)
vec4 o961871362274_0_1_rgba = o961871362274_input_in(get_from_tileset(2.0, o961871362274_0_rnd, custom_uv_transform(o961871362274_0_map.xy, vec2(p_o961871362274_sx, p_o961871362274_sy), p_o961871362274_rotate*0.01745329251, p_o961871362274_scale, vec2(o961871362274_0_map.z, float((seed_o961871362274+fract(_seed_variation_)))))), false ? o961871362274_0_rnd : 0.0);
// #output3: graph_4/graph_6/scale (o961972025576)
vec4 o961972025576_3_1_rgba = o961871362274_0_1_rgba;
// #output3: graph_4/graph_6/transform2_2 (o961955248359)
vec4 o961955248359_3_1_rgba = o961972025576_3_1_rgba;
return o961955248359_3_1_rgba;
}
vec4 o955764455608_input_in(vec2 uv, float _seed_variation_) {
vec4 o955680569523_0 = textureLod(texture_1, fract(uv), 0.0);
return o955680569523_0;
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o742307935352_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o742307935352_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o742307935352_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o742307935352_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_1_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o801648948962_translate_x, p_o801648948962_translate_y))-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_1_rgba = vec4(vec3(o801514731226_0_1_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_1_rgba = o800189331149_4_1_rgba;

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_3_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o801648948962_translate_x, p_o801648948962_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_3_rgba = vec4(vec3(o801514731226_0_3_f), 1.0);

// #code: graph_4/graph_3/graph_3/math_2 (o801632171745)
float o801632171745_0_clamp_false = max((dot((o800189331149_4_3_rgba).rgb, vec3(1.0))/3.0),(dot((o801598617311_0_1_rgba).rgb, vec3(1.0))/3.0));
float o801632171745_0_clamp_true = clamp(o801632171745_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_3/math_2 (o801632171745)
float o801632171745_0_1_f = o801632171745_0_clamp_false;

// #output0: graph_4/graph_3/graph_3/translate_5 (o801648948962)
vec4 o801648948962_0_1_rgba = vec4(vec3(o801632171745_0_1_f), 1.0);

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_5_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y))-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_5_rgba = vec4(vec3(o801514731226_0_5_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_3_rgba = o800189331149_4_5_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y))-vec2(p_o801615394528_translate_x, p_o801615394528_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_0_map = ((o804668847882_0_1_rgba).rgb);
float o804685625099_0_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_1_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_0_rnd, custom_uv_transform(o804685625099_0_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_0_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_0_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_1_rgba = o804685625099_0_1_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_1_rgba = o804786288401_3_1_rgba;

// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_7_rgba = o804769511184_3_1_rgba;

// #output0: graph_4/graph_3/graph_3/translate_3 (o801615394528)
vec4 o801615394528_0_1_rgba = o800189331149_2_7_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_2_map = ((o804668847882_0_3_rgba).rgb);
float o804685625099_2_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_3_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_2_rnd, custom_uv_transform(o804685625099_2_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_2_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_2_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_3_rgba = o804685625099_0_3_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_3_rgba = o804786288401_3_3_rgba;

// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_9_rgba = o804769511184_3_3_rgba;

// #code: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_b = o800189331149_2_9_rgba;
vec4 o801665726179_0_l;
float o801665726179_0_a;

o801665726179_0_l = o801615394528_0_1_rgba;
o801665726179_0_a = p_o801665726179_amount1*(dot((o801598617311_0_3_rgba).rgb, vec3(1.0))/3.0);
o801665726179_0_b = vec4(blend_normal(((uv)-vec2(p_o801682503396_translate_x, p_o801682503396_translate_y)), o801665726179_0_l.rgb, o801665726179_0_b.rgb, o801665726179_0_a*o801665726179_0_l.a), min(1.0, o801665726179_0_b.a+o801665726179_0_a*o801665726179_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_1_rgba = o801665726179_0_b;

// #output0: graph_4/graph_3/graph_3/translate_4 (o801682503396)
vec4 o801682503396_0_1_rgba = o801665726179_0_1_rgba;

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_7_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o801598617311_translate_x, p_o801598617311_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_11_rgba = vec4(vec3(o801514731226_0_7_f), 1.0);

// #output0: graph_4/graph_3/graph_3/translate_2 (o801598617311)
vec4 o801598617311_0_5_rgba = o800189331149_4_11_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o801615394528_translate_x, p_o801615394528_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_4_map = ((o804668847882_0_5_rgba).rgb);
float o804685625099_4_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_5_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_4_rnd, custom_uv_transform(o804685625099_4_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_4_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_4_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_5_rgba = o804685625099_0_5_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_5_rgba = o804786288401_3_5_rgba;

// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_13_rgba = o804769511184_3_5_rgba;

// #output0: graph_4/graph_3/graph_3/translate_3 (o801615394528)
vec4 o801615394528_0_3_rgba = o800189331149_2_13_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_6_map = ((o804668847882_0_7_rgba).rgb);
float o804685625099_6_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_7_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_6_rnd, custom_uv_transform(o804685625099_6_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_6_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_6_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_7_rgba = o804685625099_0_7_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_7_rgba = o804786288401_3_7_rgba;

// #output2: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_2_15_rgba = o804769511184_3_7_rgba;

// #code: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_2_b = o800189331149_2_15_rgba;
vec4 o801665726179_2_l;
float o801665726179_2_a;

o801665726179_2_l = o801615394528_0_3_rgba;
o801665726179_2_a = p_o801665726179_amount1*(dot((o801598617311_0_5_rgba).rgb, vec3(1.0))/3.0);
o801665726179_2_b = vec4(blend_normal((uv), o801665726179_2_l.rgb, o801665726179_2_b.rgb, o801665726179_2_a*o801665726179_2_l.a), min(1.0, o801665726179_2_b.a+o801665726179_2_a*o801665726179_2_l.a));
// #output0: graph_4/graph_3/graph_3/blend2 (o801665726179)
vec4 o801665726179_0_3_rgba = o801665726179_2_b;

// #code: graph_4/graph_3/graph_3/blend2_2 (o801699280613)
vec4 o801699280613_0_b = o801665726179_0_3_rgba;
vec4 o801699280613_0_l;
float o801699280613_0_a;

o801699280613_0_l = o801682503396_0_1_rgba;
o801699280613_0_a = p_o801699280613_amount1*(dot((o801648948962_0_1_rgba).rgb, vec3(1.0))/3.0);
o801699280613_0_b = vec4(blend_normal((uv), o801699280613_0_l.rgb, o801699280613_0_b.rgb, o801699280613_0_a*o801699280613_0_l.a), min(1.0, o801699280613_0_b.a+o801699280613_0_a*o801699280613_0_l.a));
// #output0: graph_4/graph_3/graph_3/blend2_2 (o801699280613)
vec4 o801699280613_0_1_rgba = o801699280613_0_b;

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y))-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_0_map = ((o958784354508_0_1_rgba).rgb);
float o958801131723_0_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_0_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_1_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_0_rnd, custom_uv_transform(o958801131723_0_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_0_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_0_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_1_rgba = o958801131723_0_1_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_1_rgba = o959002458328_0_1_rgba;

// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_1_f = o958985681111_0_1_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_1_rgba = vec4(vec3(o798125733540_0_1_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_17_rgba = o800222885583_0_1_rgba;

// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_1_rgba = o800189331149_0_17_rgba;

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800273217234_translate_x, p_o800273217234_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_2_map = ((o958784354508_0_3_rgba).rgb);
float o958801131723_2_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_2_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_3_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_2_rnd, custom_uv_transform(o958801131723_2_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_2_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_2_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_3_rgba = o958801131723_0_3_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_3_rgba = o959002458328_0_3_rgba;

// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_3_f = o958985681111_0_3_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_3_rgba = vec4(vec3(o798125733540_0_3_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_19_rgba = o800222885583_0_3_rgba;

// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_clamp_false = max((dot((o800189331149_0_19_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_0_clamp_true = clamp(o800306771668_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_1_f = o800306771668_0_clamp_false;

// #output0: graph_4/graph_3/graph_2/translate_2 (o800273217234)
vec4 o800273217234_0_1_rgba = vec4(vec3(o800306771668_0_1_f), 1.0);

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o800289994451_translate_x, p_o800289994451_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_4_map = ((o958784354508_0_5_rgba).rgb);
float o958801131723_4_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_4_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_5_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_4_rnd, custom_uv_transform(o958801131723_4_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_4_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_4_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_5_rgba = o958801131723_0_5_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_5_rgba = o959002458328_0_5_rgba;

// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_5_f = o958985681111_0_5_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_5_rgba = vec4(vec3(o798125733540_0_5_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_21_rgba = o800222885583_0_5_rgba;

// #output0: graph_4/graph_3/graph_2/translate (o800289994451)
vec4 o800289994451_0_3_rgba = o800189331149_0_21_rgba;

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o800222885583_translate_x*(2.0*1.0-1.0), p_o800222885583_translate_y*(2.0*1.0-1.0)), p_o800222885583_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o800222885583_scale_x*(2.0*1.0-1.0), p_o800222885583_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_6_map = ((o958784354508_0_7_rgba).rgb);
float o958801131723_6_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_6_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_7_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_6_rnd, custom_uv_transform(o958801131723_6_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_6_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_6_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_7_rgba = o958801131723_0_7_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_7_rgba = o959002458328_0_7_rgba;

// #output0: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_0_7_f = o958985681111_0_7_rgba.r;

// #output0: graph_4/graph_3/transform2_5 (o800222885583)
vec4 o800222885583_0_7_rgba = vec4(vec3(o798125733540_0_7_f), 1.0);

// #output0: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_0_22_rgba = o800222885583_0_7_rgba;

// #code: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_2_clamp_false = max((dot((o800189331149_0_22_rgba).rgb, vec3(1.0))/3.0),(dot((o800289994451_0_3_rgba).rgb, vec3(1.0))/3.0));
float o800306771668_2_clamp_true = clamp(o800306771668_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_11 (o800306771668)
float o800306771668_0_3_f = o800306771668_2_clamp_false;

// #code: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_clamp_false = max(o800306771668_0_3_f,(dot((o800273217234_0_1_rgba).rgb, vec3(1.0))/3.0));
float o800323548885_0_clamp_true = clamp(o800323548885_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_2/math_12 (o800323548885)
float o800323548885_0_1_f = o800323548885_0_clamp_false;

// #code: graph_4/graph_3/tones_step_3 (o800138999498)
vec3 o800138999498_0_false = clamp((vec4(vec3(o800323548885_0_1_f), 1.0).rgb-vec3(p_o800138999498_value))/max(0.0001, p_o800138999498_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o800138999498_0_true = vec3(1.0)-o800138999498_0_false;
// #output0: graph_4/graph_3/tones_step_3 (o800138999498)
vec4 o800138999498_0_1_rgba = vec4(o800138999498_0_false, vec4(vec3(o800323548885_0_1_f), 1.0).a);

// #output0: graph_4/graph_4/translate_2 (o955781232825)
vec4 o955781232825_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955781232825_translate_x, p_o955781232825_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_5 (o955798010042)
vec3 o955798010042_0_map = ((o955781232825_0_1_rgba).rgb);
float o955798010042_0_rnd =  float((seed_o955798010042+fract(_seed_variation_)))+o955798010042_0_map.z;
// #output0: graph_4/graph_4/custom_uv_5 (o955798010042)
vec4 o955798010042_0_1_rgba = o955798010042_input_in(get_from_tileset(2.0, o955798010042_0_rnd, custom_uv_transform(o955798010042_0_map.xy, vec2(p_o955798010042_sx, p_o955798010042_sy), p_o955798010042_rotate*0.01745329251, p_o955798010042_scale, vec2(o955798010042_0_map.z, float((seed_o955798010042+fract(_seed_variation_)))))), false ? o955798010042_0_rnd : 0.0);

// #output1: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_1_1_rgba = o955798010042_0_1_rgba;

// #output1: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_1_1_rgba = o955965782212_1_1_rgba;

// #output3: graph_4/decompose_2 (o796951328391)
float o796951328391_3_1_f = o955949004995_1_1_rgba.a;

// #code: graph_4/graph_3/math_9 (o800172553932)
float o800172553932_0_clamp_false = o796951328391_3_1_f*(dot((o800138999498_0_1_rgba).rgb, vec3(1.0))/3.0);
float o800172553932_0_clamp_true = clamp(o800172553932_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_9 (o800172553932)
float o800172553932_0_1_f = o800172553932_0_clamp_false;

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_1_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((((uv)-vec2(p_o803209230069_translate_x, p_o803209230069_translate_y))-vec2(p_o803226007286_translate_x, p_o803226007286_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_0_map = ((o958817908933_0_1_rgba).rgb);
float o958834686158_0_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_0_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_1_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_0_rnd, custom_uv_transform(o958834686158_0_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_0_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_0_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_9_rgba = o958834686158_0_1_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_9_rgba = o959002458328_1_9_rgba;

// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_1_f = o958985681111_1_9_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_24_rgba = vec4(vec3(o803175675635_2_1_f), 1.0);

// #output0: graph_4/graph_3/graph_5/translate (o803226007286)
vec4 o803226007286_0_1_rgba = o800189331149_1_24_rgba;

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_3_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o803209230069_translate_x, p_o803209230069_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_2_map = ((o958817908933_0_3_rgba).rgb);
float o958834686158_2_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_2_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_3_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_2_rnd, custom_uv_transform(o958834686158_2_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_2_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_2_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_11_rgba = o958834686158_0_3_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_11_rgba = o959002458328_1_11_rgba;

// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_3_f = o958985681111_1_11_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_26_rgba = vec4(vec3(o803175675635_2_3_f), 1.0);

// #code: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_clamp_false = max((dot((o800189331149_1_26_rgba).rgb, vec3(1.0))/3.0),(dot((o803226007286_0_1_rgba).rgb, vec3(1.0))/3.0));
float o803242784503_0_clamp_true = clamp(o803242784503_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_1_f = o803242784503_0_clamp_false;

// #output0: graph_4/graph_3/graph_5/translate_2 (o803209230069)
vec4 o803209230069_0_1_rgba = vec4(vec3(o803242784503_0_1_f), 1.0);

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_5_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2(((uv)-vec2(p_o803226007286_translate_x, p_o803226007286_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_4_map = ((o958817908933_0_5_rgba).rgb);
float o958834686158_4_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_4_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_5_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_4_rnd, custom_uv_transform(o958834686158_4_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_4_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_4_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_13_rgba = o958834686158_0_5_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_13_rgba = o959002458328_1_13_rgba;

// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_5_f = o958985681111_1_13_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_28_rgba = vec4(vec3(o803175675635_2_5_f), 1.0);

// #output0: graph_4/graph_3/graph_5/translate (o803226007286)
vec4 o803226007286_0_3_rgba = o800189331149_1_28_rgba;

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_7_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_6_map = ((o958817908933_0_7_rgba).rgb);
float o958834686158_6_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_6_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_7_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_6_rnd, custom_uv_transform(o958834686158_6_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_6_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_6_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_15_rgba = o958834686158_0_7_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_15_rgba = o959002458328_1_15_rgba;

// #output2: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_2_7_f = o958985681111_1_15_rgba.b;

// #output1: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_1_29_rgba = vec4(vec3(o803175675635_2_7_f), 1.0);

// #code: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_2_clamp_false = max((dot((o800189331149_1_29_rgba).rgb, vec3(1.0))/3.0),(dot((o803226007286_0_3_rgba).rgb, vec3(1.0))/3.0));
float o803242784503_2_clamp_true = clamp(o803242784503_2_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_11 (o803242784503)
float o803242784503_0_3_f = o803242784503_2_clamp_false;

// #code: graph_4/graph_3/graph_5/math_12 (o803259561720)
float o803259561720_0_clamp_false = max(o803242784503_0_3_f,(dot((o803209230069_0_1_rgba).rgb, vec3(1.0))/3.0));
float o803259561720_0_clamp_true = clamp(o803259561720_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_5/math_12 (o803259561720)
float o803259561720_0_1_f = o803259561720_0_clamp_false;

// #code: graph_4/graph_3/math_8 (o800122222281)
float o800122222281_0_clamp_false = o803259561720_0_1_f*o796951328391_3_1_f;
float o800122222281_0_clamp_true = clamp(o800122222281_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_8 (o800122222281)
float o800122222281_0_1_f = o800122222281_0_clamp_false;

// #output0: graph_4/graph_3/invert_3 (o800071890630)
vec4 o800071890630_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o800323548885_0_1_f), 1.0).rgb, vec4(vec3(o800323548885_0_1_f), 1.0).a);

// #output0: graph_4/graph_3/combine (o800206108366)
vec4 o800206108366_0_1_rgba = vec4((dot((o800071890630_0_1_rgba).rgb, vec3(1.0))/3.0), o800122222281_0_1_f, o800172553932_0_1_f, (dot((o801699280613_0_1_rgba).rgb, vec3(1.0))/3.0));

// #output2: graph_4/decompose (o914005964572)
float o914005964572_2_1_f = o800206108366_0_1_rgba.b;

// #output0: graph_4/graph_3/normal_map2_3/edge_detect_1 (o799300138689)
vec3 o799300138689_0_1_rgb = nm_o799300138689((uv), p_o799300138689_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_8_map = ((o958784354508_0_9_rgba).rgb);
float o958801131723_8_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_8_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_9_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_8_rnd, custom_uv_transform(o958801131723_8_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_8_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_8_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_17_rgba = o958801131723_0_9_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_17_rgba = o959002458328_0_17_rgba;

// #output3: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_3_9_f = o958985681111_0_17_rgba.a;

// #output0: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_0_1_rgba = vec4(vec3(o798125733540_3_9_f), 1.0);

// #code: graph_4/graph_3/tones_step_2 (o799048480434)
vec3 o799048480434_0_false = clamp((o798108956323_0_1_rgba.rgb-vec3(p_o799048480434_value))/max(0.0001, p_o799048480434_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o799048480434_0_true = vec3(1.0)-o799048480434_0_false;
// #output0: graph_4/graph_3/tones_step_2 (o799048480434)
vec4 o799048480434_0_1_rgba = vec4(o799048480434_0_false, o798108956323_0_1_rgba.a);

// #code: graph_4/graph_3/math_6 (o799065257651)
float o799065257651_0_clamp_false = o796951328391_3_1_f*(dot((o799048480434_0_1_rgba).rgb, vec3(1.0))/3.0);
float o799065257651_0_clamp_true = clamp(o799065257651_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_6 (o799065257651)
float o799065257651_0_1_f = o799065257651_0_clamp_false;

// #output0: graph_4/graph_3/normal_map2_2/edge_detect_1 (o798259951276)
vec3 o798259951276_0_1_rgb = nm_o798259951276((uv), p_o798259951276_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_10_map = ((o958784354508_0_11_rgba).rgb);
float o958801131723_10_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_10_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_11_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_10_rnd, custom_uv_transform(o958801131723_10_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_10_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_10_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_19_rgba = o958801131723_0_11_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_19_rgba = o959002458328_0_19_rgba;

// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_11_f = o958985681111_0_19_rgba.b;

// #output0: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_0_1_rgba = vec4(vec3(o798125733540_2_11_f), 1.0);

// #output0: graph_4/graph_5/translate (o958784354508)
vec4 o958784354508_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958784354508_translate_x, p_o958784354508_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_4 (o958801131723)
vec3 o958801131723_12_map = ((o958784354508_0_13_rgba).rgb);
float o958801131723_12_rnd =  float((seed_o958801131723+fract(_seed_variation_)))+o958801131723_12_map.z;
// #output0: graph_4/graph_5/custom_uv_4 (o958801131723)
vec4 o958801131723_0_13_rgba = o958801131723_input_in(get_from_tileset(2.0, o958801131723_12_rnd, custom_uv_transform(o958801131723_12_map.xy, vec2(p_o958801131723_sx, p_o958801131723_sy), p_o958801131723_rotate*0.01745329251, p_o958801131723_scale, vec2(o958801131723_12_map.z, float((seed_o958801131723+fract(_seed_variation_)))))), false ? o958801131723_12_rnd : 0.0);

// #output0: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_0_21_rgba = o958801131723_0_13_rgba;

// #output0: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_0_21_rgba = o959002458328_0_21_rgba;

// #output2: graph_4/graph_3/decompose_2 (o798125733540)
float o798125733540_2_13_f = o958985681111_0_21_rgba.b;

// #output0: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_0_1_rgba = vec4(vec3(o798125733540_2_13_f), 1.0);

// #code: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_b = o797051991693_0_1_rgba;
vec4 o797085546127_0_l;
float o797085546127_0_a;

o797085546127_0_l = o797068768910_0_1_rgba;
o797085546127_0_a = p_o797085546127_amount1*1.0;
o797085546127_0_b = vec4(blend_lighten((uv), o797085546127_0_l.rgb, o797085546127_0_b.rgb, o797085546127_0_a*o797085546127_0_l.a), min(1.0, o797085546127_0_b.a+o797085546127_0_a*o797085546127_0_l.a));
// #output0: graph_4/graph_3/blend2 (o797085546127)
vec4 o797085546127_0_1_rgba = o797085546127_0_b;

// #code: graph_4/graph_3/tones_step (o798008293021)
vec3 o798008293021_0_false = clamp((o797085546127_0_1_rgba.rgb-vec3(p_o798008293021_value))/max(0.0001, p_o798008293021_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o798008293021_0_true = vec3(1.0)-o798008293021_0_false;
// #output0: graph_4/graph_3/tones_step (o798008293021)
vec4 o798008293021_0_1_rgba = vec4(o798008293021_0_false, o797085546127_0_1_rgba.a);

// #code: graph_4/graph_3/math_2 (o798025070238)
float o798025070238_0_clamp_false = (dot((o798008293021_0_1_rgba).rgb, vec3(1.0))/3.0)*o796951328391_3_1_f;
float o798025070238_0_clamp_true = clamp(o798025070238_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_2 (o798025070238)
float o798025070238_0_1_f = o798025070238_0_clamp_false;

// #output0: graph_4/graph_3/normal_map2/edge_detect_1 (o797186209429)
vec3 o797186209429_0_1_rgb = nm_o797186209429((uv), p_o797186209429_amount, 1024.0, _seed_variation_);

// #output0: graph_4/graph_4/translate_3 (o955814787259)
vec4 o955814787259_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955814787259_translate_x, p_o955814787259_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_6 (o955831564476)
vec3 o955831564476_0_map = ((o955814787259_0_1_rgba).rgb);
float o955831564476_0_rnd =  float((seed_o955831564476+fract(_seed_variation_)))+o955831564476_0_map.z;
// #output0: graph_4/graph_4/custom_uv_6 (o955831564476)
vec4 o955831564476_0_1_rgba = o955831564476_input_in(get_from_tileset(2.0, o955831564476_0_rnd, custom_uv_transform(o955831564476_0_map.xy, vec2(p_o955831564476_sx, p_o955831564476_sy), p_o955831564476_rotate*0.01745329251, p_o955831564476_scale, vec2(o955831564476_0_map.z, float((seed_o955831564476+fract(_seed_variation_)))))), false ? o955831564476_0_rnd : 0.0);

// #output2: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_2_2_rgba = o955831564476_0_1_rgba;

// #output2: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_2_2_rgba = o955965782212_2_2_rgba;

// #code: graph_4/blend2_16 (o913888524062)
vec4 o913888524062_0_b = o955949004995_2_2_rgba;
vec4 o913888524062_0_l;
float o913888524062_0_a;

o913888524062_0_l = vec4(o797186209429_0_1_rgb, 1.0);
o913888524062_0_a = p_o913888524062_amount1*o798025070238_0_1_f;
o913888524062_0_b = vec4(blend_normal((uv), o913888524062_0_l.rgb, o913888524062_0_b.rgb, o913888524062_0_a*o913888524062_0_l.a), min(1.0, o913888524062_0_b.a+o913888524062_0_a*o913888524062_0_l.a));

o913888524062_0_l = vec4(o798259951276_0_1_rgb, 1.0);
o913888524062_0_a = p_o913888524062_amount2*o799065257651_0_1_f;
o913888524062_0_b = vec4(blend_normal((uv), o913888524062_0_l.rgb, o913888524062_0_b.rgb, o913888524062_0_a*o913888524062_0_l.a), min(1.0, o913888524062_0_b.a+o913888524062_0_a*o913888524062_0_l.a));

o913888524062_0_l = vec4(o799300138689_0_1_rgb, 1.0);
o913888524062_0_a = p_o913888524062_amount3*o914005964572_2_1_f;
o913888524062_0_b = vec4(blend_normal((uv), o913888524062_0_l.rgb, o913888524062_0_b.rgb, o913888524062_0_a*o913888524062_0_l.a), min(1.0, o913888524062_0_b.a+o913888524062_0_a*o913888524062_0_l.a));
// #output0: graph_4/blend2_16 (o913888524062)
vec4 o913888524062_0_1_rgba = o913888524062_0_b;

// #output3: graph_4/decompose (o914005964572)
float o914005964572_3_2_f = o800206108366_0_1_rgba.a;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_9_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_8_map = ((o804668847882_0_9_rgba).rgb);
float o804685625099_8_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_8_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_9_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_8_rnd, custom_uv_transform(o804685625099_8_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_8_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_8_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_9_rgba = o804685625099_0_9_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_9_rgba = o804786288401_3_9_rgba;

// #output2: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_2_2_rgba = o804769511184_3_9_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_11_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_10_map = ((o804668847882_0_11_rgba).rgb);
float o804685625099_10_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_10_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_11_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_10_rnd, custom_uv_transform(o804685625099_10_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_10_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_10_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_11_rgba = o804685625099_0_11_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_11_rgba = o804786288401_3_11_rgba;

// #output2: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_2_2_rgba = o804769511184_3_11_rgba;

// #output0: graph_4/graph_3/graph_6/translate_4 (o804668847882)
vec4 o804668847882_0_13_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804668847882_translate_x, p_o804668847882_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec3 o804685625099_12_map = ((o804668847882_0_13_rgba).rgb);
float o804685625099_12_rnd =  float((seed_o804685625099+fract(_seed_variation_)))+o804685625099_12_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_7 (o804685625099)
vec4 o804685625099_0_13_rgba = o804685625099_input_in(get_from_tileset(2.0, o804685625099_12_rnd, custom_uv_transform(o804685625099_12_map.xy, vec2(p_o804685625099_sx, p_o804685625099_sy), p_o804685625099_rotate*0.01745329251, p_o804685625099_scale, vec2(o804685625099_12_map.z, float((seed_o804685625099+fract(_seed_variation_)))))), false ? o804685625099_12_rnd : 0.0);

// #output3: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_3_13_rgba = o804685625099_0_13_rgba;

// #output3: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_3_13_rgba = o804786288401_3_13_rgba;

// #output2: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_2_2_rgba = o804769511184_3_13_rgba;

// #code: graph_4/graph_3/blend2_3 (o798058624672)
vec4 o798058624672_0_b = o797051991693_0_1_rgba;
vec4 o798058624672_0_l;
float o798058624672_0_a;

o798058624672_0_l = o797051991693_2_2_rgba;
o798058624672_0_a = p_o798058624672_amount1*1.0;
o798058624672_0_b = vec4(blend_multiply((uv), o798058624672_0_l.rgb, o798058624672_0_b.rgb, o798058624672_0_a*o798058624672_0_l.a), min(1.0, o798058624672_0_b.a+o798058624672_0_a*o798058624672_0_l.a));

o798058624672_0_l = o797068768910_2_2_rgba;
o798058624672_0_a = p_o798058624672_amount2*(dot((o797068768910_0_1_rgba).rgb, vec3(1.0))/3.0);
o798058624672_0_b = vec4(blend_normal((uv), o798058624672_0_l.rgb, o798058624672_0_b.rgb, o798058624672_0_a*o798058624672_0_l.a), min(1.0, o798058624672_0_b.a+o798058624672_0_a*o798058624672_0_l.a));
// #output0: graph_4/graph_3/blend2_3 (o798058624672)
vec4 o798058624672_0_1_rgba = o798058624672_0_b;

// #code: graph_4/graph_3/math_4 (o798075401889)
float o798075401889_0_clamp_false = o796951328391_3_1_f*(dot((o798058624672_0_1_rgba).rgb, vec3(1.0))/3.0);
float o798075401889_0_clamp_true = clamp(o798075401889_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_4 (o798075401889)
float o798075401889_0_1_f = o798075401889_0_clamp_false;

// #output1: graph_4/decompose_2 (o796951328391)
float o796951328391_1_2_f = o955949004995_1_1_rgba.g;

// #code: graph_4/blend2_20 (o913955632922)
vec4 o913955632922_0_b = vec4(vec3(o796951328391_1_2_f), 1.0);
vec4 o913955632922_0_l;
float o913955632922_0_a;

o913955632922_0_l = vec4(vec3(o798075401889_0_1_f), 1.0);
o913955632922_0_a = p_o913955632922_amount1*o798025070238_0_1_f;
o913955632922_0_b = vec4(blend_normal((uv), o913955632922_0_l.rgb, o913955632922_0_b.rgb, o913955632922_0_a*o913955632922_0_l.a), min(1.0, o913955632922_0_b.a+o913955632922_0_a*o913955632922_0_l.a));

o913955632922_0_l = o798108956323_2_2_rgba;
o913955632922_0_a = p_o913955632922_amount2*o799065257651_0_1_f;
o913955632922_0_b = vec4(blend_normal((uv), o913955632922_0_l.rgb, o913955632922_0_b.rgb, o913955632922_0_a*o913955632922_0_l.a), min(1.0, o913955632922_0_b.a+o913955632922_0_a*o913955632922_0_l.a));

o913955632922_0_l = vec4(vec3(o914005964572_3_2_f), 1.0);
o913955632922_0_a = p_o913955632922_amount3*o914005964572_2_1_f;
o913955632922_0_b = vec4(blend_normal((uv), o913955632922_0_l.rgb, o913955632922_0_b.rgb, o913955632922_0_a*o913955632922_0_l.a), min(1.0, o913955632922_0_b.a+o913955632922_0_a*o913955632922_0_l.a));
// #output0: graph_4/blend2_20 (o913955632922)
vec4 o913955632922_0_1_rgba = o913955632922_0_b;

// #output0: graph_4/graph_5/translate_3 (o958851463375)
vec4 o958851463375_0_1_rgba = vec4(((scale((transform2_clamp(transform2((fract(transform2((uv), vec2(p_o961720367326_translate_x*(2.0*1.0-1.0), p_o961720367326_translate_y*(2.0*1.0-1.0)), p_o961720367326_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o961720367326_scale_x*(2.0*1.0-1.0), p_o961720367326_scale_y*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958851463375_translate_x, p_o958851463375_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_6 (o958868240592)
vec3 o958868240592_0_map = ((o958851463375_0_1_rgba).rgb);
float o958868240592_0_rnd =  float((seed_o958868240592+fract(_seed_variation_)))+o958868240592_0_map.z;
// #output0: graph_4/graph_5/custom_uv_6 (o958868240592)
vec4 o958868240592_0_1_rgba = o958868240592_input_in(get_from_tileset(2.0, o958868240592_0_rnd, custom_uv_transform(o958868240592_0_map.xy, vec2(p_o958868240592_sx, p_o958868240592_sy), p_o958868240592_rotate*0.01745329251, p_o958868240592_scale, vec2(o958868240592_0_map.z, float((seed_o958868240592+fract(_seed_variation_)))))), false ? o958868240592_0_rnd : 0.0);

// #output2: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_2_23_rgba = o958868240592_0_1_rgba;

// #output2: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_2_23_rgba = o959002458328_2_23_rgba;

// #output0: graph_4/transform2 (o961720367326)
vec4 o961720367326_0_1_rgba = o958985681111_2_23_rgba;

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_9_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o802454255341_translate_x, p_o802454255341_translate_y))-vec2(p_o802403923690_translate_x, p_o802403923690_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_31_rgba = vec4(vec3(o801514731226_0_9_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o802403923690)
vec4 o802403923690_0_1_rgba = o800189331149_4_31_rgba;

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_11_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o802454255341_translate_x, p_o802454255341_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_33_rgba = vec4(vec3(o801514731226_0_11_f), 1.0);

// #code: graph_4/graph_3/graph_4/math_2 (o802437478124)
float o802437478124_0_clamp_false = max((dot((o800189331149_4_33_rgba).rgb, vec3(1.0))/3.0),(dot((o802403923690_0_1_rgba).rgb, vec3(1.0))/3.0));
float o802437478124_0_clamp_true = clamp(o802437478124_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/graph_4/math_2 (o802437478124)
float o802437478124_0_1_f = o802437478124_0_clamp_false;

// #output0: graph_4/graph_3/graph_4/translate_5 (o802454255341)
vec4 o802454255341_0_1_rgba = vec4(vec3(o802437478124_0_1_f), 1.0);

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_13_f = shape_circle((transform2_clamp(transform2((((uv)-vec2(p_o802487809775_translate_x, p_o802487809775_translate_y))-vec2(p_o802403923690_translate_x, p_o802403923690_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_35_rgba = vec4(vec3(o801514731226_0_13_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o802403923690)
vec4 o802403923690_0_3_rgba = o800189331149_4_35_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o804635293448)
vec4 o804635293448_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((((uv)-vec2(p_o802487809775_translate_x, p_o802487809775_translate_y))-vec2(p_o802420700907_translate_x, p_o802420700907_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804635293448_translate_x, p_o804635293448_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec3 o804652070665_0_map = ((o804635293448_0_1_rgba).rgb);
float o804652070665_0_rnd =  float((seed_o804652070665+fract(_seed_variation_)))+o804652070665_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec4 o804652070665_0_1_rgba = o804652070665_input_in(get_from_tileset(2.0, o804652070665_0_rnd, custom_uv_transform(o804652070665_0_map.xy, vec2(p_o804652070665_sx, p_o804652070665_sy), p_o804652070665_rotate*0.01745329251, p_o804652070665_scale, vec2(o804652070665_0_map.z, float((seed_o804652070665+fract(_seed_variation_)))))), false ? o804652070665_0_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_2_15_rgba = o804652070665_0_1_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_2_15_rgba = o804786288401_2_15_rgba;

// #output3: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_3_37_rgba = o804769511184_2_15_rgba;

// #output0: graph_4/graph_3/graph_4/translate_3 (o802420700907)
vec4 o802420700907_0_1_rgba = o800189331149_3_37_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o804635293448)
vec4 o804635293448_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o802487809775_translate_x, p_o802487809775_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804635293448_translate_x, p_o804635293448_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec3 o804652070665_2_map = ((o804635293448_0_3_rgba).rgb);
float o804652070665_2_rnd =  float((seed_o804652070665+fract(_seed_variation_)))+o804652070665_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec4 o804652070665_0_3_rgba = o804652070665_input_in(get_from_tileset(2.0, o804652070665_2_rnd, custom_uv_transform(o804652070665_2_map.xy, vec2(p_o804652070665_sx, p_o804652070665_sy), p_o804652070665_rotate*0.01745329251, p_o804652070665_scale, vec2(o804652070665_2_map.z, float((seed_o804652070665+fract(_seed_variation_)))))), false ? o804652070665_2_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_2_17_rgba = o804652070665_0_3_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_2_17_rgba = o804786288401_2_17_rgba;

// #output3: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_3_39_rgba = o804769511184_2_17_rgba;

// #code: graph_4/graph_3/graph_4/blend2 (o802471032558)
vec4 o802471032558_0_b = o800189331149_3_39_rgba;
vec4 o802471032558_0_l;
float o802471032558_0_a;

o802471032558_0_l = o802420700907_0_1_rgba;
o802471032558_0_a = p_o802471032558_amount1*(dot((o802403923690_0_3_rgba).rgb, vec3(1.0))/3.0);
o802471032558_0_b = vec4(blend_normal(((uv)-vec2(p_o802487809775_translate_x, p_o802487809775_translate_y)), o802471032558_0_l.rgb, o802471032558_0_b.rgb, o802471032558_0_a*o802471032558_0_l.a), min(1.0, o802471032558_0_b.a+o802471032558_0_a*o802471032558_0_l.a));
// #output0: graph_4/graph_3/graph_4/blend2 (o802471032558)
vec4 o802471032558_0_1_rgba = o802471032558_0_b;

// #output0: graph_4/graph_3/graph_4/translate_4 (o802487809775)
vec4 o802487809775_0_1_rgba = o802471032558_0_1_rgba;

// #output0: graph_4/graph_3/shape (o801514731226)
float o801514731226_0_15_f = shape_circle((transform2_clamp(transform2(((uv)-vec2(p_o802403923690_translate_x, p_o802403923690_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), p_o801514731226_sides, p_o801514731226_radius*1.0, p_o801514731226_edge*1.0);

// #output4: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_4_41_rgba = vec4(vec3(o801514731226_0_15_f), 1.0);

// #output0: graph_4/graph_3/graph_4/translate_2 (o802403923690)
vec4 o802403923690_0_5_rgba = o800189331149_4_41_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o804635293448)
vec4 o804635293448_0_5_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2(((uv)-vec2(p_o802420700907_translate_x, p_o802420700907_translate_y)), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804635293448_translate_x, p_o804635293448_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec3 o804652070665_4_map = ((o804635293448_0_5_rgba).rgb);
float o804652070665_4_rnd =  float((seed_o804652070665+fract(_seed_variation_)))+o804652070665_4_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec4 o804652070665_0_5_rgba = o804652070665_input_in(get_from_tileset(2.0, o804652070665_4_rnd, custom_uv_transform(o804652070665_4_map.xy, vec2(p_o804652070665_sx, p_o804652070665_sy), p_o804652070665_rotate*0.01745329251, p_o804652070665_scale, vec2(o804652070665_4_map.z, float((seed_o804652070665+fract(_seed_variation_)))))), false ? o804652070665_4_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_2_19_rgba = o804652070665_0_5_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_2_19_rgba = o804786288401_2_19_rgba;

// #output3: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_3_43_rgba = o804769511184_2_19_rgba;

// #output0: graph_4/graph_3/graph_4/translate_3 (o802420700907)
vec4 o802420700907_0_3_rgba = o800189331149_3_43_rgba;

// #output0: graph_4/graph_3/graph_6/translate_3 (o804635293448)
vec4 o804635293448_0_7_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o800189331149_translate_x*(2.0*1.0-1.0), p_o800189331149_translate_y*(2.0*1.0-1.0)), (-elapsed_time*90.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o800189331149_scale_x*(2.0*1.0-1.0), (p_o800189331149_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804635293448_translate_x, p_o804635293448_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec3 o804652070665_6_map = ((o804635293448_0_7_rgba).rgb);
float o804652070665_6_rnd =  float((seed_o804652070665+fract(_seed_variation_)))+o804652070665_6_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_6 (o804652070665)
vec4 o804652070665_0_7_rgba = o804652070665_input_in(get_from_tileset(2.0, o804652070665_6_rnd, custom_uv_transform(o804652070665_6_map.xy, vec2(p_o804652070665_sx, p_o804652070665_sy), p_o804652070665_rotate*0.01745329251, p_o804652070665_scale, vec2(o804652070665_6_map.z, float((seed_o804652070665+fract(_seed_variation_)))))), false ? o804652070665_6_rnd : 0.0);

// #output2: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_2_20_rgba = o804652070665_0_7_rgba;

// #output2: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_2_20_rgba = o804786288401_2_20_rgba;

// #output3: graph_4/graph_3/transform2_4 (o800189331149)
vec4 o800189331149_3_44_rgba = o804769511184_2_20_rgba;

// #code: graph_4/graph_3/graph_4/blend2 (o802471032558)
vec4 o802471032558_2_b = o800189331149_3_44_rgba;
vec4 o802471032558_2_l;
float o802471032558_2_a;

o802471032558_2_l = o802420700907_0_3_rgba;
o802471032558_2_a = p_o802471032558_amount1*(dot((o802403923690_0_5_rgba).rgb, vec3(1.0))/3.0);
o802471032558_2_b = vec4(blend_normal((uv), o802471032558_2_l.rgb, o802471032558_2_b.rgb, o802471032558_2_a*o802471032558_2_l.a), min(1.0, o802471032558_2_b.a+o802471032558_2_a*o802471032558_2_l.a));
// #output0: graph_4/graph_3/graph_4/blend2 (o802471032558)
vec4 o802471032558_0_3_rgba = o802471032558_2_b;

// #code: graph_4/graph_3/graph_4/blend2_2 (o802504586992)
vec4 o802504586992_0_b = o802471032558_0_3_rgba;
vec4 o802504586992_0_l;
float o802504586992_0_a;

o802504586992_0_l = o802487809775_0_1_rgba;
o802504586992_0_a = p_o802504586992_amount1*(dot((o802454255341_0_1_rgba).rgb, vec3(1.0))/3.0);
o802504586992_0_b = vec4(blend_normal((uv), o802504586992_0_l.rgb, o802504586992_0_b.rgb, o802504586992_0_a*o802504586992_0_l.a), min(1.0, o802504586992_0_b.a+o802504586992_0_a*o802504586992_0_l.a));
// #output0: graph_4/graph_3/graph_4/blend2_2 (o802504586992)
vec4 o802504586992_0_1_rgba = o802504586992_0_b;

// #output1: graph_4/decompose (o914005964572)
float o914005964572_1_3_f = o800206108366_0_1_rgba.g;

// #output0: graph_4/uniform_greyscale (o915012597547)
float o915012597547_0_1_f = p_o915012597547_color;

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_9_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_8_map = ((o958817908933_0_9_rgba).rgb);
float o958834686158_8_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_8_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_9_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_8_rnd, custom_uv_transform(o958834686158_8_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_8_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_8_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_24_rgba = o958834686158_0_9_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_24_rgba = o959002458328_1_24_rgba;

// #output1: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_1_9_f = o958985681111_1_24_rgba.g;

// #output1: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_1_3_rgba = vec4(vec3(o803175675635_1_9_f), 1.0);

// #code: graph_4/graph_3/math_7 (o799082034868)
float o799082034868_0_clamp_false = (dot((o798108956323_1_3_rgba).rgb, vec3(1.0))/3.0)*o796951328391_3_1_f;
float o799082034868_0_clamp_true = clamp(o799082034868_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_7 (o799082034868)
float o799082034868_0_1_f = o799082034868_0_clamp_false;

// #output0: graph_4/graph_3/graph_6/translate_2 (o804601739014)
vec4 o804601739014_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o798108956323_translate_x*(2.0*1.0-1.0), p_o798108956323_translate_y*(2.0*1.0-1.0)), (sin(elapsed_time*5.0)*200.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o798108956323_scale_x*(2.0*1.0-1.0), (p_o798108956323_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804601739014_translate_x, p_o804601739014_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_5 (o804618516231)
vec3 o804618516231_0_map = ((o804601739014_0_1_rgba).rgb);
float o804618516231_0_rnd =  float((seed_o804618516231+fract(_seed_variation_)))+o804618516231_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_5 (o804618516231)
vec4 o804618516231_0_1_rgba = o804618516231_input_in(get_from_tileset(2.0, o804618516231_0_rnd, custom_uv_transform(o804618516231_0_map.xy, vec2(p_o804618516231_sx, p_o804618516231_sy), p_o804618516231_rotate*0.01745329251, p_o804618516231_scale, vec2(o804618516231_0_map.z, float((seed_o804618516231+fract(_seed_variation_)))))), false ? o804618516231_0_rnd : 0.0);

// #output1: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_1_21_rgba = o804618516231_0_1_rgba;

// #output1: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_1_21_rgba = o804786288401_1_21_rgba;

// #output3: graph_4/graph_3/transform2_3 (o798108956323)
vec4 o798108956323_3_4_rgba = o804769511184_1_21_rgba;

// #output0: graph_4/graph_3/graph_6/translate (o804568184580)
vec4 o804568184580_0_1_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804568184580_translate_x, p_o804568184580_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_4 (o804584961797)
vec3 o804584961797_0_map = ((o804568184580_0_1_rgba).rgb);
float o804584961797_0_rnd =  float((seed_o804584961797+fract(_seed_variation_)))+o804584961797_0_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_4 (o804584961797)
vec4 o804584961797_0_1_rgba = o804584961797_input_in(get_from_tileset(2.0, o804584961797_0_rnd, custom_uv_transform(o804584961797_0_map.xy, vec2(p_o804584961797_sx, p_o804584961797_sy), p_o804584961797_rotate*0.01745329251, p_o804584961797_scale, vec2(o804584961797_0_map.z, float((seed_o804584961797+fract(_seed_variation_)))))), false ? o804584961797_0_rnd : 0.0);

// #output0: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_0_22_rgba = o804584961797_0_1_rgba;

// #output0: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_0_22_rgba = o804786288401_0_22_rgba;

// #output3: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_3_3_rgba = o804769511184_0_22_rgba;

// #output0: graph_4/graph_3/graph_6/translate (o804568184580)
vec4 o804568184580_0_3_rgba = vec4(((scale((fract(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o804769511184_translate_x*(2.0*1.0-1.0), p_o804769511184_translate_y*(2.0*1.0-1.0)), p_o804769511184_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o804769511184_scale_x*(2.0*1.0-1.0), p_o804769511184_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o804786288401_cx, 0.5+p_o804786288401_cy), vec2(p_o804786288401_scale_x, p_o804786288401_scale_y)))-vec2(p_o804568184580_translate_x, p_o804568184580_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_3/graph_6/custom_uv_4 (o804584961797)
vec3 o804584961797_2_map = ((o804568184580_0_3_rgba).rgb);
float o804584961797_2_rnd =  float((seed_o804584961797+fract(_seed_variation_)))+o804584961797_2_map.z;
// #output0: graph_4/graph_3/graph_6/custom_uv_4 (o804584961797)
vec4 o804584961797_0_3_rgba = o804584961797_input_in(get_from_tileset(2.0, o804584961797_2_rnd, custom_uv_transform(o804584961797_2_map.xy, vec2(p_o804584961797_sx, p_o804584961797_sy), p_o804584961797_rotate*0.01745329251, p_o804584961797_scale, vec2(o804584961797_2_map.z, float((seed_o804584961797+fract(_seed_variation_)))))), false ? o804584961797_2_rnd : 0.0);

// #output0: graph_4/graph_3/graph_6/scale (o804786288401)
vec4 o804786288401_0_23_rgba = o804584961797_0_3_rgba;

// #output0: graph_4/graph_3/graph_6/transform2_2 (o804769511184)
vec4 o804769511184_0_23_rgba = o804786288401_0_23_rgba;

// #output3: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_3_3_rgba = o804769511184_0_23_rgba;

// #code: graph_4/graph_3/blend2_5 (o798092179106)
vec4 o798092179106_0_b = o797051991693_3_3_rgba;
vec4 o798092179106_0_l;
float o798092179106_0_a;

o798092179106_0_l = o797068768910_3_3_rgba;
o798092179106_0_a = p_o798092179106_amount1*1.0;
o798092179106_0_b = vec4(blend_lighten((uv), o798092179106_0_l.rgb, o798092179106_0_b.rgb, o798092179106_0_a*o798092179106_0_l.a), min(1.0, o798092179106_0_b.a+o798092179106_0_a*o798092179106_0_l.a));
// #output0: graph_4/graph_3/blend2_5 (o798092179106)
vec4 o798092179106_0_1_rgba = o798092179106_0_b;

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_11_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797068768910_translate_x*(2.0*1.0-1.0), p_o797068768910_translate_y*(2.0*1.0-1.0)), (-elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797068768910_scale_x*(2.0*1.0-1.0), (p_o797068768910_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_10_map = ((o958817908933_0_11_rgba).rgb);
float o958834686158_10_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_10_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_11_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_10_rnd, custom_uv_transform(o958834686158_10_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_10_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_10_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_25_rgba = o958834686158_0_11_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_25_rgba = o959002458328_1_25_rgba;

// #output0: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_0_11_f = o958985681111_1_25_rgba.r;

// #output1: graph_4/graph_3/transform2_2 (o797068768910)
vec4 o797068768910_1_4_rgba = vec4(vec3(o803175675635_0_11_f), 1.0);

// #output0: graph_4/graph_5/translate_2 (o958817908933)
vec4 o958817908933_0_13_rgba = vec4(((scale((transform2_clamp(transform2((transform2_clamp(transform2((uv), vec2(p_o797051991693_translate_x*(2.0*1.0-1.0), p_o797051991693_translate_y*(2.0*1.0-1.0)), (elapsed_time*30.0)*0.01745329251*(2.0*1.0-1.0), vec2(p_o797051991693_scale_x*(2.0*1.0-1.0), (p_o797051991693_scale_x)*(2.0*1.0-1.0))))), vec2(p_o958985681111_translate_x*(2.0*1.0-1.0), p_o958985681111_translate_y*(2.0*1.0-1.0)), p_o958985681111_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o958985681111_scale_x*(2.0*1.0-1.0), p_o958985681111_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o959002458328_cx, 0.5+p_o959002458328_cy), vec2(p_o959002458328_scale_x, p_o959002458328_scale_y)))-vec2(p_o958817908933_translate_x, p_o958817908933_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_5/custom_uv_5 (o958834686158)
vec3 o958834686158_12_map = ((o958817908933_0_13_rgba).rgb);
float o958834686158_12_rnd =  float((seed_o958834686158+fract(_seed_variation_)))+o958834686158_12_map.z;
// #output0: graph_4/graph_5/custom_uv_5 (o958834686158)
vec4 o958834686158_0_13_rgba = o958834686158_input_in(get_from_tileset(2.0, o958834686158_12_rnd, custom_uv_transform(o958834686158_12_map.xy, vec2(p_o958834686158_sx, p_o958834686158_sy), p_o958834686158_rotate*0.01745329251, p_o958834686158_scale, vec2(o958834686158_12_map.z, float((seed_o958834686158+fract(_seed_variation_)))))), false ? o958834686158_12_rnd : 0.0);

// #output1: graph_4/graph_5/scale (o959002458328)
vec4 o959002458328_1_26_rgba = o958834686158_0_13_rgba;

// #output1: graph_4/graph_5/transform2_2 (o958985681111)
vec4 o958985681111_1_26_rgba = o959002458328_1_26_rgba;

// #output0: graph_4/graph_3/decompose_4 (o803175675635)
float o803175675635_0_13_f = o958985681111_1_26_rgba.r;

// #output1: graph_4/graph_3/transform2 (o797051991693)
vec4 o797051991693_1_4_rgba = vec4(vec3(o803175675635_0_13_f), 1.0);

// #code: graph_4/graph_3/blend2_2 (o797991515804)
vec4 o797991515804_0_b = o797051991693_1_4_rgba;
vec4 o797991515804_0_l;
float o797991515804_0_a;

o797991515804_0_l = o797068768910_1_4_rgba;
o797991515804_0_a = p_o797991515804_amount1*1.0;
o797991515804_0_b = vec4(blend_lighten((uv), o797991515804_0_l.rgb, o797991515804_0_b.rgb, o797991515804_0_a*o797991515804_0_l.a), min(1.0, o797991515804_0_b.a+o797991515804_0_a*o797991515804_0_l.a));
// #output0: graph_4/graph_3/blend2_2 (o797991515804)
vec4 o797991515804_0_1_rgba = o797991515804_0_b;

// #code: graph_4/graph_3/math_3 (o798041847455)
float o798041847455_0_clamp_false = (dot((o797991515804_0_1_rgba).rgb, vec3(1.0))/3.0)*o796951328391_3_1_f;
float o798041847455_0_clamp_true = clamp(o798041847455_0_clamp_false, 0.0, 1.0);
// #output0: graph_4/graph_3/math_3 (o798041847455)
float o798041847455_0_1_f = o798041847455_0_clamp_false;

// #output0: graph_4/graph_4/translate (o955747678391)
vec4 o955747678391_0_1_rgba = vec4(((scale((fract(transform2((uv), vec2(p_o955949004995_translate_x*(2.0*1.0-1.0), p_o955949004995_translate_y*(2.0*1.0-1.0)), p_o955949004995_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o955949004995_scale_x*(2.0*1.0-1.0), p_o955949004995_scale_y*(2.0*1.0-1.0))))), vec2(0.5+p_o955965782212_cx, 0.5+p_o955965782212_cy), vec2(p_o955965782212_scale_x, p_o955965782212_scale_y)))-vec2(p_o955747678391_translate_x, p_o955747678391_translate_y)), 0.0, 1.0);

// #code: graph_4/graph_4/custom_uv_4 (o955764455608)
vec3 o955764455608_0_map = ((o955747678391_0_1_rgba).rgb);
float o955764455608_0_rnd =  float((seed_o955764455608+fract(_seed_variation_)))+o955764455608_0_map.z;
// #output0: graph_4/graph_4/custom_uv_4 (o955764455608)
vec4 o955764455608_0_1_rgba = o955764455608_input_in(get_from_tileset(2.0, o955764455608_0_rnd, custom_uv_transform(o955764455608_0_map.xy, vec2(p_o955764455608_sx, p_o955764455608_sy), p_o955764455608_rotate*0.01745329251, p_o955764455608_scale, vec2(o955764455608_0_map.z, float((seed_o955764455608+fract(_seed_variation_)))))), false ? o955764455608_0_rnd : 0.0);

// #output0: graph_4/graph_4/scale (o955965782212)
vec4 o955965782212_0_3_rgba = o955764455608_0_1_rgba;

// #output0: graph_4/graph_4/transform2_2 (o955949004995)
vec4 o955949004995_0_3_rgba = o955965782212_0_3_rgba;

// #code: graph_4/blend2_18 (o913922078493)
vec4 o913922078493_0_b = o955949004995_0_3_rgba;
vec4 o913922078493_0_l;
float o913922078493_0_a;

o913922078493_0_l = vec4(vec3(o915012597547_0_1_f), 1.0);
o913922078493_0_a = p_o913922078493_amount1*o798041847455_0_1_f;
o913922078493_0_b = vec4(blend_normal((uv), o913922078493_0_l.rgb, o913922078493_0_b.rgb, o913922078493_0_a*o913922078493_0_l.a), min(1.0, o913922078493_0_b.a+o913922078493_0_a*o913922078493_0_l.a));
// #output0: graph_4/blend2_18 (o913922078493)
vec4 o913922078493_0_1_rgba = o913922078493_0_b;

// #code: graph_4/blend2_15 (o913871746838)
vec4 o913871746838_0_b = o913922078493_0_1_rgba;
vec4 o913871746838_0_l;
float o913871746838_0_a;

o913871746838_0_l = o798092179106_0_1_rgba;
o913871746838_0_a = p_o913871746838_amount1*o798025070238_0_1_f;
o913871746838_0_b = vec4(blend_normal((uv), o913871746838_0_l.rgb, o913871746838_0_b.rgb, o913871746838_0_a*o913871746838_0_l.a), min(1.0, o913871746838_0_b.a+o913871746838_0_a*o913871746838_0_l.a));

o913871746838_0_l = o798108956323_3_4_rgba;
o913871746838_0_a = p_o913871746838_amount2*o799082034868_0_1_f;
o913871746838_0_b = vec4(blend_normal((uv), o913871746838_0_l.rgb, o913871746838_0_b.rgb, o913871746838_0_a*o913871746838_0_l.a), min(1.0, o913871746838_0_b.a+o913871746838_0_a*o913871746838_0_l.a));

o913871746838_0_l = vec4(vec3(o915012597547_0_1_f), 1.0);
o913871746838_0_a = p_o913871746838_amount3*o914005964572_1_3_f;
o913871746838_0_b = vec4(blend_normal((uv), o913871746838_0_l.rgb, o913871746838_0_b.rgb, o913871746838_0_a*o913871746838_0_l.a), min(1.0, o913871746838_0_b.a+o913871746838_0_a*o913871746838_0_l.a));

o913871746838_0_l = o802504586992_0_1_rgba;
o913871746838_0_a = p_o913871746838_amount4*o914005964572_2_1_f;
o913871746838_0_b = vec4(blend_normal((uv), o913871746838_0_l.rgb, o913871746838_0_b.rgb, o913871746838_0_a*o913871746838_0_l.a), min(1.0, o913871746838_0_b.a+o913871746838_0_a*o913871746838_0_l.a));
// #output0: graph_4/blend2_15 (o913871746838)
vec4 o913871746838_0_1_rgba = o913871746838_0_b;

// #code: graph_4/blend2_21 (o913989187351)
vec4 o913989187351_0_b = o913871746838_0_1_rgba;
vec4 o913989187351_0_l;
float o913989187351_0_a;

o913989187351_0_l = o961720367326_0_1_rgba;
o913989187351_0_a = p_o913989187351_amount1*o796951328391_3_1_f;
o913989187351_0_b = vec4(blend_multiply((uv), o913989187351_0_l.rgb, o913989187351_0_b.rgb, o913989187351_0_a*o913989187351_0_l.a), min(1.0, o913989187351_0_b.a+o913989187351_0_a*o913989187351_0_l.a));
// #output0: graph_4/blend2_21 (o913989187351)
vec4 o913989187351_0_1_rgba = o913989187351_0_b;

	vec3 albedo_tex = ((o913989187351_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o742307935352_albedo_color.rgb;
	METALLIC = 1.0*p_o742307935352_metallic;
	ROUGHNESS = (dot((o913955632922_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o742307935352_roughness;
	NORMAL_MAP = ((o913888524062_0_1_rgba).rgb);
	NORMAL_MAP_DEPTH = p_o742307935352_normal;
	EMISSION = vec3(0.0)*p_o742307935352_emission_energy;
}



