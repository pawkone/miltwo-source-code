function scr_player_skateboardwall()
{
    image_speed = 0.35;
    
    if (grounded)
    {
        sprite_index = spr_player_skate_idle;
        state = scr_player_skateboard;
    }
    
    if (pky_grab2 && sprayCans >= 1)
    {
        sprayCans--;
        state = scr_player_skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
    
    if (grounded)
        sprayCans = 4;
}