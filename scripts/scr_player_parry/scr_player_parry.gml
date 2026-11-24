function scr_player_parry()
{
    image_speed = 0.4;
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 0, 0.25);
    
    if (animation_end())
    {
        state = scr_player_normal;
        sprite_index = sprites.idle;
        image_index = 0;
    }
}
