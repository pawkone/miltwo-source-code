function scr_player_crashoutbounce()
{
    image_speed = 0.4;
    move = pky_right + pky_left;
    hsp = approach(hsp, movespeed, 1.7);
	buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
	
    if (move != 0)
        movespeed = 12 * move;
    else
        movespeed = 0;

	if (place_meeting(x + sign(xscale), y, obj_solid) && sprite_index == spr_player0_airgrab)
	{
	    vsp = -16;
	    sprite_index = spr_player0_wallkickspin;
	    image_index = 0;
	    hsp = -8 * xscale;
	}

	if (sprite_index != spr_player0_airgrab && pky_grab2)
    {
        
		vsp = -5;
        sprite_index = spr_player0_airgrab;
        
        if (move != 0)
            xscale = move;
        
        if (move != 0)
            hsp = 13 * move;
        else
            hsp = 13 * xscale;
		doGrab()
	}
	
    if (sprite_index == spr_player0_wallkickspin && pky_jump2)
    {
        vsp = 20;
        sprite_index = spr_player0_goingdown;
    }
    
    if (sprite_index == spr_player0_wallkickspin && pky_down2 && vsp < 10)
        vsp = 15;
    
    if (grounded)
    {
        if (sprite_index == spr_player0_airgrab && pky_jump)
        {
            vsp = -8;
            sprite_index = spr_player0_wallkickspin;
        }
        else if (sprite_index == spr_player0_goingdown && pky_jump)
        {
            if (movespeed < 16)
                vsp = -16;
            else
                vsp = -movespeed;

			sprite_index = spr_player0_wallkickspin;
        }
        else if (!pky_run)
        {
            state = states.normal;
            sprite_index = spr_player0_land;
            image_index = 0;
            movespeed = abs(movespeed);
        }
        else
        {
            state = states.mach3;
            flash = true;
            sprite_index = spr_player0_mach3hit;
            image_index = 0;
            
            if (move != 0)
                xscale = move;
            
            if (movespeed < 13)
                movespeed = 13;
        }
    }
	doTaunt();
}