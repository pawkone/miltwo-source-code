function scr_player_skateboardhitwall()
{
    image_speed = 0.35;
    hsp = movespeed * xscale;
    
    if (grounded)
        movespeed = approach(movespeed, 0, 0.5);
    
    if (movespeed == 0)
    {
        sprite_index = spr_player_skate_idle;
        image_index = 0;
        state = scr_player_skateboard;
    }
    
    if (grounded)
        sprayCans = 4;
}