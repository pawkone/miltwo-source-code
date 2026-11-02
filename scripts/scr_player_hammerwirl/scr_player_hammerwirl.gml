function scr_player_hammerwirl()
{
    hsp = movespeed;
    var move = pky_right + pky_left;
	movespeed = approach(movespeed, move * 12, 0.6);
	
    if (grounded && vsp >= 0)
    {
        movespeed = abs(movespeed);
        if (move != 0)
            xscale = move;
        
        if (pky_run)
        {
            movespeed = 13;
            flash = true;
            state = scr_player_mach3;
            image_index = 0;
            sprite_index = sprites.mach3;
        }
        else
        {
            movespeed = abs(movespeed);
            state = scr_player_normal;
            image_index = 0;
            sprite_index = (move != 0) ? sprites.land2 : sprites.land;
        }
    }
    
    if (pky_down2 && !grounded)
    {
        image_index = 0;
        sprite_index = sprites.rolling;
        state = scr_player_tumble;
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
        
        if (move != 0)
            xscale = move;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !scr_slope(x,y+1)) || (place_meeting(x + sign(hsp), y-6, obj_solid) && !place_meeting(x, y-6, obj_solid))
    {
        xscale = sign(hsp);
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
        
        verticalMovespeed = movespeed;
        state = scr_player_climbwall;
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
