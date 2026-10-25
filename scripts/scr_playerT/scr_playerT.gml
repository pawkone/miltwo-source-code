function scr_player_hammerattack()
{
    hsp = movespeed * xscale;
    
	if global.modded_bettermilton
	{
		if movespeed > 12
			movespeed -= 0.03
	}
	else
	{
	    if movespeed < 13
	        movespeed = approach(movespeed, 13, 1);
	}
    
    buffers.hammer = approach(buffers.hammer, 0, 1);
    
    if (movespeed >= 7)
    {
        buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
        
        if (buffers.afterimageBlur == 0)
        {
            buffers.afterimageBlur = 5;
            create_miltonAfterimage(sprite_index, image_index, x, y, xscale);
        }
    }
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (pky_down2 && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/crouchslide", x, y);
        crouchslip = 25;
        sprite_index = sprites.crouchslip;
        image_index = 0;
        state = states.tumble;
        
        if (movespeed < 12)
            movespeed = 12;
        
        create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
    }
    
    if (pky_down2 && !grounded)
    {
        image_index = 0;
        sprite_index = sprites.rolling;
        state = states.tumble;
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
    }
	
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        image_index = 0;
        sprite_index = sprites.longjump;
        state = states.mach2;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
    
    if (!pky_grab && buffers.hammer == 0)
    {
        flash = true;
        state = states.mach3;
        image_index = 0;
        sprite_index = sprites.mach3;
    }
    
    if (animation_end() && sprite_index == spr_milton_hammerspin_prep)
    {
        image_index = 0;
        sprite_index = spr_milton_hammerspin;
    }
    
    if (vsp >= 2)
        vsp += 0.5;
    
    if (place_meeting(x + xscale, y, obj_solid) && !scr_slope(x,y+1))
    {
        state = states.hammerwirl;
        xscale *= -1;
        movespeed = 9 * xscale;
        flash = true;
        vsp = -16;
        squashX = 1.3;
        squashY = 0.8;
        FMODevent_oneshot("event:/Sfx/Player/hammerbounce", x, y);
        image_index = 0;
        sprite_index = spr_milton_hammerwirl;
    }
    
    if (sprite_index == spr_milton_hammerspin_prep)
        image_speed = 0.35;
    else
        image_speed = 0.5;
}

function scr_player_hammerwirl()
{
    hsp = movespeed;
    var move = pky_right + pky_left;
    if (global.modded_bettermilton)
		 movespeed = approach(movespeed, move * 12, 0.6);
	else
		movespeed = approach(movespeed, move * 11, 0.7);
	
    if (grounded && vsp >= 0)
    {
        movespeed = abs(movespeed);
        if (move != 0)
            xscale = move;
        
        if (pky_run)
        {
            movespeed = 13;
            flash = true;
            state = states.mach3;
            image_index = 0;
            sprite_index = sprites.mach3;
        }
        else
        {
            movespeed = abs(movespeed);
            state = states.normal;
            image_index = 0;
            sprite_index = (move != 0) ? sprites.land2 : sprites.land;
        }
    }
    
    if (pky_down2 && !grounded)
    {
        image_index = 0;
        sprite_index = sprites.rolling;
        state = states.tumble;
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
        
        if (move != 0)
            xscale = move;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !scr_slope(x,y+1))
    {
        xscale = sign(hsp);
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
        
        verticalMovespeed = movespeed;
        state = states.climbwall;
        sprite_index = sprites.wallclimb;
    }
    
    if (vsp >= 2)
        vsp += 0.5;
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_miltonAfterimage(sprite_index, image_index, x, y, xscale);
    }
    
    doGrab();
    image_speed = 0.5;
}
