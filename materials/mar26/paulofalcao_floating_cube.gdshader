shader_type spatial;

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
const float p_o871240840134_LookAtX = 0.000000000;
const float p_o871240840134_LookAtY = 1.200000000;
const float p_o871240840134_LookAtZ = 0.000000000;
const float p_o871240840134_CamD = 2.287000000;
const float p_o871240840134_CamZoom = 1.000000000;
const float p_o871240840134_SunX = 2.500000000;
const float p_o871240840134_SunY = 2.500000000;
const float p_o871240840134_SunZ = 2.500000000;
const float p_o871240840134_AmbLight = 0.250000000;
const float p_o871240840134_AmbOcclusion = 0.530000000;
const float p_o871240840134_Shadow = 0.894000000;
const float p_o871240840134_Gamma = 1.218000000;
const vec4 p_o871073067979_BaseColor = vec4(1.000000000, 0.000000000, 0.000000000, 1.000000000);
const float p_o871073067979_Metallic = 0.000000000;
const float p_o871073067979_Specular = 1.000000000;
const float p_o871073067979_Roughness = 0.000000000;
const float p_o871073067979_Emission = 0.000000000;
const float p_o871073067979_scale = 1.000000000;
const float p_o871073067979_TranlateX = -0.917000000;
const float p_o871073067979_TranlateZ = -1.467000000;
const float p_o871073067979_RotateY = 29.963000000;
const float p_o871073067979_RotateZ = -22.234000000;
const float p_o871173731274_X = 0.100000000;
const float p_o871173731274_Y = 0.100000000;
const float p_o871173731274_Z = 0.100000000;
const float p_o871173731274_RepX = 128.000000000;
const float p_o871173731274_RepY = 128.000000000;
const float p_o871173731274_RepZ = 128.000000000;
const float p_o871156954060_sx = 0.050000000;
const float p_o871156954060_sy = 0.050000000;
const float p_o871156954060_sz = 0.050000000;
const float p_o871156954060_r = 0.025000000;
const float p_o871140176846_sx = 0.500000000;
const float p_o871140176846_sy = 0.500000000;
const float p_o871140176846_sz = 0.500000000;
const float p_o871140176846_r = 0.000000000;
const vec4 p_o870838186970_BaseColor = vec4(1.000000000, 1.000000000, 1.000000000, 1.000000000);
const float p_o870838186970_Metallic = 1.000000000;
const float p_o870838186970_Specular = 0.000000000;
const float p_o870838186970_Roughness = 0.000000000;
const float p_o870838186970_Emission = 0.000000000;
const float p_o870838186970_scale = 1.000000000;
const float p_o870838186970_TranlateX = 0.000000000;
const float p_o870838186970_TranlateY = 0.552000000;
const float p_o870838186970_TranlateZ = 0.000000000;
const float p_o870838186970_RotateX = 0.000000000;
const float p_o870838186970_RotateY = 0.000000000;
const float p_o870838186970_RotateZ = 0.000000000;
const float p_o870922073044_Distort = 0.045000000;
const float p_o870922073044_Correction = 0.000000000;
const float p_o870922073044_Bound = 10.000000000;
const float p_o870989181901_scale = 2.807000000;
const float p_o870989181901_scale_x = 1.000000000;
const float p_o870989181901_scale_y = 1.000000000;
const float p_o870989181901_scale_z = 1.000000000;
const float p_o870989181901_transx = 0.000000000;
const float p_o870989181901_transz = 0.000000000;
const float p_o870989181901_persistence = 0.500000000;
const float p_o870989181901_brightness = 0.000000000;
const float p_o870989181901_contrast = 2.000000000;
uniform sampler2D texture_1;
// #globals: MFSDF_Boolean (o871224062919)
vec4 mfsdf_boolean_union(vec4 a, vec4 b) {
	return vec4((a.w<b.w)?vec4(a):vec4(b));
}
vec4 mfsdf_boolean_sub(vec4 a, vec4 b) {
	return vec4((-a.w>b.w)?vec4(a.xyz,-a.w):vec4(b));
}
vec4 mfsdf_boolean_inter(vec4 a, vec4 b) {
	return vec4((a.w>b.w)?vec4(a):vec4(b));
}
// #globals: sdf3d_boolean (o871190508489)
vec2 sdf3dc_union(vec2 a, vec2 b) {
	return vec2(min(a.x, b.x), mix(b.y, a.y, step(a.x, b.x)));
}
vec2 sdf3dc_sub(vec2 a, vec2 b) {
	return vec2(max(-a.x, b.x), a.y);
}
vec2 sdf3dc_inter(vec2 a, vec2 b) {
	return vec2(max(a.x, b.x), mix(a.y, b.y, step(a.x, b.x)));
}
// #globals: SDF_Repeat (o871173731274)
//Adapted from https://www.iquilezles.org/www/articles/distfunctions/distfunctions.htm - Finite Repetition
vec3 opRepLim(vec3 p,vec3 c,vec3 l){
    p+=(c*l)/2.0;
    return p-c*clamp(floor((p+0.0001)/c+0.5),vec3(0.0),l);
}
// #globals: sdf3d_box_2 (o871156954060)
float box3d(vec3 uv, vec3 s) {
	vec3 q = abs(uv) - s;
	return length(max(q, 0.0))+min(max(q.x, max(q.y, q.z)), 0.0);
}
// #globals: MFSDF_Object_And_Transform_2 (o871073067979)
vec3 MFSDF_Obj_Maker_rotate3d(vec3 p, vec3 a) {
	vec3 rv;
	float c;
	float s;
	c = cos(a.x);
	s = sin(a.x);
	rv.x = p.x;
	rv.y = p.y*c+p.z*s;
	rv.z = -p.y*s+p.z*c;
	c = cos(a.y);
	s = sin(a.y);
	p.x = rv.x*c+rv.z*s;
	p.y = rv.y;
	p.z = -rv.x*s+rv.z*c;
	c = cos(a.z);
	s = sin(a.z);
	rv.x = p.x*c+p.y*s;
	rv.y = -p.x*s+p.y*c;
	rv.z = p.z;
	return rv;
}
// #globals: sdf3d_plane (o870905295823)
// #globals: TEX3D_Simplex_Noise_Octaves (o870989181901)
// https://www.shadertoy.com/view/XsX3zB
//
// The MIT License
// Copyright © 2013 Nikita Miropolskiy
// 
// ( license has been changed from CCA-NC-SA 3.0 to MIT
//
//   but thanks for attributing your source code when deriving from this sample 
//   with a following link: https://www.shadertoy.com/view/XsX3zB )
//
//
// if you're looking for procedural noise implementation examples you might 
// also want to look at the following shaders:
// 
// Noise Lab shader by candycat: https://www.shadertoy.com/view/4sc3z2
//
// Noise shaders by iq:
//     Value    Noise 2D, Derivatives: https://www.shadertoy.com/view/4dXBRH
//     Gradient Noise 2D, Derivatives: https://www.shadertoy.com/view/XdXBRH
//     Value    Noise 3D, Derivatives: https://www.shadertoy.com/view/XsXfRH
//     Gradient Noise 3D, Derivatives: https://www.shadertoy.com/view/4dffRH
//     Value    Noise 2D             : https://www.shadertoy.com/view/lsf3WH
//     Value    Noise 3D             : https://www.shadertoy.com/view/4sfGzS
//     Gradient Noise 2D             : https://www.shadertoy.com/view/XdXGW8
//     Gradient Noise 3D             : https://www.shadertoy.com/view/Xsl3Dl
//     Simplex  Noise 2D             : https://www.shadertoy.com/view/Msf3WH
//     Voronoise: https://www.shadertoy.com/view/Xd23Dh
//
//
//
// using https://www.shadertoy.com/view/4djSRW Hash without Sine by Dave_Hoskins
// discontinuous pseudorandom uniformly distributed in [-0.5, +0.5]^3 */
vec3 XsX3zB_oct_random3(vec3 c) {
	c = fract(c * vec3(.1031, .1030, .0973));
    c += dot(c, c.yxz+0.3333333);
    return fract((c.xxy + c.yxx)*c.zyx)-0.5;
}
// skew constants for 3d simplex functions
const float XsX3zB_oct_F3 =  0.3333333;
const float XsX3zB_oct_G3 =  0.1666667;
// 3d simplex noise
float XsX3zB_oct_simplex3d(vec3 p) {
	 // 1. find current tetrahedron T and it's four vertices
	 // s, s+i1, s+i2, s+1.0 - absolute skewed (integer) coordinates of T vertices
	 // x, x1, x2, x3 - unskewed coordinates of p relative to each of T vertices
	 
	 // calculate s and x
	 vec3 s = floor(p + dot(p, vec3(XsX3zB_oct_F3)));
	 vec3 x = p - s + dot(s, vec3(XsX3zB_oct_G3));
	 
	 // calculate i1 and i2
	 vec3 e = step(vec3(0.0), x - x.yzx);
	 vec3 i1 = e*(1.0 - e.zxy);
	 vec3 i2 = 1.0 - e.zxy*(1.0 - e);
	 	
	 // x1, x2, x3
	 vec3 x1 = x - i1 + XsX3zB_oct_G3;
	 vec3 x2 = x - i2 + 2.0*XsX3zB_oct_G3;
	 vec3 x3 = x - 1.0 + 3.0*XsX3zB_oct_G3;
	 
	 // 2. find four surflets and store them in d
	 vec4 w, d;
	 
	 // calculate surflet weights
	 w.x = dot(x, x);
	 w.y = dot(x1, x1);
	 w.z = dot(x2, x2);
	 w.w = dot(x3, x3);
	 
	 // w fades from 0.6 at the center of the surflet to 0.0 at the margin
	 w = max(0.6 - w, 0.0);
	 
	 // calculate surflet components
	 d.x = dot(XsX3zB_oct_random3(s), x);
	 d.y = dot(XsX3zB_oct_random3(s + i1), x1);
	 d.z = dot(XsX3zB_oct_random3(s + i2), x2);
	 d.w = dot(XsX3zB_oct_random3(s + 1.0), x3);
	 
	 // multiply d by w^4
	 w *= w;
	 w *= w;
	 d *= w;
	 
	 // 3. return the sum of the four surflets
	 return dot(d, vec4(52.0));
}
// #globals: MFSDF_Render (o871240840134)
vec2 Simple360HDR_equirectangularMap(vec3 dir) {
	vec2 longlat = vec2(atan(dir.y,dir.x),acos(dir.z));
 	return longlat/vec2(2.0*3.14159265359,3.14159265359);
}
//Simple HDRI START
//Hash without Sine Dave_Hoskins
//https://www.shadertoy.com/view/4djSRW 
float Simple360HDR_hash12(vec2 p)
{
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}
float Simple360HDR_noise(vec2 v){
  vec2 v1=floor(v);
  vec2 v2=smoothstep(0.0,1.0,fract(v));
  float n00=Simple360HDR_hash12(v1);
  float n01=Simple360HDR_hash12(v1+vec2(0,1));
  float n10=Simple360HDR_hash12(v1+vec2(1,0));
  float n11=Simple360HDR_hash12(v1+vec2(1,1));
  return mix(mix(n00,n01,v2.y),mix(n10,n11,v2.y),v2.x);
}
float Simple360HDR_noiseOct(vec2 p){
  return
    Simple360HDR_noise(p)*0.5+
    Simple360HDR_noise(p*2.0+13.0)*0.25+
    Simple360HDR_noise(p*4.0+23.0)*0.15+
    Simple360HDR_noise(p*8.0+33.0)*0.10+
    Simple360HDR_noise(p*16.0+43.0)*0.05;
}
vec3 Simple360HDR_skyColor(vec3 p){
	vec3 s1=vec3(0.2,0.5,1.0);
	vec3 s2=vec3(0.1,0.2,0.4)*1.5;
    vec3 v=(Simple360HDR_noiseOct(p.xz*0.1)-0.5)*vec3(1.0);
	float d=length(p);
    return mix(s2+v,s1+v*(12.0/max(d,20.0)),clamp(d*0.1,0.0,1.0));
}
vec3 Simple360HDR_floorColor(vec3 p){
    vec3 v=(Simple360HDR_noiseOct(p.xz*0.1)*0.5+0.25)*vec3(0.7,0.5,0.4);
    return v;
}
vec3 Simple360HDR_renderHDR360(vec3 rd, vec3 sun){
    vec3 col;
	vec3 p;
	vec3 c;
	if (rd.y>0.0) {
        p=rd*(5.0/rd.y);
        c=Simple360HDR_skyColor(p);
    } else {
        p=rd*(-10.0/rd.y);
        c=Simple360HDR_floorColor(p);
		c=mix(c,vec3(0.5,0.7,1.0),clamp(1.0-sqrt(-rd.y)*3.0,0.0,1.0));
	}
	vec3 skycolor=vec3(0.1,0.45,0.68);
	float d=length(p);
	
	float ds=clamp(dot(sun,rd),0.0,1.0);
	vec3 sunc=(ds>0.9997?vec3(2.0):vec3(0.0))+pow(ds,512.0)*4.0+pow(ds,128.0)*vec3(0.5)+pow(ds,4.0)*vec3(0.5);
    if (rd.y>0.0){
		c+=vec3(0.3)*pow(1.0-abs(rd.y),3.0)*0.7;
	} 
    return c+sunc;
}
vec3 Simple360HDR_make360hdri(vec2 p, vec3 sun){
    float xPI=3.14159265359;
    vec2 thetaphi = ((p * 2.0) - vec2(1.0)) * vec2(xPI,xPI/2.0); 
    vec3 rayDirection = vec3(cos(thetaphi.y) * cos(thetaphi.x), sin(thetaphi.y), cos(thetaphi.y) * sin(thetaphi.x));
    return Simple360HDR_renderHDR360(rayDirection,sun);
}
//Simple HDRI END
float o871073067979_input_sdf3d(vec3 p, float _seed_variation_) {
// #output0: sdf3d_box_2 (o871156954060)
float o871156954060_0_1_sdf3d = box3d((opRepLim((p),vec3(p_o871173731274_X,p_o871173731274_Y,p_o871173731274_Z)*2.0,vec3(p_o871173731274_RepX-1.0,p_o871173731274_RepY-1.0,p_o871173731274_RepZ-1.0))), vec3(p_o871156954060_sx, p_o871156954060_sy, p_o871156954060_sz))-p_o871156954060_r;
// #output0: SDF_Repeat (o871173731274)
float o871173731274_0_1_sdf3d = o871156954060_0_1_sdf3d;
// #output0: sdf3d_box (o871140176846)
float o871140176846_0_1_sdf3d = box3d((p), vec3(p_o871140176846_sx, p_o871140176846_sy, p_o871140176846_sz))-p_o871140176846_r;
// #code: sdf3d_boolean (o871190508489)
vec2 o871190508489_0_b = vec2(o871140176846_0_1_sdf3d, 0.0);
o871190508489_0_b = sdf3dc_inter(vec2(o871173731274_0_1_sdf3d, 0.0), o871190508489_0_b);
// #output0: sdf3d_boolean (o871190508489)
vec2 o871190508489_0_1_sdf3dc = o871190508489_0_b;
return (o871190508489_0_1_sdf3dc).x;
}
// #instance: MFSDF_Object_And_Transform_2 (o871073067979)
vec4 PBRObjectMaker_o871073067979(vec4 uv, float _seed_variation_) {
    uv.xyz=MFSDF_Obj_Maker_rotate3d(uv.xyz-vec3(p_o871073067979_TranlateX,(0.734+sin(elapsed_time*1.5)*0.1),p_o871073067979_TranlateZ),vec3((-8.203+sin(elapsed_time)*10.0),p_o871073067979_RotateY,p_o871073067979_RotateZ)*0.01745329251)/p_o871073067979_scale;
	float sdf=o871073067979_input_sdf3d((uv.xyz), _seed_variation_)*p_o871073067979_scale;
	//13 - Emission
	if (uv.w>12.5&&uv.w<13.5) {
		return vec4(p_o871073067979_Emission*vec3(1.0),sdf);
	} else
	//5 - Roughness
	if (uv.w>4.5&&uv.w<5.5) {
		return vec4(p_o871073067979_Roughness*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//4 - Specular
	if (uv.w>3.5) {
		return vec4(p_o871073067979_Specular*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//2 - Metallic
	if (uv.w>1.5&&uv.w<2.5) {
		return vec4(p_o871073067979_Metallic*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//1 - BaseColor
	if (uv.w>0.5){
		return vec4(p_o871073067979_BaseColor.rgb*clamp(vec3(1.0),vec3(0.0),vec3(1.0)),sdf);
	} else
	//0 - SDF
	{
		return vec4(vec3(0),sdf);
	}
}
float o870922073044_input_sdf(vec3 p, float _seed_variation_) {
// #output0: sdf3d_plane (o870905295823)
float o870905295823_0_1_sdf3d = p.y;
return o870905295823_0_1_sdf3d;
}
// #instance: TEX3D_Simplex_Noise_Octaves (o870989181901)
float o870989181901_fbm(vec3 coord, float persistence, float _seed_variation_) {
	float normalize_factor = 0.0;
	float value = 0.0;
	float scale = 1.0;
	float size = 1.0;
	for (int i = 0; i < 3; i++) {
		value += XsX3zB_oct_simplex3d(coord*size) * scale;
		normalize_factor += scale;
		size *= 2.0;
		scale *= persistence;
	}
	return value / normalize_factor;
}
float o870989181901_bc(float f,float contrast, float brightness, float _seed_variation_) {
	return f*contrast+brightness+0.5-contrast*0.5;
}
vec3 o870922073044_input_tex3d(vec4 p, float _seed_variation_) {
// #code: TEX3D_Simplex_Noise_Octaves (o870989181901)
vec3 o870989181901_0_out = vec3(o870989181901_bc(o870989181901_fbm(p.xyz*vec3(p_o870989181901_scale_x,p_o870989181901_scale_y,p_o870989181901_scale_z)*0.5*p_o870989181901_scale+vec3(p_o870989181901_transx,(elapsed_time),p_o870989181901_transz),p_o870989181901_persistence, _seed_variation_)*0.5+0.5,p_o870989181901_contrast,p_o870989181901_brightness, _seed_variation_));
// #output0: TEX3D_Simplex_Noise_Octaves (o870989181901)
vec3 o870989181901_0_1_tex3d = o870989181901_0_out;
return o870989181901_0_1_tex3d;
}
// #instance: SDF_Displace (o870922073044)
float distort_o870922073044(vec3 uv, float _seed_variation_) {
    float sdf=o870922073044_input_sdf((uv), _seed_variation_);
	if (abs(sdf)>(abs(p_o870922073044_Distort)+p_o870922073044_Bound)){
		return sdf;
	} else {
		vec3 s=o870922073044_input_tex3d((vec4(uv,0.0)), _seed_variation_);
	    return sdf-s.x*p_o870922073044_Distort;
	}
}
float o870838186970_input_sdf3d(vec3 p, float _seed_variation_) {
// #output0: SDF_Displace (o870922073044)
float o870922073044_0_1_sdf3d = distort_o870922073044(p, _seed_variation_)/(1.0+abs(p_o870922073044_Distort*p_o870922073044_Correction));
return o870922073044_0_1_sdf3d;
}
// #instance: MFSDF_Object_And_Transform (o870838186970)
vec4 PBRObjectMaker_o870838186970(vec4 uv, float _seed_variation_) {
    uv.xyz=MFSDF_Obj_Maker_rotate3d(uv.xyz-vec3(p_o870838186970_TranlateX,p_o870838186970_TranlateY,p_o870838186970_TranlateZ),vec3(p_o870838186970_RotateX,p_o870838186970_RotateY,p_o870838186970_RotateZ)*0.01745329251)/p_o870838186970_scale;
	float sdf=o870838186970_input_sdf3d((uv.xyz), _seed_variation_)*p_o870838186970_scale;
	//13 - Emission
	if (uv.w>12.5&&uv.w<13.5) {
		return vec4(p_o870838186970_Emission*vec3(1.0),sdf);
	} else
	//5 - Roughness
	if (uv.w>4.5&&uv.w<5.5) {
		return vec4(p_o870838186970_Roughness*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//4 - Specular
	if (uv.w>3.5) {
		return vec4(p_o870838186970_Specular*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//2 - Metallic
	if (uv.w>1.5&&uv.w<2.5) {
		return vec4(p_o870838186970_Metallic*clamp(1.0,0.0,1.0),0.0,0.0,sdf);
	} else
	//1 - BaseColor
	if (uv.w>0.5){
		return vec4(p_o870838186970_BaseColor.rgb*clamp(vec3(1.0),vec3(0.0),vec3(1.0)),sdf);
	} else
	//0 - SDF
	{
		return vec4(vec3(0),sdf);
	}
}
vec4 o871240840134_input_mfsdf1(vec4 p, float _seed_variation_) {
// #output0: MFSDF_Object_And_Transform_2 (o871073067979)
vec4 o871073067979_0_1_v4v4 = PBRObjectMaker_o871073067979((p), _seed_variation_);
// #output0: MFSDF_Object_And_Transform (o870838186970)
vec4 o870838186970_0_1_v4v4 = PBRObjectMaker_o870838186970((p), _seed_variation_);
// #code: MFSDF_Boolean (o871224062919)
vec4 o871224062919_0_sout=o870838186970_0_1_v4v4;
o871224062919_0_sout=mfsdf_boolean_union(o871224062919_0_sout, o871073067979_0_1_v4v4);
// #output0: MFSDF_Boolean (o871224062919)
vec4 o871224062919_0_1_v4v4 = o871224062919_0_sout;
return o871224062919_0_1_v4v4;
}
vec3 o871240840134_input_hdri(vec2 uv, float _seed_variation_) {
vec4 o871442166728_0 = textureLod(texture_1, mod(uv, 1.0), 0.0);
return ((o871442166728_0).rgb);
}
// #instance: MFSDF_Render (o871240840134)
vec4 mfsdf_o871240840134(vec4 p, float _seed_variation_) { 
  vec4 a=vec4(0.0,0.0,0.0,999999999.0);
  vec4 b;
  b=o871240840134_input_mfsdf1((p), _seed_variation_);
  a=(a.w<b.w)?a:b;
  return a;
}
//tetrahedron normal by PauloFalcao
//https://www.shadertoy.com/view/XstGDS
vec3 normal_o871240840134(vec3 p, float _seed_variation_) {  
  const vec3 e=vec3(0.001,-0.001,0.0);
  float v1=mfsdf_o871240840134(vec4(p+e.xyy,0.0), _seed_variation_).w;
  float v2=mfsdf_o871240840134(vec4(p+e.yyx,0.0), _seed_variation_).w;
  float v3=mfsdf_o871240840134(vec4(p+e.yxy,0.0), _seed_variation_).w;
  float v4=mfsdf_o871240840134(vec4(p+e.xxx,0.0), _seed_variation_).w;
  return normalize(vec3(v4+v1-v3-v2,v3+v4-v1-v2,v2+v4-v3-v1));
}
void march_o871240840134(inout float d,inout vec3 p,float dS, vec3 ro, vec3 rd, float _seed_variation_) {
    for (int i=0; i < 500; i++) {
    	p = ro + rd*d;
        dS = mfsdf_o871240840134(vec4(p,0.0), _seed_variation_).w;
        d += dS;
        if (d > 50.0 || abs(dS) < 0.0001) break;
    }
}
//from https://www.shadertoy.com/view/lsKcDD
float calcAO_o871240840134( in vec3 pos, in vec3 nor , float _seed_variation_) {
	float occ = 0.0;
    float sca = 1.0;
    for( int i=0; i<5; i++ ){
        float h = 0.001 + 0.25*float(i)/4.0;
        float d = mfsdf_o871240840134(vec4( pos + h*nor ,0.0), _seed_variation_).w;
        occ += (h-d)*sca;
        sca *= 0.98;
    }
    return clamp( 1.0 - 1.6*occ, 0.0, 1.0 );    
}
//from https://www.shadertoy.com/view/lsKcDD
float calcSoftshadow_o871240840134( in vec3 ro, in vec3 rd, in float mint, in float tmax, float _seed_variation_) {
	float res = 1.0;
    float t = mint;
    float ph = 1e10; // big, such that y = 0 on the first iteration
    for( int i=0; i<32; i++ ){
	    vec3 p=ro + rd*t;
		float h = mfsdf_o871240840134(vec4(p,0.0), _seed_variation_).w;
		float isLight=mfsdf_o871240840134(vec4(p,13.0), _seed_variation_).x;
		if (isLight>0.0) h=999999.0;
        res = min( res, 10.0*h/t );
        t += h;
        if( res<0.0001 || t>tmax ) break;  
    }
    return clamp( res, 0.0, 1.0 );
}
vec3 raymarch_o871240840134(vec2 uv, float _seed_variation_) {
    uv-=0.5;
	vec3 cam=vec3((1.652+sin(elapsed_time)*0.2),(2.491+sin(elapsed_time*0.9)*0.2),(2.570+sin(elapsed_time*1.2)*0.2))*p_o871240840134_CamZoom;
	vec3 lookat=vec3(p_o871240840134_LookAtX,p_o871240840134_LookAtY,p_o871240840134_LookAtZ);
	vec3 ray=normalize(lookat-cam);
	vec3 cX=normalize(cross(vec3(0.0,1.0,0.0),ray));
	vec3 cY=normalize(cross(cX,ray));
	vec3 rd = normalize(ray*p_o871240840134_CamD+cX*uv.x+cY*uv.y);
	vec3 ro = cam;
	
	float d=0.;
	vec3 p=vec3(0);
	float dS=0.0;
	march_o871240840134(d,p,dS,ro,rd, _seed_variation_);
	
    vec3 color=vec3(0.0);
	vec3 objColor=mfsdf_o871240840134(vec4(p,1.0), _seed_variation_).xyz;   // 1 - BaseColor (r,g,b,sdf) linear (0-1)
	float objMetallic=clamp(mfsdf_o871240840134(vec4(p,2.0), _seed_variation_).x,0.0,1.0);  // 2 - Metallic  (v,0,0,sdf)
	float objSpecular=clamp(max(mfsdf_o871240840134(vec4(p,4.0), _seed_variation_).x*0.2,objMetallic),0.0,1.0);  // 4 - Specular  (v,0,0,sdf)
	float objRoughness=mfsdf_o871240840134(vec4(p,5.0), _seed_variation_).x; // 5 - Roughness (v,0,0,sdf)
	vec3 objEmission=mfsdf_o871240840134(vec4(p,13.0), _seed_variation_).xyz; // 13 - Emission (r,g,b,sdf)
	objColor=max(objColor,objEmission);
	vec3 light=normalize(vec3(p_o871240840134_SunX,p_o871240840134_SunY,p_o871240840134_SunZ));
	if (d<50.0) {
	    vec3 n=normal_o871240840134(p, _seed_variation_);
		float l=clamp(dot(-light,-n),0.0,1.0);
		vec3 ref=normalize(reflect(rd,-n));
		float r=clamp(dot(ref,light),0.0,1.0);
		float cAO=mix(1.0,calcAO_o871240840134(p,n, _seed_variation_),p_o871240840134_AmbOcclusion);
		float shadow=mix(1.0,calcSoftshadow_o871240840134(p,light,0.05,5.0, _seed_variation_),p_o871240840134_Shadow);
		if (objEmission.x>0.0){
			color=objEmission;
		} else {
			color=min(vec3(max(shadow,p_o871240840134_AmbLight)),max(l,p_o871240840134_AmbLight))*max(cAO,p_o871240840134_AmbLight)*((1.0-objMetallic)*objColor)+
			pow(r,pow(256.0,(1.0-objRoughness)))*objSpecular*mix(vec3(1.0),objColor,objMetallic)*(1.0-objRoughness)*16.0;
		}
		//reflection
		d=0.01;
		march_o871240840134(d,p,dS,p,ref, _seed_variation_);
		vec3 objColorRef=vec3(0);
		vec3 objEmissionRef=vec3(0);
		if (d<50.0) {
			objColorRef=mfsdf_o871240840134(vec4(p,1.0), _seed_variation_).xyz;
			objEmissionRef=mfsdf_o871240840134(vec4(p,13.0), _seed_variation_).xyz;
			n=normal_o871240840134(p, _seed_variation_);
			l=clamp(dot(-light,-n),0.0,1.0);
			if (objEmissionRef.x>0.0){
			  objColorRef=objEmissionRef;
			} else {
			  objColorRef=max(l,p_o871240840134_AmbLight)*objColorRef;
			}
		} else {
			objColorRef=o871240840134_input_hdri((Simple360HDR_equirectangularMap(ref.xzy)), _seed_variation_).xyz;
		}
		color=mix(color,objColorRef,objSpecular*mix(vec3(1.0),objColor,objMetallic));
	} else {
		color=o871240840134_input_hdri((Simple360HDR_equirectangularMap(rd.xzy)), _seed_variation_).xyz;
	}
	return pow(color,vec3(1.0/p_o871240840134_Gamma));
}
void fragment() {
	float _seed_variation_ = variation;
	vec2 uv = fract(UV*2.0+vec2(0.3));

// #output0: MFSDF_Render (o871240840134)
vec3 o871240840134_0_1_rgb = raymarch_o871240840134((uv), _seed_variation_);

	vec4 color_tex = vec4(o871240840134_0_1_rgb, 1.0);
	color_tex = mix(pow((color_tex + vec4(0.055)) * (1.0 / (1.0 + 0.055)),vec4(2.4)),color_tex * (1.0 / 12.92),lessThan(color_tex,vec4(0.04045)));
	ALBEDO = color_tex.rgb;
	ALPHA = color_tex.a;
}



