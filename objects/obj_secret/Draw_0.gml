var _s = sprite_index
if global.modded_oldsecreteye
{
	if oldsprite != sprite_index
	{
		oldsprite = sprite_index
		var _n = asset_get_index(string_concat(sprite_get_name(sprite_index), "_old"))
		if _n >= 0 customsprite = _n
	}
	_s = customsprite
}
if _s < 0 _s = sprite_index
if _s >= 0 draw_sprite_ext(_s, image_index, x, y, image_xscale * xscaleMulti, image_yscale * yscaleMulti, 0, c_white, 1);
