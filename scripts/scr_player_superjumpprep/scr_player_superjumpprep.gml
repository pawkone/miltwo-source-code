function scr_player_superjumpprep()
{
	hsp = movespeed * xscale;
    image_speed = 0.35;
    
    if (animation_end() && sprite_index == sprites.superjumpprepstart)
    {
        image_index = 0;
        sprite_index = sprites.superjumpprep;
    }
    
    if (sprite_index != sprites.superjumpprepstart)
    {
        var move = pky_right + pky_left;
        
        if (move != 0)
        {
            sprite_index = sprites.superjumpprepwalk;
            xscale = move;
            movespeed = approach(movespeed, 3, 0.5);
        }
        else
        {
            sprite_index = sprites.superjumpprep;
            movespeed = 0;
        }
        
        if (!pky_up)
        {
            state = scr_player_superjump;
            sprite_index = sprites.superjump;
            image_index = 0;
            verticalMovespeed = -14;
            vsp = verticalMovespeed;
            plrsnds_play(sfx.sjump_release, x, y);
        }
    }
    else
    {
        movespeed = approach(movespeed, 0, 1);
    }
}