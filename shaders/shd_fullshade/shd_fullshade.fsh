varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 darkest;
uniform vec3 lightest;
void main()
{
	vec4 tex = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = vec4((distance(tex.rgb, vec3(0.0)) <= 0.05) ? darkest : lightest, tex.a);
}