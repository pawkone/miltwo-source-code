varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float frequency;
uniform float amplitude;
void main()
{
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + (cos((gl_FragCoord.x + time) * frequency) * amplitude)));
}