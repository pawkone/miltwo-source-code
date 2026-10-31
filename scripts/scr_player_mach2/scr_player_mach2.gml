function scr_player_mach2()
{
    hsp = movespeed * xscale;
    var move = pky_right + pky_left;
    var _accel = 0.1;
    if character == chars.pepperni && sprite_index == sprites.mach1
	{
		image_speed = 0.4
		vsp = 0
		hsp = xscale*(image_index*1.5-8)
		if animation_end()
		{
			flash = true
			squashX = 1.4
			squashY = 0.6
			sprite_index = sprites.mach3
			image_speed = 0.35
			movespeed = 12
			state = states.mach3
		}
		exit
	}
    if character == chars.pepperni && sprite_index == sprites.mach2
	{
		flash = true
		squashX = 1.4
		squashY = 0.6
		sprite_index = sprites.mach3
		image_speed = 0.35
		movespeed = 12
		state = states.mach3
		exit
	}
    if (character == chars.milton)
        _accel = 0.08;
    
	if (movespeed < 6)
		movespeed = 6
	
    if (grounded)
        movespeed += _accel;
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach <= 0)
    {
        buffers.afterimageMach = 6;
        create_machEffect(sprite_index, image_index, x, y, xscale, movespeed / 12);
    }
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    slope_momentum();
    
    if (animation_end() && sprite_index == sprites.mach1)
    {
        image_index = 0;
        sprite_index = sprites.mach2;
    }
    
    if (animation_end() && sprite_index == sprites.rollgetup)
    {
        image_index = 0;
        sprite_index = sprites.mach2;
    }
    
    if (animation_end() && sprite_index == sprites.mach2jump)
    {
        image_index = 0;
        sprite_index = sprites.mach2jumpend;
    }
    
    if (animation_end() && sprite_index == sprites.longjump)
    {
        image_index = 0;
        sprite_index = sprites.longjumpend;
    }
    
    if (animation_end() && sprite_index == sprites.walljumpstart)
    {
        image_index = 0;
        sprite_index = sprites.walljump;
    }
    
    if (!grounded && (sprite_index == sprites.mach2 || sprite_index == sprites.mach1))
    {
        image_index = 0;
        sprite_index = sprites.mach2jump;
    }
    
    if (grounded && (sprite_index == sprites.mach2jump || sprite_index == sprites.mach2jumpend || sprite_index == sprites.walljump || sprite_index == sprites.walljumpstart || sprite_index == sprites.longjump || sprite_index == sprites.longjumpend))
    {
        image_index = 3;
        sprite_index = sprites.mach2;
    }
    
    if (grounded && sprite_index == sprites.groundpoundcancel)
    {
        image_index = 0;
        sprite_index = sprites.rollgetup;
    }
    
    if (sprite_index == sprites.mach2)
        image_speed = movespeed / 18;
    else
        image_speed = 0.45;
    
    if (jumpstop == false && !pky_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if character != chars.pepperni && (movespeed >= 12 && grounded)
    {
        movespeed = max(movespeed, 12);
        flash = true;
        state = states.mach3;
        
        if (sprite_index != sprites.rollgetup)
        {
            image_index = 0;
            sprite_index = sprites.mach3;
        }
        
        exit;
    }
    
    if (jumpBuffer && coyote_time)
    {
        grounded = false;
        jumpBuffer = false;
        image_index = 0;
        sprite_index = sprites.mach2jump;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
    
    if (!pky_run && grounded)
    {
        if (sprite_index == sprites.mach1)
        {
            state = states.normal;
            sprite_index = sprites.idle;
            image_index = 0;
            image_speed = 0.35;
            movespeed = 0;
        }
        else
        {
            plrsnds_play(sfx.machend, x, y);
            state = states.machslide;
            sprite_index = sprites.machslidestart;
            image_index = 0;
        }
        
        exit;
    }
    
    if (move != xscale && move != 0 && grounded)
    {
        if (sprite_index == sprites.mach1)
        {
            xscale *= -1;
        }
        else
        {
            plrsnds_play(sfx.machturn, x, y);
            sprite_index = sprites.mach2turn;
            image_index = 0;
            state = states.machturn;
            exit;
        }
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x, y + 1, obj_slope) && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
        state = states.hitwall;
        sprite_index = sprites.wallsplat;
        image_index = 0;
        exit;
    }
    
    if (pky_down)
    {
        image_index = 0;
        sprite_index = sprites.rollstart;
        state = states.tumble;
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        exit;
    }
    
    if ((place_meeting(x + sign(hsp), y, obj_solid) && !grounded) || (scr_slope(x, y + 4) && place_meeting(x + sign(hsp), y - 4, obj_solid) && !place_meeting(x + hsp, y, obj_metalblock)))
    {
        var _climb = true;
        
        if (!(character == chars.milton))
            _climb = doBump(40, abs(hsp) + 1);
        
        if (_climb)
        {
			if character == chars.skatenic
			{
				verticalMovespeed = -18
				grounded = false
				squashX = 1.5
				squashY = 0.5
			}
			else
				verticalMovespeed = movespeed+(character == chars.milton*3);
            state = states.climbwall;
            sprite_index = sprites.wallclimb;
            image_index = 0;
            exit;
        }
    }
	
    if (jumpBuffer > 8 && !grounded && global.modded_machdoublejump && (isMildred || character == chars.milton))
    {
		jumpBuffer = false;
		if (character == chars.milton)
		{
			vsp = -14;
			movespeed *= xscale
			state = states.hammerwirl;
			sprite_index = spr_milton_hammerwirl;
			image_index = 0;
			plrsnds_play(sfx.jump, x, y);
			exit;
		}
        image_index = 0;
        FMODevent_oneshot("event:/Sfx/Player/airspin", x, y);
        vsp = -11;
        state = states.buzzsaw;
        image_index = 0;
        sprite_index = sprites.buzzsawBump;
    }
	
    doTaunt();
    doGrab();
}
