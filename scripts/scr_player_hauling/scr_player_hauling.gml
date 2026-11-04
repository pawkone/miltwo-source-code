function scr_player_hauling()
{
    hsp = movespeed * xscale;
    var move = pky_right + pky_left;
    
    if (animation_end() && sprite_index == spr_player_haulingland)
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
    }
    
    if (animation_end() && sprite_index == spr_player_haulingjump)
    {
        sprite_index = spr_player_haulingfall;
        image_index = 0;
    }
    
    if (jumpstop == false && !pky_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (grounded && (sprite_index == spr_player_haulingfall || sprite_index == spr_player_haulingjump) && sprite_index != spr_player_swingading)
    {
        sprite_index = spr_player_haulingidle;
        image_index = 0;
        create_particleStatic(spr_landeffect, x, y, 1, 1);
    }
    
    if (sprite_index == spr_player_swingading)
    {
        movespeed = approach(movespeed, 0, 0.15);
        
        if (movespeed == 0)
        {
            image_index = 0;
            sprite_index = spr_player_haulingidle;
            exit;
        }
        
        if (place_meeting(x + xscale, y, obj_solid) && !place_meeting(x + xscale, y, obj_destructibles))
        {
            state = scr_player_finishingblow;
            sprite_index = spr_player_swingadingend;
            image_index = 0;
            exit;
        }
    }
    
    if (sprite_index != spr_player_swingading)
    {
        if (move != 0)
        {
            if (sprite_index == spr_player_haulingidle)
            {
                image_index = 0;
                sprite_index = spr_player_haulingwalk;
            }
            
            xscale = move;
            movespeed = approach(movespeed, 6, 0.5);
            buffers.step--;
            
            if (sprite_index == spr_player_haulingwalk)
            {
                image_speed = movespeed / 15;
                
                if ((floor(image_index) == 3 || floor(image_index) == 8) && buffers.step <= 0)
                {
                    buffers.step = 12;
                    plrsnds_play(sfx.step, x, y);
                    create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
                }
            }
        }
        else
        {
            movespeed = 0;
            image_speed = 0.35;
            
            if (sprite_index == spr_player_haulingwalk)
            {
                image_index = 0;
                sprite_index = spr_player_haulingidle;
            }
        }
    }
    
    if (sprite_index == spr_player_swingading)
        image_speed = movespeed / 13;
    
    if (!grounded && sprite_index != spr_player_haulingjump && sprite_index != spr_player_haulingfall && sprite_index != spr_player_swingading)
    {
        image_index = 0;
        sprite_index = spr_player_haulingfall;
    }
    
    if (jumpBuffer && grounded && sprite_index != spr_player_swingading)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_haulingjump;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
    
    if (slapBuffer)
    {
        slapBuffer = false;
        state = scr_player_finishingblow;
        
        if (pky_up)
            sprite_index = spr_player_finisheruppercut;
        else if (sprite_index == spr_player_swingading)
            sprite_index = spr_player_swingadingend;
        else
            sprite_index = choose(spr_player_finisher1, spr_player_finisher2);
        
        image_index = 0;
        exit;
    }
    
    if (pky_down && grounded)
    {
        image_speed = 0.35;
        image_index = 0;
        sprite_index = sprites.crouch;
        state = scr_player_crouch;
		enemyID = -4
    }
    
    if (pky_down2 && !grounded)
    {
        vsp = -6;
        sprite_index = spr_player_piledriver;
        image_index = 0;
        state = scr_player_groundpoundstart;
    }
    
    if (!instance_exists(enemyID))
    {
        state = scr_player_normal;
        sprite_index = sprites.idle;
    }
}