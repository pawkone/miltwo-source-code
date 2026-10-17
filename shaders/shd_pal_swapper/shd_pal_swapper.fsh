varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D u_palTexture;
uniform vec4 u_Uvs;
uniform float u_paletteId;
uniform vec2 u_pixelSize;
vec4 findAltColor(vec4 inCol, vec2 corner)
{
    if(inCol.a == 0.) return vec4(.0,.0,.0,.0);
    for(float i = corner.y; i < u_Uvs.w; i += u_pixelSize.y)
    {
        if(distance(texture2D(u_palTexture,vec2(corner.x,i)),inCol) < 0.004)
        {
            vec2 testPos = vec2(corner.x + u_pixelSize.x * floor(u_paletteId + 1.0), i);
            return mix(texture2D(u_palTexture, vec2(testPos.x - u_pixelSize.x, testPos.y)), texture2D(u_palTexture, testPos), fract(u_paletteId));
        }
    }
    return inCol;
}
void main()
{
    gl_FragColor = v_vColour * findAltColor(texture2D( gm_BaseTexture, v_vTexcoord), u_Uvs.xy);
}