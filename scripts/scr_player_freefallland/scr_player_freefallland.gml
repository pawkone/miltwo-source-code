function scr_player_freefallland()
{
    image_speed = 0.35;
    vsp = 0;
    hsp = 0;
    movespeed = 0;
    
    if (animation_end())
    {
        if (sprite_index == spr_player_hitceiling)
        {
            state = states.jump;
            sprite_index = spr_player_spinout;
            vsp = 2;
        }
        
        if (sprite_index == sprites.groundpoundland || sprite_index == sprites.divebombland)
        {
            state = states.normal;
            image_index = 0;
            sprite_index = sprites.land;
        }
        
        if (sprite_index == spr_player_piledriverend)
        {
            state = states.jump;
            vsp = -8;
            image_index = 0;
            sprite_index = sprites.fall;
        }
    }
}
