singtime -= 1/60
if singtime < 0 && obj_fnf.beat && obj_fnf.curBeat mod idlebop == 0
{
	image_index = 0
	sprite_index = spr_idle
}
draw_self()