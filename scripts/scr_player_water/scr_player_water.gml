function scr_player_water()
{
	var move = pky_left + pky_right
	
	if slapBuffer
	{
		FMODevent_oneshot("event:/Sfx/Player/airspin", x, y)
		slapBuffer = false
		if pky_jump || pky_up
		{
			if move == 0
				movespeed /= 5
			squashY = 1.6
			squashX = 0.4
			if vsp > -9
				vsp = -9
		}
		else if pky_down
		{
			if move == 0
				movespeed /= 5
			squashY = 1.6
			squashX = 0.4
			if vsp < 9
				vsp = 9
		}
		else
		{
			squashX = 1.6
			squashY = 0.4
		}
		if move != 0
			movespeed = move * 16
		else if squashY == 0.6
			movespeed = xscale * 16
	}
	
	if sign(movespeed) != move
		movespeed += move
	else
		movespeed += move / 4
	if abs(movespeed) > 13
		movespeed = approach(movespeed, 0, 1.5)
	if move != 0
		xscale = move
	var _s = sign(movespeed)
	
	if !grounded || move == 0
		vsp -= grav + 0.1
	if place_meeting(x,y-1,obj_solid)
	{
		squashX = 1.2
		squashY = 0.8
		FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y)
		vsp = 6
	}
	if place_meeting(x+_s,y-16,obj_solid) && place_meeting(x+_s,y,obj_solid)
	{
		squashY = 1.2
		squashX = 0.8
		FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y)
		movespeed = -_s * 13
	}
	
	if pky_down
		vsp += 0.45
	else if pky_up || pky_jump
	{
		if !(!grounded || move == 0)
			vsp -= grav + 0.1
		vsp -= 0.45
	}
	
	vsp = clamp(vsp, -12, 12)
	image_speed = 0.35
	if grounded
	{
		sprite_index = spr_player_mach2
		image_speed = abs(movespeed)/30
		if buffers.step <= 0
		{
			if round(image_index) == 4 || round(image_index) == 9
			{
				create_particleStatic(spr_dashcloud1, x, y, xscale, 1)
				FMODevent_oneshot("event:/Sfx/Player/airbump", x, y)
				buffers.step = 5
			}
		}
		else
			buffers.step--
	}
	else if vsp < 0
		sprite_index = spr_player_groundpoundcancel
	else
		sprite_index = spr_player_dive
	
	hsp = movespeed
	
	if !place_meeting(x,y,obj_waterNew)
	{
        grounded = false
        jumpBuffer = false
        image_index = 0
        sprite_index = sprites.mach2jump
        jumpstop = true
		movespeed = abs(hsp)
		if _s != 0
			xscale = _s
		state = states.mach2
	}
	
	doTaunt()
}