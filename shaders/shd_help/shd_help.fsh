varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_mode;
uniform float u_seed;
uniform float u_time;
float hash(float x)
{
	x += u_seed * 17.123;
	x = fract(x * 0.1031);
	x *= x + 33.33;
	x *= x + x;
	float h = fract(x);
	h = fract(h * 43758.5453123 + sin(h * 91.7) * 13.1);
	return h;
}
float height(vec2 uv)
{
	return texture2D(gm_BaseTexture, uv).r * 0.05;
}
void main()
{
    vec2 uv = v_vTexcoord;
    vec4 base = texture2D(gm_BaseTexture, uv);
    vec4 result = base;

    if (u_mode < 0.5)
    {
        float seed = base.r*0.3 + base.g*0.59 + base.b*0.11;
        vec2 offset = vec2(hash(seed+1.0), hash(seed+2.0)) * 0.03;
        vec4 col = texture2D(gm_BaseTexture, fract(uv + offset));
        result = vec4(col.rgb, base.a);
    }
	else if (u_mode < 1.5)
	{
		vec2 p = floor(uv * 1200.0);
		float lum = dot(base.rgb, vec3(0.299, 0.587, 0.114));
		float seed = p.x * 12.9898 + p.y * 78.233 + lum * 43758.5453;
		result = vec4(vec3(fract(sin(seed + 1.0) * 43250.5453), fract(sin(seed + 2.0) * 44238.4326), fract(sin(seed + 3.0) * 43758.5453)), step(0.5,base.a));
	}
    else if (u_mode < 2.5)
    {
        vec2 muv = uv;
        muv.x = abs(fract(muv.x*2.0) - 0.5) * 2.0;
        muv.y = abs(fract(muv.y*2.0) - 0.5) * 2.0;
        result = texture2D(gm_BaseTexture, muv);
    }
    else if (u_mode < 3.5)
    {
        vec2 center = vec2(0.5);
        vec2 dir = uv - center;
        float h = height(uv);
        vec2 uvp = fract(uv + dir * h);
        vec4 col = texture2D(gm_BaseTexture, uvp);
        col.rgb += h * 2.0;
        result = col;
    }
    else if (u_mode < 4.5)
    {
        result = texture2D(gm_BaseTexture, uv + vec2(uv.y*0.3, 0.05));
    }
    else if (u_mode < 5.5)
    {
        vec2 c = uv - vec2(0.5);
        vec4 col = base;
        col.rgb = floor(col.rgb*5.0)/5.0 + length(c)*0.2;
        result = col;
    }
    else
    {
        float seed = base.r*0.3 + base.g*0.59 + base.b*0.11;
        result = vec4(
            fract(sin((seed + 1.0) * 12.9898) * 43758.5453),
            fract(sin((seed + 2.0) * 12.9898) * 43758.5453),
            fract(sin((seed + 3.0) * 12.9898) * 43758.5453),
            base.a
        );
    }
    gl_FragColor = result;
	gl_FragColor.a = step(0.5, gl_FragColor.a);
}