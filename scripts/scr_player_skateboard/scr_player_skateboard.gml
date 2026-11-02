function scr_player_skateboard()
{
    hsp = movespeed * xscale;
    var move = pky_right + pky_left;
    image_speed = 0.4;
    
    if (grounded)
        sprayCans = 4;
    
    if (pky_grab && sprayCans >= 1)
    {
        sprayCans--;
        state = scr_player_skateboardAim;
        verticalMovespeed = vsp;
        movespeed = -3 * move;
    }
}
