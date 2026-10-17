if global.prophuntmode.select >= 0
{
	if instance_exists(obj_player)
		draw_sprite_ext(sprite_index, image_index, obj_player.x+global.prophuntmode.sprites[global.prophuntmode.select][2], obj_player.y+global.prophuntmode.sprites[global.prophuntmode.select][3], global.prophuntmode.sprites[global.prophuntmode.select][4] ? obj_player.xscale : 1, 1, 0, c_white, 1)
}
else
{
	
}