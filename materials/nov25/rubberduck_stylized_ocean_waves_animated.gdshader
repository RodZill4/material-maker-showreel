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
const vec4 p_o28278131789586_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o28278131789586_metallic = 0.000000000;
const float p_o28278131789586_roughness = 1.000000000;
const float p_o28278131789586_emission_energy = 1.000000000;
const float p_o28278131789586_normal = 1.000000000;
const float p_o28278131789586_ao = 1.000000000;
const float p_o28278131789586_depth_scale = 0.200000000;
const float p_o28278249236025_amount = 1.000000000;
const float p_o28305159886489_amount1 = 0.530000000;
const vec4 p_o28305193441951_in_min = vec4(0.166557059, 0.166557059, 0.166557059, 0.000000000);
const vec4 p_o28305193441951_in_mid = vec4(0.555957675, 0.555957675, 0.555957675, 0.500000000);
const vec4 p_o28305193441951_in_max = vec4(0.992758155, 0.992758155, 0.992758155, 1.000000000);
const vec4 p_o28305193441951_out_min = vec4(1.000000000, 1.000000000, 1.000000000, 0.000000000);
const vec4 p_o28305193441951_out_max = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const float p_o28305226996376_rotate = 0.000000000;
const float p_o28305226996376_scale_x = 1.000000000;
const float p_o28305226996376_scale_y = 1.000000000;
const float seed_o28305210216698 = 0.000000000;
const float p_o28305210216698_scale_x = 4.000000000;
const float p_o28305210216698_scale_y = 4.000000000;
const float p_o28305210216698_folds = 0.000000000;
const float p_o28305210216698_iterations = 3.000000000;
const float p_o28305210216698_persistence = 0.240000000;
const float p_o28305210216698_offset = 0.000000000;
const float p_o28305059225329_amount = 0.100000000;
const float p_o28305059225329_eps = 0.100000000;
const float p_o28305042447688_rotate = 0.000000000;
const float p_o28305042447688_scale_x = 1.000000000;
const float p_o28305042447688_scale_y = 1.000000000;
const float seed_o28287241820405 = 0.000000000;
const float p_o28287241820405_scale_x = 2.000000000;
const float p_o28287241820405_scale_y = 2.000000000;
const float p_o28287241820405_folds = 0.000000000;
const float p_o28287241820405_iterations = 5.000000000;
const float p_o28287241820405_persistence = 0.500000000;
const float p_o28287241820405_offset = 0.000000000;
const float p_o28305025669534_translate_y = 0.000000000;
const float p_o28305025669534_rotate = 0.000000000;
const float p_o28305025669534_scale_x = 1.000000000;
const float p_o28305025669534_scale_y = 1.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 1024.000000000;
const float p_o28287275374247_amount = 0.100000000;
const float p_o28287275374247_eps = 0.100000000;
const float p_o28287258597578_rotate = 0.000000000;
const float p_o28287258597578_scale_x = 1.000000000;
const float p_o28287258597578_scale_y = 1.000000000;
const float p_o28287225038709_translate_y = 0.000000000;
const float p_o28287225038709_rotate = 0.000000000;
const float p_o28287225038709_scale_x = 1.000000000;
const float p_o28287225038709_scale_y = 1.000000000;
uniform sampler2D texture_2;
const float texture_2_size = 1024.000000000;
const float p_o28305780643945_brightness = 0.170000000;
const float p_o28305780643945_contrast = 1.000000000;
const float p_o28305763868004_amount1 = 0.800000000;
const float p_o28293499717879_amount = 0.100000000;
const float p_o28293499717879_eps = 0.100000000;
const float p_o28293482941440_rotate = 0.000000000;
const float p_o28293482941440_scale_x = 1.000000000;
const float p_o28293482941440_scale_y = 1.000000000;
const float p_o28293466167083_translate_y = 0.000000000;
const float p_o28293466167083_rotate = 0.000000000;
const float p_o28293466167083_scale_x = 1.000000000;
const float p_o28293466167083_scale_y = 1.000000000;
uniform sampler2D texture_3;
const float texture_3_size = 1024.000000000;
const float p_o28305361214934_gradient_pos[3] = float[]( 0.120560929, 0.233643815, 0.738310099 );
const vec4 p_o28305361214934_gradient_col[3] = vec4[]( vec4(0.699218750, 0.699218750, 0.699218750, 1.000000000), vec4(0.386718750, 0.379165649, 0.379165649, 1.000000000), vec4(0.152343750, 0.152343750, 0.152343750, 1.000000000) );
const float p_o28305596093633_amount1 = 0.490000000;
const float p_o28305679978295_amount1 = 1.000000000;
const vec4 p_o28305713531272_in_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o28305713531272_in_mid = vec4(0.344831944, 0.344831944, 0.344831944, 0.500000000);
const vec4 p_o28305713531272_in_max = vec4(0.907348990, 0.907348990, 0.907348990, 1.000000000);
const vec4 p_o28305713531272_out_min = vec4(1.000000000, 1.000000000, 1.000000000, 0.000000000);
const vec4 p_o28305713531272_out_max = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const float p_o28305696757866_rotate = 0.000000000;
const float p_o28305696757866_scale_x = 1.000000000;
const float p_o28305696757866_scale_y = 1.000000000;
const vec4 p_o28305663206848_in_min = vec4(0.072416142, 0.072416142, 0.072416142, 0.000000000);
const vec4 p_o28305663206848_in_mid = vec4(0.414417326, 0.414417326, 0.414417326, 0.500000000);
const vec4 p_o28305663206848_in_max = vec4(0.723501980, 0.723501980, 0.723501980, 1.000000000);
const vec4 p_o28305663206848_out_min = vec4(1.000000000, 1.000000000, 1.000000000, 0.000000000);
const vec4 p_o28305663206848_out_max = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const vec4 p_o28305612867540_color = vec4(0.245697021, 0.648437500, 0.572923660, 1.000000000);
const float p_o28305243769347_amount1 = 0.350000000;
const float p_o28305277331081_amount1 = 0.540000000;
const vec4 p_o28305747089203_in_min = vec4(0.263331503, 0.263331503, 0.263331503, 0.000000000);
const vec4 p_o28305747089203_in_mid = vec4(0.565832734, 0.565832734, 0.565832734, 0.500000000);
const vec4 p_o28305747089203_in_max = vec4(0.763001561, 0.763001561, 0.763001561, 1.000000000);
const vec4 p_o28305747089203_out_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o28305747089203_out_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o28305260546652_color = vec4(0.485702515, 0.846621633, 0.894531250, 1.000000000);
const float p_o28304925006104_amount1 = 0.180000000;
const float p_o28304857898672_amount1 = 1.000000000;
const vec4 p_o28304891452541_in_min = vec4(0.247852564, 0.247852564, 0.247852564, 0.000000000);
const vec4 p_o28304891452541_in_mid = vec4(0.522105813, 0.522105813, 0.522105813, 0.500000000);
const vec4 p_o28304891452541_in_max = vec4(0.727362037, 0.727362037, 0.727362037, 1.000000000);
const vec4 p_o28304891452541_out_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o28304891452541_out_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o28304908225341_rotate = 0.000000000;
const float p_o28304908225341_scale_x = 1.000000000;
const float p_o28304908225341_scale_y = 1.000000000;
const float seed_o28304874674418 = 0.000000000;
const float p_o28304874674418_scale_x = 7.000000000;
const float p_o28304874674418_scale_y = 2.000000000;
const float p_o28304874674418_folds = 0.000000000;
const float p_o28304874674418_iterations = 5.000000000;
const float p_o28304874674418_persistence = 0.500000000;
const float p_o28304874674418_offset = 0.000000000;
const float p_o28303129843993_amount1 = 0.180000000;
const float p_o28302676857234_gradient_pos[16] = float[]( 0.000000000, 0.110336021, 0.180118650, 0.229462415, 0.251529604, 0.273596823, 0.407826394, 0.457170159, 0.499310523, 0.523371756, 0.589573383, 0.633707762, 0.683051527, 0.843703270, 0.977932811, 1.000000000 );
const vec4 p_o28302676857234_gradient_col[16] = vec4[]( vec4(0.431372553, 0.627451003, 0.870588243, 1.000000000), vec4(0.384313732, 0.564705908, 0.831372559, 1.000000000), vec4(0.239215687, 0.396078438, 0.686274529, 1.000000000), vec4(0.239215687, 0.396078438, 0.686274529, 1.000000000), vec4(0.282352954, 0.423529416, 0.705882370, 1.000000000), vec4(0.274509817, 0.640808821, 0.658823550, 1.000000000), vec4(0.352941185, 0.552941203, 0.768627465, 1.000000000), vec4(0.235294119, 0.435294122, 0.678431392, 1.000000000), vec4(0.384313762, 0.811764717, 0.751654446, 1.000000000), vec4(0.211764708, 0.415686280, 0.650980413, 1.000000000), vec4(0.450980395, 0.647058845, 0.866666675, 1.000000000), vec4(0.431372553, 0.682352960, 0.890196085, 1.000000000), vec4(0.243137240, 0.661029398, 0.729411781, 1.000000000), vec4(0.294117659, 0.545098066, 0.827450991, 1.000000000), vec4(0.325490206, 0.588235319, 0.866666675, 1.000000000), vec4(0.325490206, 0.592156887, 0.878431380, 1.000000000) );
const float p_o28302609750856_amount = 0.050000000;
const float p_o28302609750856_eps = 0.100000000;
const float p_o28293667490886_amount1 = 1.000000000;
const vec4 p_o28302542637174_in_min = vec4(0.358010948, 0.358010948, 0.358010948, 0.000000000);
const vec4 p_o28302542637174_in_mid = vec4(0.472176015, 0.472176015, 0.472176015, 0.500000000);
const vec4 p_o28302542637174_in_max = vec4(0.960500360, 0.960500360, 0.960500360, 1.000000000);
const vec4 p_o28302542637174_out_min = vec4(0.006583282, 0.006583282, 0.006583282, 0.000000000);
const vec4 p_o28302542637174_out_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o28302525864730_amount1 = 0.670000000;
const float p_o28302408420943_amount = 0.100000000;
const float p_o28302408420943_eps = 0.100000000;
const float p_o28302475532290_rotate = 0.000000000;
const float p_o28302475532290_scale_x = 1.000000000;
const float p_o28302475532290_scale_y = 1.000000000;
const float p_o28302072878933_size = 5.000000000;
uniform sampler2D texture_4;
const float texture_4_size = 1024.000000000;
const vec4 p_o28302492310391_color = vec4(0.000000000, 0.352478027, 0.585937500, 1.000000000);
const float p_o28279457189883_gradient_pos[2] = float[]( 0.098144531, 0.826693952 );
const vec4 p_o28279457189883_gradient_col[2] = vec4[]( vec4(0.026733398, 0.056882765, 0.285156250, 1.000000000), vec4(0.715179443, 0.734658241, 0.839843750, 1.000000000) );
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
// #globals: blend2_16 (o28305159886489)
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
// #globals: tones_4 (o28305193441951)
vec4 adjust_levels(vec4 color, vec4 in_min, vec4 in_mid, vec4 in_max, vec4 out_min, vec4 out_max) {
	color = clamp((color-in_min)/(in_max-in_min), 0.0, 1.0);
	in_mid = (in_mid-in_min)/(in_max-in_min);
	vec4 dark = step(in_mid, color);
	color = 0.5*mix(color/(in_mid), 1.0+(color-in_mid)/(1.0-in_mid), dark);
	return out_min+color*(out_max-out_min);
}
// #globals: transform2_13 (o28305226996376)
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
// #globals: fbm3_10 (o28305210216698)
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
// #globals: decompose_3 (o28305126333084)
float o28305059225329_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3_7 (o28287241820405)
float o28287241820405_0_1_f = fbm_2d_value((fract(transform2(uv, vec2((elapsed_time * 0.3)*(2.0*1.0-1.0), (-elapsed_time * 0.1)*(2.0*1.0-1.0)), p_o28305042447688_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305042447688_scale_x*(2.0*1.0-1.0), p_o28305042447688_scale_y*(2.0*1.0-1.0))))), vec2(p_o28287241820405_scale_x, p_o28287241820405_scale_y), int(p_o28287241820405_folds), int(p_o28287241820405_iterations), p_o28287241820405_persistence, p_o28287241820405_offset, (seed_o28287241820405+fract(_seed_variation_)));
// #output0: transform2_12 (o28305042447688)
vec4 o28305042447688_0_1_rgba = vec4(vec3(o28287241820405_0_1_f), 1.0);
return (dot((o28305042447688_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp_11 (o28305059225329)
vec2 o28305059225329_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o28305059225329_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o28305059225329_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o28305059225329_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o28305059225329_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
float o28287275374247_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3_7 (o28287241820405)
float o28287241820405_0_1_f = fbm_2d_value((fract(transform2(uv, vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), (elapsed_time * 0.1)*(2.0*1.0-1.0)), p_o28287258597578_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28287258597578_scale_x*(2.0*1.0-1.0), p_o28287258597578_scale_y*(2.0*1.0-1.0))))), vec2(p_o28287241820405_scale_x, p_o28287241820405_scale_y), int(p_o28287241820405_folds), int(p_o28287241820405_iterations), p_o28287241820405_persistence, p_o28287241820405_offset, (seed_o28287241820405+fract(_seed_variation_)));
// #output0: transform2_6 (o28287258597578)
vec4 o28287258597578_0_1_rgba = vec4(vec3(o28287241820405_0_1_f), 1.0);
return (dot((o28287258597578_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp (o28287275374247)
vec2 o28287275374247_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o28287275374247_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o28287275374247_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o28287275374247_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o28287275374247_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
float o28278249236025_input_in(vec2 uv, float _seed_variation_) {
// #output0: fbm3_10 (o28305210216698)
float o28305210216698_0_1_f = fbm_2d_perlin((fract(transform2((uv), vec2((-elapsed_time * 0.16)*(2.0*1.0-1.0), (elapsed_time * 0.03)*(2.0*1.0-1.0)), p_o28305226996376_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305226996376_scale_x*(2.0*1.0-1.0), p_o28305226996376_scale_y*(2.0*1.0-1.0))))), vec2(p_o28305210216698_scale_x, p_o28305210216698_scale_y), int(p_o28305210216698_folds), int(p_o28305210216698_iterations), p_o28305210216698_persistence, p_o28305210216698_offset, (seed_o28305210216698+fract(_seed_variation_)));
// #output0: transform2_13 (o28305226996376)
vec4 o28305226996376_0_1_rgba = vec4(vec3(o28305210216698_0_1_f), 1.0);
// #output0: tones_4 (o28305193441951)
vec4 o28305193441951_0_1_rgba = adjust_levels(o28305226996376_0_1_rgba, p_o28305193441951_in_min, p_o28305193441951_in_mid, p_o28305193441951_in_max, p_o28305193441951_out_min, p_o28305193441951_out_max);
// #code: warp_11 (o28305059225329)
vec2 o28305059225329_0_slope = o28305059225329_slope((uv), p_o28305059225329_eps, _seed_variation_);
vec2 o28305059225329_0_warp = o28305059225329_0_slope;vec4 o28304975341212_0 = textureLod(texture_1, fract((fract(transform2(((uv)+p_o28305059225329_amount*o28305059225329_0_warp), vec2((elapsed_time * 0.25)*(2.0*1.0-1.0), p_o28305025669534_translate_y*(2.0*1.0-1.0)), p_o28305025669534_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305025669534_scale_x*(2.0*1.0-1.0), p_o28305025669534_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_11 (o28305025669534)
vec4 o28305025669534_0_1_rgba = o28304975341212_0;
// #output0: warp_11 (o28305059225329)
vec4 o28305059225329_0_1_rgba = o28305025669534_0_1_rgba;
// #output0: decompose_3 (o28305126333084)
float o28305126333084_0_1_f = o28305059225329_0_1_rgba.r;
// #code: warp (o28287275374247)
vec2 o28287275374247_0_slope = o28287275374247_slope((uv), p_o28287275374247_eps, _seed_variation_);
vec2 o28287275374247_0_warp = o28287275374247_0_slope;vec4 o28287174707900_0 = textureLod(texture_2, fract((fract(transform2(((uv)+p_o28287275374247_amount*o28287275374247_0_warp), vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), p_o28287225038709_translate_y*(2.0*1.0-1.0)), p_o28287225038709_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28287225038709_scale_x*(2.0*1.0-1.0), p_o28287225038709_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_3 (o28287225038709)
vec4 o28287225038709_0_1_rgba = o28287174707900_0;
// #output0: warp (o28287275374247)
vec4 o28287275374247_0_1_rgba = o28287225038709_0_1_rgba;
// #output0: decompose_2 (o28293650715857)
float o28293650715857_0_1_f = o28287275374247_0_1_rgba.r;
// #code: blend2_16 (o28305159886489)
vec4 o28305159886489_0_b = vec4(vec3(o28293650715857_0_1_f), 1.0);
vec4 o28305159886489_0_l;
float o28305159886489_0_a;
o28305159886489_0_l = vec4(vec3(o28305126333084_0_1_f), 1.0);
o28305159886489_0_a = p_o28305159886489_amount1*(dot((o28305193441951_0_1_rgba).rgb, vec3(1.0))/3.0);
o28305159886489_0_b = vec4(blend_multiply(uv, o28305159886489_0_l.rgb, o28305159886489_0_b.rgb, o28305159886489_0_a*o28305159886489_0_l.a), min(1.0, o28305159886489_0_b.a+o28305159886489_0_a*o28305159886489_0_l.a));
// #output0: blend2_16 (o28305159886489)
vec4 o28305159886489_0_1_rgba = o28305159886489_0_b;
return (dot((o28305159886489_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: normal_map2/edge_detect_1 (o28278249236025)
vec3 nm_o28278249236025(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (0 == 0) {
		rv = vec2(1.0, -1.0)*o28278249236025_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o28278249236025_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o28278249236025_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o28278249236025_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o28278249236025_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o28278249236025_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o28278249236025_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o28278249236025_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (0 == 1) {
		rv = vec2(3.0, -3.0)*o28278249236025_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o28278249236025_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o28278249236025_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o28278249236025_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o28278249236025_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o28278249236025_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o28278249236025_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o28278249236025_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (0 == 2) {
		rv = vec2(2.0, 0.0)*o28278249236025_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o28278249236025_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o28278249236025_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o28278249236025_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o28278249236025_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o28278249236025_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o28278249236025_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
float o28293499717879_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3_7 (o28287241820405)
float o28287241820405_0_1_f = fbm_2d_value((fract(transform2(uv, vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), (elapsed_time * 0.1)*(2.0*1.0-1.0)), p_o28293482941440_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28293482941440_scale_x*(2.0*1.0-1.0), p_o28293482941440_scale_y*(2.0*1.0-1.0))))), vec2(p_o28287241820405_scale_x, p_o28287241820405_scale_y), int(p_o28287241820405_folds), int(p_o28287241820405_iterations), p_o28287241820405_persistence, p_o28287241820405_offset, (seed_o28287241820405+fract(_seed_variation_)));
// #output0: transform2_8 (o28293482941440)
vec4 o28293482941440_0_1_rgba = vec4(vec3(o28287241820405_0_1_f), 1.0);
return (dot((o28293482941440_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp_8 (o28293499717879)
vec2 o28293499717879_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o28293499717879_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o28293499717879_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o28293499717879_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o28293499717879_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec4 o28305361214934_gradient_gradient_fct(float x) {
  if (x < p_o28305361214934_gradient_pos[0]) {
    return p_o28305361214934_gradient_col[0];
  } else if (x < p_o28305361214934_gradient_pos[1]) {
    return mix(p_o28305361214934_gradient_col[0], p_o28305361214934_gradient_col[1], ((x-p_o28305361214934_gradient_pos[0])/(p_o28305361214934_gradient_pos[1]-p_o28305361214934_gradient_pos[0])));
  } else if (x < p_o28305361214934_gradient_pos[2]) {
    return mix(p_o28305361214934_gradient_col[1], p_o28305361214934_gradient_col[2], ((x-p_o28305361214934_gradient_pos[1])/(p_o28305361214934_gradient_pos[2]-p_o28305361214934_gradient_pos[1])));
  }
  return p_o28305361214934_gradient_col[2];
}
vec4 o28302676857234_gradient_gradient_fct(float x) {
  if (x < p_o28302676857234_gradient_pos[0]) {
    return p_o28302676857234_gradient_col[0];
  } else if (x < p_o28302676857234_gradient_pos[1]) {
    return mix(p_o28302676857234_gradient_col[0], p_o28302676857234_gradient_col[1], ((x-p_o28302676857234_gradient_pos[0])/(p_o28302676857234_gradient_pos[1]-p_o28302676857234_gradient_pos[0])));
  } else if (x < p_o28302676857234_gradient_pos[2]) {
    return mix(p_o28302676857234_gradient_col[1], p_o28302676857234_gradient_col[2], ((x-p_o28302676857234_gradient_pos[1])/(p_o28302676857234_gradient_pos[2]-p_o28302676857234_gradient_pos[1])));
  } else if (x < p_o28302676857234_gradient_pos[3]) {
    return mix(p_o28302676857234_gradient_col[2], p_o28302676857234_gradient_col[3], ((x-p_o28302676857234_gradient_pos[2])/(p_o28302676857234_gradient_pos[3]-p_o28302676857234_gradient_pos[2])));
  } else if (x < p_o28302676857234_gradient_pos[4]) {
    return mix(p_o28302676857234_gradient_col[3], p_o28302676857234_gradient_col[4], ((x-p_o28302676857234_gradient_pos[3])/(p_o28302676857234_gradient_pos[4]-p_o28302676857234_gradient_pos[3])));
  } else if (x < p_o28302676857234_gradient_pos[5]) {
    return mix(p_o28302676857234_gradient_col[4], p_o28302676857234_gradient_col[5], ((x-p_o28302676857234_gradient_pos[4])/(p_o28302676857234_gradient_pos[5]-p_o28302676857234_gradient_pos[4])));
  } else if (x < p_o28302676857234_gradient_pos[6]) {
    return mix(p_o28302676857234_gradient_col[5], p_o28302676857234_gradient_col[6], ((x-p_o28302676857234_gradient_pos[5])/(p_o28302676857234_gradient_pos[6]-p_o28302676857234_gradient_pos[5])));
  } else if (x < p_o28302676857234_gradient_pos[7]) {
    return mix(p_o28302676857234_gradient_col[6], p_o28302676857234_gradient_col[7], ((x-p_o28302676857234_gradient_pos[6])/(p_o28302676857234_gradient_pos[7]-p_o28302676857234_gradient_pos[6])));
  } else if (x < p_o28302676857234_gradient_pos[8]) {
    return mix(p_o28302676857234_gradient_col[7], p_o28302676857234_gradient_col[8], ((x-p_o28302676857234_gradient_pos[7])/(p_o28302676857234_gradient_pos[8]-p_o28302676857234_gradient_pos[7])));
  } else if (x < p_o28302676857234_gradient_pos[9]) {
    return mix(p_o28302676857234_gradient_col[8], p_o28302676857234_gradient_col[9], ((x-p_o28302676857234_gradient_pos[8])/(p_o28302676857234_gradient_pos[9]-p_o28302676857234_gradient_pos[8])));
  } else if (x < p_o28302676857234_gradient_pos[10]) {
    return mix(p_o28302676857234_gradient_col[9], p_o28302676857234_gradient_col[10], ((x-p_o28302676857234_gradient_pos[9])/(p_o28302676857234_gradient_pos[10]-p_o28302676857234_gradient_pos[9])));
  } else if (x < p_o28302676857234_gradient_pos[11]) {
    return mix(p_o28302676857234_gradient_col[10], p_o28302676857234_gradient_col[11], ((x-p_o28302676857234_gradient_pos[10])/(p_o28302676857234_gradient_pos[11]-p_o28302676857234_gradient_pos[10])));
  } else if (x < p_o28302676857234_gradient_pos[12]) {
    return mix(p_o28302676857234_gradient_col[11], p_o28302676857234_gradient_col[12], ((x-p_o28302676857234_gradient_pos[11])/(p_o28302676857234_gradient_pos[12]-p_o28302676857234_gradient_pos[11])));
  } else if (x < p_o28302676857234_gradient_pos[13]) {
    return mix(p_o28302676857234_gradient_col[12], p_o28302676857234_gradient_col[13], ((x-p_o28302676857234_gradient_pos[12])/(p_o28302676857234_gradient_pos[13]-p_o28302676857234_gradient_pos[12])));
  } else if (x < p_o28302676857234_gradient_pos[14]) {
    return mix(p_o28302676857234_gradient_col[13], p_o28302676857234_gradient_col[14], ((x-p_o28302676857234_gradient_pos[13])/(p_o28302676857234_gradient_pos[14]-p_o28302676857234_gradient_pos[13])));
  } else if (x < p_o28302676857234_gradient_pos[15]) {
    return mix(p_o28302676857234_gradient_col[14], p_o28302676857234_gradient_col[15], ((x-p_o28302676857234_gradient_pos[14])/(p_o28302676857234_gradient_pos[15]-p_o28302676857234_gradient_pos[14])));
  }
  return p_o28302676857234_gradient_col[15];
}
float o28302609750856_input_d(vec2 uv, float _seed_variation_) {
// #code: warp (o28287275374247)
vec2 o28287275374247_0_slope = o28287275374247_slope((uv), p_o28287275374247_eps, _seed_variation_);
vec2 o28287275374247_0_warp = o28287275374247_0_slope;vec4 o28287174707900_0 = textureLod(texture_2, fract((fract(transform2(((uv)+p_o28287275374247_amount*o28287275374247_0_warp), vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), p_o28287225038709_translate_y*(2.0*1.0-1.0)), p_o28287225038709_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28287225038709_scale_x*(2.0*1.0-1.0), p_o28287225038709_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_3 (o28287225038709)
vec4 o28287225038709_0_1_rgba = o28287174707900_0;
// #output0: warp (o28287275374247)
vec4 o28287275374247_0_1_rgba = o28287225038709_0_1_rgba;
// #output1: decompose_2 (o28293650715857)
float o28293650715857_1_1_f = o28287275374247_0_1_rgba.g;
return o28293650715857_1_1_f;
}
// #instance: warp_10 (o28302609750856)
vec2 o28302609750856_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o28302609750856_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o28302609750856_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o28302609750856_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o28302609750856_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec3 o28302072878933_input_in(vec2 uv, float _seed_variation_) {
float o28302139988525_0 = textureLod(texture_4, fract(uv), 0.0).r;
return vec3(o28302139988525_0);
}
// #instance: classic_kuwahara/shader_1 (o28302072878933)
// License: GPLv3 / Jan Eric Kyprianidis <www.kyprianidis.com>
// Source: https://code.google.com/archive/p/gpuakf/
vec3 o28302072878933_classic_kuwahara(vec2 uv, int radius, float _seed_variation_) {
	float n = float((radius + 1) * (radius + 1));
	vec3 col = vec3(0.0);
	vec3 m[4];
	vec3 s[4];
	for (int k = 0; k < 4; ++k) {
	  m[k] = vec3(0.0);
	  s[k] = vec3(0.0);
	}
	for (int j = -radius; j <= 0; ++j)  {
		for (int i = -radius; i <= 0; ++i)  {
		   vec3 c = o28302072878933_input_in((uv + vec2(float(i),float(j)) * 1.0/1024.0), _seed_variation_).rgb;
		   m[0] += c;
		   s[0] += c * c;
		}
	}
	for (int j = -radius; j <= 0; ++j)  {
		for (int i = 0; i <= radius; ++i)  {
			vec3 c = o28302072878933_input_in((uv + vec2(float(i),float(j)) * 1.0/1024.0), _seed_variation_).rgb;
			m[1] += c;
			s[1] += c * c;
		}
	}
	for (int j = 0; j <= radius; ++j)  {
		for (int i = 0; i <= radius; ++i)  {
		   vec3 c = o28302072878933_input_in((uv + vec2(float(i),float(j)) * 1.0/1024.0), _seed_variation_).rgb;
		   m[2] += c;
		   s[2] += c * c;
		}
	}
	for (int j = 0; j <= radius; ++j)  {
		for (int i = -radius; i <= 0; ++i)  {
			vec3 c = o28302072878933_input_in((uv + vec2(float(i),float(j)) * 1.0/1024.0), _seed_variation_).rgb;
			m[3] += c;
			s[3] += c * c;
		}
	}
	float min_sigma2 = 1e+2;
	for (int k = 0; k < 4; ++k) {
		m[k] /= n;
		s[k] = abs(s[k] / n - m[k] * m[k]);
		float sigma2 = s[k].r + s[k].g + s[k].b;
		if (sigma2 < min_sigma2) {
			min_sigma2 = sigma2;
			col = m[k];
		}
	}
	return col;
}
float o28302408420943_input_d(vec2 uv, float _seed_variation_) {
// #output0: classic_kuwahara/shader_1 (o28302072878933)
vec3 o28302072878933_0_1_rgb = o28302072878933_classic_kuwahara((fract(transform2(uv, vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), (elapsed_time * 0.03)*(2.0*1.0-1.0)), p_o28302475532290_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28302475532290_scale_x*(2.0*1.0-1.0), p_o28302475532290_scale_y*(2.0*1.0-1.0))))), int(max(p_o28302072878933_size,0.0)), _seed_variation_);
// #output0: transform2_9 (o28302475532290)
vec4 o28302475532290_0_1_rgba = vec4(o28302072878933_0_1_rgb, 1.0);
return (dot((o28302475532290_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp_9 (o28302408420943)
vec2 o28302408420943_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o28302408420943_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o28302408420943_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o28302408420943_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o28302408420943_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
vec4 o28279457189883_gradient_gradient_fct(float x) {
  if (x < p_o28279457189883_gradient_pos[0]) {
    return p_o28279457189883_gradient_col[0];
  } else if (x < p_o28279457189883_gradient_pos[1]) {
    return mix(p_o28279457189883_gradient_col[0], p_o28279457189883_gradient_col[1], ((x-p_o28279457189883_gradient_pos[0])/(p_o28279457189883_gradient_pos[1]-p_o28279457189883_gradient_pos[0])));
  }
  return p_o28279457189883_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: normal_map2/edge_detect_1 (o28278249236025)
vec3 o28278249236025_0_1_rgb = nm_o28278249236025((uv), p_o28278249236025_amount, 1024.0, _seed_variation_);

// #code: warp_8 (o28293499717879)
vec2 o28293499717879_0_slope = o28293499717879_slope((uv), p_o28293499717879_eps, _seed_variation_);
vec2 o28293499717879_0_warp = o28293499717879_0_slope;vec4 o28293382281156_0 = textureLod(texture_3, fract((fract(transform2(((uv)+p_o28293499717879_amount*o28293499717879_0_warp), vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), p_o28293466167083_translate_y*(2.0*1.0-1.0)), p_o28293466167083_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28293466167083_scale_x*(2.0*1.0-1.0), p_o28293466167083_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_7 (o28293466167083)
vec4 o28293466167083_0_1_rgba = o28293382281156_0;

// #output0: warp_8 (o28293499717879)
vec4 o28293499717879_0_1_rgba = o28293466167083_0_1_rgba;

// #output2: decompose (o28293600383388)
float o28293600383388_2_1_f = o28293499717879_0_1_rgba.b;

// #output0: invert_3 (o28305629652647)
vec4 o28305629652647_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o28293600383388_2_1_f), 1.0).rgb, vec4(vec3(o28293600383388_2_1_f), 1.0).a);

// #output1: decompose (o28293600383388)
float o28293600383388_1_2_f = o28293499717879_0_1_rgba.g;

// #output0: colorize_4 (o28305361214934)
vec4 o28305361214934_0_1_rgba = o28305361214934_gradient_gradient_fct(o28293600383388_1_2_f);

// #code: blend2_21 (o28305763868004)
vec4 o28305763868004_0_b = o28305361214934_0_1_rgba;
vec4 o28305763868004_0_l;
float o28305763868004_0_a;

o28305763868004_0_l = o28305629652647_0_1_rgba;
o28305763868004_0_a = p_o28305763868004_amount1*1.0;
o28305763868004_0_b = vec4(blend_overlay((uv), o28305763868004_0_l.rgb, o28305763868004_0_b.rgb, o28305763868004_0_a*o28305763868004_0_l.a), min(1.0, o28305763868004_0_b.a+o28305763868004_0_a*o28305763868004_0_l.a));
// #output0: blend2_21 (o28305763868004)
vec4 o28305763868004_0_1_rgba = o28305763868004_0_b;

// #output0: brightness_contrast (o28305780643945)
vec4 o28305780643945_0_1_rgba = vec4(clamp(o28305763868004_0_1_rgba.rgb*p_o28305780643945_contrast+vec3(p_o28305780643945_brightness)+0.5-p_o28305780643945_contrast*0.5, vec3(0.0), vec3(1.0)), o28305763868004_0_1_rgba.a);

// #output0: fbm3_10 (o28305210216698)
float o28305210216698_0_1_f = fbm_2d_perlin((fract(transform2((uv), vec2((elapsed_time * 0.13)*(2.0*1.0-1.0), (elapsed_time * 0.03)*(2.0*1.0-1.0)), p_o28305696757866_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305696757866_scale_x*(2.0*1.0-1.0), p_o28305696757866_scale_y*(2.0*1.0-1.0))))), vec2(p_o28305210216698_scale_x, p_o28305210216698_scale_y), int(p_o28305210216698_folds), int(p_o28305210216698_iterations), p_o28305210216698_persistence, p_o28305210216698_offset, (seed_o28305210216698+fract(_seed_variation_)));

// #output0: transform2_14 (o28305696757866)
vec4 o28305696757866_0_1_rgba = vec4(vec3(o28305210216698_0_1_f), 1.0);

// #output0: tones_6 (o28305713531272)
vec4 o28305713531272_0_1_rgba = adjust_levels(o28305696757866_0_1_rgba, p_o28305713531272_in_min, p_o28305713531272_in_mid, p_o28305713531272_in_max, p_o28305713531272_out_min, p_o28305713531272_out_max);

// #code: warp (o28287275374247)
vec2 o28287275374247_0_slope = o28287275374247_slope((uv), p_o28287275374247_eps, _seed_variation_);
vec2 o28287275374247_0_warp = o28287275374247_0_slope;vec4 o28287174707900_0 = textureLod(texture_2, fract((fract(transform2(((uv)+p_o28287275374247_amount*o28287275374247_0_warp), vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), p_o28287225038709_translate_y*(2.0*1.0-1.0)), p_o28287225038709_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28287225038709_scale_x*(2.0*1.0-1.0), p_o28287225038709_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_3 (o28287225038709)
vec4 o28287225038709_0_1_rgba = o28287174707900_0;

// #output0: warp (o28287275374247)
vec4 o28287275374247_0_1_rgba = o28287225038709_0_1_rgba;

// #output0: decompose_2 (o28293650715857)
float o28293650715857_0_1_f = o28287275374247_0_1_rgba.r;

// #output0: tones_5 (o28305663206848)
vec4 o28305663206848_0_1_rgba = adjust_levels(vec4(vec3(o28293650715857_0_1_f), 1.0), p_o28305663206848_in_min, p_o28305663206848_in_mid, p_o28305663206848_in_max, p_o28305663206848_out_min, p_o28305663206848_out_max);

// #code: blend2_20 (o28305679978295)
vec4 o28305679978295_0_b = o28305663206848_0_1_rgba;
vec4 o28305679978295_0_l;
float o28305679978295_0_a;

o28305679978295_0_l = o28305713531272_0_1_rgba;
o28305679978295_0_a = p_o28305679978295_amount1*1.0;
o28305679978295_0_b = vec4(blend_multiply((uv), o28305679978295_0_l.rgb, o28305679978295_0_b.rgb, o28305679978295_0_a*o28305679978295_0_l.a), min(1.0, o28305679978295_0_b.a+o28305679978295_0_a*o28305679978295_0_l.a));
// #output0: blend2_20 (o28305679978295)
vec4 o28305679978295_0_1_rgba = o28305679978295_0_b;

// #output0: uniform_3 (o28305612867540)
vec4 o28305612867540_0_1_rgba = p_o28305612867540_color;

// #output0: fbm3_10 (o28305210216698)
float o28305210216698_0_3_f = fbm_2d_perlin((fract(transform2((uv), vec2((-elapsed_time * 0.16)*(2.0*1.0-1.0), (elapsed_time * 0.03)*(2.0*1.0-1.0)), p_o28305226996376_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305226996376_scale_x*(2.0*1.0-1.0), p_o28305226996376_scale_y*(2.0*1.0-1.0))))), vec2(p_o28305210216698_scale_x, p_o28305210216698_scale_y), int(p_o28305210216698_folds), int(p_o28305210216698_iterations), p_o28305210216698_persistence, p_o28305210216698_offset, (seed_o28305210216698+fract(_seed_variation_)));

// #output0: transform2_13 (o28305226996376)
vec4 o28305226996376_0_1_rgba = vec4(vec3(o28305210216698_0_3_f), 1.0);

// #output0: tones_4 (o28305193441951)
vec4 o28305193441951_0_1_rgba = adjust_levels(o28305226996376_0_1_rgba, p_o28305193441951_in_min, p_o28305193441951_in_mid, p_o28305193441951_in_max, p_o28305193441951_out_min, p_o28305193441951_out_max);

// #code: warp_11 (o28305059225329)
vec2 o28305059225329_0_slope = o28305059225329_slope((uv), p_o28305059225329_eps, _seed_variation_);
vec2 o28305059225329_0_warp = o28305059225329_0_slope;vec4 o28304975341212_0 = textureLod(texture_1, fract((fract(transform2(((uv)+p_o28305059225329_amount*o28305059225329_0_warp), vec2((elapsed_time * 0.25)*(2.0*1.0-1.0), p_o28305025669534_translate_y*(2.0*1.0-1.0)), p_o28305025669534_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28305025669534_scale_x*(2.0*1.0-1.0), p_o28305025669534_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_11 (o28305025669534)
vec4 o28305025669534_0_1_rgba = o28304975341212_0;

// #output0: warp_11 (o28305059225329)
vec4 o28305059225329_0_1_rgba = o28305025669534_0_1_rgba;

// #output0: decompose_3 (o28305126333084)
float o28305126333084_0_1_f = o28305059225329_0_1_rgba.r;

// #output0: tones_7 (o28305747089203)
vec4 o28305747089203_0_1_rgba = adjust_levels(vec4(vec3(o28305126333084_0_1_f), 1.0), p_o28305747089203_in_min, p_o28305747089203_in_mid, p_o28305747089203_in_max, p_o28305747089203_out_min, p_o28305747089203_out_max);

// #code: blend2_18 (o28305277331081)
vec4 o28305277331081_0_b = o28305747089203_0_1_rgba;
vec4 o28305277331081_0_l;
float o28305277331081_0_a;

o28305277331081_0_l = o28305193441951_0_1_rgba;
o28305277331081_0_a = p_o28305277331081_amount1*1.0;
o28305277331081_0_b = vec4(blend_multiply((uv), o28305277331081_0_l.rgb, o28305277331081_0_b.rgb, o28305277331081_0_a*o28305277331081_0_l.a), min(1.0, o28305277331081_0_b.a+o28305277331081_0_a*o28305277331081_0_l.a));
// #output0: blend2_18 (o28305277331081)
vec4 o28305277331081_0_1_rgba = o28305277331081_0_b;

// #output0: uniform_2 (o28305260546652)
vec4 o28305260546652_0_1_rgba = p_o28305260546652_color;

// #output0: fbm3_9 (o28304874674418)
float o28304874674418_0_1_f = fbm_2d_value((fract(transform2((uv), vec2((elapsed_time * 0.16)*(2.0*1.0-1.0), (-elapsed_time * 0.03)*(2.0*1.0-1.0)), p_o28304908225341_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28304908225341_scale_x*(2.0*1.0-1.0), p_o28304908225341_scale_y*(2.0*1.0-1.0))))), vec2(p_o28304874674418_scale_x, p_o28304874674418_scale_y), int(p_o28304874674418_folds), int(p_o28304874674418_iterations), p_o28304874674418_persistence, p_o28304874674418_offset, (seed_o28304874674418+fract(_seed_variation_)));

// #output0: transform2_10 (o28304908225341)
vec4 o28304908225341_0_1_rgba = vec4(vec3(o28304874674418_0_1_f), 1.0);

// #output0: tones_3 (o28304891452541)
vec4 o28304891452541_0_1_rgba = adjust_levels(o28304908225341_0_1_rgba, p_o28304891452541_in_min, p_o28304891452541_in_mid, p_o28304891452541_in_max, p_o28304891452541_out_min, p_o28304891452541_out_max);

// #output3: decompose (o28293600383388)
float o28293600383388_3_3_f = o28293499717879_0_1_rgba.a;

// #code: blend2_14 (o28304857898672)
vec4 o28304857898672_0_b = vec4(vec3(o28293600383388_3_3_f), 1.0);
vec4 o28304857898672_0_l;
float o28304857898672_0_a;

o28304857898672_0_l = o28304891452541_0_1_rgba;
o28304857898672_0_a = p_o28304857898672_amount1*1.0;
o28304857898672_0_b = vec4(blend_multiply((uv), o28304857898672_0_l.rgb, o28304857898672_0_b.rgb, o28304857898672_0_a*o28304857898672_0_l.a), min(1.0, o28304857898672_0_b.a+o28304857898672_0_a*o28304857898672_0_l.a));
// #output0: blend2_14 (o28304857898672)
vec4 o28304857898672_0_1_rgba = o28304857898672_0_b;

// #code: warp_10 (o28302609750856)
vec2 o28302609750856_0_slope = o28302609750856_slope((uv), p_o28302609750856_eps, _seed_variation_);
vec2 o28302609750856_0_warp = o28302609750856_0_slope;
// #code: warp (o28287275374247)
vec2 o28287275374247_2_slope = o28287275374247_slope(((uv)+p_o28302609750856_amount*o28302609750856_0_warp), p_o28287275374247_eps, _seed_variation_);
vec2 o28287275374247_2_warp = o28287275374247_2_slope;vec4 o28287174707900_1 = textureLod(texture_2, fract((fract(transform2((((uv)+p_o28302609750856_amount*o28302609750856_0_warp)+p_o28287275374247_amount*o28287275374247_2_warp), vec2((elapsed_time * 0.1)*(2.0*1.0-1.0), p_o28287225038709_translate_y*(2.0*1.0-1.0)), p_o28287225038709_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o28287225038709_scale_x*(2.0*1.0-1.0), p_o28287225038709_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_3 (o28287225038709)
vec4 o28287225038709_0_3_rgba = o28287174707900_1;

// #output0: warp (o28287275374247)
vec4 o28287275374247_0_3_rgba = o28287225038709_0_3_rgba;

// #output3: decompose_2 (o28293650715857)
float o28293650715857_3_3_f = o28287275374247_0_3_rgba.a;

// #output0: warp_10 (o28302609750856)
vec4 o28302609750856_0_1_rgba = vec4(vec3(o28293650715857_3_3_f), 1.0);

// #output0: colorize_3 (o28302676857234)
vec4 o28302676857234_0_1_rgba = o28302676857234_gradient_gradient_fct((dot((o28302609750856_0_1_rgba).rgb, vec3(1.0))/3.0));

// #output2: decompose_2 (o28293650715857)
float o28293650715857_2_4_f = o28287275374247_0_1_rgba.b;

// #code: warp_9 (o28302408420943)
vec2 o28302408420943_0_slope = o28302408420943_slope((uv), p_o28302408420943_eps, _seed_variation_);
vec2 o28302408420943_0_warp = o28302408420943_0_slope;
// #output0: classic_kuwahara/shader_1 (o28302072878933)
vec3 o28302072878933_0_1_rgb = o28302072878933_classic_kuwahara(((uv)+p_o28302408420943_amount*o28302408420943_0_warp), int(max(p_o28302072878933_size,0.0)), _seed_variation_);

// #output0: warp_9 (o28302408420943)
vec4 o28302408420943_0_1_rgba = vec4(o28302072878933_0_1_rgb, 1.0);

// #code: blend2_13 (o28302525864730)
vec4 o28302525864730_0_b = o28302408420943_0_1_rgba;
vec4 o28302525864730_0_l;
float o28302525864730_0_a;

o28302525864730_0_l = vec4(vec3(o28293650715857_2_4_f), 1.0);
o28302525864730_0_a = p_o28302525864730_amount1*1.0;
o28302525864730_0_b = vec4(blend_multiply((uv), o28302525864730_0_l.rgb, o28302525864730_0_b.rgb, o28302525864730_0_a*o28302525864730_0_l.a), min(1.0, o28302525864730_0_b.a+o28302525864730_0_a*o28302525864730_0_l.a));
// #output0: blend2_13 (o28302525864730)
vec4 o28302525864730_0_1_rgba = o28302525864730_0_b;

// #output0: tones_2 (o28302542637174)
vec4 o28302542637174_0_1_rgba = adjust_levels(o28302525864730_0_1_rgba, p_o28302542637174_in_min, p_o28302542637174_in_mid, p_o28302542637174_in_max, p_o28302542637174_out_min, p_o28302542637174_out_max);

// #output0: uniform (o28302492310391)
vec4 o28302492310391_0_1_rgba = p_o28302492310391_color;

// #output0: colorize (o28279457189883)
vec4 o28279457189883_0_1_rgba = o28279457189883_gradient_gradient_fct(o28293650715857_0_1_f);

// #code: blend2_12 (o28293667490886)
vec4 o28293667490886_0_b = o28279457189883_0_1_rgba;
vec4 o28293667490886_0_l;
float o28293667490886_0_a;

o28293667490886_0_l = o28302492310391_0_1_rgba;
o28293667490886_0_a = p_o28293667490886_amount1*(dot((o28302542637174_0_1_rgba).rgb, vec3(1.0))/3.0);
o28293667490886_0_b = vec4(blend_normal((uv), o28293667490886_0_l.rgb, o28293667490886_0_b.rgb, o28293667490886_0_a*o28293667490886_0_l.a), min(1.0, o28293667490886_0_b.a+o28293667490886_0_a*o28293667490886_0_l.a));
// #output0: blend2_12 (o28293667490886)
vec4 o28293667490886_0_1_rgba = o28293667490886_0_b;

// #code: blend2_11 (o28303129843993)
vec4 o28303129843993_0_b = o28293667490886_0_1_rgba;
vec4 o28303129843993_0_l;
float o28303129843993_0_a;

o28303129843993_0_l = o28302676857234_0_1_rgba;
o28303129843993_0_a = p_o28303129843993_amount1*1.0;
o28303129843993_0_b = vec4(blend_hue((uv), o28303129843993_0_l.rgb, o28303129843993_0_b.rgb, o28303129843993_0_a*o28303129843993_0_l.a), min(1.0, o28303129843993_0_b.a+o28303129843993_0_a*o28303129843993_0_l.a));
// #output0: blend2_11 (o28303129843993)
vec4 o28303129843993_0_1_rgba = o28303129843993_0_b;

// #code: blend2_15 (o28304925006104)
vec4 o28304925006104_0_b = o28303129843993_0_1_rgba;
vec4 o28304925006104_0_l;
float o28304925006104_0_a;

o28304925006104_0_l = o28304857898672_0_1_rgba;
o28304925006104_0_a = p_o28304925006104_amount1*1.0;
o28304925006104_0_b = vec4(blend_lighten((uv), o28304925006104_0_l.rgb, o28304925006104_0_b.rgb, o28304925006104_0_a*o28304925006104_0_l.a), min(1.0, o28304925006104_0_b.a+o28304925006104_0_a*o28304925006104_0_l.a));
// #output0: blend2_15 (o28304925006104)
vec4 o28304925006104_0_1_rgba = o28304925006104_0_b;

// #code: blend2_17 (o28305243769347)
vec4 o28305243769347_0_b = o28304925006104_0_1_rgba;
vec4 o28305243769347_0_l;
float o28305243769347_0_a;

o28305243769347_0_l = o28305260546652_0_1_rgba;
o28305243769347_0_a = p_o28305243769347_amount1*(dot((o28305277331081_0_1_rgba).rgb, vec3(1.0))/3.0);
o28305243769347_0_b = vec4(blend_hue((uv), o28305243769347_0_l.rgb, o28305243769347_0_b.rgb, o28305243769347_0_a*o28305243769347_0_l.a), min(1.0, o28305243769347_0_b.a+o28305243769347_0_a*o28305243769347_0_l.a));
// #output0: blend2_17 (o28305243769347)
vec4 o28305243769347_0_1_rgba = o28305243769347_0_b;

// #code: blend2_19 (o28305596093633)
vec4 o28305596093633_0_b = o28305243769347_0_1_rgba;
vec4 o28305596093633_0_l;
float o28305596093633_0_a;

o28305596093633_0_l = o28305612867540_0_1_rgba;
o28305596093633_0_a = p_o28305596093633_amount1*(dot((o28305679978295_0_1_rgba).rgb, vec3(1.0))/3.0);
o28305596093633_0_b = vec4(blend_normal((uv), o28305596093633_0_l.rgb, o28305596093633_0_b.rgb, o28305596093633_0_a*o28305596093633_0_l.a), min(1.0, o28305596093633_0_b.a+o28305596093633_0_a*o28305596093633_0_l.a));
// #output0: blend2_19 (o28305596093633)
vec4 o28305596093633_0_1_rgba = o28305596093633_0_b;

	vec3 albedo_tex = ((o28305596093633_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o28278131789586_albedo_color.rgb;
	METALLIC = 1.0*p_o28278131789586_metallic;
	ROUGHNESS = (dot((o28305780643945_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o28278131789586_roughness;
	NORMAL_MAP = o28278249236025_0_1_rgb;
	NORMAL_MAP_DEPTH = p_o28278131789586_normal;
	EMISSION = vec3(0.0)*p_o28278131789586_emission_energy;
}



