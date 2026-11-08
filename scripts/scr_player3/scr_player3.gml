function scr_player_twistedWallbounce()
{
	image_speed = 0.5
	var move = pky_right + pky_left
	hsp = approach(hsp, movespeed * move, 0.9)
	if move != 0
	{
		if abs(hsp) < 12
			movespeed = 12
	}
	else
		movespeed = 0
	if animation_end() && sprite_index = spr_player3_spinnystart
		sprite_index = spr_player3_spinny
	if slapBuffer > 0
	{
		if move != 0
			xscale = move
		slapBuffer = 0
		jumpstop = true
		vsp = -8
		create_particleStatic(spr_jumpeffect, x, y, xscale)
		sprite_index = spr_player3_longjump
		image_index = 0
		state = scr_player_mach3
		if movespeed < 13
			movespeed = 13
		grav = 0.5
	}
	if vsp < 0
		freefalling = -4
	if pky_down2
	{
		freefalling = 0
		sprite_index = spr_player3_spinnygroundpound
		if vsp < 15
			vsp = 15
		hsp = 0
		flash = true
	}
	if sprite_index == spr_player3_spinnygroundpound
	{
		freefalling += 0.7
		vsp += 0.1
	}
	if freefalling >= 10 && sprite_index == spr_player3_spinnygroundpound
	{
		buffers.afterimageMach--
		if buffers.afterimageMach <= 0
		{
			create_machEffect(sprite_index, image_index, x, y, xscale, 1)
			buffers.afterimageMach = 6
			create_particleStatic(spr_player3shineEffect, x, y, 1, -2)
		}
	    if (!instance_exists(chargeeffect))
	        chargeeffect = instance_create(x, y, obj_chargeeffect);
	}
	buffers.afterimageBlur--
	if buffers.afterimageBlur <= 0
	{
		create_blur_effect(sprite_index, image_index, x, y, xscale)
		buffers.afterimageBlur = 2
	}
	if grounded && vsp >= 0 && !place_meeting(x, y + vsp, obj_destructibles) && sprite_index != spr_player3_bounceLand && !(place_meeting(x, y + vsp, obj_metalblock) && sprite_index == spr_player3_spinnygroundpound)
	{
		fromDive = false
		diveMovespeed = movespeed
		if pky_run
		{
			state = pky_down ? scr_player_tumble : scr_player_mach3
			if movespeed < 12
				movespeed = 12
			sprite_index = pky_down ? sprites.rolling : sprites.mach3
			image_index = 0
			flash = true
		}
		else
		{
			movespeed = abs(hsp)
			create_particleStatic(spr_landeffect, x, y, 1)
			if move != 0
				sprite_index = sprites.land2
			else
				sprite_index = sprites.land
			image_index = 0
			state = scr_player_normal
		}
		if move != 0
			xscale = move
	}
	doTaunt()
}
function scr_player_twistedBuzzsaw()
{
	image_speed = 0.54
	hsp = movespeed * xscale
	var move = pky_right + pky_left
	if scr_solid(x, y - 1)
	{
		plrsnds_play(sfx_player_bt_ballbounce, x, y)
		vsp = 12
		sprite_index = spr_player3_bounceLand
	}
	buffers.afterimageMach--
	if buffers.afterimageMach <= 0
	{
		buffers.afterimageMach = 6
		var num = random_range(-40, 40)
		create_particleStatic(spr_cloudeffect, x + num, y + num, 1)
	}
	buffers.afterimageBlur--
	if buffers.afterimageBlur <= 0
	{
		create_blur_effect(sprite_index, image_index, x, y, xscale)
		buffers.afterimageBlur = 2
	}
	if animation_end() && sprite_index != spr_player3_buzzsaw
		sprite_index = spr_player3_buzzsaw
	if slapBuffer > 0
	{
		if move != 0
			xscale = move
		slapBuffer = 0
		jumpstop = true
		vsp = -8
		create_particleStatic(spr_jumpeffect, x, y, xscale)
		sprite_index = spr_player3_longjump
		image_index = 0
		state = scr_player_mach3
		if movespeed < 13
			movespeed = 13
		grav = 0.5
	}
	if scr_solid(x + sign(hsp), y) && !scr_slope(x, y + 4)
	{
		vsp = -14
		xscale *= -1
		state = scr_player_twistedWallbounce
		movespeed = 12
		hsp = movespeed * xscale
		sprite_index = spr_player3_spinnystart
		image_index = 0
		plrsnds_play(sfx_player_bt_ballbounce, x, y)
		create_particleStatic(spr_player3shineEffect, x, y, 1, -2)
	}
	if grounded && vsp >= 0 && !place_meeting(x, y + vsp, obj_destructibles) && sprite_index != spr_player3_bounceLand
	{
		if pky_run
		{
			state = pky_down ? scr_player_tumble : scr_player_mach3
			if movespeed < 12
				movespeed = 12
			sprite_index = pky_down ? sprites.rolling : sprites.mach3
			image_index = 0
			flash = true
		}
		else
		{
			movespeed = abs(hsp)
			create_particleStatic(spr_landeffect, x, y, 1)
			if move != 0
				sprite_index = spr_player_land2
			else
				sprite_index = spr_player_land
			image_index = 0
			state = scr_player_normal
		}
	}
	if pky_down2 && vsp < 14
	{
		freefalling = 0
		if move != 0
			xscale = move
		vsp = 14
		state = scr_player_twistedWallbounce
		sprite_index = spr_player3_spinnygroundpound
	}
	doTaunt()
}