function scr_player_grab()
{
    static grabOut = function()
    {
        var move = pky_right + pky_left;
        
        if (pky_run)
        {
            state = states.mach2;
            sprite_index = sprites.mach2;
            image_index = 0;
        }
        else
        {
            sprite_index = sprites.idle;
            image_index = 0;
            state = states.normal;
            
            if (move == 0)
                movespeed = 0;
        }
    };
    
    hsp = movespeed * xscale;
    
    if (jumpstop == false && !pky_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    var move = pky_right + pky_left;
    
    if (movespeed < 10)
        movespeed = approach(movespeed, 10, 1);
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    image_speed = 0.35;
    
    if (!grounded && sprite_index == sprites.grab)
    {
        image_index = 0;
        sprite_index = sprites.airgrabstart;
    }
    
    if (grounded && sprite_index == sprites.airgrab)
    {
        grabOut();
        exit;
    }
    
    if (animation_end() && sprite_index == sprites.grab)
    {
        grabOut();
        exit;
    }
    
    if (animation_end() && sprite_index == sprites.airgrabstart)
        sprite_index = sprites.airgrab;
    
    if (pky_down2 && grounded)
    {
        FMODevent_oneshot("event:/Sfx/Player/crouchslide", x, y);
        crouchslip = 25;
        sprite_index = sprites.crouchslip;
        image_index = 0;
        state = states.tumble;
        movespeed = 12;
        create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        exit;
    }
    
    if (move != 0 && move != xscale)
    {
        movespeed = 0;
        sprite_index = spr_player_grabcancel;
        state = states.jump;
        exit;
    }
    
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        image_index = 0;
        sprite_index = sprites.longjump;
        state = states.mach2;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.rollgetup, x, y);
        create_particleStatic(spr_grabcloud, x, y, xscale, 1);
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && !grounded)
    {
        wallgrab = 10;
        verticalMovespeed = movespeed;
        state = states.climbwall;
        sprite_index = sprites.wallclimb;
        image_index = 0;
    }
    
    if (place_meeting(x + sign(hsp), y, obj_solid) && grounded)
    {
        movespeed = 0;
        hsp = 0;
        vsp = -6;
        state = states.jump;
        sprite_index = spr_player_grabbump;
        create_particleStatic(spr_hurteffect, x, y, 1);
        image_index = 0;
        FMODevent_oneshot("event:/Sfx/Player/bump", x, y);
    }
}
