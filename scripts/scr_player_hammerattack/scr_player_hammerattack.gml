function scr_player_hammerattack()
{
    hsp = movespeed * xscale;
    
	if movespeed > 13
		movespeed -= 0.005
	if movespeed < 13
	    movespeed = approach(movespeed, 13, 1);
    
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
        state = scr_player_tumble;
        
        if (movespeed < 12)
            movespeed = 12;
        
        create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
    }
    
    if (pky_down2 && !grounded)
    {
        image_index = 0;
        sprite_index = sprites.rolling;
        state = scr_player_tumble;
        movespeed = abs(movespeed);
        
        if (movespeed < 12)
            movespeed = 12;
    }
	
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        image_index = 0;
        sprite_index = sprites.longjump;
        state = scr_player_mach2;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
    
    if (!pky_grab && buffers.hammer == 0)
    {
        flash = true;
        state = scr_player_mach3;
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
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !scr_slope(x,y+1)) || (place_meeting(x + sign(hsp), y-6, obj_solid) && !place_meeting(x, y-6, obj_solid))
    {
        state = scr_player_hammerwirl;
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