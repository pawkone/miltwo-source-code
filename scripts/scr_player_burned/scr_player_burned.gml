function scr_player_burned()
{
	hsp = approach(hsp, movespeed, 0.7)
	var move = pky_right + pky_left
	if move != 0
		movespeed = 8 * move
	else
		movespeed = 0
	if grounded
	{
		create_particleStatic(spr_landeffect, x, y, 1)
		state = scr_player_normal
		sprite_index = sprites.land
		image_index = 0
		movespeed = abs(movespeed)
		exit
	}
	sprite_index = spr_player3_burn
	image_speed = 0.35
	buffers.afterimageMach--
	if buffers.afterimageMach <= 0
	{
		create_machEffect(sprite_index, image_index, x, y, xscale, 1)
		buffers.afterimageMach = 6
	}
}
