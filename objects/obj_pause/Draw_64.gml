if global.hide_hud exit
if is_callable(hud_scr_draw)
{
	var _s = hud_scr_draw
	with obj_hud
		_s()
}
if is_callable(roomname_scr_step)
{
	var _s = roomname_scr_step
	with obj_hud
		_s()
}
draw_set_colour(c_white)