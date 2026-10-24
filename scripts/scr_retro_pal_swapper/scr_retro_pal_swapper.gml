global.retro_pal_swapper = [
	shader_get_uniform(shd_pal_swapper, "u_pixelSize"),
	shader_get_uniform(shd_pal_swapper, "u_Uvs"),
	shader_get_uniform(shd_pal_swapper, "u_paletteId"),
	shader_get_sampler_index(shd_pal_swapper, "u_palTexture"),
]
function pal_swap_set(arg0, arg1, arg2)
{
	if (arg1 == 0) exit
	var _swapper = global.retro_pal_swapper
	shader_sset(shd_pal_swapper)
	var _tex = sprite_get_texture(arg0, 0)
	var _UVs = sprite_get_uvs(arg0, 0)
	texture_set_stage(_swapper[3], _tex)
	var _texel_x = texture_get_texel_width(_tex)
	var _texel_y = texture_get_texel_height(_tex)
	shader_set_uniform_f(_swapper[0], _texel_x, _texel_y)
	shader_set_uniform_f(_swapper[1], _UVs[0] + _texel_x * 0.5, _UVs[1] + _texel_y * 0.5, _UVs[2], _UVs[3])
	shader_set_uniform_f(_swapper[2], arg1)
}