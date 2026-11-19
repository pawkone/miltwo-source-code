if global.hide_hud exit
saveiconTimer = approach(saveiconTimer,0,1)
saveiconAlpha = approach(saveiconAlpha, saveiconTimer > 0, 0.1)
if saveiconAlpha > 0
{
	saveiconIndex += 0.35
	if saveiconIndex > saveiconMax
		saveiconIndex = saveiconIndex mod saveiconMax
    draw_set_alpha(saveiconAlpha)
    draw_sprite(spr_littlesaltdance, saveiconIndex, 886, 466)
    draw_set_alpha(1)
}

if room == timesup_room exit
if is_callable(hud_scr_draw) hud_scr_draw()
if is_callable(roomname_scr_step) roomname_scr_step()
