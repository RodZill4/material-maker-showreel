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
const vec4 p_o31334152016989_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o31334152016989_metallic = 0.100000000;
const float p_o31334152016989_roughness = 0.320000000;
const float p_o31334152016989_emission_energy = 1.000000000;
const float p_o31334152016989_normal = 2.460000000;
const float p_o31334152016989_ao = 1.000000000;
const float p_o31334152016989_depth_scale = 0.208500000;
const float p_o31334185571166_gradient_pos[2] = float[]( 0.180616945, 0.780449033 );
const vec4 p_o31334185571166_gradient_col[2] = vec4[]( vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000), vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000) );
uniform sampler2D texture_1;
const float texture_1_size = 1024.000000000;
const float p_o31335427089921_amount1 = 1.000000000;
const float p_o31335427089921_amount2 = 1.000000000;
const float p_o31336232393686_value = 0.262300000;
const float p_o31336232393686_width = 0.090000000;
const float p_o31336232393686_contrast = 1.000000000;
const float seed_o31334722446655 = 0.000000000;
const float p_o31334722446655_sx = 1.000000000;
const float p_o31334722446655_sy = 1.000000000;
const float p_o31334722446655_rotate = 0.000000000;
const float p_o31334722446655_scale = 0.000000000;
const float p_o31336215619033_c1 = 0.300000000;
const float p_o31336198841721_x = 0.331100000;
const float p_o31336198841721_y = 0.359800000;
const float p_o31336198841721_z = 0.278700000;
const float p_o31336182063220_r = 0.011500000;
const float p_o31335393536566_c1 = 0.200000000;
const float p_o31334470786448_sx = 0.403933406;
const float p_o31334470786448_sy = 0.378517389;
const float p_o31334470786448_sz = 1.000000000;
const float p_o31334470786448_r = 0.010000000;
const float p_o31334454010881_s = 0.970490000;
const float p_o31334454010881_sx = 1.416980000;
const float p_o31334454010881_sy = 1.162300000;
const float p_o31334454010881_sz = 0.016240000;
const float p_o31334437228943_r = 0.423600000;
const float p_o31335376752993_c1 = 0.100000000;
const float p_o31336333057134_k1 = 0.027700000;
const float p_o31334420453349_sx = 0.363500000;
const float p_o31334420453349_sy = 0.274300000;
const float p_o31334420453349_sz = 0.328100000;
const float p_o31334420453349_r = 0.019700000;
const float p_o31334403676651_sx = 0.419100000;
const float p_o31334403676651_sy = 0.388300000;
const float p_o31334403676651_sz = 0.250000000;
const float p_o31334403676651_r = 0.027900000;
const float p_o31336282727553_amount1 = 1.000000000;
const float p_o31336282727553_amount2 = 0.016200000;
const float seed_o31336316279701 = 0.242038622;
const float p_o31336299505284_cx = 0.000000000;
const float p_o31336299505284_cy = 0.000000000;
const float p_o31336299505284_scale_x = 1.162400000;
const float p_o31336299505284_scale_y = 0.837600000;
const float p_o31336265945782_sides = 6.000000000;
const float p_o31336265945782_radius = 0.860000000;
const float p_o31336265945782_edge = 0.730000000;
const float p_o31335443866883_cx = 0.000000000;
const float p_o31335443866883_cy = 0.000000000;
const float p_o31335443866883_scale_x = 0.821150000;
const float p_o31335443866883_scale_y = 0.655450000;
const float p_o31336165283870_amount1 = 0.520000000;
const float seed_o31336148508367 = 0.000000000;
const float p_o31336148508367_v2 = 0.100000000;
const float p_o31336148508367_v3 = 0.200000000;
const float p_o31336148508367_v4 = 0.300000000;
const float p_o31336148508367_v5 = 0.400000000;
const float seed_o31336098176389 = 0.386550814;
const float p_o31336081397615_steps = 8.000000000;
const float p_o31335863293248_repeat = 1.000000000;
const float p_o31335863293248_rotate = 90.000000000;
const float p_o31335863293248_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o31335863293248_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o31335829742711_brightness = -0.050000000;
const float p_o31335829742711_contrast = 1.120000000;
const float p_o31334168798492_s = 86.500000000;
const float p_o31335846521031_translate_x = 0.021900000;
const float p_o31335846521031_translate_y = 0.006100000;
const float p_o31335846521031_rotate = 0.000000000;
const float p_o31335846521031_scale_x = 1.000000000;
const float p_o31335846521031_scale_y = 1.000000000;
const float seed_o31336349832183 = 0.900757134;
const float p_o31336349832183_grad_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o31336349832183_grad_col[2] = vec4[]( vec4(0.591796875, 0.591796875, 0.591796875, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o31336349832183_layers = 1.000000000;
const float p_o31336349832183_rotate = 0.000000000;
const float p_o31336349832183_r_rotate = 180.000000000;
const float p_o31336349832183_r_offset = 0.060000000;
const float seed_o31334605006482 = 0.000000000;
const float p_o31334605006482_tx = 2.000000000;
const float p_o31334605006482_ty = 2.000000000;
const float p_o31334605006482_overlap = 2.000000000;
const float p_o31334605006482_scale_x = 0.552700000;
const float p_o31334605006482_scale_y = 0.609100000;
const float p_o31334605006482_fixed_offset = 0.460000000;
const float p_o31334605006482_offset = 0.070000000;
const float p_o31334605006482_rotate = 4.646000000;
const float p_o31334605006482_scale = 0.020100000;
const float p_o31334605006482_value = 0.730000000;
const vec4 p_o31336249166597_color = vec4(0.699218750, 1.000000000, 0.000000000, 1.000000000);
const float p_o31335410311903_value = 0.210000000;
const float p_o31335410311903_width = 0.090000000;
const float p_o31335410311903_contrast = 1.000000000;
const float p_o31335477417192_amount1 = 1.000000000;
const float p_o31335460641716_value = 0.210000000;
const float p_o31335460641716_width = 0.090000000;
const float p_o31335460641716_contrast = 1.000000000;
const float p_o31335527751407_amount1 = 0.120000000;
const float p_o31335527751407_amount2 = 0.380000000;
const float seed_o31335561300277 = 0.000000000;
const float p_o31335561300277_scale_x = 8.000000000;
const float p_o31335561300277_scale_y = 8.000000000;
const float p_o31335561300277_folds = 0.000000000;
const float p_o31335561300277_iterations = 7.000000000;
const float p_o31335561300277_persistence = 1.000000000;
const float p_o31335561300277_offset = 0.000000000;
const float seed_o31335544529324 = 0.000000000;
const float p_o31335544529324_length = 0.100000000;
const float p_o31335544529324_width = 0.022600000;
const float p_o31335544529324_layers = 10.000000000;
const float p_o31335544529324_waviness = 0.510000000;
const float p_o31335544529324_angle = -1.000000000;
const float p_o31335544529324_randomness = 0.710000000;
const float p_o31335510976885_color = 0.230000000;
const float p_o31335494195275_color = 0.390000000;
const float p_o31335578082643_amount1 = 1.000000000;
const float p_o31335594860864_value = 0.095000000;
const float p_o31335594860864_width = 0.144600000;
const float p_o31335594860864_contrast = 1.000000000;
const float p_o31335611635004_gradient_pos[2] = float[]( 0.129377395, 0.883763373 );
const vec4 p_o31335611635004_gradient_col[2] = vec4[]( vec4(0.048828125, 0.048828125, 0.048828125, 1.000000000), vec4(0.847901106, 0.859375000, 0.775451660, 1.000000000) );
// #globals: colorize (o31334185571166)
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
// #globals: blend2 (o31335427089921)
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
// #globals: sdf3d_boolean_3 (o31335359980836)
vec2 sdf3dc_union(vec2 a, vec2 b) {
	return vec2(min(a.x, b.x), mix(b.y, a.y, step(a.x, b.x)));
}
vec2 sdf3dc_sub(vec2 a, vec2 b) {
	return vec2(max(-a.x, b.x), a.y);
}
vec2 sdf3dc_inter(vec2 a, vec2 b) {
	return vec2(max(a.x, b.x), mix(a.y, b.y, step(a.x, b.x)));
}
// #globals: sdf3d_box_3 (o31334470786448)
float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
}
// #globals: sdf3d_smoothboolean (o31336333057134)
vec2 sdf3d_smooth_union(vec2 d1, vec2 d2, float k) {
	float h = clamp(0.5+0.5*(d2.x-d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, d1.x, h)-k*h*(1.0-h), mix(d2.y, d1.y, step(d1.x, d2.x)));
}
vec2 sdf3d_smooth_subtraction(vec2 d1, vec2 d2, float k ) {
	float h = clamp(0.5-0.5*(d2.x+d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, -d1.x, h )+k*h*(1.0-h), d2.y);
}
vec2 sdf3d_smooth_intersection(vec2 d1, vec2 d2, float k ) {
	float h = clamp(0.5-0.5*(d2.x-d1.x)/k, 0.0, 1.0);
	return vec2(mix(d2.x, d1.x, h)+k*h*(1.0-h), mix(d1.y, d2.y, step(d1.x, d2.x)));
}
// #globals: scale_2 (o31336299505284)
vec2 scale(vec2 uv, vec2 center, vec2 scale) {
	uv -= center;
	uv /= scale;
	uv += center;
	return uv;
}
// #globals: shape (o31336265945782)
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
// #globals: shader_1 (o31334168798492)
float st(float e0, float e1, float v) {
	return smoothstep(e0, e1, v);
}
vec3 shader_error(vec2 uv, float offset, float s) {
	float mask = smoothstep(0.42,0.415, length(uv-0.5));
	vec3 col = vec3(1.0);
	float id = floor(uv.y*14.0);
	if (id == 2.0) {
		float mask = step(abs(uv.x-0.5),0.12);
		col = mix(col, vec3(0.15), mask);
	}
	if (id == 3.0) {
		col = vec3(0.05);
		col = mix(col, vec3(1.0), step(abs(uv.x-0.5),0.2));
		col = mix(col, vec3(0.0), step(abs(uv.x-0.35),0.004));
	}
	if (id == 4.0) {
		col = vec3(0.75);
		col = mix(col, vec3(0.05), step(fract(uv.x*8.0),0.5));
	}
	if (id == 5.0 || id == 6.0) {
		float cid = floor(uv.x*8.0);
		if (cid <= 1.0) { col = vec3(1.0,0.943,0.0); }
		if (cid == 2.0) { col = vec3(0.0,0.815,1.0); }
		if (cid == 3.0) { col = vec3(0.0,0.814,0.0); }
		if (cid == 4.0) { col = vec3(0.625,0.191,0.594); }
		if (cid == 5.0) { col = vec3(1.0,0.191,0.164); }
		if (cid >= 6.0) { col = vec3(0.251,0.251,0.606); }
	}
	if (id == 7.0) {
		col = vec3(0.05);
		col = mix(col, vec3(1.0), step(fract(uv.x*20.0+0.05),0.1));
		col = mix(col, vec3(1.0), step(abs(uv.y-0.535),0.002));
	}
	if (id == 8.0 || id == 9.0) {
		float id = floor(uv.x*9.0);
		col = vec3(0.05);
		if (id <= 1.0) { col = vec3(0.1); }
		if (id == 2.0) { col = vec3(step(fract(uv.x*37.0),0.35)); }
		if (id == 3.0 || id == 4.0) { col = vec3(st(0.5,1.0, cos(uv.x*500.0))); }
		if (id == 5.0) { col = vec3(st(0.8,0.4, cos(uv.x*500.0))); }
		if (id == 6.0) { col = vec3(st(0.0,0.6, cos(uv.x*800.0))); }
	}
	if (id > 5.0 && id <= 8.0) {
		float mask = step(abs(uv.x-0.5),0.04);
		col = mix(col, vec3(0.0), mask);
		col = mix(col, vec3(1.0), step(fract(uv.x*20.0+0.05),0.1)*mask);
		col = mix(col, vec3(1.0), step(abs(uv.y-0.535),0.002)*mask);
	}
	if (id == 10.0) {
		col = pow(vec3(floor(uv.x*10.0)/10.0)*mask,vec3(1.5))*1.3;
	}
	if (id == 11.0) {
		col = mix(col, vec3(0.15), step(abs(uv.x-0.5),0.18));
	}
	if (id == 12.0) {
		col = vec3(1.0, 0.94, 0.0);
		float mask = step(abs(uv.x-0.5),0.03);
		col = mix(col, vec3(1.0,0.0,0.16), mask);
	}
	float noise = pow(rand(floor(uv*s)+offset),2.5);
	return col*mask+noise*0.3;
}
// #globals: transform2 (o31335846521031)
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
// #globals: fill_to_uv
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
// #globals: fill_to_gradient (o31336349832183)
vec2 gradient_uv(vec2 uv, float rotate, float rnd_rotate, float rnd_offset, vec2 seed) {
	seed = rand2(seed);
	uv -= vec2(0.5);
	float angle = (rotate + (seed.x * 2.0 - 1.0) * rnd_rotate) * 0.01745329251;
	float ca = cos(angle);
	float sa = sin(angle);
	uv = vec2(ca*uv.x+sa*uv.y, -sa*uv.x+ca*uv.y);
	uv.x += seed.y * rnd_offset;
	uv /= sqrt(2.0); // square root of 2 is the diagonal of a 1x1 square, to ensure full coverate of gradient
	uv += vec2(0.5);
	return clamp(uv, vec2(0.0), vec2(1.0));
}
// #globals: custom_uv2 (o31334722446655)
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
// #globals: fbm3 (o31335561300277)
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
// #globals: scratches (o31335544529324)
float scratch(vec2 uv, vec2 size, float waviness, float angle, float randomness, vec2 seed) {
	float subdivide = floor(1.0/size.x);
	float cut = size.x*subdivide;
	uv *= subdivide;
	vec2 r1 = rand2(floor(uv)+seed);
	vec2 r2 = rand2(r1);
	uv = fract(uv);
	vec2 border = 10.0*min(fract(uv), 1.0-fract(uv));
	uv = 2.0*uv-vec2(1.0);
	float a = 6.28318530718*(angle+(r1.x-0.5)*randomness);
	float c = cos(a);
	float s = sin(a);
	uv = vec2(c*uv.x+s*uv.y, s*uv.x-c*uv.y);
	uv.y += 2.0*r1.y-1.0;
	uv.y += 0.5*waviness*cos(2.0*uv.x+6.28318530718*r2.y);
	uv.x /= cut;
	uv.y /= subdivide*size.y;
	return min(border.x, border.y)*(1.0-uv.x*uv.x)*max(0.0, 1.0-1000.0*uv.y*uv.y);
}
float scratches(vec2 uv, int layers, vec2 size, float waviness, float angle, float randomness, vec2 seed) {
	float v = 0.0;
	for (int i = 0; i < layers; ++i) {
		seed = rand2(seed);
		v = max(v, scratch(fract(uv+seed), size, waviness, angle/360.0, randomness, seed));
	}
	return v;
}
vec4 o31334185571166_gradient_gradient_fct(float x) {
  if (x < p_o31334185571166_gradient_pos[0]) {
    return p_o31334185571166_gradient_col[0];
  } else if (x < p_o31334185571166_gradient_pos[1]) {
    return mix(p_o31334185571166_gradient_col[0], p_o31334185571166_gradient_col[1], ((x-p_o31334185571166_gradient_pos[0])/(p_o31334185571166_gradient_pos[1]-p_o31334185571166_gradient_pos[0])));
  }
  return p_o31334185571166_gradient_col[1];
}
float o31334152016989_input_depth_tex(vec2 uv, float _seed_variation_) {
vec4 o31334672111393_0 = textureLod(texture_1, fract((uv)), 0.0);
// #output0: colorize (o31334185571166)
vec4 o31334185571166_0_1_rgba = o31334185571166_gradient_gradient_fct((dot((o31334672111393_0).rgb, vec3(1.0))/3.0));
return (dot((o31334185571166_0_1_rgba).rgb, vec3(1.0))/3.0);
}
vec2 o31334521117646_input_sdf(vec3 p, float _seed_variation_) {
// #output0: sdf3d_sphere_2 (o31336182063220)
float o31336182063220_0_1_sdf3d = length(((p)-vec3(p_o31336198841721_x, p_o31336198841721_y, p_o31336198841721_z)))-p_o31336182063220_r;
// #output0: sdf3d_translate_3_2 (o31336198841721)
vec2 o31336198841721_0_1_sdf3dc = vec2(o31336182063220_0_1_sdf3d, 0.0);
// #output0: sdf3d_color_3 (o31336215619033)
vec2 o31336215619033_0_1_sdf3dc = vec2((o31336198841721_0_1_sdf3dc).x, p_o31336215619033_c1);
// #output0: sdf3d_box_3 (o31334470786448)
float o31334470786448_0_1_sdf3d = box3d((p), vec3(p_o31334470786448_sx, p_o31334470786448_sy, p_o31334470786448_sz))-p_o31334470786448_r;
// #output0: sdf3d_sphere (o31334437228943)
float o31334437228943_0_1_sdf3d = length((((p))/vec3(p_o31334454010881_sx*p_o31334454010881_s,p_o31334454010881_sy*p_o31334454010881_s,p_o31334454010881_sz*p_o31334454010881_s)))-p_o31334437228943_r;
// #output0: sdf3d_scale_xyz (o31334454010881)
vec2 o31334454010881_0_1_sdf3dc = vec2(vec2(o31334437228943_0_1_sdf3d, 0.0).x*min(min(p_o31334454010881_sx*p_o31334454010881_s,p_o31334454010881_sy*p_o31334454010881_s),p_o31334454010881_sz*p_o31334454010881_s), vec2(o31334437228943_0_1_sdf3d, 0.0).y);
// #code: sdf3d_boolean_2 (o31334487566458)
vec2 o31334487566458_0_b = o31334454010881_0_1_sdf3dc;
o31334487566458_0_b = sdf3dc_inter(vec2(o31334470786448_0_1_sdf3d, 0.0), o31334487566458_0_b);
o31334487566458_0_b = sdf3dc_union(vec2(100.0, 0.0), o31334487566458_0_b);
// #output0: sdf3d_boolean_2 (o31334487566458)
vec2 o31334487566458_0_1_sdf3dc = o31334487566458_0_b;
// #output0: sdf3d_color_2 (o31335393536566)
vec2 o31335393536566_0_1_sdf3dc = vec2((o31334487566458_0_1_sdf3dc).x, p_o31335393536566_c1);
// #output0: sdf3d_box_2 (o31334420453349)
float o31334420453349_0_1_sdf3d = box3d((p), vec3(p_o31334420453349_sx, p_o31334420453349_sy, p_o31334420453349_sz))-p_o31334420453349_r;
// #output0: sdf3d_box (o31334403676651)
float o31334403676651_0_1_sdf3d = box3d((p), vec3(p_o31334403676651_sx, p_o31334403676651_sy, p_o31334403676651_sz))-p_o31334403676651_r;
// #code: sdf3d_smoothboolean (o31336333057134)
vec2 o31336333057134_0_b = vec2(o31334403676651_0_1_sdf3d, 0.0);
o31336333057134_0_b = sdf3d_smooth_subtraction(vec2(o31334420453349_0_1_sdf3d, 0.0), o31336333057134_0_b, p_o31336333057134_k1);
// #output0: sdf3d_smoothboolean (o31336333057134)
vec2 o31336333057134_0_1_sdf3dc = o31336333057134_0_b;
// #output0: sdf3d_color (o31335376752993)
vec2 o31335376752993_0_1_sdf3dc = vec2((o31336333057134_0_1_sdf3dc).x, p_o31335376752993_c1);
// #code: sdf3d_boolean_3 (o31335359980836)
vec2 o31335359980836_0_b = o31335376752993_0_1_sdf3dc;
o31335359980836_0_b = sdf3dc_union(o31335393536566_0_1_sdf3dc, o31335359980836_0_b);
o31335359980836_0_b = sdf3dc_union(o31336215619033_0_1_sdf3dc, o31335359980836_0_b);
// #output0: sdf3d_boolean_3 (o31335359980836)
vec2 o31335359980836_0_1_sdf3dc = o31335359980836_0_b;
return o31335359980836_0_1_sdf3dc;
}
// #instance: raymarching (o31334521117646)
vec2 raymarch_o31334521117646(vec2 uv, float _seed_variation_) {
	vec3 ro = vec3(uv-vec2(0.5), 1.0);
	vec3 rd = vec3(0.0, 0.0, -1.0);
	float dO = 0.0;
	float c = 0.0;
	for (int i=0; i < 100; i++) {
		vec3 p = ro + rd*dO;
		vec2 dS = o31334521117646_input_sdf((p), _seed_variation_);
		dO += dS.x;
		if (dO >= 1.0) {
			break;
		} else if (abs(dS.x) < 0.0001) {
			c = dS.y;
			break;
		}
	}
	
	return vec2(dO, c);
}
vec3 normal_o31334521117646(vec3 p, float _seed_variation_) {
	if (p.z <= 0.0) {
		return vec3(0.0, 0.0, -1.0);
	}
	float d = o31334521117646_input_sdf((p), _seed_variation_).x;
	float e = .001;
	
	vec3 n = d - vec3(
		o31334521117646_input_sdf((p-vec3(e, 0.0, 0.0)), _seed_variation_).x,
		o31334521117646_input_sdf((p-vec3(0.0, e, 0.0)), _seed_variation_).x,
		o31334521117646_input_sdf((p-vec3(0.0, 0.0, e)), _seed_variation_).x);
	
	return vec3(-1.0, -1.0, -1.0)*normalize(n);
}
vec4 o31334722446655_input_in1(vec2 uv, float _seed_variation_) {
// #code: raymarching (o31334521117646)
vec2 o31334521117646_0_d = raymarch_o31334521117646(uv, _seed_variation_);
// #output1: raymarching (o31334521117646)
vec3 o31334521117646_1_1_rgb = vec3(0.5)+0.5*normal_o31334521117646(vec3(uv-vec2(0.5), 1.0-o31334521117646_0_d.x), _seed_variation_);
return vec4(o31334521117646_1_1_rgb, 1.0);
}
vec4 o31335863293248_gradient_gradient_fct(float x) {
  if (x < p_o31335863293248_gradient_pos[0]) {
    return p_o31335863293248_gradient_col[0];
  } else if (x < p_o31335863293248_gradient_pos[1]) {
    return mix(p_o31335863293248_gradient_col[0], p_o31335863293248_gradient_col[1], ((x-p_o31335863293248_gradient_pos[0])/(p_o31335863293248_gradient_pos[1]-p_o31335863293248_gradient_pos[0])));
  }
  return p_o31335863293248_gradient_col[1];
}
float o31336148508367_input_in(vec2 uv, float _seed_variation_) {
// #code: gradient (o31335863293248)
float o31335863293248_0_r = 0.5+(cos(p_o31335863293248_rotate*0.01745329251)*((uv).x-0.5)+sin(p_o31335863293248_rotate*0.01745329251)*((uv).y-0.5))/(cos(abs(mod(p_o31335863293248_rotate, 90.0)-45.0)*0.01745329251)*1.41421356237);
// #output0: gradient (o31335863293248)
vec4 o31335863293248_0_1_rgba = o31335863293248_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(o31335863293248_0_r*p_o31335863293248_repeat)-0.5)) : fract(o31335863293248_0_r*p_o31335863293248_repeat));
// #output0: quantize (o31336081397615)
vec4 o31336081397615_0_1_rgba = vec4(floor(o31335863293248_0_1_rgba.rgb*p_o31336081397615_steps)/p_o31336081397615_steps, o31335863293248_0_1_rgba.a);
// #code: randomize (o31336098176389)
vec3 o31336098176389_0_rand = ((o31336081397615_0_1_rgba).rgb);
// #output0: randomize (o31336098176389)
vec3 o31336098176389_0_1_rgb = rand3( vec2( float((seed_o31336098176389+fract(_seed_variation_))) + o31336098176389_0_rand.x, rand( o31336098176389_0_rand.yz ) ) );
return (dot(o31336098176389_0_1_rgb, vec3(1.0))/3.0);
}
vec4 o31334722446655_input_in2(vec2 uv, float _seed_variation_) {
// #code: randomize_2 (o31336316279701)
vec3 o31336316279701_0_rand = vec3(0.0);
// #output0: randomize_2 (o31336316279701)
vec3 o31336316279701_0_1_rgb = rand3( vec2( float((seed_o31336316279701+fract(_seed_variation_))) + o31336316279701_0_rand.x, rand( o31336316279701_0_rand.yz ) ) );
// #output0: shape (o31336265945782)
float o31336265945782_0_1_f = shape_circle((scale((uv), vec2(0.5+p_o31336299505284_cx, 0.5+p_o31336299505284_cy), vec2(p_o31336299505284_scale_x, p_o31336299505284_scale_y))), p_o31336265945782_sides+1.0e-5, p_o31336265945782_radius*1.0, p_o31336265945782_edge*1.0);
// #output0: scale_2 (o31336299505284)
vec4 o31336299505284_0_1_rgba = vec4(vec3(o31336265945782_0_1_f), 1.0);
// #output0: variations_greyscale (o31336148508367)
float o31336148508367_0_1_f = o31336148508367_input_in((scale((uv), vec2(0.5+p_o31335443866883_cx, 0.5+p_o31335443866883_cy), vec2(p_o31335443866883_scale_x, p_o31335443866883_scale_y))), (seed_o31336148508367+fract(_seed_variation_))+(floor(elapsed_time*20.0)/20.0));
// #output0: shader_1 (o31334168798492)
vec3 o31334168798492_0_1_rgb = shader_error((scale((uv), vec2(0.5+p_o31335443866883_cx, 0.5+p_o31335443866883_cy), vec2(p_o31335443866883_scale_x, p_o31335443866883_scale_y))), elapsed_time, p_o31334168798492_s);
// #output2: decompose (o31336114955738)
float o31336114955738_2_1_f = vec4(o31334168798492_0_1_rgb, 1.0).b;
// #output0: shader_1 (o31334168798492)
vec3 o31334168798492_0_3_rgb = shader_error((transform2((scale((uv), vec2(0.5+p_o31335443866883_cx, 0.5+p_o31335443866883_cy), vec2(p_o31335443866883_scale_x, p_o31335443866883_scale_y))), vec2(p_o31335846521031_translate_x*(2.0*o31336148508367_0_1_f-1.0), p_o31335846521031_translate_y*(2.0*1.0-1.0)), p_o31335846521031_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31335846521031_scale_x*(2.0*1.0-1.0), p_o31335846521031_scale_y*(2.0*1.0-1.0)))), elapsed_time, p_o31334168798492_s);
// #output1: decompose (o31336114955738)
float o31336114955738_1_3_f = vec4(o31334168798492_0_3_rgb, 1.0).g;
// #output0: transform2 (o31335846521031)
vec4 o31335846521031_0_1_rgba = vec4(vec3(o31336114955738_1_3_f), 1.0);
// #output0: decompose (o31336114955738)
float o31336114955738_0_4_f = vec4(o31334168798492_0_1_rgb, 1.0).r;
// #output0: combine (o31336131733149)
vec4 o31336131733149_0_1_rgba = vec4(o31336114955738_0_4_f, (dot((o31335846521031_0_1_rgba).rgb, vec3(1.0))/3.0), o31336114955738_2_1_f, 1.0);
// #output0: brightness_contrast (o31335829742711)
vec4 o31335829742711_0_1_rgba = vec4(clamp(o31336131733149_0_1_rgba.rgb*p_o31335829742711_contrast+vec3(p_o31335829742711_brightness)+0.5-p_o31335829742711_contrast*0.5, vec3(0.0), vec3(1.0)), o31336131733149_0_1_rgba.a);
// #code: blend2_5 (o31336165283870)
vec4 o31336165283870_0_b = o31335829742711_0_1_rgba;
vec4 o31336165283870_0_l;
float o31336165283870_0_a;
o31336165283870_0_l = vec4(vec3(o31336148508367_0_1_f), 1.0);
o31336165283870_0_a = p_o31336165283870_amount1*1.0;
o31336165283870_0_b = vec4(blend_multiply((scale((uv), vec2(0.5+p_o31335443866883_cx, 0.5+p_o31335443866883_cy), vec2(p_o31335443866883_scale_x, p_o31335443866883_scale_y))), o31336165283870_0_l.rgb, o31336165283870_0_b.rgb, o31336165283870_0_a*o31336165283870_0_l.a), min(1.0, o31336165283870_0_b.a+o31336165283870_0_a*o31336165283870_0_l.a));
// #output0: blend2_5 (o31336165283870)
vec4 o31336165283870_0_1_rgba = o31336165283870_0_b;
// #output0: scale (o31335443866883)
vec4 o31335443866883_0_1_rgba = o31336165283870_0_1_rgba;
// #code: blend2_6 (o31336282727553)
vec4 o31336282727553_0_b = o31335443866883_0_1_rgba;
vec4 o31336282727553_0_l;
float o31336282727553_0_a;
o31336282727553_0_l = o31336299505284_0_1_rgba;
o31336282727553_0_a = p_o31336282727553_amount1*1.0;
o31336282727553_0_b = vec4(blend_multiply(uv, o31336282727553_0_l.rgb, o31336282727553_0_b.rgb, o31336282727553_0_a*o31336282727553_0_l.a), min(1.0, o31336282727553_0_b.a+o31336282727553_0_a*o31336282727553_0_l.a));
o31336282727553_0_l = vec4(o31336316279701_0_1_rgb, 1.0);
o31336282727553_0_a = p_o31336282727553_amount2*1.0;
o31336282727553_0_b = vec4(blend_normal(uv, o31336282727553_0_l.rgb, o31336282727553_0_b.rgb, o31336282727553_0_a*o31336282727553_0_l.a), min(1.0, o31336282727553_0_b.a+o31336282727553_0_a*o31336282727553_0_l.a));
// #output0: blend2_6 (o31336282727553)
vec4 o31336282727553_0_1_rgba = o31336282727553_0_b;
return o31336282727553_0_1_rgba;
}
vec4 o31334722446655_input_in3(vec2 uv, float _seed_variation_) {
// #code: raymarching (o31334521117646)
vec2 o31334521117646_0_d = raymarch_o31334521117646(uv, _seed_variation_);
// #output2: raymarching (o31334521117646)
float o31334521117646_2_1_f = o31334521117646_0_d.y;
return vec4(vec3(o31334521117646_2_1_f), 1.0);
}
vec4 o31336349832183_grad_gradient_fct(float x) {
  if (x < p_o31336349832183_grad_pos[0]) {
    return p_o31336349832183_grad_col[0];
  } else if (x < p_o31336349832183_grad_pos[1]) {
    return mix(p_o31336349832183_grad_col[0], p_o31336349832183_grad_col[1], ((x-p_o31336349832183_grad_pos[0])/(p_o31336349832183_grad_pos[1]-p_o31336349832183_grad_pos[0])));
  }
  return p_o31336349832183_grad_col[1];
}
// #instance: fill_to_gradient (o31336349832183)
vec4 o31336349832183_multiple_gradients(vec2 uv, float _seed_variation_) {
	vec4 bb = vec4(0.0, 0.0, 1.0, 1.0);
	vec3 custom_uv = fill_to_uv_stretch(uv, bb, float((seed_o31336349832183+fract(_seed_variation_))));
	float rnd =  float((seed_o31336349832183+fract(_seed_variation_)))+custom_uv.z;
	vec4 value = vec4(1.0);
	for( int i = 0; i < int(p_o31336349832183_layers); i++) {
		vec2 grad_uv = gradient_uv(custom_uv.xy, p_o31336349832183_rotate, p_o31336349832183_r_rotate, p_o31336349832183_r_offset, vec2(custom_uv.z, (seed_o31336349832183+fract(_seed_variation_)) + float(i)));
		vec4 gradient = o31336349832183_grad_gradient_fct(grad_uv.x);
		//if (grad_uv.x > 0.99999)
		//	gradient = o31336349832183_grad_gradient_fct(0.0);
		value = min(value, gradient);
	}
	return value;
}
vec4 o31334722446655_input_in4(vec2 uv, float _seed_variation_) {
// #output0: fill_to_gradient (o31336349832183)
vec4 o31336349832183_0_1_rgba = o31336349832183_multiple_gradients(uv, _seed_variation_);
return o31336349832183_0_1_rgba;
}
float o31334605006482_input_in(vec2 uv, float _seed_variation_) {
// #code: raymarching (o31334521117646)
vec2 o31334521117646_0_d = raymarch_o31334521117646(uv, _seed_variation_);
// #output0: raymarching (o31334521117646)
float o31334521117646_0_1_f = clamp(1.0-o31334521117646_0_d.x, 0.0, 1.0);
return o31334521117646_0_1_f;
}
// #instance: tiler (o31334605006482)
vec4 tiler_o31334605006482(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o31334605006482_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o31334605006482_offset*seed/tile;
			float mask = 1.0;
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o31334605006482_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o31334605006482_scale+1.0;
				pv /= vec2(p_o31334605006482_scale_x, p_o31334605006482_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o31334605006482_input_in(pv, true ? seed.x : 0.0)*mask*(1.0-p_o31334605006482_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
vec4 o31335611635004_gradient_gradient_fct(float x) {
  if (x < p_o31335611635004_gradient_pos[0]) {
    return p_o31335611635004_gradient_col[0];
  } else if (x < p_o31335611635004_gradient_pos[1]) {
    return mix(p_o31335611635004_gradient_col[0], p_o31335611635004_gradient_col[1], ((x-p_o31335611635004_gradient_pos[0])/(p_o31335611635004_gradient_pos[1]-p_o31335611635004_gradient_pos[0])));
  }
  return p_o31335611635004_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);
	{

		float depth_scale = 0.2*p_o31334152016989_depth_scale;

		vec3 view_dir = normalize(normalize(-VERTEX)*mat3(TANGENT*depth_flip.x,-BINORMAL*depth_flip.y,NORMAL));
		float num_layers = mix(float(depth_max_layers),float(depth_min_layers), abs(dot(vec3(0.0, 0.0, 1.0), view_dir)));
		float layer_depth = 1.0 / num_layers;
		float current_layer_depth = 0.0;
		vec2 P = view_dir.xy * depth_scale;
		vec2 delta = P / num_layers / dot(VIEW, NORMAL);
		vec2  ofs = uv;

		float depth = o31334152016989_input_depth_tex((ofs), _seed_variation_);
		float current_depth = 0.0;
		while(current_depth < depth) {
			ofs -= delta;

			depth = o31334152016989_input_depth_tex((ofs), _seed_variation_);
			current_depth += layer_depth;
		}
		vec2 prev_ofs = ofs + delta;
		float after_depth  = depth - current_depth;

		float before_depth = o31334152016989_input_depth_tex((prev_ofs), _seed_variation_) - current_depth + layer_depth;
		float weight = after_depth / (after_depth - before_depth);
		ofs = mix(ofs, prev_ofs, weight);
		uv = ofs;
	}

// #code: tiler (o31334605006482)
vec3 o31334605006482_0_instance_uv = vec3(0.0);
vec4 o31334605006482_0_rch = tiler_o31334605006482((uv), vec2(p_o31334605006482_tx, p_o31334605006482_ty), int(p_o31334605006482_overlap), o31334605006482_0_instance_uv, vec2(float((seed_o31334605006482+fract(_seed_variation_)))), _seed_variation_);
// #output2: tiler (o31334605006482)
vec3 o31334605006482_2_1_rgb = o31334605006482_0_instance_uv;

// #code: custom_uv2 (o31334722446655)
vec3 o31334722446655_0_map = o31334605006482_2_1_rgb;
float o31334722446655_0_rnd =  float((seed_o31334722446655+fract(_seed_variation_)))+o31334722446655_0_map.z;
// #output2: custom_uv2 (o31334722446655)
vec4 o31334722446655_2_1_rgba = o31334722446655_input_in3(get_from_tileset_clamp(1.0, o31334722446655_0_rnd, custom_uv_transform(o31334722446655_0_map.xy, vec2(p_o31334722446655_sx, p_o31334722446655_sy), p_o31334722446655_rotate*0.01745329251, p_o31334722446655_scale, vec2(o31334722446655_0_map.z, float((seed_o31334722446655+fract(_seed_variation_)))))), true ? o31334722446655_0_rnd : 0.0);

// #code: tones_range_4 (o31336232393686)
float o31336232393686_0_step = clamp(((dot((o31334722446655_2_1_rgba).rgb, vec3(1.0))/3.0) - (p_o31336232393686_value))/max(0.0001, p_o31336232393686_width)+0.5, 0.0, 1.0);
float o31336232393686_0_false = clamp((min(o31336232393686_0_step, 1.0-o31336232393686_0_step) * 2.0) / (1.0 - p_o31336232393686_contrast), 0.0, 1.0);
float o31336232393686_0_true = 1.0-o31336232393686_0_false;
// #output0: tones_range_4 (o31336232393686)
float o31336232393686_0_1_f = o31336232393686_0_false;

// #output0: uniform (o31336249166597)
vec4 o31336249166597_0_1_rgba = p_o31336249166597_color;

// #code: tones_range (o31335410311903)
float o31335410311903_0_step = clamp(((dot((o31334722446655_2_1_rgba).rgb, vec3(1.0))/3.0) - (p_o31335410311903_value))/max(0.0001, p_o31335410311903_width)+0.5, 0.0, 1.0);
float o31335410311903_0_false = clamp((min(o31335410311903_0_step, 1.0-o31335410311903_0_step) * 2.0) / (1.0 - p_o31335410311903_contrast), 0.0, 1.0);
float o31335410311903_0_true = 1.0-o31335410311903_0_false;
// #output0: tones_range (o31335410311903)
float o31335410311903_0_1_f = o31335410311903_0_false;

// #output1: custom_uv2 (o31334722446655)
vec4 o31334722446655_1_2_rgba = o31334722446655_input_in2(get_from_tileset_clamp(1.0, o31334722446655_0_rnd, custom_uv_transform(o31334722446655_0_map.xy, vec2(p_o31334722446655_sx, p_o31334722446655_sy), p_o31334722446655_rotate*0.01745329251, p_o31334722446655_scale, vec2(o31334722446655_0_map.z, float((seed_o31334722446655+fract(_seed_variation_)))))), true ? o31334722446655_0_rnd : 0.0);

// #code: blend2 (o31335427089921)
vec4 o31335427089921_0_b = o31334722446655_1_2_rgba;
vec4 o31335427089921_0_l;
float o31335427089921_0_a;

o31335427089921_0_l = vec4(vec3(o31335410311903_0_1_f), 1.0);
o31335427089921_0_a = p_o31335427089921_amount1*1.0;
o31335427089921_0_b = vec4(blend_multiply((uv), o31335427089921_0_l.rgb, o31335427089921_0_b.rgb, o31335427089921_0_a*o31335427089921_0_l.a), min(1.0, o31335427089921_0_b.a+o31335427089921_0_a*o31335427089921_0_l.a));

o31335427089921_0_l = o31336249166597_0_1_rgba;
o31335427089921_0_a = p_o31335427089921_amount2*o31336232393686_0_1_f;
o31335427089921_0_b = vec4(blend_normal((uv), o31335427089921_0_l.rgb, o31335427089921_0_b.rgb, o31335427089921_0_a*o31335427089921_0_l.a), min(1.0, o31335427089921_0_b.a+o31335427089921_0_a*o31335427089921_0_l.a));
// #output0: blend2 (o31335427089921)
vec4 o31335427089921_0_1_rgba = o31335427089921_0_b;

// #output0: custom_uv2 (o31334722446655)
vec4 o31334722446655_0_3_rgba = o31334722446655_input_in1(get_from_tileset_clamp(1.0, o31334722446655_0_rnd, custom_uv_transform(o31334722446655_0_map.xy, vec2(p_o31334722446655_sx, p_o31334722446655_sy), p_o31334722446655_rotate*0.01745329251, p_o31334722446655_scale, vec2(o31334722446655_0_map.z, float((seed_o31334722446655+fract(_seed_variation_)))))), true ? o31334722446655_0_rnd : 0.0);

// #code: tones_range_2 (o31335460641716)
float o31335460641716_0_step = clamp(((dot((o31334722446655_2_1_rgba).rgb, vec3(1.0))/3.0) - (p_o31335460641716_value))/max(0.0001, p_o31335460641716_width)+0.5, 0.0, 1.0);
float o31335460641716_0_false = clamp((min(o31335460641716_0_step, 1.0-o31335460641716_0_step) * 2.0) / (1.0 - p_o31335460641716_contrast), 0.0, 1.0);
float o31335460641716_0_true = 1.0-o31335460641716_0_false;
// #output0: tones_range_2 (o31335460641716)
float o31335460641716_0_1_f = o31335460641716_0_false;

// #output0: fbm3 (o31335561300277)
float o31335561300277_0_1_f = fbm_2d_value((uv), vec2(p_o31335561300277_scale_x, p_o31335561300277_scale_y), int(p_o31335561300277_folds), int(p_o31335561300277_iterations), p_o31335561300277_persistence, p_o31335561300277_offset, (seed_o31335561300277+fract(_seed_variation_)));

// #output0: scratches (o31335544529324)
float o31335544529324_0_1_f = scratches((uv), int(p_o31335544529324_layers), vec2(p_o31335544529324_length, p_o31335544529324_width), p_o31335544529324_waviness, p_o31335544529324_angle, p_o31335544529324_randomness, vec2(float((seed_o31335544529324+fract(_seed_variation_))), 0.0));

// #output0: uniform_greyscale_2 (o31335510976885)
float o31335510976885_0_1_f = p_o31335510976885_color;

// #code: blend2_3 (o31335527751407)
vec4 o31335527751407_0_b = vec4(vec3(o31335510976885_0_1_f), 1.0);
vec4 o31335527751407_0_l;
float o31335527751407_0_a;

o31335527751407_0_l = vec4(vec3(o31335544529324_0_1_f), 1.0);
o31335527751407_0_a = p_o31335527751407_amount1*1.0;
o31335527751407_0_b = vec4(blend_normal((uv), o31335527751407_0_l.rgb, o31335527751407_0_b.rgb, o31335527751407_0_a*o31335527751407_0_l.a), min(1.0, o31335527751407_0_b.a+o31335527751407_0_a*o31335527751407_0_l.a));

o31335527751407_0_l = vec4(vec3(o31335561300277_0_1_f), 1.0);
o31335527751407_0_a = p_o31335527751407_amount2*1.0;
o31335527751407_0_b = vec4(blend_normal((uv), o31335527751407_0_l.rgb, o31335527751407_0_b.rgb, o31335527751407_0_a*o31335527751407_0_l.a), min(1.0, o31335527751407_0_b.a+o31335527751407_0_a*o31335527751407_0_l.a));
// #output0: blend2_3 (o31335527751407)
vec4 o31335527751407_0_1_rgba = o31335527751407_0_b;

// #output0: uniform_greyscale (o31335494195275)
float o31335494195275_0_1_f = p_o31335494195275_color;

// #code: blend2_2 (o31335477417192)
vec4 o31335477417192_0_b = vec4(vec3(o31335494195275_0_1_f), 1.0);
vec4 o31335477417192_0_l;
float o31335477417192_0_a;

o31335477417192_0_l = o31335527751407_0_1_rgba;
o31335477417192_0_a = p_o31335477417192_amount1*o31335460641716_0_1_f;
o31335477417192_0_b = vec4(blend_normal((uv), o31335477417192_0_l.rgb, o31335477417192_0_b.rgb, o31335477417192_0_a*o31335477417192_0_l.a), min(1.0, o31335477417192_0_b.a+o31335477417192_0_a*o31335477417192_0_l.a));
// #output0: blend2_2 (o31335477417192)
vec4 o31335477417192_0_1_rgba = o31335477417192_0_b;

// #code: tones_range_3 (o31335594860864)
float o31335594860864_0_step = clamp(((dot((o31334722446655_2_1_rgba).rgb, vec3(1.0))/3.0) - (p_o31335594860864_value))/max(0.0001, p_o31335594860864_width)+0.5, 0.0, 1.0);
float o31335594860864_0_false = clamp((min(o31335594860864_0_step, 1.0-o31335594860864_0_step) * 2.0) / (1.0 - p_o31335594860864_contrast), 0.0, 1.0);
float o31335594860864_0_true = 1.0-o31335594860864_0_false;
// #output0: tones_range_3 (o31335594860864)
float o31335594860864_0_1_f = o31335594860864_0_false;

// #output1: tiler (o31334605006482)
vec3 o31334605006482_1_2_rgb = o31334605006482_0_rch.rgb;

// #output0: colorize_2 (o31335611635004)
vec4 o31335611635004_0_1_rgba = o31335611635004_gradient_gradient_fct((dot(o31334605006482_1_2_rgb, vec3(1.0))/3.0));

// #code: blend2_4 (o31335578082643)
vec4 o31335578082643_0_b = o31335427089921_0_1_rgba;
vec4 o31335578082643_0_l;
float o31335578082643_0_a;

o31335578082643_0_l = o31335611635004_0_1_rgba;
o31335578082643_0_a = p_o31335578082643_amount1*o31335594860864_0_1_f;
o31335578082643_0_b = vec4(blend_normal((uv), o31335578082643_0_l.rgb, o31335578082643_0_b.rgb, o31335578082643_0_a*o31335578082643_0_l.a), min(1.0, o31335578082643_0_b.a+o31335578082643_0_a*o31335578082643_0_l.a));
// #output0: blend2_4 (o31335578082643)
vec4 o31335578082643_0_1_rgba = o31335578082643_0_b;

	vec3 albedo_tex = ((o31335578082643_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o31334152016989_albedo_color.rgb;
	METALLIC = 1.0*p_o31334152016989_metallic;
	ROUGHNESS = (dot((o31335477417192_0_1_rgba).rgb, vec3(1.0))/3.0)*p_o31334152016989_roughness;
	NORMAL_MAP = ((o31334722446655_0_3_rgba).rgb);
	NORMAL_MAP_DEPTH = p_o31334152016989_normal;
	EMISSION = ((o31335427089921_0_1_rgba).rgb)*p_o31334152016989_emission_energy;
}



