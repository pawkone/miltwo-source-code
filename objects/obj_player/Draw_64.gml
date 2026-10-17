if room == initObject
{
	draw_rectangle_color(0,0,1920,1080,0,0,0,0,false)
	draw_sprite(spr_loadingBacon, 1, 480, 270);
	draw_sprite_part(spr_loadingBacon, 0, 0, 0, npprg * 586, 391, 480 - 293, 270 - 195)
}