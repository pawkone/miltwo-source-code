if is_callable(roomname_scr_roomstart)
{
	var _s = roomname_scr_roomstart
	with obj_hud
	{
		roomname_text = ""
		var _s1 = $"roomname_{room_get_name(room)}"
		var _s2 = lang_get_phrase(_s1)
		roomname_text = _s2 != _s1 ? _s2 : ""
		_s()
	}
}