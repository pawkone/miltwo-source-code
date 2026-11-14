if instance_exists(obj_player)
{
	var _hud_postfix = hud_postfix
	hud_postfix = "WSB"
	if obj_player.character == chars.bacon_crash
		hud_postfix = "NGAB2"
	if obj_player.character == chars.bacon_twist
		hud_postfix = "TTWOB"
	
	if _hud_postfix != hud_postfix
	{
		if is_callable(hud_scr_clean)
		{
			var _s = hud_scr_clean
			with obj_hud
				_s()
		}
		event_user(0)
	}
}

if is_callable(roomname_scr_earlystep)
{
	var _s = roomname_scr_earlystep
	with obj_hud
		_s()
}