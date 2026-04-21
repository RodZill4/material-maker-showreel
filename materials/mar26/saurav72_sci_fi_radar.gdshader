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
const vec4 p_o3838073376051_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o3838073376051_metallic = 0.000000000;
const float p_o3838073376051_roughness = 0.890000000;
const float p_o3838073376051_emission_energy = 1.000000000;
const float p_o3838073376051_normal = 1.000000000;
const float p_o3838073376051_ao = 1.000000000;
const float p_o3838073376051_depth_scale = 0.500000000;
const float p_o3839231003224_amount1 = 1.000000000;
const float p_o3839231003224_amount2 = 1.000000000;
const float p_o3839231003224_amount3 = 1.000000000;
const float p_o3839231003224_amount4 = 1.000000000;
const float p_o3839231003224_amount5 = 1.000000000;
const float p_o3839348444481_default_in1 = 0.000000000;
const float p_o3839348444481_default_in2 = 0.035000000;
const float p_o3838325033495_repeat = 1.000000000;
const float p_o3838325033495_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o3838325033495_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const vec4 p_o3839365221734_color = vec4(0.495829582, 0.115814209, 0.644531250, 1.000000000);
const float seed_o3839080007461 = 0.270420998;
const float p_o3839080007461_tx = 6.000000000;
const float p_o3839080007461_ty = 6.000000000;
const float p_o3839080007461_overlap = 2.000000000;
const float p_o3839080007461_scale_x = 0.180000000;
const float p_o3839080007461_scale_y = 0.180000000;
const float p_o3839080007461_fixed_offset = 0.000000000;
const float p_o3839080007461_offset = 0.930000000;
const float p_o3839080007461_rotate = 27.000000000;
const float p_o3839080007461_scale = 0.400000000;
const float p_o3839080007461_value = 0.050000000;
const float p_o3839063232073_sides = 5.000000000;
const float p_o3839063232073_radius = 0.200000000;
const float p_o3839063232073_edge = 0.100000000;
const float p_o3839147116387_translate_x = 0.000000000;
const float p_o3839147116387_translate_y = 0.000000000;
const float p_o3839147116387_rotate = 1.000000000;
const float p_o3839147116387_scale_x = 1.000000000;
const float p_o3839147116387_scale_y = 1.000000000;
const float p_o3839163895090_default_in2 = 35.000000000;
const float p_o3839600101809_default_in1 = 0.000000000;
const float p_o3839600101809_default_in2 = 1.500000000;
const float p_o3839616878997_default_in1 = 0.000000000;
const float p_o3839616878997_default_in2 = 1.250000000;
const float p_o3839046453414_default_in1 = 0.000000000;
const float p_o3839046453414_default_in2 = 0.000000000;
const float p_o3839029675978_default_in1 = 0.000000000;
const float p_o3839029675978_default_in2 = 0.000000000;
const float p_o3839012899638_default_in1 = 0.750000000;
const float p_o3839012899638_default_in2 = 0.000000000;
const float p_o3838794795133_repeat = 1.000000000;
const float p_o3838794795133_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o3838794795133_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o3838576691828_repeat = 4.000000000;
const float p_o3838576691828_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o3838576691828_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o3838543136821_default_in1 = 0.000000000;
const float p_o3838543136821_default_in2 = 0.590000000;
const vec4 p_o3839264558269_color = vec4(0.945312500, 0.160911441, 0.077545166, 1.000000000);
const vec4 p_o3839281335984_color = vec4(0.409641981, 0.886718750, 0.142013550, 1.000000000);
const float p_o3839633656406_amount1 = 0.450000000;
const float p_o3839214225305_default_in1 = 0.000000000;
const float p_o3839214225305_default_in2 = 0.000000000;
const float p_o3839197449930_value = 1.000000000;
const float p_o3839197449930_width = 0.001000000;
const float p_o3839197449930_contrast = 0.500000000;
const float p_o3839180672678_x_scale = 1.000000000;
const float p_o3839180672678_y_scale = 1.000000000;
const float p_o3838559914620_default_in1 = 0.000000000;
const float p_o3838559914620_default_in2 = 0.000000000;
const float p_o3838308255544_default_in1 = 0.000000000;
const float p_o3838308255544_default_in2 = 0.125000000;
const float p_o3838090151767_repeat = 7.000000000;
const float p_o3838090151767_gradient_pos[2] = float[]( 0.000000000, 0.867367268 );
const vec4 p_o3838090151767_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const vec4 p_o3839247780382_color = vec4(0.877449989, 0.902343750, 0.105743408, 1.000000000);
const float p_o3839314890306_value = 1.000000000;
const float p_o3839314890306_width = 0.005000000;
const float p_o3839314890306_contrast = 0.500000000;
const float p_o3839298113045_x_scale = 11.000000000;
const float p_o3839298113045_y_scale = 11.000000000;
const vec4 p_o3839331667728_color = vec4(0.096008301, 0.329546720, 0.558593750, 1.000000000);
const float p_o3839381998002_gradient_pos[2] = float[]( 0.417716056, 1.000000000 );
const vec4 p_o3839381998002_gradient_col[2] = vec4[]( vec4(0.053924561, 0.223526031, 0.445312500, 1.000000000), vec4(0.030715942, 0.116935402, 0.238281250, 1.000000000) );
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
// #globals: blend2 (o3839231003224)
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
// #globals: math_9 (o3839348444481)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: radial_gradient_2 (o3838325033495)
// #globals: shape (o3839063232073)
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
// #globals: transform2 (o3839147116387)
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
// #globals: pattern (o3839180672678)
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
vec4 o3838325033495_gradient_gradient_fct(float x) {
  if (x < p_o3838325033495_gradient_pos[0]) {
    return p_o3838325033495_gradient_col[0];
  } else if (x < p_o3838325033495_gradient_pos[1]) {
    return mix(p_o3838325033495_gradient_col[0], p_o3838325033495_gradient_col[1], ((x-p_o3838325033495_gradient_pos[0])/(p_o3838325033495_gradient_pos[1]-p_o3838325033495_gradient_pos[0])));
  }
  return p_o3838325033495_gradient_col[1];
}
float o3839080007461_input_in(vec2 uv, float _seed_variation_) {
// #output0: shape (o3839063232073)
float o3839063232073_0_1_f = shape_circle(uv, p_o3839063232073_sides+1.0e-5, p_o3839063232073_radius*1.0, p_o3839063232073_edge*1.0);
return o3839063232073_0_1_f;
}
vec4 o3838794795133_gradient_gradient_fct(float x) {
  if (x < p_o3838794795133_gradient_pos[0]) {
    return p_o3838794795133_gradient_col[0];
  } else if (x < p_o3838794795133_gradient_pos[1]) {
    return mix(p_o3838794795133_gradient_col[0], p_o3838794795133_gradient_col[1], ((x-p_o3838794795133_gradient_pos[0])/(p_o3838794795133_gradient_pos[1]-p_o3838794795133_gradient_pos[0])));
  }
  return p_o3838794795133_gradient_col[1];
}
vec4 o3838576691828_gradient_gradient_fct(float x) {
  if (x < p_o3838576691828_gradient_pos[0]) {
    return p_o3838576691828_gradient_col[0];
  } else if (x < p_o3838576691828_gradient_pos[1]) {
    return mix(p_o3838576691828_gradient_col[0], p_o3838576691828_gradient_col[1], ((x-p_o3838576691828_gradient_pos[0])/(p_o3838576691828_gradient_pos[1]-p_o3838576691828_gradient_pos[0])));
  }
  return p_o3838576691828_gradient_col[1];
}
float o3839080007461_input_mask(vec2 uv, float _seed_variation_) {
// #code: math_7 (o3839163895090)
float o3839163895090_0_clamp_false = (elapsed_time)*p_o3839163895090_default_in2;
float o3839163895090_0_clamp_true = clamp(o3839163895090_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o3839163895090)
float o3839163895090_0_1_f = o3839163895090_0_clamp_false;
// #output0: circular_gradient_2 (o3838794795133)
vec4 o3838794795133_0_1_rgba = o3838794795133_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o3838794795133_repeat*0.15915494309*atan((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5))-0.5)) : fract(p_o3838794795133_repeat*0.15915494309*atan((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5)));
// #code: math_4 (o3839012899638)
float o3839012899638_0_clamp_false = (1.0-step((dot((o3838794795133_0_1_rgba).rgb, vec3(1.0))/3.0),p_o3839012899638_default_in1));
float o3839012899638_0_clamp_true = clamp(o3839012899638_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o3839012899638)
float o3839012899638_0_1_f = o3839012899638_0_clamp_false;
// #output0: circular_gradient (o3838576691828)
vec4 o3838576691828_0_1_rgba = o3838576691828_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o3838576691828_repeat*0.15915494309*atan((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5))-0.5)) : fract(p_o3838576691828_repeat*0.15915494309*atan((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5)));
// #code: math_5 (o3839029675978)
float o3839029675978_0_clamp_false = (dot((o3838576691828_0_1_rgba).rgb, vec3(1.0))/3.0)*o3839012899638_0_1_f;
float o3839029675978_0_clamp_true = clamp(o3839029675978_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o3839029675978)
float o3839029675978_0_1_f = o3839029675978_0_clamp_false;
// #output0: radial_gradient_2 (o3838325033495)
vec4 o3838325033495_0_1_rgba = o3838325033495_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))))-vec2(0.5, 0.5))*p_o3838325033495_repeat)-0.5)) : fract(p_o3838325033495_repeat*1.41421356237*length(fract((transform2_clamp(transform2(uv, vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))))-vec2(0.5, 0.5))) );
// #code: math_2 (o3838543136821)
float o3838543136821_0_clamp_false = (1.0-step(p_o3838543136821_default_in2,(dot((o3838325033495_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o3838543136821_0_clamp_true = clamp(o3838543136821_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o3838543136821)
float o3838543136821_0_1_f = o3838543136821_0_clamp_false;
// #code: math_6 (o3839046453414)
float o3839046453414_0_clamp_false = o3838543136821_0_1_f*o3839029675978_0_1_f;
float o3839046453414_0_clamp_true = clamp(o3839046453414_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o3839046453414)
float o3839046453414_0_1_f = o3839046453414_0_clamp_false;
// #code: math_11 (o3839616878997)
float o3839616878997_0_clamp_false = o3839046453414_0_1_f*p_o3839616878997_default_in2;
float o3839616878997_0_clamp_true = clamp(o3839616878997_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o3839616878997)
float o3839616878997_0_1_f = o3839616878997_0_clamp_false;
// #code: math_10 (o3839600101809)
float o3839600101809_0_clamp_false = pow(o3839616878997_0_1_f,p_o3839600101809_default_in2);
float o3839600101809_0_clamp_true = clamp(o3839600101809_0_clamp_false, 0.0, 1.0);
// #output0: math_10 (o3839600101809)
float o3839600101809_0_1_f = o3839600101809_0_clamp_false;
// #output0: transform2 (o3839147116387)
vec4 o3839147116387_0_1_rgba = vec4(vec3(o3839600101809_0_1_f), 1.0);
return (dot((o3839147116387_0_1_rgba).rgb, vec3(1.0))/3.0);
}
// #instance: tiler (o3839080007461)
vec4 tiler_o3839080007461(vec2 uv, vec2 tile, int overlap, inout vec3 instance_uv, vec2 _seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	for (int dx = -overlap; dx <= overlap; ++dx) {
		for (int dy = -overlap; dy <= overlap; ++dy) {
			vec2 pos = uv*tile+vec2(float(dx), float(dy)); pos = fract((floor(mod(pos, tile))+vec2(0.5))/tile)-vec2(0.5);
			vec2 seed = rand2(pos+_seed);
			rc1 = rand3(seed);
			vec2 tile_index = floor(uv * tile) + vec2(float(dx), float(dy));
			pos += vec2((p_o3839080007461_fixed_offset/tile.x)*mod(mod(tile_index.y, tile.y), 2.0), 0.0)+p_o3839080007461_offset*seed/tile;
			float mask = o3839080007461_input_mask((fract(pos+vec2(0.5))), _seed_variation_);
			if (mask > 0.01) {
				vec2 pv = fract(uv - pos)-vec2(0.5);
				seed = rand2(seed);
				float angle = (seed.x * 2.0 - 1.0) * p_o3839080007461_rotate * 0.01745329251;
				float ca = cos(angle);
				float sa = sin(angle);
				pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
				pv *= (seed.y-0.5)*2.0*p_o3839080007461_scale+1.0;
				pv /= vec2(p_o3839080007461_scale_x, p_o3839080007461_scale_y);
				pv += vec2(0.5);
				seed = rand2(seed);
				vec2 clamped_pv = clamp(pv, vec2(0.0), vec2(1.0));
				if (pv.x != clamped_pv.x || pv.y != clamped_pv.y) {
					continue;
				}
				vec2 full_uv = pv;
				pv = get_from_tileset( 1.0, seed.x, pv);
				float c1 = o3839080007461_input_in(pv, false ? seed.x : 0.0)*mask*(1.0-p_o3839080007461_value*seed.x);
				c = max(c, c1);
				rc = mix(rc, rc1, step(c, c1));
				instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
			}
		}
	}
	return vec4(rc, c);
}
vec4 o3838090151767_gradient_gradient_fct(float x) {
  if (x < p_o3838090151767_gradient_pos[0]) {
    return p_o3838090151767_gradient_col[0];
  } else if (x < p_o3838090151767_gradient_pos[1]) {
    return mix(p_o3838090151767_gradient_col[0], p_o3838090151767_gradient_col[1], ((x-p_o3838090151767_gradient_pos[0])/(p_o3838090151767_gradient_pos[1]-p_o3838090151767_gradient_pos[0])));
  }
  return p_o3838090151767_gradient_col[1];
}
vec4 o3839381998002_gradient_gradient_fct(float x) {
  if (x < p_o3839381998002_gradient_pos[0]) {
    return p_o3839381998002_gradient_col[0];
  } else if (x < p_o3839381998002_gradient_pos[1]) {
    return mix(p_o3839381998002_gradient_col[0], p_o3839381998002_gradient_col[1], 0.5-0.5*cos(3.14159265359*(x-p_o3839381998002_gradient_pos[0])/(p_o3839381998002_gradient_pos[1]-p_o3839381998002_gradient_pos[0])));
  }
  return p_o3839381998002_gradient_col[1];
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #output0: radial_gradient_2 (o3838325033495)
vec4 o3838325033495_0_1_rgba = o3838325033495_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((uv))-vec2(0.5, 0.5))*p_o3838325033495_repeat)-0.5)) : fract(p_o3838325033495_repeat*1.41421356237*length(fract((uv))-vec2(0.5, 0.5))) );

// #code: math_9 (o3839348444481)
float o3839348444481_0_clamp_false = (1.0-step(p_o3839348444481_default_in2,(dot((o3838325033495_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o3839348444481_0_clamp_true = clamp(o3839348444481_0_clamp_false, 0.0, 1.0);
// #output0: math_9 (o3839348444481)
float o3839348444481_0_1_f = o3839348444481_0_clamp_false;

// #output0: uniform_8 (o3839365221734)
vec4 o3839365221734_0_1_rgba = p_o3839365221734_color;

// #code: tiler (o3839080007461)
vec3 o3839080007461_0_instance_uv = vec3(0.0);
vec4 o3839080007461_0_rch = tiler_o3839080007461((uv), vec2(p_o3839080007461_tx, p_o3839080007461_ty), int(p_o3839080007461_overlap), o3839080007461_0_instance_uv, vec2(float((seed_o3839080007461+fract(_seed_variation_)))), _seed_variation_);
// #output0: tiler (o3839080007461)
float o3839080007461_0_1_f = o3839080007461_0_rch.a;

// #output0: uniform_3 (o3839264558269)
vec4 o3839264558269_0_1_rgba = p_o3839264558269_color;

// #code: math_7 (o3839163895090)
float o3839163895090_0_clamp_false = (elapsed_time)*p_o3839163895090_default_in2;
float o3839163895090_0_clamp_true = clamp(o3839163895090_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o3839163895090)
float o3839163895090_0_1_f = o3839163895090_0_clamp_false;

// #output0: circular_gradient_2 (o3838794795133)
vec4 o3838794795133_0_1_rgba = o3838794795133_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o3838794795133_repeat*0.15915494309*atan((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5))-0.5)) : fract(p_o3838794795133_repeat*0.15915494309*atan((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5)));

// #code: math_4 (o3839012899638)
float o3839012899638_0_clamp_false = (1.0-step((dot((o3838794795133_0_1_rgba).rgb, vec3(1.0))/3.0),p_o3839012899638_default_in1));
float o3839012899638_0_clamp_true = clamp(o3839012899638_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o3839012899638)
float o3839012899638_0_1_f = o3839012899638_0_clamp_false;

// #output0: circular_gradient (o3838576691828)
vec4 o3838576691828_0_1_rgba = o3838576691828_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o3838576691828_repeat*0.15915494309*atan((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5))-0.5)) : fract(p_o3838576691828_repeat*0.15915494309*atan((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).y-0.5, (transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))).x-0.5)));

// #code: math_5 (o3839029675978)
float o3839029675978_0_clamp_false = (dot((o3838576691828_0_1_rgba).rgb, vec3(1.0))/3.0)*o3839012899638_0_1_f;
float o3839029675978_0_clamp_true = clamp(o3839029675978_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o3839029675978)
float o3839029675978_0_1_f = o3839029675978_0_clamp_false;

// #output0: radial_gradient_2 (o3838325033495)
vec4 o3838325033495_0_3_rgba = o3838325033495_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))))-vec2(0.5, 0.5))*p_o3838325033495_repeat)-0.5)) : fract(p_o3838325033495_repeat*1.41421356237*length(fract((transform2_clamp(transform2((uv), vec2(p_o3839147116387_translate_x*(2.0*1.0-1.0), p_o3839147116387_translate_y*(2.0*1.0-1.0)), p_o3839147116387_rotate*0.01745329251*(2.0*o3839163895090_0_1_f-1.0), vec2(p_o3839147116387_scale_x*(2.0*1.0-1.0), p_o3839147116387_scale_y*(2.0*1.0-1.0))))))-vec2(0.5, 0.5))) );

// #code: math_2 (o3838543136821)
float o3838543136821_0_clamp_false = (1.0-step(p_o3838543136821_default_in2,(dot((o3838325033495_0_3_rgba).rgb, vec3(1.0))/3.0)));
float o3838543136821_0_clamp_true = clamp(o3838543136821_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o3838543136821)
float o3838543136821_0_1_f = o3838543136821_0_clamp_false;

// #code: math_6 (o3839046453414)
float o3839046453414_0_clamp_false = o3838543136821_0_1_f*o3839029675978_0_1_f;
float o3839046453414_0_clamp_true = clamp(o3839046453414_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o3839046453414)
float o3839046453414_0_1_f = o3839046453414_0_clamp_false;

// #code: math_11 (o3839616878997)
float o3839616878997_0_clamp_false = o3839046453414_0_1_f*p_o3839616878997_default_in2;
float o3839616878997_0_clamp_true = clamp(o3839616878997_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o3839616878997)
float o3839616878997_0_1_f = o3839616878997_0_clamp_false;

// #code: math_10 (o3839600101809)
float o3839600101809_0_clamp_false = pow(o3839616878997_0_1_f,p_o3839600101809_default_in2);
float o3839600101809_0_clamp_true = clamp(o3839600101809_0_clamp_false, 0.0, 1.0);
// #output0: math_10 (o3839600101809)
float o3839600101809_0_1_f = o3839600101809_0_clamp_false;

// #output0: transform2 (o3839147116387)
vec4 o3839147116387_0_1_rgba = vec4(vec3(o3839600101809_0_1_f), 1.0);

// #output0: uniform_4 (o3839281335984)
vec4 o3839281335984_0_1_rgba = p_o3839281335984_color;

// #output0: invert (o3839650432954)
vec4 o3839650432954_0_1_rgba = vec4(vec3(1.0)-o3838325033495_0_1_rgba.rgb, o3838325033495_0_1_rgba.a);

// #output0: pattern (o3839180672678)
float o3839180672678_0_1_f = mix_max(wave_sine(p_o3839180672678_x_scale*(uv).x), wave_sine(p_o3839180672678_y_scale*(uv).y));

// #code: tones_range (o3839197449930)
float o3839197449930_0_step = clamp((o3839180672678_0_1_f - (p_o3839197449930_value))/max(0.0001, p_o3839197449930_width)+0.5, 0.0, 1.0);
float o3839197449930_0_false = clamp((min(o3839197449930_0_step, 1.0-o3839197449930_0_step) * 2.0) / (1.0 - p_o3839197449930_contrast), 0.0, 1.0);
float o3839197449930_0_true = 1.0-o3839197449930_0_false;
// #output0: tones_range (o3839197449930)
float o3839197449930_0_1_f = o3839197449930_0_false;

// #code: math_2 (o3838543136821)
float o3838543136821_2_clamp_false = (1.0-step(p_o3838543136821_default_in2,(dot((o3838325033495_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o3838543136821_2_clamp_true = clamp(o3838543136821_2_clamp_false, 0.0, 1.0);
// #output0: math_2 (o3838543136821)
float o3838543136821_0_3_f = o3838543136821_2_clamp_false;

// #output0: radial_gradient (o3838090151767)
vec4 o3838090151767_0_1_rgba = o3838090151767_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((uv))-vec2(0.5, 0.5))*p_o3838090151767_repeat)-0.5)) : fract(p_o3838090151767_repeat*1.41421356237*length(fract((uv))-vec2(0.5, 0.5))) );

// #code: math (o3838308255544)
float o3838308255544_0_clamp_false = (1.0-step(p_o3838308255544_default_in2,(dot((o3838090151767_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o3838308255544_0_clamp_true = clamp(o3838308255544_0_clamp_false, 0.0, 1.0);
// #output0: math (o3838308255544)
float o3838308255544_0_1_f = o3838308255544_0_clamp_false;

// #code: math_3 (o3838559914620)
float o3838559914620_0_clamp_false = o3838308255544_0_1_f*o3838543136821_0_3_f;
float o3838559914620_0_clamp_true = clamp(o3838559914620_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o3838559914620)
float o3838559914620_0_1_f = o3838559914620_0_clamp_false;

// #code: math_8 (o3839214225305)
float o3839214225305_0_clamp_false = max(o3838559914620_0_1_f,o3839197449930_0_1_f);
float o3839214225305_0_clamp_true = clamp(o3839214225305_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o3839214225305)
float o3839214225305_0_1_f = o3839214225305_0_clamp_false;

// #code: blend2_2 (o3839633656406)
vec4 o3839633656406_0_b = vec4(vec3(o3839214225305_0_1_f), 1.0);
vec4 o3839633656406_0_l;
float o3839633656406_0_a;

o3839633656406_0_l = o3839650432954_0_1_rgba;
o3839633656406_0_a = p_o3839633656406_amount1*1.0;
o3839633656406_0_b = vec4(blend_multiply((uv), o3839633656406_0_l.rgb, o3839633656406_0_b.rgb, o3839633656406_0_a*o3839633656406_0_l.a), min(1.0, o3839633656406_0_b.a+o3839633656406_0_a*o3839633656406_0_l.a));
// #output0: blend2_2 (o3839633656406)
vec4 o3839633656406_0_1_rgba = o3839633656406_0_b;

// #output0: uniform (o3839247780382)
vec4 o3839247780382_0_1_rgba = p_o3839247780382_color;

// #output0: pattern_2 (o3839298113045)
float o3839298113045_0_1_f = mix_max(wave_sine(p_o3839298113045_x_scale*(uv).x), wave_sine(p_o3839298113045_y_scale*(uv).y));

// #code: tones_range_2 (o3839314890306)
float o3839314890306_0_step = clamp((o3839298113045_0_1_f - (p_o3839314890306_value))/max(0.0001, p_o3839314890306_width)+0.5, 0.0, 1.0);
float o3839314890306_0_false = clamp((min(o3839314890306_0_step, 1.0-o3839314890306_0_step) * 2.0) / (1.0 - p_o3839314890306_contrast), 0.0, 1.0);
float o3839314890306_0_true = 1.0-o3839314890306_0_false;
// #output0: tones_range_2 (o3839314890306)
float o3839314890306_0_1_f = o3839314890306_0_false;

// #output0: uniform_5 (o3839331667728)
vec4 o3839331667728_0_1_rgba = p_o3839331667728_color;

// #output0: colorize (o3839381998002)
vec4 o3839381998002_0_1_rgba = o3839381998002_gradient_gradient_fct((dot((o3838325033495_0_1_rgba).rgb, vec3(1.0))/3.0));

// #code: blend2 (o3839231003224)
vec4 o3839231003224_0_b = o3839381998002_0_1_rgba;
vec4 o3839231003224_0_l;
float o3839231003224_0_a;

o3839231003224_0_l = o3839331667728_0_1_rgba;
o3839231003224_0_a = p_o3839231003224_amount1*o3839314890306_0_1_f;
o3839231003224_0_b = vec4(blend_normal((uv), o3839231003224_0_l.rgb, o3839231003224_0_b.rgb, o3839231003224_0_a*o3839231003224_0_l.a), min(1.0, o3839231003224_0_b.a+o3839231003224_0_a*o3839231003224_0_l.a));

o3839231003224_0_l = o3839247780382_0_1_rgba;
o3839231003224_0_a = p_o3839231003224_amount2*(dot((o3839633656406_0_1_rgba).rgb, vec3(1.0))/3.0);
o3839231003224_0_b = vec4(blend_normal((uv), o3839231003224_0_l.rgb, o3839231003224_0_b.rgb, o3839231003224_0_a*o3839231003224_0_l.a), min(1.0, o3839231003224_0_b.a+o3839231003224_0_a*o3839231003224_0_l.a));

o3839231003224_0_l = o3839281335984_0_1_rgba;
o3839231003224_0_a = p_o3839231003224_amount3*(dot((o3839147116387_0_1_rgba).rgb, vec3(1.0))/3.0);
o3839231003224_0_b = vec4(blend_normal((uv), o3839231003224_0_l.rgb, o3839231003224_0_b.rgb, o3839231003224_0_a*o3839231003224_0_l.a), min(1.0, o3839231003224_0_b.a+o3839231003224_0_a*o3839231003224_0_l.a));

o3839231003224_0_l = o3839264558269_0_1_rgba;
o3839231003224_0_a = p_o3839231003224_amount4*o3839080007461_0_1_f;
o3839231003224_0_b = vec4(blend_normal((uv), o3839231003224_0_l.rgb, o3839231003224_0_b.rgb, o3839231003224_0_a*o3839231003224_0_l.a), min(1.0, o3839231003224_0_b.a+o3839231003224_0_a*o3839231003224_0_l.a));

o3839231003224_0_l = o3839365221734_0_1_rgba;
o3839231003224_0_a = p_o3839231003224_amount5*o3839348444481_0_1_f;
o3839231003224_0_b = vec4(blend_normal((uv), o3839231003224_0_l.rgb, o3839231003224_0_b.rgb, o3839231003224_0_a*o3839231003224_0_l.a), min(1.0, o3839231003224_0_b.a+o3839231003224_0_a*o3839231003224_0_l.a));
// #output0: blend2 (o3839231003224)
vec4 o3839231003224_0_1_rgba = o3839231003224_0_b;

	vec3 albedo_tex = ((o3839231003224_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o3838073376051_albedo_color.rgb;
	METALLIC = 1.0*p_o3838073376051_metallic;
	ROUGHNESS = 1.0*p_o3838073376051_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o3838073376051_normal;
	EMISSION = vec3(0.0)*p_o3838073376051_emission_energy;
}



