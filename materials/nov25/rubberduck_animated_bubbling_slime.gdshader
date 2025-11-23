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
const vec4 p_o29269950468240_albedo_color = vec4(0.464843750, 1.000000000, 0.711517334, 1.000000000);
const float p_o29269950468240_metallic = 0.000000000;
const float p_o29269950468240_roughness = 1.000000000;
const float p_o29269950468240_emission_energy = 1.000000000;
const float p_o29269950468240_normal = 1.400000000;
const float p_o29269950468240_ao = 1.000000000;
const float p_o29269950468240_depth_scale = 0.310000000;
const float p_o29310752658685_amount1 = 0.690000000;
const float p_o29294310987927_rotate = 0.000000000;
const float p_o29294310987927_scale_x = 1.000000000;
const float p_o29294310987927_scale_y = 1.000000000;
uniform sampler2D texture_1;
const float texture_1_size = 2048.000000000;
const float p_o29312145170225_default_in1 = 0.000000000;
const float p_o29312145170225_default_in2 = 1.000000000;
const float p_o29312161945529_curve_0_x = 0.000000000;
const float p_o29312161945529_curve_0_y = 0.000000000;
const float p_o29312161945529_curve_0_ls = 0.000000000;
const float p_o29312161945529_curve_0_rs = 4.000000000;
const float p_o29312161945529_curve_1_x = 0.292892992;
const float p_o29312161945529_curve_1_y = 0.707107008;
const float p_o29312161945529_curve_1_ls = 1.000000000;
const float p_o29312161945529_curve_1_rs = 1.000000000;
const float p_o29312161945529_curve_2_x = 1.000000000;
const float p_o29312161945529_curve_2_y = 1.000000000;
const float p_o29312161945529_curve_2_ls = 0.000000000;
const float p_o29312161945529_curve_2_rs = 0.000000000;
const float p_o29314242320509_amount1 = 1.000000000;
const float p_o29310769437481_rotate = 0.000000000;
const float p_o29310769437481_scale_x = 1.000000000;
const float p_o29310769437481_scale_y = 1.000000000;
uniform sampler2D texture_2;
const float texture_2_size = 2048.000000000;
const float p_o29312866586521_default_in1 = 0.000000000;
const float p_o29312866586521_default_in2 = 0.000000000;
const float p_o29312849812166_in_min = 0.000000000;
const float p_o29312849812166_in_max = 1.000000000;
const float p_o29312849812166_out_min = -3.000000000;
const float p_o29312849812166_out_max = 1.000000000;
const float p_o29312782700716_default_in1 = 0.000000000;
const float p_o29312782700716_default_in2 = 1.000000000;
const float p_o29312799478701_default_in1 = 0.000000000;
const float p_o29312799478701_default_in2 = 1.000000000;
const float p_o29312833033501_default_in1 = 0.000000000;
const float p_o29312833033501_default_in2 = 1.000000000;
const float p_o29312883362233_default_in1 = 0.000000000;
const float p_o29312883362233_default_in2 = 0.160000000;
const float p_o29309343372618_amount1 = 1.000000000;
const float p_o29312732371653_default_in1 = 0.000000000;
const float p_o29312732371653_default_in2 = 0.830000000;
const float p_o29310819765451_default_in1 = 0.000000000;
const float p_o29310819765451_default_in2 = 1.000000000;
const float p_o29312447160461_curve_0_x = 0.000000000;
const float p_o29312447160461_curve_0_y = 0.000000000;
const float p_o29312447160461_curve_0_ls = 0.000000000;
const float p_o29312447160461_curve_0_rs = 0.748853809;
const float p_o29312447160461_curve_1_x = 0.472484827;
const float p_o29312447160461_curve_1_y = 0.671786904;
const float p_o29312447160461_curve_1_ls = 1.000000166;
const float p_o29312447160461_curve_1_rs = 1.000000166;
const float p_o29312447160461_curve_2_x = 1.000000000;
const float p_o29312447160461_curve_2_y = 1.000000000;
const float p_o29312447160461_curve_2_ls = 0.000000000;
const float p_o29312447160461_curve_2_rs = 0.000000000;
const vec4 p_o29307850202915_in_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o29307850202915_in_mid = vec4(0.500000000, 0.500000000, 0.500000000, 0.500000000);
const vec4 p_o29307850202915_in_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o29307850202915_out_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o29307850202915_out_max = vec4(0.910227597, 0.910227597, 0.910227597, 1.000000000);
const float p_o29287029676955_amount = 0.210000000;
const float p_o29287029676955_eps = 0.100000000;
const float p_o29287012896389_translate_x = 0.000000000;
const float p_o29287012896389_rotate = 0.000000000;
const float p_o29287012896389_scale_x = 1.000000000;
const float p_o29287012896389_scale_y = 1.000000000;
const float seed_o29286996120778 = 0.000000000;
const float p_o29286996120778_scale_x = 2.000000000;
const float p_o29286996120778_scale_y = 2.000000000;
const float p_o29286996120778_folds = 0.000000000;
const float p_o29286996120778_iterations = 5.000000000;
const float p_o29286996120778_persistence = 0.500000000;
const float p_o29286996120778_offset = 0.000000000;
const float p_o29288002754191_rotate = 0.000000000;
const float p_o29288002754191_scale_x = 1.000000000;
const float p_o29288002754191_scale_y = 1.000000000;
uniform sampler2D texture_3;
const float texture_3_size = 2048.000000000;
const float p_o29287197446018_amount = 1.000000000;
const float p_o29315148286470_brightness = 0.520000000;
const float p_o29315148286470_contrast = 1.500000000;
const float p_o29315081181426_amount1 = 1.000000000;
const float p_o29315064400232_value = 0.410000000;
const float p_o29315064400232_width = 0.080000000;
const float p_o29314728855781_amount1 = 0.470000000;
const float p_o29314259093700_gradient_pos[17] = float[]( 0.000000000, 0.129768148, 0.234390572, 0.275426865, 0.304443896, 0.345480174, 0.450102597, 0.595187783, 0.624204814, 0.665241122, 0.706277430, 0.771161497, 0.800178528, 0.865062594, 0.906098902, 0.970982969, 1.000000000 );
const vec4 p_o29314259093700_gradient_col[17] = vec4[]( vec4(0.200000003, 0.596078455, 0.000000000, 1.000000000), vec4(0.341176480, 0.780392170, 0.070588239, 1.000000000), vec4(0.341176480, 0.780392170, 0.070588239, 1.000000000), vec4(0.274509817, 0.741176486, 0.035294119, 1.000000000), vec4(0.282352954, 0.752941191, 0.066666670, 1.000000000), vec4(0.329411775, 0.858823538, 0.141176477, 1.000000000), vec4(0.654901981, 0.913725495, 0.235294119, 1.000000000), vec4(0.474509805, 0.909803927, 0.227450982, 1.000000000), vec4(0.392156869, 0.917647064, 0.200000003, 1.000000000), vec4(0.333333343, 0.905882359, 0.145098045, 1.000000000), vec4(0.313725501, 0.913725495, 0.105882354, 1.000000000), vec4(0.337254912, 0.886274517, 0.070588239, 1.000000000), vec4(0.560784340, 0.964705884, 0.203921571, 1.000000000), vec4(0.560784340, 0.964705884, 0.203921571, 1.000000000), vec4(0.572549045, 0.913725495, 0.164705887, 1.000000000), vec4(0.600000024, 0.933333337, 0.164705887, 1.000000000), vec4(0.600000024, 0.933333337, 0.164705887, 1.000000000) );
const float p_o29280436231452_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o29280436231452_gradient_col[2] = vec4[]( vec4(0.000000000, 0.871093750, 0.176940918, 1.000000000), vec4(0.223878622, 0.902343750, 0.218536377, 1.000000000) );
const float p_o29315014073268_brightness = 0.540000000;
const float p_o29315014073268_contrast = 1.270000000;
const float p_o29314963742550_amount1 = 0.080000000;
const float p_o29307749534604_amount = 0.210000000;
const float p_o29307749534604_eps = 0.100000000;
const float p_o29307732758278_translate_x = 0.000000000;
const float p_o29307732758278_rotate = 0.000000000;
const float p_o29307732758278_scale_x = 1.000000000;
const float p_o29307732758278_scale_y = 1.000000000;
const float seed_o29307816645122 = 0.000000000;
const float p_o29307816645122_scale_x = 2.000000000;
const float p_o29307816645122_scale_y = 2.000000000;
const float p_o29307816645122_folds = 0.000000000;
const float p_o29307816645122_iterations = 5.000000000;
const float p_o29307816645122_persistence = 0.500000000;
const float p_o29307816645122_offset = 0.000000000;
const float p_o29307715981736_rotate = 0.000000000;
const float p_o29307715981736_scale_x = 1.000000000;
const float p_o29307715981736_scale_y = 1.000000000;
uniform sampler2D texture_4;
const float texture_4_size = 2048.000000000;
const float p_o29315097955971_brightness = -0.250000000;
const float p_o29315097955971_contrast = 1.080000000;
const float p_o29314863078245_amount1 = 0.120000000;
const float p_o29314946959876_amount1 = 1.000000000;
const vec4 p_o29314879851368_in_min = vec4(0.700987935, 0.700987935, 0.700987935, 0.000000000);
const vec4 p_o29314879851368_in_mid = vec4(0.853680313, 0.853680313, 0.853680313, 0.500000000);
const vec4 p_o29314879851368_in_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o29314879851368_out_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o29314879851368_out_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o29314896630115_color = vec4(0.831911564, 0.957031250, 0.385055542, 1.000000000);
const float p_o29314846303893_amount1 = 0.540000000;
const float p_o29314779192022_amount1 = 1.000000000;
const vec4 p_o29315181846098_in_min = vec4(0.014483240, 0.014483240, 0.014483240, 0.000000000);
const vec4 p_o29315181846098_in_mid = vec4(0.261026591, 0.261026591, 0.261026591, 0.500000000);
const vec4 p_o29315181846098_in_max = vec4(0.775509715, 0.775509715, 0.775509715, 1.000000000);
const vec4 p_o29315181846098_out_min = vec4(0.000000000, 0.000000000, 0.000000000, 0.000000000);
const vec4 p_o29315181846098_out_max = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const vec4 p_o29315165064570_color = vec4(0.057678223, 0.738281250, 0.195925713, 1.000000000);
// #globals: invert_2 (o29287096784889)
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
// #globals: blend2_9 (o29310752658685)
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
// #globals: transform2_3 (o29294310987927)
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
// #globals: math_2 (o29312145170225)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: tones_2 (o29307850202915)
vec4 adjust_levels(vec4 color, vec4 in_min, vec4 in_mid, vec4 in_max, vec4 out_min, vec4 out_max) {
	color = clamp((color-in_min)/(in_max-in_min), 0.0, 1.0);
	in_mid = (in_mid-in_min)/(in_max-in_min);
	vec4 dark = step(in_mid, color);
	color = 0.5*mix(color/(in_mid), 1.0+(color-in_mid)/(1.0-in_mid), dark);
	return out_min+color*(out_max-out_min);
}
// #globals: fbm3_7 (o29286996120778)
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
// #globals: greyscale (o29315030850915)
float gs_min(vec3 c) {
	return min(c.r, min(c.g, c.b));
}
float gs_max(vec3 c) {
	return max(c.r, max(c.g, c.b));
}
float gs_lightness(vec3 c) {
	return 0.5*(max(c.r, max(c.g, c.b)) + min(c.r, min(c.g, c.b)));
}
float gs_average(vec3 c) {
	return 0.333333333333*(c.r + c.g + c.b);
}
float gs_luminosity(vec3 c) {
	return 0.21 * c.r + 0.72 * c.g + 0.07 * c.b;
}
float o29312161945529_curve_curve_fct(float x) {
if (x <= p_o29312161945529_curve_1_x) {
float dx = x - p_o29312161945529_curve_0_x;
float d = p_o29312161945529_curve_1_x - p_o29312161945529_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o29312161945529_curve_0_y;
float yac = p_o29312161945529_curve_0_y + d*p_o29312161945529_curve_0_rs;
float ybc = p_o29312161945529_curve_1_y - d*p_o29312161945529_curve_1_ls;
float y2 = p_o29312161945529_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o29312161945529_curve_1_x;
float d = p_o29312161945529_curve_2_x - p_o29312161945529_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o29312161945529_curve_1_y;
float yac = p_o29312161945529_curve_1_y + d*p_o29312161945529_curve_1_rs;
float ybc = p_o29312161945529_curve_2_y - d*p_o29312161945529_curve_2_ls;
float y2 = p_o29312161945529_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
float o29312447160461_curve_curve_fct(float x) {
if (x <= p_o29312447160461_curve_1_x) {
float dx = x - p_o29312447160461_curve_0_x;
float d = p_o29312447160461_curve_1_x - p_o29312447160461_curve_0_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o29312447160461_curve_0_y;
float yac = p_o29312447160461_curve_0_y + d*p_o29312447160461_curve_0_rs;
float ybc = p_o29312447160461_curve_1_y - d*p_o29312447160461_curve_1_ls;
float y2 = p_o29312447160461_curve_1_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
{
float dx = x - p_o29312447160461_curve_1_x;
float d = p_o29312447160461_curve_2_x - p_o29312447160461_curve_1_x;
float t = dx/d;
float omt = (1.0 - t);
float omt2 = omt * omt;
float omt3 = omt2 * omt;
float t2 = t * t;
float t3 = t2 * t;
d /= 3.0;
float y1 = p_o29312447160461_curve_1_y;
float yac = p_o29312447160461_curve_1_y + d*p_o29312447160461_curve_1_rs;
float ybc = p_o29312447160461_curve_2_y - d*p_o29312447160461_curve_2_ls;
float y2 = p_o29312447160461_curve_2_y;
return y1*omt3 + yac*omt2*t*3.0 + ybc*omt*t2*3.0 + y2*t3;
}
}
float o29287029676955_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3_7 (o29286996120778)
float o29286996120778_0_1_f = fbm_2d_perlin((fract(transform2(uv, vec2(p_o29287012896389_translate_x*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29287012896389_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29287012896389_scale_x*(2.0*1.0-1.0), p_o29287012896389_scale_y*(2.0*1.0-1.0))))), vec2(p_o29286996120778_scale_x, p_o29286996120778_scale_y), int(p_o29286996120778_folds), int(p_o29286996120778_iterations), p_o29286996120778_persistence, p_o29286996120778_offset, (seed_o29286996120778+fract(_seed_variation_)));
// #output0: transform2_6 (o29287012896389)
vec4 o29287012896389_0_1_rgba = vec4(vec3(o29286996120778_0_1_f), 1.0);
return (dot((o29287012896389_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp_4 (o29287029676955)
vec2 o29287029676955_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o29287029676955_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o29287029676955_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o29287029676955_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o29287029676955_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
float o29269950468240_input_depth_tex(vec2 uv, float _seed_variation_) {
vec4 o29294394871521_0 = textureLod(texture_1, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29294310987927_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29294310987927_scale_x*(2.0*1.0-1.0), p_o29294310987927_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_3 (o29294310987927)
vec4 o29294310987927_0_1_rgba = o29294394871521_0;
// #output3: decompose_2 (o29294461983315)
float o29294461983315_3_1_f = o29294310987927_0_1_rgba.a;
// #output0: invert_3 (o29310735883809)
vec4 o29310735883809_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o29294461983315_3_1_f), 1.0).rgb, vec4(vec3(o29294461983315_3_1_f), 1.0).a);
vec4 o29309293038663_0 = textureLod(texture_2, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29310769437481_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29310769437481_scale_x*(2.0*1.0-1.0), p_o29310769437481_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_9 (o29310769437481)
vec4 o29310769437481_0_1_rgba = o29309293038663_0;
// #output3: decompose_4 (o29310802987072)
float o29310802987072_3_1_f = o29310769437481_0_1_rgba.a;
// #output1: decompose_4 (o29310802987072)
float o29310802987072_1_2_f = o29310769437481_0_1_rgba.g;
// #output0: uniform_greyscale_2 (o29312816253996)
float o29312816253996_0_1_f = (elapsed_time);
// #code: math_8 (o29312883362233)
float o29312883362233_0_clamp_false = o29312816253996_0_1_f*p_o29312883362233_default_in2;
float o29312883362233_0_clamp_true = clamp(o29312883362233_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o29312883362233)
float o29312883362233_0_1_f = o29312883362233_0_clamp_false;
// #code: math_6 (o29312833033501)
float o29312833033501_0_clamp_false = o29312883362233_0_1_f*o29310802987072_1_2_f;
float o29312833033501_0_clamp_true = clamp(o29312833033501_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o29312833033501)
float o29312833033501_0_1_f = o29312833033501_0_clamp_false;
// #output0: decompose_4 (o29310802987072)
float o29310802987072_0_3_f = o29310769437481_0_1_rgba.r;
// #code: math_5 (o29312799478701)
float o29312799478701_0_clamp_false = o29310802987072_0_3_f+o29312833033501_0_1_f;
float o29312799478701_0_clamp_true = clamp(o29312799478701_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o29312799478701)
float o29312799478701_0_1_f = o29312799478701_0_clamp_false;
// #code: math_4 (o29312782700716)
float o29312782700716_0_clamp_false = mod(o29312799478701_0_1_f, p_o29312782700716_default_in2);
float o29312782700716_0_clamp_true = clamp(o29312782700716_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o29312782700716)
float o29312782700716_0_1_f = o29312782700716_0_clamp_false;
// #output0: tones_map (o29312849812166)
vec4 o29312849812166_0_1_rgba = vec4(vec3(p_o29312849812166_out_min)+(vec4(vec3(o29312782700716_0_1_f), 1.0).rgb-vec3(p_o29312849812166_in_min))*vec3((p_o29312849812166_out_max-(p_o29312849812166_out_min))/(p_o29312849812166_in_max-(p_o29312849812166_in_min))), vec4(vec3(o29312782700716_0_1_f), 1.0).a);
// #code: math_7 (o29312866586521)
float o29312866586521_0_clamp_false = (dot((o29312849812166_0_1_rgba).rgb, vec3(1.0))/3.0)+p_o29312866586521_default_in2;
float o29312866586521_0_clamp_true = clamp(o29312866586521_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o29312866586521)
float o29312866586521_0_1_f = o29312866586521_0_clamp_true;
// #code: blend2_10 (o29314242320509)
vec4 o29314242320509_0_b = vec4(vec3(o29312866586521_0_1_f), 1.0);
vec4 o29314242320509_0_l;
float o29314242320509_0_a;
o29314242320509_0_l = vec4(vec3(o29310802987072_3_1_f), 1.0);
o29314242320509_0_a = p_o29314242320509_amount1*1.0;
o29314242320509_0_b = vec4(blend_multiply((uv), o29314242320509_0_l.rgb, o29314242320509_0_b.rgb, o29314242320509_0_a*o29314242320509_0_l.a), min(1.0, o29314242320509_0_b.a+o29314242320509_0_a*o29314242320509_0_l.a));
// #output0: blend2_10 (o29314242320509)
vec4 o29314242320509_0_1_rgba = o29314242320509_0_b;
// #output0: tonality (o29312161945529)
float o29312161945529_0_1_f = o29312161945529_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));
// #code: math_2 (o29312145170225)
float o29312145170225_0_clamp_false = o29294461983315_3_1_f*o29312161945529_0_1_f;
float o29312145170225_0_clamp_true = clamp(o29312145170225_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o29312145170225)
float o29312145170225_0_1_f = o29312145170225_0_clamp_true;
// #output0: tonality_2 (o29312447160461)
float o29312447160461_0_1_f = o29312447160461_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));
// #output1: decompose_2 (o29294461983315)
float o29294461983315_1_2_f = o29294310987927_0_1_rgba.g;
// #code: math (o29310819765451)
float o29310819765451_0_clamp_false = o29294461983315_1_2_f*o29312447160461_0_1_f;
float o29310819765451_0_clamp_true = clamp(o29310819765451_0_clamp_false, 0.0, 1.0);
// #output0: math (o29310819765451)
float o29310819765451_0_1_f = o29310819765451_0_clamp_false;
// #code: math_3 (o29312732371653)
float o29312732371653_0_clamp_false = o29310819765451_0_1_f*p_o29312732371653_default_in2;
float o29312732371653_0_clamp_true = clamp(o29312732371653_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o29312732371653)
float o29312732371653_0_1_f = o29312732371653_0_clamp_false;
// #code: warp_4 (o29287029676955)
vec2 o29287029676955_0_slope = o29287029676955_slope((uv), p_o29287029676955_eps, _seed_variation_);
vec2 o29287029676955_0_warp = o29287029676955_0_slope*(1.0-o29287029676955_input_d((uv), _seed_variation_));vec4 o29286945787794_0 = textureLod(texture_3, fract((fract(transform2(((uv)+p_o29287029676955_amount*o29287029676955_0_warp), vec2((elapsed_time * 0.02)*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29288002754191_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29288002754191_scale_x*(2.0*1.0-1.0), p_o29288002754191_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_4 (o29288002754191)
vec4 o29288002754191_0_1_rgba = o29286945787794_0;
// #output0: warp_4 (o29287029676955)
vec4 o29287029676955_0_1_rgba = o29288002754191_0_1_rgba;
// #output0: decompose (o29294193549215)
float o29294193549215_0_1_f = o29287029676955_0_1_rgba.r;
// #output0: tones_2 (o29307850202915)
vec4 o29307850202915_0_1_rgba = adjust_levels(vec4(vec3(o29294193549215_0_1_f), 1.0), p_o29307850202915_in_min, p_o29307850202915_in_mid, p_o29307850202915_in_max, p_o29307850202915_out_min, p_o29307850202915_out_max);
// #code: blend2_8 (o29309343372618)
vec4 o29309343372618_0_b = o29307850202915_0_1_rgba;
vec4 o29309343372618_0_l;
float o29309343372618_0_a;
o29309343372618_0_l = vec4(vec3(o29312732371653_0_1_f), 1.0);
o29309343372618_0_a = p_o29309343372618_amount1*1.0;
o29309343372618_0_b = vec4(blend_additive((uv), o29309343372618_0_l.rgb, o29309343372618_0_b.rgb, o29309343372618_0_a*o29309343372618_0_l.a), min(1.0, o29309343372618_0_b.a+o29309343372618_0_a*o29309343372618_0_l.a));
// #output0: blend2_8 (o29309343372618)
vec4 o29309343372618_0_1_rgba = o29309343372618_0_b;
// #code: blend2_9 (o29310752658685)
vec4 o29310752658685_0_b = o29309343372618_0_1_rgba;
vec4 o29310752658685_0_l;
float o29310752658685_0_a;
o29310752658685_0_l = vec4(vec3(o29312145170225_0_1_f), 1.0);
o29310752658685_0_a = p_o29310752658685_amount1*(dot((o29310735883809_0_1_rgba).rgb, vec3(1.0))/3.0);
o29310752658685_0_b = vec4(blend_additive((uv), o29310752658685_0_l.rgb, o29310752658685_0_b.rgb, o29310752658685_0_a*o29310752658685_0_l.a), min(1.0, o29310752658685_0_b.a+o29310752658685_0_a*o29310752658685_0_l.a));
// #output0: blend2_9 (o29310752658685)
vec4 o29310752658685_0_1_rgba = o29310752658685_0_b;
// #output0: invert_2 (o29287096784889)
vec4 o29287096784889_0_1_rgba = vec4(vec3(1.0)-o29310752658685_0_1_rgba.rgb, o29310752658685_0_1_rgba.a);
return (dot((o29287096784889_0_1_rgba).rgb, vec3(1.0))/3.0);
}
float o29287197446018_input_in(vec2 uv, float _seed_variation_) {
vec4 o29294394871521_0 = textureLod(texture_1, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29294310987927_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29294310987927_scale_x*(2.0*1.0-1.0), p_o29294310987927_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_3 (o29294310987927)
vec4 o29294310987927_0_1_rgba = o29294394871521_0;
// #output3: decompose_2 (o29294461983315)
float o29294461983315_3_1_f = o29294310987927_0_1_rgba.a;
// #output0: invert_3 (o29310735883809)
vec4 o29310735883809_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o29294461983315_3_1_f), 1.0).rgb, vec4(vec3(o29294461983315_3_1_f), 1.0).a);
vec4 o29309293038663_0 = textureLod(texture_2, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29310769437481_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29310769437481_scale_x*(2.0*1.0-1.0), p_o29310769437481_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_9 (o29310769437481)
vec4 o29310769437481_0_1_rgba = o29309293038663_0;
// #output3: decompose_4 (o29310802987072)
float o29310802987072_3_1_f = o29310769437481_0_1_rgba.a;
// #output1: decompose_4 (o29310802987072)
float o29310802987072_1_2_f = o29310769437481_0_1_rgba.g;
// #output0: uniform_greyscale_2 (o29312816253996)
float o29312816253996_0_1_f = (elapsed_time);
// #code: math_8 (o29312883362233)
float o29312883362233_0_clamp_false = o29312816253996_0_1_f*p_o29312883362233_default_in2;
float o29312883362233_0_clamp_true = clamp(o29312883362233_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o29312883362233)
float o29312883362233_0_1_f = o29312883362233_0_clamp_false;
// #code: math_6 (o29312833033501)
float o29312833033501_0_clamp_false = o29312883362233_0_1_f*o29310802987072_1_2_f;
float o29312833033501_0_clamp_true = clamp(o29312833033501_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o29312833033501)
float o29312833033501_0_1_f = o29312833033501_0_clamp_false;
// #output0: decompose_4 (o29310802987072)
float o29310802987072_0_3_f = o29310769437481_0_1_rgba.r;
// #code: math_5 (o29312799478701)
float o29312799478701_0_clamp_false = o29310802987072_0_3_f+o29312833033501_0_1_f;
float o29312799478701_0_clamp_true = clamp(o29312799478701_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o29312799478701)
float o29312799478701_0_1_f = o29312799478701_0_clamp_false;
// #code: math_4 (o29312782700716)
float o29312782700716_0_clamp_false = mod(o29312799478701_0_1_f, p_o29312782700716_default_in2);
float o29312782700716_0_clamp_true = clamp(o29312782700716_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o29312782700716)
float o29312782700716_0_1_f = o29312782700716_0_clamp_false;
// #output0: tones_map (o29312849812166)
vec4 o29312849812166_0_1_rgba = vec4(vec3(p_o29312849812166_out_min)+(vec4(vec3(o29312782700716_0_1_f), 1.0).rgb-vec3(p_o29312849812166_in_min))*vec3((p_o29312849812166_out_max-(p_o29312849812166_out_min))/(p_o29312849812166_in_max-(p_o29312849812166_in_min))), vec4(vec3(o29312782700716_0_1_f), 1.0).a);
// #code: math_7 (o29312866586521)
float o29312866586521_0_clamp_false = (dot((o29312849812166_0_1_rgba).rgb, vec3(1.0))/3.0)+p_o29312866586521_default_in2;
float o29312866586521_0_clamp_true = clamp(o29312866586521_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o29312866586521)
float o29312866586521_0_1_f = o29312866586521_0_clamp_true;
// #code: blend2_10 (o29314242320509)
vec4 o29314242320509_0_b = vec4(vec3(o29312866586521_0_1_f), 1.0);
vec4 o29314242320509_0_l;
float o29314242320509_0_a;
o29314242320509_0_l = vec4(vec3(o29310802987072_3_1_f), 1.0);
o29314242320509_0_a = p_o29314242320509_amount1*1.0;
o29314242320509_0_b = vec4(blend_multiply((uv), o29314242320509_0_l.rgb, o29314242320509_0_b.rgb, o29314242320509_0_a*o29314242320509_0_l.a), min(1.0, o29314242320509_0_b.a+o29314242320509_0_a*o29314242320509_0_l.a));
// #output0: blend2_10 (o29314242320509)
vec4 o29314242320509_0_1_rgba = o29314242320509_0_b;
// #output0: tonality (o29312161945529)
float o29312161945529_0_1_f = o29312161945529_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));
// #code: math_2 (o29312145170225)
float o29312145170225_0_clamp_false = o29294461983315_3_1_f*o29312161945529_0_1_f;
float o29312145170225_0_clamp_true = clamp(o29312145170225_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o29312145170225)
float o29312145170225_0_1_f = o29312145170225_0_clamp_true;
// #output0: tonality_2 (o29312447160461)
float o29312447160461_0_1_f = o29312447160461_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));
// #output1: decompose_2 (o29294461983315)
float o29294461983315_1_2_f = o29294310987927_0_1_rgba.g;
// #code: math (o29310819765451)
float o29310819765451_0_clamp_false = o29294461983315_1_2_f*o29312447160461_0_1_f;
float o29310819765451_0_clamp_true = clamp(o29310819765451_0_clamp_false, 0.0, 1.0);
// #output0: math (o29310819765451)
float o29310819765451_0_1_f = o29310819765451_0_clamp_false;
// #code: math_3 (o29312732371653)
float o29312732371653_0_clamp_false = o29310819765451_0_1_f*p_o29312732371653_default_in2;
float o29312732371653_0_clamp_true = clamp(o29312732371653_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o29312732371653)
float o29312732371653_0_1_f = o29312732371653_0_clamp_false;
// #code: warp_4 (o29287029676955)
vec2 o29287029676955_0_slope = o29287029676955_slope((uv), p_o29287029676955_eps, _seed_variation_);
vec2 o29287029676955_0_warp = o29287029676955_0_slope*(1.0-o29287029676955_input_d((uv), _seed_variation_));vec4 o29286945787794_0 = textureLod(texture_3, fract((fract(transform2(((uv)+p_o29287029676955_amount*o29287029676955_0_warp), vec2((elapsed_time * 0.02)*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29288002754191_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29288002754191_scale_x*(2.0*1.0-1.0), p_o29288002754191_scale_y*(2.0*1.0-1.0)))))), 0.0);
// #output0: transform2_4 (o29288002754191)
vec4 o29288002754191_0_1_rgba = o29286945787794_0;
// #output0: warp_4 (o29287029676955)
vec4 o29287029676955_0_1_rgba = o29288002754191_0_1_rgba;
// #output0: decompose (o29294193549215)
float o29294193549215_0_1_f = o29287029676955_0_1_rgba.r;
// #output0: tones_2 (o29307850202915)
vec4 o29307850202915_0_1_rgba = adjust_levels(vec4(vec3(o29294193549215_0_1_f), 1.0), p_o29307850202915_in_min, p_o29307850202915_in_mid, p_o29307850202915_in_max, p_o29307850202915_out_min, p_o29307850202915_out_max);
// #code: blend2_8 (o29309343372618)
vec4 o29309343372618_0_b = o29307850202915_0_1_rgba;
vec4 o29309343372618_0_l;
float o29309343372618_0_a;
o29309343372618_0_l = vec4(vec3(o29312732371653_0_1_f), 1.0);
o29309343372618_0_a = p_o29309343372618_amount1*1.0;
o29309343372618_0_b = vec4(blend_additive((uv), o29309343372618_0_l.rgb, o29309343372618_0_b.rgb, o29309343372618_0_a*o29309343372618_0_l.a), min(1.0, o29309343372618_0_b.a+o29309343372618_0_a*o29309343372618_0_l.a));
// #output0: blend2_8 (o29309343372618)
vec4 o29309343372618_0_1_rgba = o29309343372618_0_b;
// #code: blend2_9 (o29310752658685)
vec4 o29310752658685_0_b = o29309343372618_0_1_rgba;
vec4 o29310752658685_0_l;
float o29310752658685_0_a;
o29310752658685_0_l = vec4(vec3(o29312145170225_0_1_f), 1.0);
o29310752658685_0_a = p_o29310752658685_amount1*(dot((o29310735883809_0_1_rgba).rgb, vec3(1.0))/3.0);
o29310752658685_0_b = vec4(blend_additive(uv, o29310752658685_0_l.rgb, o29310752658685_0_b.rgb, o29310752658685_0_a*o29310752658685_0_l.a), min(1.0, o29310752658685_0_b.a+o29310752658685_0_a*o29310752658685_0_l.a));
// #output0: blend2_9 (o29310752658685)
vec4 o29310752658685_0_1_rgba = o29310752658685_0_b;
return (dot((o29310752658685_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: normal_map2/edge_detect_1 (o29287197446018)
vec3 nm_o29287197446018(vec2 uv, float amount, float size, float _seed_variation_) {
	vec3 e = vec3(1.0/size, -1.0/size, 0);
	vec2 rv;
	if (0 == 0) {
		rv = vec2(1.0, -1.0)*o29287197446018_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-1.0, 1.0)*o29287197446018_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(1.0, 1.0)*o29287197446018_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o29287197446018_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(2.0, 0.0)*o29287197446018_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o29287197446018_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o29287197446018_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o29287197446018_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/128.0;
	} else if (0 == 1) {
		rv = vec2(3.0, -3.0)*o29287197446018_input_in((uv+e.xy), _seed_variation_);
		rv += vec2(-3.0, 3.0)*o29287197446018_input_in((uv-e.xy), _seed_variation_);
		rv += vec2(3.0, 3.0)*o29287197446018_input_in((uv+e.xx), _seed_variation_);
		rv += vec2(-3.0, -3.0)*o29287197446018_input_in((uv-e.xx), _seed_variation_);
		rv += vec2(10.0, 0.0)*o29287197446018_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-10.0, 0.0)*o29287197446018_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 10.0)*o29287197446018_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -10.0)*o29287197446018_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/512.0;
	} else if (0 == 2) {
		rv = vec2(2.0, 0.0)*o29287197446018_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(-2.0, 0.0)*o29287197446018_input_in((uv-e.xz), _seed_variation_);
		rv += vec2(0.0, 2.0)*o29287197446018_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(0.0, -2.0)*o29287197446018_input_in((uv-e.zx), _seed_variation_);
		rv *= size*amount/64.0;
	} else {
		rv = vec2(1.0, 0.0)*o29287197446018_input_in((uv+e.xz), _seed_variation_);
		rv += vec2(0.0, 1.0)*o29287197446018_input_in((uv+e.zx), _seed_variation_);
		rv += vec2(-1.0, -1.0)*o29287197446018_input_in((uv), _seed_variation_);
		rv *= size*amount/20.0;
	}
	return vec3(0.5)+0.5*normalize(vec3(rv, -1.0));
}
vec4 o29314259093700_gradient_gradient_fct(float x) {
  if (x < p_o29314259093700_gradient_pos[0]) {
    return p_o29314259093700_gradient_col[0];
  } else if (x < p_o29314259093700_gradient_pos[1]) {
    return mix(p_o29314259093700_gradient_col[0], p_o29314259093700_gradient_col[1], ((x-p_o29314259093700_gradient_pos[0])/(p_o29314259093700_gradient_pos[1]-p_o29314259093700_gradient_pos[0])));
  } else if (x < p_o29314259093700_gradient_pos[2]) {
    return mix(p_o29314259093700_gradient_col[1], p_o29314259093700_gradient_col[2], ((x-p_o29314259093700_gradient_pos[1])/(p_o29314259093700_gradient_pos[2]-p_o29314259093700_gradient_pos[1])));
  } else if (x < p_o29314259093700_gradient_pos[3]) {
    return mix(p_o29314259093700_gradient_col[2], p_o29314259093700_gradient_col[3], ((x-p_o29314259093700_gradient_pos[2])/(p_o29314259093700_gradient_pos[3]-p_o29314259093700_gradient_pos[2])));
  } else if (x < p_o29314259093700_gradient_pos[4]) {
    return mix(p_o29314259093700_gradient_col[3], p_o29314259093700_gradient_col[4], ((x-p_o29314259093700_gradient_pos[3])/(p_o29314259093700_gradient_pos[4]-p_o29314259093700_gradient_pos[3])));
  } else if (x < p_o29314259093700_gradient_pos[5]) {
    return mix(p_o29314259093700_gradient_col[4], p_o29314259093700_gradient_col[5], ((x-p_o29314259093700_gradient_pos[4])/(p_o29314259093700_gradient_pos[5]-p_o29314259093700_gradient_pos[4])));
  } else if (x < p_o29314259093700_gradient_pos[6]) {
    return mix(p_o29314259093700_gradient_col[5], p_o29314259093700_gradient_col[6], ((x-p_o29314259093700_gradient_pos[5])/(p_o29314259093700_gradient_pos[6]-p_o29314259093700_gradient_pos[5])));
  } else if (x < p_o29314259093700_gradient_pos[7]) {
    return mix(p_o29314259093700_gradient_col[6], p_o29314259093700_gradient_col[7], ((x-p_o29314259093700_gradient_pos[6])/(p_o29314259093700_gradient_pos[7]-p_o29314259093700_gradient_pos[6])));
  } else if (x < p_o29314259093700_gradient_pos[8]) {
    return mix(p_o29314259093700_gradient_col[7], p_o29314259093700_gradient_col[8], ((x-p_o29314259093700_gradient_pos[7])/(p_o29314259093700_gradient_pos[8]-p_o29314259093700_gradient_pos[7])));
  } else if (x < p_o29314259093700_gradient_pos[9]) {
    return mix(p_o29314259093700_gradient_col[8], p_o29314259093700_gradient_col[9], ((x-p_o29314259093700_gradient_pos[8])/(p_o29314259093700_gradient_pos[9]-p_o29314259093700_gradient_pos[8])));
  } else if (x < p_o29314259093700_gradient_pos[10]) {
    return mix(p_o29314259093700_gradient_col[9], p_o29314259093700_gradient_col[10], ((x-p_o29314259093700_gradient_pos[9])/(p_o29314259093700_gradient_pos[10]-p_o29314259093700_gradient_pos[9])));
  } else if (x < p_o29314259093700_gradient_pos[11]) {
    return mix(p_o29314259093700_gradient_col[10], p_o29314259093700_gradient_col[11], ((x-p_o29314259093700_gradient_pos[10])/(p_o29314259093700_gradient_pos[11]-p_o29314259093700_gradient_pos[10])));
  } else if (x < p_o29314259093700_gradient_pos[12]) {
    return mix(p_o29314259093700_gradient_col[11], p_o29314259093700_gradient_col[12], ((x-p_o29314259093700_gradient_pos[11])/(p_o29314259093700_gradient_pos[12]-p_o29314259093700_gradient_pos[11])));
  } else if (x < p_o29314259093700_gradient_pos[13]) {
    return mix(p_o29314259093700_gradient_col[12], p_o29314259093700_gradient_col[13], ((x-p_o29314259093700_gradient_pos[12])/(p_o29314259093700_gradient_pos[13]-p_o29314259093700_gradient_pos[12])));
  } else if (x < p_o29314259093700_gradient_pos[14]) {
    return mix(p_o29314259093700_gradient_col[13], p_o29314259093700_gradient_col[14], ((x-p_o29314259093700_gradient_pos[13])/(p_o29314259093700_gradient_pos[14]-p_o29314259093700_gradient_pos[13])));
  } else if (x < p_o29314259093700_gradient_pos[15]) {
    return mix(p_o29314259093700_gradient_col[14], p_o29314259093700_gradient_col[15], ((x-p_o29314259093700_gradient_pos[14])/(p_o29314259093700_gradient_pos[15]-p_o29314259093700_gradient_pos[14])));
  } else if (x < p_o29314259093700_gradient_pos[16]) {
    return mix(p_o29314259093700_gradient_col[15], p_o29314259093700_gradient_col[16], ((x-p_o29314259093700_gradient_pos[15])/(p_o29314259093700_gradient_pos[16]-p_o29314259093700_gradient_pos[15])));
  }
  return p_o29314259093700_gradient_col[16];
}
vec4 o29280436231452_gradient_gradient_fct(float x) {
  if (x < p_o29280436231452_gradient_pos[0]) {
    return p_o29280436231452_gradient_col[0];
  } else if (x < p_o29280436231452_gradient_pos[1]) {
    return mix(p_o29280436231452_gradient_col[0], p_o29280436231452_gradient_col[1], ((x-p_o29280436231452_gradient_pos[0])/(p_o29280436231452_gradient_pos[1]-p_o29280436231452_gradient_pos[0])));
  }
  return p_o29280436231452_gradient_col[1];
}
float o29307749534604_input_d(vec2 uv, float _seed_variation_) {
// #output0: fbm3_4 (o29307816645122)
float o29307816645122_0_1_f = fbm_2d_perlin((fract(transform2(uv, vec2(p_o29307732758278_translate_x*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29307732758278_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29307732758278_scale_x*(2.0*1.0-1.0), p_o29307732758278_scale_y*(2.0*1.0-1.0))))), vec2(p_o29307816645122_scale_x, p_o29307816645122_scale_y), int(p_o29307816645122_folds), int(p_o29307816645122_iterations), p_o29307816645122_persistence, p_o29307816645122_offset, (seed_o29307816645122+fract(_seed_variation_)));
// #output0: transform2_8 (o29307732758278)
vec4 o29307732758278_0_1_rgba = vec4(vec3(o29307816645122_0_1_f), 1.0);
return (dot((o29307732758278_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: warp_7 (o29307749534604)
vec2 o29307749534604_slope(vec2 uv, float epsilon, float _seed_variation_) {
	return vec2(o29307749534604_input_d((fract(uv+vec2(epsilon, 0.0))), _seed_variation_)-o29307749534604_input_d((fract(uv-vec2(epsilon, 0.0))), _seed_variation_), o29307749534604_input_d((fract(uv+vec2(0.0, epsilon))), _seed_variation_)-o29307749534604_input_d((fract(uv-vec2(0.0, epsilon))), _seed_variation_));
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o29269950468240_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o29269950468240_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o29269950468240_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o29269950468240_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #output0: normal_map2/edge_detect_1 (o29287197446018)
vec3 o29287197446018_0_1_rgb = nm_o29287197446018((uv), p_o29287197446018_amount, 2048.0, _seed_variation_);

// #code: warp_4 (o29287029676955)
vec2 o29287029676955_0_slope = o29287029676955_slope((uv), p_o29287029676955_eps, _seed_variation_);
vec2 o29287029676955_0_warp = o29287029676955_0_slope*(1.0-o29287029676955_input_d((uv), _seed_variation_));vec4 o29286945787794_0 = textureLod(texture_3, fract((fract(transform2(((uv)+p_o29287029676955_amount*o29287029676955_0_warp), vec2((elapsed_time * 0.02)*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29288002754191_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29288002754191_scale_x*(2.0*1.0-1.0), p_o29288002754191_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_4 (o29288002754191)
vec4 o29288002754191_0_1_rgba = o29286945787794_0;

// #output0: warp_4 (o29287029676955)
vec4 o29287029676955_0_1_rgba = o29288002754191_0_1_rgba;

// #output2: decompose (o29294193549215)
float o29294193549215_2_1_f = o29287029676955_0_1_rgba.b;

// #output0: colorize_2 (o29314259093700)
vec4 o29314259093700_0_1_rgba = o29314259093700_gradient_gradient_fct(o29294193549215_2_1_f);
vec4 o29294394871521_0 = textureLod(texture_1, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29294310987927_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29294310987927_scale_x*(2.0*1.0-1.0), p_o29294310987927_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_3 (o29294310987927)
vec4 o29294310987927_0_1_rgba = o29294394871521_0;

// #output3: decompose_2 (o29294461983315)
float o29294461983315_3_1_f = o29294310987927_0_1_rgba.a;

// #output0: invert_3 (o29310735883809)
vec4 o29310735883809_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o29294461983315_3_1_f), 1.0).rgb, vec4(vec3(o29294461983315_3_1_f), 1.0).a);
vec4 o29309293038663_0 = textureLod(texture_2, fract((fract(transform2((uv), vec2((elapsed_time * 0.015)*(2.0*1.0-1.0), (elapsed_time * 0.05)*(2.0*1.0-1.0)), p_o29310769437481_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29310769437481_scale_x*(2.0*1.0-1.0), p_o29310769437481_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_9 (o29310769437481)
vec4 o29310769437481_0_1_rgba = o29309293038663_0;

// #output3: decompose_4 (o29310802987072)
float o29310802987072_3_1_f = o29310769437481_0_1_rgba.a;

// #output1: decompose_4 (o29310802987072)
float o29310802987072_1_2_f = o29310769437481_0_1_rgba.g;

// #output0: uniform_greyscale_2 (o29312816253996)
float o29312816253996_0_1_f = (elapsed_time);

// #code: math_8 (o29312883362233)
float o29312883362233_0_clamp_false = o29312816253996_0_1_f*p_o29312883362233_default_in2;
float o29312883362233_0_clamp_true = clamp(o29312883362233_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o29312883362233)
float o29312883362233_0_1_f = o29312883362233_0_clamp_false;

// #code: math_6 (o29312833033501)
float o29312833033501_0_clamp_false = o29312883362233_0_1_f*o29310802987072_1_2_f;
float o29312833033501_0_clamp_true = clamp(o29312833033501_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o29312833033501)
float o29312833033501_0_1_f = o29312833033501_0_clamp_false;

// #output0: decompose_4 (o29310802987072)
float o29310802987072_0_3_f = o29310769437481_0_1_rgba.r;

// #code: math_5 (o29312799478701)
float o29312799478701_0_clamp_false = o29310802987072_0_3_f+o29312833033501_0_1_f;
float o29312799478701_0_clamp_true = clamp(o29312799478701_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o29312799478701)
float o29312799478701_0_1_f = o29312799478701_0_clamp_false;

// #code: math_4 (o29312782700716)
float o29312782700716_0_clamp_false = mod(o29312799478701_0_1_f, p_o29312782700716_default_in2);
float o29312782700716_0_clamp_true = clamp(o29312782700716_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o29312782700716)
float o29312782700716_0_1_f = o29312782700716_0_clamp_false;

// #output0: tones_map (o29312849812166)
vec4 o29312849812166_0_1_rgba = vec4(vec3(p_o29312849812166_out_min)+(vec4(vec3(o29312782700716_0_1_f), 1.0).rgb-vec3(p_o29312849812166_in_min))*vec3((p_o29312849812166_out_max-(p_o29312849812166_out_min))/(p_o29312849812166_in_max-(p_o29312849812166_in_min))), vec4(vec3(o29312782700716_0_1_f), 1.0).a);

// #code: math_7 (o29312866586521)
float o29312866586521_0_clamp_false = (dot((o29312849812166_0_1_rgba).rgb, vec3(1.0))/3.0)+p_o29312866586521_default_in2;
float o29312866586521_0_clamp_true = clamp(o29312866586521_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o29312866586521)
float o29312866586521_0_1_f = o29312866586521_0_clamp_true;

// #code: blend2_10 (o29314242320509)
vec4 o29314242320509_0_b = vec4(vec3(o29312866586521_0_1_f), 1.0);
vec4 o29314242320509_0_l;
float o29314242320509_0_a;

o29314242320509_0_l = vec4(vec3(o29310802987072_3_1_f), 1.0);
o29314242320509_0_a = p_o29314242320509_amount1*1.0;
o29314242320509_0_b = vec4(blend_multiply((uv), o29314242320509_0_l.rgb, o29314242320509_0_b.rgb, o29314242320509_0_a*o29314242320509_0_l.a), min(1.0, o29314242320509_0_b.a+o29314242320509_0_a*o29314242320509_0_l.a));
// #output0: blend2_10 (o29314242320509)
vec4 o29314242320509_0_1_rgba = o29314242320509_0_b;

// #output0: tonality (o29312161945529)
float o29312161945529_0_1_f = o29312161945529_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));

// #code: math_2 (o29312145170225)
float o29312145170225_0_clamp_false = o29294461983315_3_1_f*o29312161945529_0_1_f;
float o29312145170225_0_clamp_true = clamp(o29312145170225_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o29312145170225)
float o29312145170225_0_1_f = o29312145170225_0_clamp_true;

// #output0: tonality_2 (o29312447160461)
float o29312447160461_0_1_f = o29312447160461_curve_curve_fct((dot((o29314242320509_0_1_rgba).rgb, vec3(1.0))/3.0));

// #output1: decompose_2 (o29294461983315)
float o29294461983315_1_2_f = o29294310987927_0_1_rgba.g;

// #code: math (o29310819765451)
float o29310819765451_0_clamp_false = o29294461983315_1_2_f*o29312447160461_0_1_f;
float o29310819765451_0_clamp_true = clamp(o29310819765451_0_clamp_false, 0.0, 1.0);
// #output0: math (o29310819765451)
float o29310819765451_0_1_f = o29310819765451_0_clamp_false;

// #code: math_3 (o29312732371653)
float o29312732371653_0_clamp_false = o29310819765451_0_1_f*p_o29312732371653_default_in2;
float o29312732371653_0_clamp_true = clamp(o29312732371653_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o29312732371653)
float o29312732371653_0_1_f = o29312732371653_0_clamp_false;

// #output0: decompose (o29294193549215)
float o29294193549215_0_2_f = o29287029676955_0_1_rgba.r;

// #output0: tones_2 (o29307850202915)
vec4 o29307850202915_0_1_rgba = adjust_levels(vec4(vec3(o29294193549215_0_2_f), 1.0), p_o29307850202915_in_min, p_o29307850202915_in_mid, p_o29307850202915_in_max, p_o29307850202915_out_min, p_o29307850202915_out_max);

// #code: blend2_8 (o29309343372618)
vec4 o29309343372618_0_b = o29307850202915_0_1_rgba;
vec4 o29309343372618_0_l;
float o29309343372618_0_a;

o29309343372618_0_l = vec4(vec3(o29312732371653_0_1_f), 1.0);
o29309343372618_0_a = p_o29309343372618_amount1*1.0;
o29309343372618_0_b = vec4(blend_additive((uv), o29309343372618_0_l.rgb, o29309343372618_0_b.rgb, o29309343372618_0_a*o29309343372618_0_l.a), min(1.0, o29309343372618_0_b.a+o29309343372618_0_a*o29309343372618_0_l.a));
// #output0: blend2_8 (o29309343372618)
vec4 o29309343372618_0_1_rgba = o29309343372618_0_b;

// #code: blend2_9 (o29310752658685)
vec4 o29310752658685_0_b = o29309343372618_0_1_rgba;
vec4 o29310752658685_0_l;
float o29310752658685_0_a;

o29310752658685_0_l = vec4(vec3(o29312145170225_0_1_f), 1.0);
o29310752658685_0_a = p_o29310752658685_amount1*(dot((o29310735883809_0_1_rgba).rgb, vec3(1.0))/3.0);
o29310752658685_0_b = vec4(blend_additive((uv), o29310752658685_0_l.rgb, o29310752658685_0_b.rgb, o29310752658685_0_a*o29310752658685_0_l.a), min(1.0, o29310752658685_0_b.a+o29310752658685_0_a*o29310752658685_0_l.a));
// #output0: blend2_9 (o29310752658685)
vec4 o29310752658685_0_1_rgba = o29310752658685_0_b;

// #output0: colorize (o29280436231452)
vec4 o29280436231452_0_1_rgba = o29280436231452_gradient_gradient_fct((dot((o29310752658685_0_1_rgba).rgb, vec3(1.0))/3.0));

// #code: blend2_11 (o29314728855781)
vec4 o29314728855781_0_b = o29280436231452_0_1_rgba;
vec4 o29314728855781_0_l;
float o29314728855781_0_a;

o29314728855781_0_l = o29314259093700_0_1_rgba;
o29314728855781_0_a = p_o29314728855781_amount1*1.0;
o29314728855781_0_b = vec4(blend_multiply((uv), o29314728855781_0_l.rgb, o29314728855781_0_b.rgb, o29314728855781_0_a*o29314728855781_0_l.a), min(1.0, o29314728855781_0_b.a+o29314728855781_0_a*o29314728855781_0_l.a));
// #output0: blend2_11 (o29314728855781)
vec4 o29314728855781_0_1_rgba = o29314728855781_0_b;

// #output0: greyscale (o29315030850915)
float o29315030850915_0_1_f = gs_lightness(((o29314728855781_0_1_rgba).rgb));

// #code: tones_step_3 (o29315064400232)
vec3 o29315064400232_0_false = clamp((vec4(vec3(o29315030850915_0_1_f), 1.0).rgb-vec3(p_o29315064400232_value))/max(0.0001, p_o29315064400232_width)+vec3(0.5), vec3(0.0), vec3(1.0));
vec3 o29315064400232_0_true = vec3(1.0)-o29315064400232_0_false;
// #output0: tones_step_3 (o29315064400232)
vec4 o29315064400232_0_1_rgba = vec4(o29315064400232_0_false, vec4(vec3(o29315030850915_0_1_f), 1.0).a);

// #code: warp_7 (o29307749534604)
vec2 o29307749534604_0_slope = o29307749534604_slope((uv), p_o29307749534604_eps, _seed_variation_);
vec2 o29307749534604_0_warp = o29307749534604_0_slope*(1.0-o29307749534604_input_d((uv), _seed_variation_));vec4 o29295116290502_0 = textureLod(texture_4, fract((fract(transform2(((uv)+p_o29307749534604_amount*o29307749534604_0_warp), vec2((elapsed_time * 0.02)*(2.0*1.0-1.0), (elapsed_time * 0.08)*(2.0*1.0-1.0)), p_o29307715981736_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o29307715981736_scale_x*(2.0*1.0-1.0), p_o29307715981736_scale_y*(2.0*1.0-1.0)))))), 0.0);

// #output0: transform2_7 (o29307715981736)
vec4 o29307715981736_0_1_rgba = o29295116290502_0;

// #output0: warp_7 (o29307749534604)
vec4 o29307749534604_0_1_rgba = o29307715981736_0_1_rgba;

// #output1: decompose_3 (o29307833424969)
float o29307833424969_1_1_f = o29307749534604_0_1_rgba.g;

// #output0: decompose_3 (o29307833424969)
float o29307833424969_0_2_f = o29307749534604_0_1_rgba.r;

// #output0: invert_5 (o29314980513774)
vec4 o29314980513774_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o29307833424969_0_2_f), 1.0).rgb, vec4(vec3(o29307833424969_0_2_f), 1.0).a);

// #code: blend2_15 (o29314963742550)
vec4 o29314963742550_0_b = o29314980513774_0_1_rgba;
vec4 o29314963742550_0_l;
float o29314963742550_0_a;

o29314963742550_0_l = vec4(vec3(o29307833424969_1_1_f), 1.0);
o29314963742550_0_a = p_o29314963742550_amount1*1.0;
o29314963742550_0_b = vec4(blend_normal((uv), o29314963742550_0_l.rgb, o29314963742550_0_b.rgb, o29314963742550_0_a*o29314963742550_0_l.a), min(1.0, o29314963742550_0_b.a+o29314963742550_0_a*o29314963742550_0_l.a));
// #output0: blend2_15 (o29314963742550)
vec4 o29314963742550_0_1_rgba = o29314963742550_0_b;

// #output0: brightness_contrast (o29315014073268)
vec4 o29315014073268_0_1_rgba = vec4(clamp(o29314963742550_0_1_rgba.rgb*p_o29315014073268_contrast+vec3(p_o29315014073268_brightness)+0.5-p_o29315014073268_contrast*0.5, vec3(0.0), vec3(1.0)), o29314963742550_0_1_rgba.a);

// #code: blend2_16 (o29315081181426)
vec4 o29315081181426_0_b = o29315014073268_0_1_rgba;
vec4 o29315081181426_0_l;
float o29315081181426_0_a;

o29315081181426_0_l = o29315064400232_0_1_rgba;
o29315081181426_0_a = p_o29315081181426_amount1*1.0;
o29315081181426_0_b = vec4(blend_multiply((uv), o29315081181426_0_l.rgb, o29315081181426_0_b.rgb, o29315081181426_0_a*o29315081181426_0_l.a), min(1.0, o29315081181426_0_b.a+o29315081181426_0_a*o29315081181426_0_l.a));
// #output0: blend2_16 (o29315081181426)
vec4 o29315081181426_0_1_rgba = o29315081181426_0_b;

// #output0: brightness_contrast_2 (o29315148286470)
vec4 o29315148286470_0_1_rgba = vec4(clamp(o29315081181426_0_1_rgba.rgb*p_o29315148286470_contrast+vec3(p_o29315148286470_brightness)+0.5-p_o29315148286470_contrast*0.5, vec3(0.0), vec3(1.0)), o29315081181426_0_1_rgba.a);

// #output0: invert_4 (o29314930182973)
vec4 o29314930182973_0_1_rgba = vec4(vec3(1.0)-vec4(vec3(o29312145170225_0_1_f), 1.0).rgb, vec4(vec3(o29312145170225_0_1_f), 1.0).a);

// #output2: decompose_3 (o29307833424969)
float o29307833424969_2_3_f = o29307749534604_0_1_rgba.b;

// #output0: tones_3 (o29314879851368)
vec4 o29314879851368_0_1_rgba = adjust_levels(vec4(vec3(o29307833424969_2_3_f), 1.0), p_o29314879851368_in_min, p_o29314879851368_in_mid, p_o29314879851368_in_max, p_o29314879851368_out_min, p_o29314879851368_out_max);

// #code: blend2_14 (o29314946959876)
vec4 o29314946959876_0_b = o29314879851368_0_1_rgba;
vec4 o29314946959876_0_l;
float o29314946959876_0_a;

o29314946959876_0_l = o29314930182973_0_1_rgba;
o29314946959876_0_a = p_o29314946959876_amount1*1.0;
o29314946959876_0_b = vec4(blend_multiply((uv), o29314946959876_0_l.rgb, o29314946959876_0_b.rgb, o29314946959876_0_a*o29314946959876_0_l.a), min(1.0, o29314946959876_0_b.a+o29314946959876_0_a*o29314946959876_0_l.a));
// #output0: blend2_14 (o29314946959876)
vec4 o29314946959876_0_1_rgba = o29314946959876_0_b;

// #output0: uniform (o29314896630115)
vec4 o29314896630115_0_1_rgba = p_o29314896630115_color;

// #output1: decompose (o29294193549215)
float o29294193549215_1_3_f = o29287029676955_0_1_rgba.g;

// #output0: tones_4 (o29315181846098)
vec4 o29315181846098_0_1_rgba = adjust_levels(vec4(vec3(o29312145170225_0_1_f), 1.0), p_o29315181846098_in_min, p_o29315181846098_in_mid, p_o29315181846098_in_max, p_o29315181846098_out_min, p_o29315181846098_out_max);

// #output0: uniform_2 (o29315165064570)
vec4 o29315165064570_0_1_rgba = p_o29315165064570_color;

// #code: blend2 (o29314779192022)
vec4 o29314779192022_0_b = o29314728855781_0_1_rgba;
vec4 o29314779192022_0_l;
float o29314779192022_0_a;

o29314779192022_0_l = o29315165064570_0_1_rgba;
o29314779192022_0_a = p_o29314779192022_amount1*(dot((o29315181846098_0_1_rgba).rgb, vec3(1.0))/3.0);
o29314779192022_0_b = vec4(blend_normal((uv), o29314779192022_0_l.rgb, o29314779192022_0_b.rgb, o29314779192022_0_a*o29314779192022_0_l.a), min(1.0, o29314779192022_0_b.a+o29314779192022_0_a*o29314779192022_0_l.a));
// #output0: blend2 (o29314779192022)
vec4 o29314779192022_0_1_rgba = o29314779192022_0_b;

// #code: blend2_12 (o29314846303893)
vec4 o29314846303893_0_b = o29314779192022_0_1_rgba;
vec4 o29314846303893_0_l;
float o29314846303893_0_a;

o29314846303893_0_l = vec4(vec3(o29294193549215_1_3_f), 1.0);
o29314846303893_0_a = p_o29314846303893_amount1*1.0;
o29314846303893_0_b = vec4(blend_multiply((uv), o29314846303893_0_l.rgb, o29314846303893_0_b.rgb, o29314846303893_0_a*o29314846303893_0_l.a), min(1.0, o29314846303893_0_b.a+o29314846303893_0_a*o29314846303893_0_l.a));
// #output0: blend2_12 (o29314846303893)
vec4 o29314846303893_0_1_rgba = o29314846303893_0_b;

// #code: blend2_13 (o29314863078245)
vec4 o29314863078245_0_b = o29314846303893_0_1_rgba;
vec4 o29314863078245_0_l;
float o29314863078245_0_a;

o29314863078245_0_l = o29314896630115_0_1_rgba;
o29314863078245_0_a = p_o29314863078245_amount1*(dot((o29314946959876_0_1_rgba).rgb, vec3(1.0))/3.0);
o29314863078245_0_b = vec4(blend_screen((uv), o29314863078245_0_l.rgb, o29314863078245_0_b.rgb, o29314863078245_0_a*o29314863078245_0_l.a), min(1.0, o29314863078245_0_b.a+o29314863078245_0_a*o29314863078245_0_l.a));
// #output0: blend2_13 (o29314863078245)
vec4 o29314863078245_0_1_rgba = o29314863078245_0_b;

// #output0: brightness_contrast_3 (o29315097955971)
vec4 o29315097955971_0_1_rgba = vec4(clamp(o29314863078245_0_1_rgba.rgb*p_o29315097955971_contrast+vec3(p_o29315097955971_brightness)+0.5-p_o29315097955971_contrast*0.5, vec3(0.0), vec3(1.0)), o29314863078245_0_1_rgba.a);

	vec3 albedo_tex = ((o29315097955971_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o29269950468240_albedo_color.rgb;
	METALLIC = 1.0*p_o29269950468240_metallic;
	ROUGHNESS = (dot((o29315148286470_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o29269950468240_roughness;
	NORMAL_MAP = o29287197446018_0_1_rgb;
	NORMAL_MAP_DEPTH = p_o29269950468240_normal;
	EMISSION = vec3(0.0)*p_o29269950468240_emission_energy;
}



