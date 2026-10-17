varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D tex_setColors;
uniform vec4 tex_colorsUV;
uniform float tex_height;
void main()
{
	vec4 baseColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	float wid = tex_colorsUV.w;
	for (float i = tex_colorsUV.y; i <= wid; i += tex_height)
	{
		if (texture2D(tex_setColors, vec2(tex_colorsUV.x, i)) == baseColor)
		{
			gl_FragColor = vec4(1, 1, 1, baseColor.a);
			break;
		}
	}
}