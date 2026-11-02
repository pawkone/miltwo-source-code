function scr_player_skateboardAim()
{
    sprite_index = sprites.fall;
    image_speed = 0.35;
    vsp = verticalMovespeed;
    hsp = movespeed;
    movespeed = lerp(movespeed, 0, 0.15);
    verticalMovespeed = lerp(verticalMovespeed, 0, 0.15);
    
    if ((hsp == 0 && vsp == 0) || !pky_grab)
    {
        FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/release", x, y);
        var move = pky_right + pky_left;
        
        if (move != 0)
            xscale = move;
        
        if (!pky_up)
        {
            movespeed = 16;
            vsp = -8;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = scr_player_skateboardramp;
        }
        else if (move == 0)
        {
            movespeed = 0;
            hsp = 0;
            vsp = -20;
            state = scr_player_skateboardwall;
            movespeed = 0;
            sprite_index = spr_playerN_knightdoublejump;
        }
        else
        {
            vsp = -20;
            movespeed = 16;
            sprite_index = spr_player_skate_rampjump;
            image_index = 0;
            state = scr_player_skateboardramp;
        }
        
        create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1).image_speed = 0.5;
    }
}