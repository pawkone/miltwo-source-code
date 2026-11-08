function scr_player_skateboardmove()
{
    hsp = movespeed * xscale;
    image_speed = 0.4;
    
    if (grounded)
        sprayCans = 4;
    
    buffers.dashcloud--;
    
    if (buffers.dashcloud <= 0 && grounded)
    {
        buffers.dashcloud = 12;
        create_particleStatic(spr_dashcloud1, x, y, xscale, 1);
    }
    
    if (jumpstop == false && !pky_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    slope_momentum(0.25);
    
    if (jumpBuffer > 5 && grounded)
    {
        jumpBuffer = false;
        jumpstop = false;
        image_index = 0;
        sprite_index = spr_player_skate_jump;
        vsp = -10;
        FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/jump", x, y);
    }
    
    if (animation_end() && sprite_index == spr_player_skate_jump)
        sprite_index = spr_player_skate_walk;
    
    prevOnSlope = scr_slope(x, y + 1);
    
    if (prevOnSlope == true)
    {
        slopeObj = instance_place(x, y + 1, obj_slope);
        
        if (sign(slopeObj.image_xscale) == xscale)
            wasRamp = true;
        else
            wasRamp = false;
    }
    
    if (onSlope != prevOnSlope)
    {
        if (onSlope == true && prevOnSlope == false && wasRamp)
        {
            onSlope = prevOnSlope;
            vsp = -12;
            movespeed = 13;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = scr_player_skateboardramp;
            FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/ramp", x, y);
            exit;
        }
        else
        {
            onSlope = prevOnSlope;
        }
    }
    
    if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_stupidcabbit))
    {
        var _hitwall = doBump(40, abs(hsp) + 1);
        
        if (_hitwall)
        {
            vsp = -6;
            movespeed = -6;
            sprite_index = spr_player_skate_stun;
            image_index = 0;
            state = scr_player_skateboardhitwall;
            FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/bump", x, y);
            exit;
        }
    }
    
    if (pky_grab2 && sprayCans >= 1)
    {
        sprayCans--;
        state = scr_player_skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
}