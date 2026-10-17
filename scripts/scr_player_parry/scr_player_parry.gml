function scr_player_parry()
{
    grav = 0.5;
    image_speed = 0.4;
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 0, 0.25);
    
    if (animation_end())
    {
        state = states.normal;
        sprite_index = sprites.idle;
        image_index = 0;
    }
}
