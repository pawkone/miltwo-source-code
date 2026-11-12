function scr_getera(_getfrompause = true)
{
	if instance_exists(obj_pause) && _getfrompause
		return obj_pause.hud_postfix
	if instance_exists(obj_player)
	{
		switch obj_player.character
		{
			case chars.bacon_crash:
				return "NGAB2"
			case chars.bacon_twist:
				return "TTWOB"
		}
	}
	return "WSB"
}
function scr_getera_pt()
{
	if instance_exists(obj_player)
	{
		switch obj_player.character
		{
			case chars.bacon_crash:
			case chars.bacon_dream:
			case chars.bacon_redem:
			case chars.bacon_twist:
				return "PT"
		}
	}
	return ""
}

function sprite_getera(_spriteindex)
{
	if sprite_exists(_spriteindex)
	{
		var _spriteindex2 = asset_get_index(sprite_get_name(_spriteindex) + scr_getera())
		if _spriteindex2 >= 0
			_spriteindex = _spriteindex2
		else
		{
			_spriteindex2 = asset_get_index(sprite_get_name(_spriteindex) + scr_getera_pt())
			if _spriteindex2 >= 0
				_spriteindex = _spriteindex2
		}
	}
	return _spriteindex
}