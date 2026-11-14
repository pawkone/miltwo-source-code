var _hud_scr_init = asset_get_index($"scr_hud{hud_postfix}_init")
if is_callable(_hud_scr_init)
{
	with obj_hud
		_hud_scr_init()
}
hud_scr_step = asset_get_index($"scr_hud{hud_postfix}_step")
hud_scr_draw = asset_get_index($"scr_hud{hud_postfix}_draw")
hud_scr_clean = asset_get_index($"scr_hud{hud_postfix}_clean")
pause_scr_draw = asset_get_index($"scr_pause{hud_postfix}")
roomname_scr_step = asset_get_index($"scr_roomname{hud_postfix}_step")
roomname_scr_earlystep = asset_get_index($"scr_roomname{hud_postfix}_earlystep")
roomname_scr_roomstart = asset_get_index($"scr_roomname{hud_postfix}_roomstart")