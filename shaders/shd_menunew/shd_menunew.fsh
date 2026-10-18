varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform int u_count;
uniform vec3 u_pal[19];
void main() {
vec4 c = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
if (c.a == 0.0) { gl_FragColor = c; return; }
vec3 r = u_pal[0]; float m = 9.0, d; vec3 p;
for (int i = 0; i < 19; i++) {
p = u_pal[i];
d = dot(c.rgb - p, c.rgb - p) + (step(float(u_count) - 0.5, float(i)) * 99.0);
r = mix(r, p, step(d, m));
m = min(m, d);
}
gl_FragColor = vec4(r, c.a);
}
