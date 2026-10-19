function scr_player_uppercut()
{
	if character == chars.valentia
	{
		scr_playerV_uppercut()
		exit
	}
	
    var move = pky_right + pky_left;
    hsp = approach(hsp, movespeed * move, 0.8);
    
    if (move != 0)
        movespeed = 6;
    
    image_speed = 0.4;
    
    if (vsp < 0)
    {
        buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
        
        if (buffers.afterimageMach == 0)
        {
            buffers.afterimageMach = 4;
            create_machEffect(sprite_index, image_index, x, y, xscale, 1);
        }
    }
    
    if (animation_end())
        image_index = image_number - 1;
    
    if (grounded && vsp > 0)
    {
        create_particleStatic(spr_landeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = (move != 0) ? sprites.land2 : sprites.land;
        state = states.normal;
        plrsnds_play(sfx.step, x, y);
        movespeed = abs(hsp);
        
        if (move != 0)
            xscale = move;
        
        hsp = movespeed * xscale;
    }
}
