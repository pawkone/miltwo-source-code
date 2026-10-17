varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float lap3_mult;
uniform int lap3_timer;
uniform float lap3_offsetx;
uniform float lap3_offsety;
uniform float pause_mult;
uniform int pause_seed;
uniform float hsv_mult;
uniform float hsv_hue;
uniform float hsv_sat;
uniform float hsv_val;
vec3 adjustSaturationAndValue(vec3 color)
{
	vec4 A = vec4(0.0,-1.0/3.0,2.0/3.0,-1.0);
	vec4 B = mix(vec4(color.b,color.g,A.w,A.z), vec4(color.g,color.b,A.x,A.y), step(color.b,color.g));
	vec4 C = mix(vec4(B.x,B.y,B.w,color.r), vec4(color.r,B.y,B.z,B.x), step(B.x,color.r));
	float d = C.x - min(C.w,C.y);
	vec3 hsv = vec3(abs(C.z + (C.w - C.y)/(6.0*d+0.00001)), d/(C.x+0.00001), C.x);
	hsv.x = fract(hsv.x + hsv_hue);
	hsv.y = max(0.0, hsv.y + hsv_sat);
	hsv.z = max(0.0, hsv.z + hsv_val);
	vec4 A2 = vec4(1.0,2.0/3.0,1.0/3.0,3.0);
	vec3 B2 = abs(fract(vec3(hsv.x + A2.x, hsv.x + A2.y, hsv.x + A2.z))*6.0 - vec3(A2.w));
	return mix(vec3(A2.x), clamp(B2 - vec3(A2.x),0.0,1.0), hsv.y) * hsv.z;
}
float hash(vec2 p)
{
	return fract(sin(dot(p + float(pause_seed), vec2(127.1,311.7))) * 43758.5453);
}
void main()
{
	vec2 uv = v_vTexcoord;
	if (lap3_mult > 0.0)
	{
		float phase = float(lap3_timer) / 2000.0 * 6.2831853;
		vec2 pixel = uv * vec2(960.0, 540.0);
		pixel.x += lap3_offsetx;
		pixel.y += lap3_offsety;
		float freq = 8.0;
		float strength = lap3_mult * lap3_mult * lap3_mult * lap3_mult * 6.0;
		float s = sin(phase);
		float c = cos(phase);
		vec2 wiggle;
		wiggle.x = sin(pixel.y * 0.004 * freq) * c + cos(pixel.y * 0.004 * freq) * s;
		wiggle.y = cos(pixel.x * 0.004 * freq) * c - sin(pixel.x * 0.004 * freq) * s;
		wiggle += vec2(sin(pixel.x * 0.002 + phase * 2.0), cos(pixel.y * 0.002 + phase * 2.5)) * 0.7;
		wiggle += vec2(sin((pixel.x + pixel.y) * 0.003 + phase * 3.0), cos((pixel.x - pixel.y) * 0.003 + phase * 3.5)) * 0.5;
		uv += wiggle * strength / vec2(960.0, 540.0);
	}
	if (pause_mult > 0.0)
	{
		vec2 texelSize = 1.0 / vec2(960.0,540.0);
		vec2 pixel = uv / texelSize;
		float frequency = 0.02;
		float phase = float(pause_seed);
		vec2 rippleOffset;
		rippleOffset.x = sin(pixel.y * frequency + phase);
		rippleOffset.y = cos(pixel.x * frequency + phase);
		vec2 block = floor(pixel / 8.0);
		vec4 tex = v_vColour * texture2D(gm_BaseTexture, (pixel + (rippleOffset + (vec2(hash(block),hash(block + vec2(19.19))) - 0.5) * 2.0) * pause_mult) * texelSize);
		tex.rgb = mix(tex.rgb, adjustSaturationAndValue(tex.rgb), hsv_mult);
		vec3 target = (distance(tex.rgb, vec3(0.0)) <= 0.25) ? mix(vec3(1.0), vec3(0.0,0.392,1.0), 0.5) : vec3(0.0,0.392,1.0);
		gl_FragColor = vec4(mix(tex.rgb,target,pause_mult), step(0.5, tex.a));
	}
	else if (hsv_mult > 0.0)
	{
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
		gl_FragColor.rgb = mix(gl_FragColor.rgb, adjustSaturationAndValue(gl_FragColor.rgb), hsv_mult);
		gl_FragColor.a = step(0.5, gl_FragColor.a);
	}
	else
	{
		gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
		gl_FragColor.a = step(0.5, gl_FragColor.a);
	}
}