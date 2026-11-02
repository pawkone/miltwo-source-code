function scr_player_groundpoundstart()
{
    var move = pky_right + pky_left;
    hsp = approach(hsp, movespeed * move, (movespeed > 7) ? 0.05 : 0.25);
    
    if (move != 0)
        movespeed = 7;
    else
    {
        movespeed = 0;
        hsp = 0;
    }
    
    move = pky_right + pky_left;
    image_speed = 0.35;
    
    if (vsp < 0)
        freefallsmash = -7;
    
    if (vsp > 0)
    {
        state = scr_player_groundpound;
        create_particleStatic(spr_cloudeffect, x, y, 1, 1);
        buffers.crazyothereffect = 0;
        
        if (character == chars.milton)
        {
            vsp = 12;
            freefallsmash = 10;
        }
    }
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (grounded && vsp >= 0 && (!place_meeting(x, y + vsp, obj_destructibles) && !place_meeting(x, y + vsp, obj_metalblock)))
    {
        if (scr_slope(x, y + 1) && sprite_index != spr_player_piledriver)
        {
            var slope = instance_place(x, y + 1, obj_slope);
            xscale = -sign(slope.image_xscale);
            movespeed = (freefallsmash >= 10) ? 12 : 8;
            state = scr_player_tumble;
            sprite_index = sprites.rolling;
            FMODevent_oneshot("event:/Sfx/Player/crouchslide", x, y);
            create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        }
        else
        {
            if (sprite_index == spr_player_piledriver)
            {
                sprite_index = spr_player_piledriverend;
                
                if (instance_exists(enemyID) && enemyID.state == "grab")
                {
                    FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
                    
                    repeat (8)
                    {
                        create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
                        create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
                    }
                    
                    create_particleStatic(spr_kungfueffect, x, y, 1, 2);
                    
                    with (enemyID)
                        instance_destroy();
                    
                    enemyID = -4;
                }
            }
            else if (sprite_index == sprites.divebomb)
            {
                sprite_index = sprites.divebombland;
            }
            else
            {
                sprite_index = sprites.groundpoundland;
            }
            
            image_index = 0;
            vsp = 0;
            hsp = 0;
            state = scr_player_freefallland;
            movespeed = abs(hsp);
            
            if (freefallsmash >= 10)
                shake_camera(25);
            else
                shake_camera(10);
            
            plrsnds_play(sfx.slam, x, y);
            create_particleStatic(spr_groundpoundeffect, x, y, 1, -2);
        }
    }
}