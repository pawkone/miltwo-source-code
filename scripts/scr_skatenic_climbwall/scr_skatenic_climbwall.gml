function scr_skatenic_climbwall()
{
	sprite_index = sprites.wallclimb
	image_speed = 0.6*(abs(hsp/10)*0.6+0.4)
	if sign(hsp) != 0
		xscale = sign(hsp)
		
	buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1)
	if (buffers.afterimageMach == 0)
	{
	    buffers.afterimageMach = 3
	    create_buzzsawAfterimage(sprite_index, image_index, x, y, xscale, 1)
	}
		
	var move = pky_right + pky_left
	movespeed = max(movespeed, 11)
	if move != 0
	{
		if move != sign(hsp)
			hsp = approach(hsp, movespeed * move, 2.6)
		else
			hsp = approach(hsp, movespeed * move, 1.3)
		if move != xscale
			movespeed = 11
	}
	verticalMovespeed += grav + (verticalMovespeed > -1 ? 0.25 : 0.11)
	if verticalMovespeed < 0 && scr_solid(x,y+verticalMovespeed) && !scr_solid(x,y)
		verticalMovespeed = 0
	vsp = verticalMovespeed
	if slapBuffer > 0
	{
	    slapBuffer = false
	    state = states.mach2
		movespeed = 13
		scale = 1.7
		image_speed = 0.5
	    image_index = 0
	    sprite_index = spr_skatenic_wallclimbcancel
		vsp = -7
		jumpstop = true
		flash = true
		if sign(move) != 0
			xscale = sign(move)
		else if sign(hsp) != 0
			xscale = sign(hsp)
	}
	else if pky_down
	{
	    image_index = 0;
	    sprite_index = sprites.rolling;
	    state = states.tumble;
	    create_particleStatic(spr_grabcloud, x, y, xscale, 1);
	}
	else if verticalMovespeed >= 0 && grounded
	{
		wallgrab = 0
	    state = states.mach3
		image_speed = 0.35
	    image_index = 0
	    sprite_index = sprites.mach3hit
	    movespeed = 13
	    vsp = 0
		flash = true
		if sign(move) != 0
			xscale = sign(move)
		else if sign(hsp) != 0
			xscale = sign(hsp)
	}
}
