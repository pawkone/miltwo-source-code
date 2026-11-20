var _hudp = hud_postfix
with obj_handlerGameUI
{
	hud_scr_step = asset_get_index($"scr_hud{_hudp}_step")
	hud_scr_draw = asset_get_index($"scr_hud{_hudp}_draw")
	hud_scr_clean = asset_get_index($"scr_hud{_hudp}_clean")
	roomname_scr_step = asset_get_index($"scr_roomname{_hudp}_step")
	roomname_scr_earlystep = asset_get_index($"scr_roomname{_hudp}_earlystep")
	roomname_scr_roomstart = asset_get_index($"scr_roomname{_hudp}_roomstart")
	var _s = asset_get_index($"scr_hud{_hudp}_init")
	if is_callable(_s)
		_s()
	if is_callable(roomname_scr_roomstart)
		roomname_scr_roomstart()
}
pause_scr_draw = asset_get_index($"scr_pause{_hudp}")