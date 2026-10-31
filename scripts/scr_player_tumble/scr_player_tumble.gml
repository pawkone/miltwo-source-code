function scr_player_tumble()
{
    var move = pky_right + pky_left;
	
	if skatenic_is_tornado()
	{
		image_speed = 0.5 * xscale
		vsp = 24
		movespeed = max(movespeed, 11)
		if move != 0
		{
			hsp = approach(hsp, movespeed * move, 0.75)
			if move != xscale
				movespeed = 11
		}
		else
			hsp = approach(hsp, 0, 0.2)
	}
	else
	{
		hsp = movespeed * xscale;
		if (movespeed < 6)
			movespeed = 6
	    if (sprite_index != sprites.dive && sprite_index != spr_milton_diveprep)
	        image_speed = movespeed / 18;
	    else
	        image_speed = 0.5;
	}
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
		if skatenic_is_tornado()
		{
			buffers.dashcloud = max(1, 12-abs(hsp)/3)
			if abs(hsp) > 3
				create_particleStatic(spr_dashcloud1, x, y, sign(hsp), 1);
		}
		else
			create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    slope_momentum();
    crouchslip--;
    
    if ((sprite_index == sprites.rolling || sprite_index == sprites.crouchslip || sprite_index == sprites.rollstart || sprite_index == spr_skatenic_diveground) && !grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/dive", x, y);
        sprite_index = sprites.dive;
        image_index = 0;
        vsp = 10;
    }
    
    if (sprite_index == sprites.dive || sprite_index == spr_milton_diveprep) && !skatenic_is_tornado()
    {
        if (jumpBuffer && !grounded && character != chars.milton)
        {
            vsp = -6;
            sprite_index = sprites.divebomb;
            image_index = 0;
            state = states.groundpoundstart;
            squashX = 1.3;
            squashY = 0.8;
        }
    }
    
    if ((character == chars.milton))
    {
        if (sprite_index == spr_milton_diveprep && animation_end())
            sprite_index = sprites.dive;
        
        if (jumpBuffer && !scr_solid(x, y - 16) && grounded)
        {
            state = states.hammerwirl;
            flash = true;
            vsp = -16;
            squashX = 1.3;
            squashY = 0.8;
            movespeed = hsp;
            FMODevent_oneshot("event:/Sfx/Player/hammerbounce", x, y);
            image_index = 0;
            sprite_index = spr_milton_hammerwirl;
            exit;
        }
    }
    
    if (sprite_index == sprites.dive && grounded)
    {
		if character == chars.bacon_twist || character == chars.bacon_redem
		{
			if character == chars.bacon_twist
				scr_soundeffect(sfx_player_bt_ballbounce)
			vsp = -14
			state = states.retwistedBuzzsaw
			exit
		}
		if character == chars.skatenic
			sprite_index = spr_skatenic_diveground;
		else
		{
			sprite_index = sprites.rollstart;
		    image_index = 0;
		}
    }
    
    if (sprite_index == sprites.rollstart && animation_end())
    {
        sprite_index = sprites.rolling;
        image_index = 0;
    }
    if (grounded && jumpBuffer && !scr_solid(x, y - 16) && (character == chars.bacon_dream))
	{
		jumpstop = false;
	    sprite_index = spr_player1_grabspinny;
	    image_index = 0;
	    state = states.dreambounce;
	    vsp = -15;
	}
	
	if (scr_solid(x, y - 16) || slapBuffer > 0) && skatenic_is_tornado()
    {
		if sign(move) != 0
			xscale = sign(move)
		else if sign(hsp) != 0
			xscale = sign(hsp)
		if slapBuffer > 0
		{
	        slapBuffer = false;
			create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
		}
        sprite_index = sprites.rolling;
        image_index = 0;
    }
	
	if character == chars.milton && movespeed > 6
		movespeed -= 0.02
    if !skatenic_is_tornado() && ((place_meeting(x + sign(hsp), y, obj_solid) && !scr_slope(x,y+1)) || (place_meeting(x + sign(hsp), y-6, obj_solid) && !place_meeting(x, y-6, obj_solid)))
    {
		if (character == chars.milton)
        {
            FMODevent_oneshot("event:/Sfx/Player/hammerbounce", x, y);
            create_particleStatic(spr_miltonEffect, x + (5 * xscale), y, 1, -2);
            xscale *= -1;
            squashX = 1.3;
            squashY = 0.8;
            if grounded
			{
		        if (movespeed < 20)
		            movespeed++
			}
        }
		else if (character == chars.bacon_dream && sprite_index == sprites.dive)
		{
			xscale *= -1;
			create_particleStatic(spr_dreambounceeffect, x, y, 1, -2);
			FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
		}
		else
		{
            crouchslip = 0;
            FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
            state = states.hitwall;
            sprite_index = sprites.wallsplat;
            image_index = 0;
		}
    }
    
    if (!pky_down && !scr_solid(x, y - 16) && grounded && crouchslip <= 0)
    {
		if skatenic_is_tornado()
		{
			verticalMovespeed = -12
			movespeed = abs(hsp)
			grounded = false
			scale = 1.35
            state = states.climbwall;
            sprite_index = sprites.wallclimb;
		}
		else
		{
	        plrsnds_play(sfx.rollgetup, x, y);
	        image_index = 0;
	        sprite_index = sprites.rollgetup;
	        state = states.mach2;
		}
    }
}
