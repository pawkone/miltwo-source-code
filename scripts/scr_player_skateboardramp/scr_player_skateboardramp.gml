function scr_player_skateboardramp()
{
    hsp = movespeed * xscale;
    movespeed = approach(movespeed, 13, 1);
    image_speed = 0.4;
    
    if (grounded)
    {
        sprite_index = spr_player_skate_walk;
        image_index = 0;
        state = scr_player_skateboardmove;
    }
    
    if (grounded)
        sprayCans = 4;
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 3;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (pky_grab2 && sprayCans >= 1)
    {
        sprayCans--;
        state = scr_player_skateboardAim;
        verticalMovespeed = vsp;
        movespeed = hsp;
    }
    
    if (pky_down2)
        vsp = 12;
}