function scr_player_climbwall()
{
    hsp = 0;
    image_speed = 0.6;
    vsp = -verticalMovespeed;
    var move = pky_right + pky_left;
    
    if (character != chars.milton)
    {
        if (move == xscale)
            verticalMovespeed = approach(verticalMovespeed, 20, 0.15);
    }
    else
    {
        verticalMovespeed = approach(verticalMovespeed, -5, 0.2);
        
        if (sprite_index == sprites.wallclimb)
            sprite_index = spr_milton_wallslide;
    }
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    buffers.step--;
    
    if (buffers.step <= 0)
    {
        buffers.step = 10;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
    }
    
    if ((!pky_run && wallgrab <= 0) || (verticalMovespeed <= 0 && character != chars.milton))
    {
        vsp = 0;
        state = states.jump;
        movespeed = -5;
        sprite_index = sprites.fall;
    }
    
    wallgrab--;
    
    if (!place_meeting(x + (32 * xscale), y, obj_solid))
    {
        wallgrab = 0;
        
        if (!(character == chars.milton) && isMildred)
        {
            state = states.buzzsaw;
            image_index = 0;
            sprite_index = sprites.buzzsawBump;
            
            if (verticalMovespeed < 14)
                verticalMovespeed = 14;
            
            movespeed = verticalMovespeed;
            vsp = -verticalMovespeed+4;
            FMODevent_oneshot("event:/Sfx/Player/airspin", x, y);
        }
        else if (verticalMovespeed >= 12)
        {
            state = states.mach3;
            movespeed = verticalMovespeed;
            flash = true;
            sprite_index = sprites.mach3;
            vsp = 0;
        }
        else
        {
            state = states.mach2;
            movespeed = verticalMovespeed;
            sprite_index = sprites.mach2;
            vsp = 0;
        }
        
        var o_y = y;
        var rep = 0;
        
        while (!place_meeting(x + xscale, y + 1, obj_solid))
        {
            y++;
            rep++;
            
            if (rep > 32)
            {
                y = o_y;
                break;
            }
        }
    }
    
    if (jumpBuffer > 8) && (character != chars.bacon_dream)
    {
        if ((character == chars.milton))
        {
            jumpBuffer = false;
            vsp = -16;
            xscale *= -1;
            movespeed = verticalMovespeed * xscale;
            state = states.hammerwirl;
            sprite_index = spr_milton_hammerwirl;
            image_index = 0;
            plrsnds_play(sfx.jump, x, y);
            exit;
        }
        
        jumpBuffer = false;
        plrsnds_play(sfx.jump, x, y);
        vsp = -11;
        xscale *= -1;
        movespeed = 10;
        state = states.mach2;
        jumpstop = false;
        sprite_index = sprites.walljumpstart;
        image_index = 0;
    }
	else if (character == chars.bacon_dream)
	{
		if (pky_jump2)
	    {
	        jumpstop = false;
	        vsp = -14;
	        xscale *= -1;
	        movespeed = 0;
	        image_index = 0;
	        state = states.dreambounce;
		}
	}

    if (pky_down2 && character == chars.milton && global.modded_bettermilton)
    {
        image_index = 0;
        sprite_index = sprites.rolling;
        state = states.tumble;
        movespeed = abs(movespeed);
        if (movespeed < 12)
            movespeed = 12;
    }
	else if (pky_down2 && isMildred)
    {
        freefallsmash = 20;
        vsp = 10;
        state = states.groundpound;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
        buffers.crazyothereffect = 0;
        sprite_index = spr_player_wallpoundstart;
        image_index = 0;
        squashX = 1.3;
        squashY = 0.8;
    }
    
    if (place_meeting(x, y - 1, obj_solid))
    {
        shake_camera(15);
        sprite_index = spr_player_hitceiling;
        image_index = 0;
        state = states.freefallland;
        plrsnds_play(sfx.slam, x, y);
    }
}
