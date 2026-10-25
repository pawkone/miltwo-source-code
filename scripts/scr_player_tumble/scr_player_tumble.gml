function scr_player_tumble()
{
    hsp = movespeed * xscale;
    
	if (movespeed < 6)
		movespeed = 6

    if (sprite_index != sprites.dive && sprite_index != spr_milton_diveprep)
        image_speed = movespeed / 18;
    else
        image_speed = 0.5;
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    slope_momentum();
    crouchslip--;
    
    if ((sprite_index == sprites.rolling || sprite_index == sprites.crouchslip || sprite_index == sprites.rollstart) && !grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/dive", x, y);
        sprite_index = sprites.dive;
        image_index = 0;
        vsp = 10;
    }
    
    if (sprite_index == sprites.dive || sprite_index == spr_milton_diveprep)
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
        sprite_index = sprites.rollstart;
        image_index = 0;
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
	
	
	if global.modded_bettermilton && character == chars.milton && movespeed > 6
		movespeed -= 0.04
    if (place_meeting(x + sign(hsp), y, obj_solid) && !scr_slope(x,y+1))
    {
		if (character == chars.milton)
        {
            FMODevent_oneshot("event:/Sfx/Player/hammerbounce", x, y);
            create_particleStatic(spr_miltonEffect, x + (5 * xscale), y, 1, -2);
            xscale *= -1;
            squashX = 1.3;
            squashY = 0.8;
            if !global.modded_bettermilton || grounded
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
        plrsnds_play(sfx.rollgetup, x, y);
        image_index = 0;
        sprite_index = sprites.rollgetup;
        state = states.mach2;
    }
}
