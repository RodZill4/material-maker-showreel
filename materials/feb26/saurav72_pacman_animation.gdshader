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
const vec4 p_o31600741980450_albedo_color = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o31600741980450_metallic = 0.000000000;
const float p_o31600741980450_roughness = 1.000000000;
const float p_o31600741980450_emission_energy = 1.000000000;
const float p_o31600741980450_normal = 1.000000000;
const float p_o31600741980450_ao = 1.000000000;
const float p_o31600741980450_depth_scale = 0.500000000;
const float p_o31602050607211_amount1 = 1.000000000;
const float p_o31601345962515_translate_x = 0.000000000;
const float p_o31601345962515_translate_y = 0.000000000;
const float p_o31601345962515_rotate = 1.000000000;
const float p_o31601345962515_scale_x = 1.000000000;
const float p_o31601345962515_scale_y = 1.000000000;
const float p_o31601933162469_default_in2 = 25.000000000;
const float p_o31601312405605_translate_x = 0.000000000;
const float p_o31601312405605_translate_y = 0.295000000;
const float p_o31601312405605_rotate = 0.000000000;
const float p_o31601312405605_scale_x = -1.000000000;
const float p_o31601312405605_scale_y = 1.000000000;
const float p_o31601329184512_default_in1 = 0.270000000;
const float p_o31601329184512_default_in2 = 0.410000000;
const float p_o31602017048745_default_in1 = 0.000000000;
const float p_o31602017048745_default_in2 = 0.000000000;
const float p_o31602100937700_default_in1 = 0.000000000;
const float p_o31602100937700_default_in2 = 0.000000000;
const float p_o31602117716159_translate_x = 0.010000000;
const float p_o31602117716159_translate_y = 0.220000000;
const float p_o31602117716159_rotate = 0.000000000;
const float p_o31602117716159_scale_x = 0.125000000;
const float p_o31602117716159_scale_y = 0.125000000;
const float p_o31602000276161_sides = 6.000000000;
const float p_o31602000276161_radius = 0.890000000;
const float p_o31602000276161_edge = 0.000000000;
const float p_o31601228519509_default_in1 = 0.000000000;
const float p_o31601228519509_default_in2 = 0.000000000;
const float p_o31601262072207_default_in1 = 0.000000000;
const float p_o31601262072207_default_in2 = 0.000000000;
const float p_o31601245295709_default_in1 = 0.170000000;
const float p_o31601245295709_default_in2 = 1.000000000;
const float p_o31601295629337_default_in1 = 1.000000000;
const float p_o31601295629337_default_in2 = 0.000000000;
const float p_o31601278855339_default_in1 = 0.525000000;
const float p_o31601278855339_default_in2 = 0.450000000;
const float p_o31601949942785_default_in1 = 0.400000000;
const float p_o31601949942785_default_in2 = 0.000000000;
const float p_o31601966717579_default_in1 = 0.055000000;
const float p_o31601966717579_default_in2 = 0.000000000;
const float p_o31601983497343_default_in2 = 15.000000000;
const float p_o31600758761898_repeat = 1.000000000;
const float p_o31600758761898_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o31600758761898_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o31600976862575_default_in1 = 0.000000000;
const float p_o31600976862575_default_in2 = 0.860000000;
const float p_o31600993638891_default_in1 = 0.000000000;
const float p_o31600993638891_default_in2 = 0.550000000;
const float p_o31601010418462_repeat = 1.000000000;
const float p_o31601010418462_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o31601010418462_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const vec4 p_o31602067383550_color = vec4(0.925781250, 0.835994482, 0.104873657, 1.000000000);
const float p_o31602033826962_amount1 = 1.000000000;
const float seed_o31601597621329 = 0.000000000;
const float p_o31601597621329_count = 20.000000000;
const float p_o31601597621329_rings = 1.000000000;
const float p_o31601597621329_scale_x = 0.060000000;
const float p_o31601597621329_scale_y = 0.060000000;
const float p_o31601597621329_radius = 0.320000000;
const float p_o31601597621329_spiral = 0.000000000;
const float p_o31601597621329_i_rotate = 0.000000000;
const float p_o31601597621329_i_scale = 0.000000000;
const float p_o31601597621329_rotate = 0.000000000;
const float p_o31601597621329_scale = 0.200000000;
const float p_o31601597621329_value = 0.000000000;
const float p_o31601882832505_default_in1 = 0.000000000;
const float p_o31601882832505_default_in2 = 0.250000000;
const float p_o31601899607937_translate_x = 0.000000000;
const float p_o31601899607937_translate_y = 0.000000000;
const float p_o31601899607937_rotate = 1.000000000;
const float p_o31601899607937_scale_x = 1.000000000;
const float p_o31601899607937_scale_y = 1.000000000;
const float p_o31601916385047_default_in1 = 52.500000000;
const float p_o31601916385047_default_in2 = 0.000000000;
const float p_o31601664726306_repeat = 1.000000000;
const float p_o31601664726306_gradient_pos[2] = float[]( 0.000000000, 1.000000000 );
const vec4 p_o31601664726306_gradient_col[2] = vec4[]( vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000), vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000) );
const float p_o31602235151897_amount1 = 0.890000000;
const vec4 p_o31602084162039_color = vec4(0.775726318, 0.813745499, 0.867187500, 1.000000000);
const float p_o31602134490629_amount1 = 1.000000000;
const float p_o31602201598652_translate_x = 0.000000000;
const float p_o31602201598652_translate_y = 0.100000000;
const float p_o31602201598652_rotate = 0.000000000;
const float p_o31602201598652_scale_x = 1.000000000;
const float p_o31602201598652_scale_y = 1.000000000;
const float p_o31602218374807_default_in1 = 0.000000000;
const float p_o31602218374807_default_in2 = 8.000000000;
const float seed_o31602184823419 = 0.295020849;
const float p_o31602184823419_density = 0.740000000;
const vec4 p_o31602151267209_color = vec4(0.000000000, 0.000000000, 0.000000000, 1.000000000);
const vec4 p_o31602168042570_color = vec4(0.142521963, 0.808593750, 0.085281372, 1.000000000);
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
// #globals: blend2_2 (o31602050607211)
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
// #globals: transform2_2 (o31601345962515)
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
// #globals: math_13 (o31601933162469)
float pingpong(float a, float b)
{
  return (b != 0.0) ? abs(fract((a - b) / (b * 2.0)) * b * 2.0 - b) : 0.0;
}
// #globals: shape (o31602000276161)
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
// #globals: circular_gradient (o31600758761898)
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
vec4 o31600758761898_gradient_gradient_fct(float x) {
  if (x < p_o31600758761898_gradient_pos[0]) {
    return p_o31600758761898_gradient_col[0];
  } else if (x < p_o31600758761898_gradient_pos[1]) {
    return mix(p_o31600758761898_gradient_col[0], p_o31600758761898_gradient_col[1], ((x-p_o31600758761898_gradient_pos[0])/(p_o31600758761898_gradient_pos[1]-p_o31600758761898_gradient_pos[0])));
  }
  return p_o31600758761898_gradient_col[1];
}
vec4 o31601010418462_gradient_gradient_fct(float x) {
  if (x < p_o31601010418462_gradient_pos[0]) {
    return p_o31601010418462_gradient_col[0];
  } else if (x < p_o31601010418462_gradient_pos[1]) {
    return mix(p_o31601010418462_gradient_col[0], p_o31601010418462_gradient_col[1], ((x-p_o31601010418462_gradient_pos[0])/(p_o31601010418462_gradient_pos[1]-p_o31601010418462_gradient_pos[0])));
  }
  return p_o31601010418462_gradient_col[1];
}
float o31601597621329_input_in(vec2 uv, float _seed_variation_) {
// #output0: radial_gradient (o31601010418462)
vec4 o31601010418462_0_1_rgba = o31601010418462_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((uv))-vec2(0.5, 0.5))*p_o31601010418462_repeat)-0.5)) : fract(p_o31601010418462_repeat*1.41421356237*length(fract((uv))-vec2(0.5, 0.5))) );
// #code: math_3 (o31600993638891)
float o31600993638891_0_clamp_false = (1.0-step(p_o31600993638891_default_in2,(dot((o31601010418462_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o31600993638891_0_clamp_true = clamp(o31600993638891_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o31600993638891)
float o31600993638891_0_1_f = o31600993638891_0_clamp_false;
return o31600993638891_0_1_f;
}
vec4 o31601664726306_gradient_gradient_fct(float x) {
  if (x < p_o31601664726306_gradient_pos[0]) {
    return p_o31601664726306_gradient_col[0];
  } else if (x < p_o31601664726306_gradient_pos[1]) {
    return mix(p_o31601664726306_gradient_col[0], p_o31601664726306_gradient_col[1], ((x-p_o31601664726306_gradient_pos[0])/(p_o31601664726306_gradient_pos[1]-p_o31601664726306_gradient_pos[0])));
  }
  return p_o31601664726306_gradient_col[1];
}
float o31601597621329_input_mask(vec2 uv, float _seed_variation_) {
// #code: math_13 (o31601933162469)
float o31601933162469_0_clamp_false = (elapsed_time)*p_o31601933162469_default_in2;
float o31601933162469_0_clamp_true = clamp(o31601933162469_0_clamp_false, 0.0, 1.0);
// #output0: math_13 (o31601933162469)
float o31601933162469_0_1_f = o31601933162469_0_clamp_false;
// #code: math_11 (o31601916385047)
float o31601916385047_0_clamp_false = p_o31601916385047_default_in1+o31601933162469_0_1_f;
float o31601916385047_0_clamp_true = clamp(o31601916385047_0_clamp_false, 0.0, 1.0);
// #output0: math_11 (o31601916385047)
float o31601916385047_0_1_f = o31601916385047_0_clamp_false;
// #output0: circular_gradient_3 (o31601664726306)
vec4 o31601664726306_0_1_rgba = o31601664726306_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o31601664726306_repeat*0.15915494309*atan((transform2((uv), vec2(p_o31601899607937_translate_x*(2.0*1.0-1.0), p_o31601899607937_translate_y*(2.0*1.0-1.0)), p_o31601899607937_rotate*0.01745329251*(2.0*o31601916385047_0_1_f-1.0), vec2(p_o31601899607937_scale_x*(2.0*1.0-1.0), p_o31601899607937_scale_y*(2.0*1.0-1.0)))).y-0.5, (transform2((uv), vec2(p_o31601899607937_translate_x*(2.0*1.0-1.0), p_o31601899607937_translate_y*(2.0*1.0-1.0)), p_o31601899607937_rotate*0.01745329251*(2.0*o31601916385047_0_1_f-1.0), vec2(p_o31601899607937_scale_x*(2.0*1.0-1.0), p_o31601899607937_scale_y*(2.0*1.0-1.0)))).x-0.5))-0.5)) : fract(p_o31601664726306_repeat*0.15915494309*atan((transform2((uv), vec2(p_o31601899607937_translate_x*(2.0*1.0-1.0), p_o31601899607937_translate_y*(2.0*1.0-1.0)), p_o31601899607937_rotate*0.01745329251*(2.0*o31601916385047_0_1_f-1.0), vec2(p_o31601899607937_scale_x*(2.0*1.0-1.0), p_o31601899607937_scale_y*(2.0*1.0-1.0)))).y-0.5, (transform2((uv), vec2(p_o31601899607937_translate_x*(2.0*1.0-1.0), p_o31601899607937_translate_y*(2.0*1.0-1.0)), p_o31601899607937_rotate*0.01745329251*(2.0*o31601916385047_0_1_f-1.0), vec2(p_o31601899607937_scale_x*(2.0*1.0-1.0), p_o31601899607937_scale_y*(2.0*1.0-1.0)))).x-0.5)));
// #output0: transform2_3 (o31601899607937)
vec4 o31601899607937_0_1_rgba = o31601664726306_0_1_rgba;
// #code: math_10 (o31601882832505)
float o31601882832505_0_clamp_false = (1.0-step(p_o31601882832505_default_in2,(dot((o31601899607937_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o31601882832505_0_clamp_true = clamp(o31601882832505_0_clamp_false, 0.0, 1.0);
// #output0: math_10 (o31601882832505)
float o31601882832505_0_1_f = o31601882832505_0_clamp_false;
return o31601882832505_0_1_f;
}
// #instance: circle_splatter (o31601597621329)
vec4 splatter_o31601597621329(vec2 uv, int count, int rings, inout vec3 instance_uv, vec2 seed, float _seed_variation_) {
	float c = 0.0;
	vec3 rc = vec3(0.0);
	vec3 rc1;
	seed = rand2(seed);
	for (int i = 0; i < count; ++i) {
		float a = -1.57079632679+6.28318530718*float(i)*p_o31601597621329_rings/float(count);
		float rings_distance = ceil(float(i+1)*float(rings)/float(count))/float(rings);
		float spiral_distance = float(i+1)/float(count);
		vec2 pos = p_o31601597621329_radius*mix(rings_distance, spiral_distance, p_o31601597621329_spiral)*vec2(cos(a), sin(a));
		float mask = o31601597621329_input_mask((fract(pos-vec2(0.5))), _seed_variation_);
		if (mask > 0.01) {
			vec2 pv = uv-0.5-pos;
			rc1 = rand3(seed);
			seed = rand2(seed);
			float angle = (seed.x * 2.0 - 1.0) * p_o31601597621329_rotate * 0.01745329251 + (a+1.57079632679) * p_o31601597621329_i_rotate;
			float ca = cos(angle);
			float sa = sin(angle);
			pv = vec2(ca*pv.x+sa*pv.y, -sa*pv.x+ca*pv.y);
			pv /= mix(1.0, float(i+1)/float(count+1), p_o31601597621329_i_scale);
			pv /= vec2(p_o31601597621329_scale_x, p_o31601597621329_scale_y);
			pv *= (seed.y-0.5)*2.0*p_o31601597621329_scale+1.0;
			pv += vec2(0.5);
			seed = rand2(seed);
			vec2 test_value = clamp(pv, vec2(0.0), vec2(1.0));
			if (pv.x != test_value.x || pv.y != test_value.y) {
				continue;
			}
			vec2 full_uv = pv;
			pv = get_from_tileset( 1.0, seed.x, pv);
			float c1 = o31601597621329_input_in(pv, false ? seed.x : 0.0)*mask*(1.0-p_o31601597621329_value*seed.x);
			c = max(c, c1);
			rc = mix(rc, rc1, step(c, c1));
			instance_uv = mix(instance_uv, vec3(full_uv, seed.x), step(c, c1));
		}
	}
	return vec4(rc, c);
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV);

// #code: math_13 (o31601933162469)
float o31601933162469_0_clamp_false = (elapsed_time)*p_o31601933162469_default_in2;
float o31601933162469_0_clamp_true = clamp(o31601933162469_0_clamp_false, 0.0, 1.0);
// #output0: math_13 (o31601933162469)
float o31601933162469_0_1_f = o31601933162469_0_clamp_false;

// #code: math_8 (o31601329184512)
float o31601329184512_0_clamp_false = p_o31601329184512_default_in1+p_o31601329184512_default_in2;
float o31601329184512_0_clamp_true = clamp(o31601329184512_0_clamp_false, 0.0, 1.0);
// #output0: math_8 (o31601329184512)
float o31601329184512_0_1_f = o31601329184512_0_clamp_false;

// #output0: shape (o31602000276161)
float o31602000276161_0_1_f = shape_circle((transform2_clamp(transform2((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))), vec2(p_o31602117716159_translate_x*(2.0*1.0-1.0), p_o31602117716159_translate_y*(2.0*1.0-1.0)), p_o31602117716159_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31602117716159_scale_x*(2.0*1.0-1.0), p_o31602117716159_scale_y*(2.0*1.0-1.0))))), p_o31602000276161_sides+1.0e-5, p_o31602000276161_radius*1.0, p_o31602000276161_edge*1.0);

// #output0: transform2_4 (o31602117716159)
vec4 o31602117716159_0_1_rgba = vec4(vec3(o31602000276161_0_1_f), 1.0);

// #code: math_16 (o31601983497343)
float o31601983497343_0_clamp_false = sin((elapsed_time)*p_o31601983497343_default_in2);
float o31601983497343_0_clamp_true = clamp(o31601983497343_0_clamp_false, 0.0, 1.0);
// #output0: math_16 (o31601983497343)
float o31601983497343_0_1_f = o31601983497343_0_clamp_false;

// #code: math_15 (o31601966717579)
float o31601966717579_0_clamp_false = p_o31601966717579_default_in1*o31601983497343_0_1_f;
float o31601966717579_0_clamp_true = clamp(o31601966717579_0_clamp_false, 0.0, 1.0);
// #output0: math_15 (o31601966717579)
float o31601966717579_0_1_f = o31601966717579_0_clamp_false;

// #code: math_14 (o31601949942785)
float o31601949942785_0_clamp_false = p_o31601949942785_default_in1+o31601966717579_0_1_f;
float o31601949942785_0_clamp_true = clamp(o31601949942785_0_clamp_false, 0.0, 1.0);
// #output0: math_14 (o31601949942785)
float o31601949942785_0_1_f = o31601949942785_0_clamp_false;

// #code: math_6 (o31601278855339)
float o31601278855339_0_clamp_false = p_o31601278855339_default_in1+o31601949942785_0_1_f;
float o31601278855339_0_clamp_true = clamp(o31601278855339_0_clamp_false, 0.0, 1.0);
// #output0: math_6 (o31601278855339)
float o31601278855339_0_1_f = o31601278855339_0_clamp_false;

// #code: math_7 (o31601295629337)
float o31601295629337_0_clamp_false = p_o31601295629337_default_in1-o31601278855339_0_1_f;
float o31601295629337_0_clamp_true = clamp(o31601295629337_0_clamp_false, 0.0, 1.0);
// #output0: math_7 (o31601295629337)
float o31601295629337_0_1_f = o31601295629337_0_clamp_false;

// #output0: circular_gradient (o31600758761898)
vec4 o31600758761898_0_1_rgba = o31600758761898_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(p_o31600758761898_repeat*0.15915494309*atan((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))).y-0.5, (transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))).x-0.5))-0.5)) : fract(p_o31600758761898_repeat*0.15915494309*atan((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))).y-0.5, (transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))).x-0.5)));

// #code: math_2 (o31601245295709)
float o31601245295709_0_clamp_false = (1.0-step((dot((o31600758761898_0_1_rgba).rgb, vec3(1.0))/3.0),o31601295629337_0_1_f));
float o31601245295709_0_clamp_true = clamp(o31601245295709_0_clamp_false, 0.0, 1.0);
// #output0: math_2 (o31601245295709)
float o31601245295709_0_1_f = o31601245295709_0_clamp_false;

// #code: math (o31600976862575)
float o31600976862575_0_clamp_false = (1.0-step(o31601278855339_0_1_f,(dot((o31600758761898_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o31600976862575_0_clamp_true = clamp(o31600976862575_0_clamp_false, 0.0, 1.0);
// #output0: math (o31600976862575)
float o31600976862575_0_1_f = o31600976862575_0_clamp_false;

// #code: math_5 (o31601262072207)
float o31601262072207_0_clamp_false = o31600976862575_0_1_f*o31601245295709_0_1_f;
float o31601262072207_0_clamp_true = clamp(o31601262072207_0_clamp_false, 0.0, 1.0);
// #output0: math_5 (o31601262072207)
float o31601262072207_0_1_f = o31601262072207_0_clamp_false;

// #output0: radial_gradient (o31601010418462)
vec4 o31601010418462_0_1_rgba = o31601010418462_gradient_gradient_fct(false ? 2.0*(0.5-abs(fract(1.41421356237*length(fract((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))))-vec2(0.5, 0.5))*p_o31601010418462_repeat)-0.5)) : fract(p_o31601010418462_repeat*1.41421356237*length(fract((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))))-vec2(0.5, 0.5))) );

// #code: math_3 (o31600993638891)
float o31600993638891_0_clamp_false = (1.0-step(p_o31600993638891_default_in2,(dot((o31601010418462_0_1_rgba).rgb, vec3(1.0))/3.0)));
float o31600993638891_0_clamp_true = clamp(o31600993638891_0_clamp_false, 0.0, 1.0);
// #output0: math_3 (o31600993638891)
float o31600993638891_0_1_f = o31600993638891_0_clamp_false;

// #code: math_4 (o31601228519509)
float o31601228519509_0_clamp_false = o31600993638891_0_1_f*o31601262072207_0_1_f;
float o31601228519509_0_clamp_true = clamp(o31601228519509_0_clamp_false, 0.0, 1.0);
// #output0: math_4 (o31601228519509)
float o31601228519509_0_1_f = o31601228519509_0_clamp_false;

// #code: math_18 (o31602100937700)
float o31602100937700_0_clamp_false = o31601228519509_0_1_f-(dot((o31602117716159_0_1_rgba).rgb, vec3(1.0))/3.0);
float o31602100937700_0_clamp_true = clamp(o31602100937700_0_clamp_false, 0.0, 1.0);
// #output0: math_18 (o31602100937700)
float o31602100937700_0_1_f = o31602100937700_0_clamp_false;

// #output0: shape (o31602000276161)
float o31602000276161_0_3_f = shape_circle((transform2_clamp(transform2((transform2((uv), vec2(p_o31601345962515_translate_x*(2.0*1.0-1.0), p_o31601345962515_translate_y*(2.0*1.0-1.0)), p_o31601345962515_rotate*0.01745329251*(2.0*o31601933162469_0_1_f-1.0), vec2(p_o31601345962515_scale_x*(2.0*1.0-1.0), p_o31601345962515_scale_y*(2.0*1.0-1.0)))), vec2(p_o31601312405605_translate_x*(2.0*1.0-1.0), p_o31601312405605_translate_y*(2.0*1.0-1.0)), p_o31601312405605_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31601312405605_scale_x*(2.0*o31601329184512_0_1_f-1.0), p_o31601312405605_scale_y*(2.0*o31601329184512_0_1_f-1.0))))), p_o31602000276161_sides+1.0e-5, p_o31602000276161_radius*1.0, p_o31602000276161_edge*1.0);

// #code: math_17 (o31602017048745)
float o31602017048745_0_clamp_false = o31602000276161_0_3_f*o31602100937700_0_1_f;
float o31602017048745_0_clamp_true = clamp(o31602017048745_0_clamp_false, 0.0, 1.0);
// #output0: math_17 (o31602017048745)
float o31602017048745_0_1_f = o31602017048745_0_clamp_false;

// #output0: transform2 (o31601312405605)
vec4 o31601312405605_0_1_rgba = vec4(vec3(o31602017048745_0_1_f), 1.0);

// #output0: transform2_2 (o31601345962515)
vec4 o31601345962515_0_1_rgba = o31601312405605_0_1_rgba;

// #output0: uniform_2 (o31602067383550)
vec4 o31602067383550_0_1_rgba = p_o31602067383550_color;

// #code: circle_splatter (o31601597621329)
vec3 o31601597621329_0_instance_uv = vec3(0.0);
vec4 o31601597621329_0_rch = splatter_o31601597621329((uv), int(p_o31601597621329_count), int(p_o31601597621329_rings), o31601597621329_0_instance_uv, vec2(float((seed_o31601597621329+fract(_seed_variation_)))), _seed_variation_);
// #output0: circle_splatter (o31601597621329)
float o31601597621329_0_1_f = o31601597621329_0_rch.a;

// #output1: circle_splatter (o31601597621329)
vec3 o31601597621329_1_2_rgb = o31601597621329_0_rch.rgb;

// #output0: uniform_3 (o31602084162039)
vec4 o31602084162039_0_1_rgba = p_o31602084162039_color;

// #code: blend2_4 (o31602235151897)
vec4 o31602235151897_0_b = o31602084162039_0_1_rgba;
vec4 o31602235151897_0_l;
float o31602235151897_0_a;

o31602235151897_0_l = vec4(o31601597621329_1_2_rgb, 1.0);
o31602235151897_0_a = p_o31602235151897_amount1*1.0;
o31602235151897_0_b = vec4(blend_hard_light((uv), o31602235151897_0_l.rgb, o31602235151897_0_b.rgb, o31602235151897_0_a*o31602235151897_0_l.a), min(1.0, o31602235151897_0_b.a+o31602235151897_0_a*o31602235151897_0_l.a));
// #output0: blend2_4 (o31602235151897)
vec4 o31602235151897_0_1_rgba = o31602235151897_0_b;

// #code: math_12 (o31602218374807)
float o31602218374807_0_clamp_false = o31601933162469_0_1_f/p_o31602218374807_default_in2;
float o31602218374807_0_clamp_true = clamp(o31602218374807_0_clamp_false, 0.0, 1.0);
// #output0: math_12 (o31602218374807)
float o31602218374807_0_1_f = o31602218374807_0_clamp_false;

// #code: noise2 (o31602184823419)
vec2 o31602184823419_0_uv = floor((transform2((uv), vec2(p_o31602201598652_translate_x*(2.0*1.0-1.0), p_o31602201598652_translate_y*(2.0*o31602218374807_0_1_f-1.0)), p_o31602201598652_rotate*0.01745329251*(2.0*1.0-1.0), vec2(p_o31602201598652_scale_x*(2.0*1.0-1.0), p_o31602201598652_scale_y*(2.0*1.0-1.0))))*32.0);
// #output0: noise2 (o31602184823419)
float o31602184823419_0_1_f = step(rand(o31602184823419_0_uv+vec2((seed_o31602184823419+fract(_seed_variation_)))), p_o31602184823419_density);

// #output0: transform2_5 (o31602201598652)
vec4 o31602201598652_0_1_rgba = vec4(vec3(o31602184823419_0_1_f), 1.0);

// #output0: uniform_4 (o31602151267209)
vec4 o31602151267209_0_1_rgba = p_o31602151267209_color;

// #output0: uniform_5 (o31602168042570)
vec4 o31602168042570_0_1_rgba = p_o31602168042570_color;

// #code: blend2_3 (o31602134490629)
vec4 o31602134490629_0_b = o31602168042570_0_1_rgba;
vec4 o31602134490629_0_l;
float o31602134490629_0_a;

o31602134490629_0_l = o31602151267209_0_1_rgba;
o31602134490629_0_a = p_o31602134490629_amount1*(dot((o31602201598652_0_1_rgba).rgb, vec3(1.0))/3.0);
o31602134490629_0_b = vec4(blend_normal((uv), o31602134490629_0_l.rgb, o31602134490629_0_b.rgb, o31602134490629_0_a*o31602134490629_0_l.a), min(1.0, o31602134490629_0_b.a+o31602134490629_0_a*o31602134490629_0_l.a));
// #output0: blend2_3 (o31602134490629)
vec4 o31602134490629_0_1_rgba = o31602134490629_0_b;

// #code: blend2 (o31602033826962)
vec4 o31602033826962_0_b = o31602134490629_0_1_rgba;
vec4 o31602033826962_0_l;
float o31602033826962_0_a;

o31602033826962_0_l = o31602235151897_0_1_rgba;
o31602033826962_0_a = p_o31602033826962_amount1*o31601597621329_0_1_f;
o31602033826962_0_b = vec4(blend_normal((uv), o31602033826962_0_l.rgb, o31602033826962_0_b.rgb, o31602033826962_0_a*o31602033826962_0_l.a), min(1.0, o31602033826962_0_b.a+o31602033826962_0_a*o31602033826962_0_l.a));
// #output0: blend2 (o31602033826962)
vec4 o31602033826962_0_1_rgba = o31602033826962_0_b;

// #code: blend2_2 (o31602050607211)
vec4 o31602050607211_0_b = o31602033826962_0_1_rgba;
vec4 o31602050607211_0_l;
float o31602050607211_0_a;

o31602050607211_0_l = o31602067383550_0_1_rgba;
o31602050607211_0_a = p_o31602050607211_amount1*(dot((o31601345962515_0_1_rgba).rgb, vec3(1.0))/3.0);
o31602050607211_0_b = vec4(blend_normal((uv), o31602050607211_0_l.rgb, o31602050607211_0_b.rgb, o31602050607211_0_a*o31602050607211_0_l.a), min(1.0, o31602050607211_0_b.a+o31602050607211_0_a*o31602050607211_0_l.a));
// #output0: blend2_2 (o31602050607211)
vec4 o31602050607211_0_1_rgba = o31602050607211_0_b;

	vec3 albedo_tex = ((o31602050607211_0_1_rgba).rgb).rgb;
	albedo_tex = mix(pow((albedo_tex + vec3(0.055)) * (1.0 / (1.0 + 0.055)),vec3(2.4)),albedo_tex * (1.0 / 12.92),lessThan(albedo_tex,vec3(0.04045)));
	ALBEDO = albedo_tex*p_o31600741980450_albedo_color.rgb;
	METALLIC = 1.0*p_o31600741980450_metallic;
	ROUGHNESS = 1.0*p_o31600741980450_roughness;
	NORMAL_MAP = vec3(0.5);
	NORMAL_MAP_DEPTH = p_o31600741980450_normal;
	EMISSION = vec3(0.0)*p_o31600741980450_emission_energy;
}



