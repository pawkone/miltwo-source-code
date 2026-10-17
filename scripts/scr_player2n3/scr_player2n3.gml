function scr_player_retwistedBuzzsaw()
{
	var _t = character == chars.bacon_twist
	
	vsp -= 0.1
	image_speed = 0.5
	move = pky_right + pky_left;
	
	buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
	if (buffers.afterimageBlur == 0)
	{
		create_blur_effect(sprite_index, image_index, x, y, xscale);
		buffers.afterimageBlur = 3
	}
	
	if _t && sprite_index != spr_player3_buzzsawCancel && sprite_index != spr_player3_superjumpcancel
	{
		buffers.dashcloud = approach(buffers.dashcloud, 0, 1);
		if (buffers.dashcloud == 0)
		{
			create_particleStatic(spr_cloudeffect, x + irandom_range(-16,16), y + irandom_range(-16,16), 1, depth+1)
			buffers.dashcloud = 4
		}
	}
	
	if pky_down2 && _t
	{
		sprite_index = spr_player3_spinnygroundpound
		state = states.groundpound
		movespeed = abs(hsp)*move
		vsp = 12;
		exit
	}
	if pky_down2 && !_t
	{
		if move != 0
			xscale = move
		hsp = abs(hsp)*xscale
		vsp = 13;
	}
	
	if slapBuffer > 0
	{
		slapBuffer = 0
		image_index = 2
		sprite_index = _t ? spr_player3_longjump : spr_player2_longjump
		state = states.mach3
		jumpstop = true
		vsp = -7
		if move != 0
			xscale = move
		else if sign(hsp) != 0
			xscale = sign(hsp)
		movespeed = abs(hsp)
		if movespeed < 13
			movespeed = 13
		exit
	}
	
	if sprite_index == spr_player3_buzzsawCancel
	|| sprite_index == spr_player3_superjumpcancel
	|| sprite_index == spr_player2P_skatespin
	{
		hsp = approach(hsp, move*13, 1.2)
		vsp += 0.1
		if vsp > 0 && !_t
			vsp += 0.5
	}
	else
	{
		if scr_solid(x + hsp, y)
		{
			if _t
			{
				create_particleStatic(spr_player3shineEffect,x,y,1)
				scr_soundeffect(sfx_player_bt_ballbounce)
			}
			if pky_jump && !_t
			{
				vsp = -16
				hsp *= -1
				xscale *= -1
				sprite_index = spr_player2_buzzsawBump
				image_index = 0
			}
			else
			{
				vsp = -16
				hsp = -xscale * 8
				sprite_index = _t ? spr_player3_buzzsawCancel : spr_player2P_skatespin;
				image_index = 0
			}
		}
		if scr_solid(x, y - 1)
		{
			if _t
				scr_soundeffect(sfx_player_bt_ballbounce)
			image_index = 1
			sprite_index = _t ? spr_player3_bounceLand : spr_player2_bounceLand
			vsp = 14
		}
	}
	
	if sprite_index != spr_player3_buzzsaw
	&& sprite_index != spr_player3_bounceLand
	&& sprite_index != spr_player3_buzzsawCancel
	&& sprite_index != spr_player3_superjumpcancel
	&& sprite_index != spr_player2_buzzsaw
	&& sprite_index != spr_player2_bounceLand
	&& sprite_index != spr_player2P_skatespin
	{
		image_index = 0
		sprite_index = _t ? spr_player3_bounceLand : spr_player2_bounceLand
	}
	
	if (sprite_index == spr_player3_buzzsawCancel) && animation_end()
	{
		image_index = 0
		sprite_index = spr_player3_superjumpcancel
	}
	if (sprite_index == spr_player2_bounceLand || sprite_index == spr_player3_bounceLand) && animation_end()
	{
		image_index = 0
		sprite_index = _t ? spr_player3_buzzsaw : spr_player2_buzzsaw
	}
	if sprite_index == spr_player2_buzzsawBump && animation_end()
	{
		image_index = 0
		sprite_index = spr_player2_buzzsaw
	}
	
	if grounded
	{
		if sprite_index == spr_player3_buzzsawCancel
		|| sprite_index == spr_player3_superjumpcancel
		|| sprite_index == spr_player2P_skatespin
		{
			if move != 0
				xscale = move
			else if sign(hsp) != 0
				xscale = sign(hsp)
		}
		movespeed = abs(hsp)
		if movespeed < 13
			movespeed = 13
		state = pky_run ? states.mach3 : states.normal
		sprite_index = sprites.mach3
	}
}