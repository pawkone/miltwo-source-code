if (global.hide_hud) exit

if is_callable(roomname_scr_step)
	roomname_scr_step()
if is_callable(hud_scr_draw)
	hud_scr_draw()