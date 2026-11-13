function scr_player_superjump()
{
    var move = pky_right + pky_left;
    
    if (sprite_index != sprites.superjumpcancelstart)
    {
        buffers.afterimageMach--
        if (buffers.afterimageMach >= 0)
        {
            buffers.afterimageMach = 4;
            create_machEffect(sprite_index, image_index, x, y, xscale, 1);
        }
        
        buffers.afterimageBlur--
        if (buffers.afterimageBlur >= 0)
        {
            buffers.afterimageBlur = 3;
            create_blur_effect(sprite_index, image_index, x, y, xscale);
        }
        
        buffers.crazyothereffect--;
        
        if (buffers.crazyothereffect <= 0)
        {
            buffers.crazyothereffect = 9;
            
            with (create_particleStatic(spr_crazyrunothereffect, x, y, 1, 1))
            {
                image_angle = 90;
                image_speed = 0.5;
            }
        }
        
        image_speed = 0.4;
        vsp = verticalMovespeed;
        verticalMovespeed -= 0.1;
        hsp = movespeed * move;
        
        if (move != 0 && sprite_index != spr_player_hitceiling && sprite_index != spr_player_spinout)
            movespeed = approach(movespeed, 3, 0.5);
        else
            movespeed = 0;
        
        if ((pky_run2 || pky_grab2) && sprite_index != spr_player_spinout)
        {
			if character == chars.bacon_redem
				instance_create(x,y,obj_player2_rocket)
            sprite_index = sprites.superjumpcancelstart;
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/superjumpcancel", x, y);
        }
        
        if (place_meeting(x, y - 1, obj_solid) && !place_meeting(x, y - 1, obj_ballofbeer))
        {
            shake_camera(15);
            sprite_index = spr_player_hitceiling;
            image_index = 0;
            state = scr_player_freefallland;
            plrsnds_play(sfx.slam, x, y);
        }
        
        buffers.step--;
        
        if (buffers.step <= 0)
        {
            buffers.step = 5;
            create_particleStatic(spr_cloudeffect, x + irandom_range(42, -42), y + irandom_range(42, -42), 1, 1);
        }
    }
    else
    {
        image_speed = 0.5;
        verticalMovespeed = lerp(verticalMovespeed, 0, 0.25);
        if character == chars.bacon_redem
			vsp = 0
		else
			vsp = verticalMovespeed;
        hsp = 0;
        
        if (move != 0)
            xscale = move;
        
        if (animation_end())
        {
            create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1);
            create_particleStatic(spr_grabcloud, x, y, xscale, 1);
            movespeed = 12;
            state = scr_player_mach3;
            jumpstop = true;
            vsp = -5;
            sprite_index = sprites.superjumpcancel;
            image_index = 6;
            image_speed = 1;
        }
    }
}
