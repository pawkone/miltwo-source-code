function scr_player_groundpoundstart()
{
    var move = pky_right + pky_left;
    hsp = approach(hsp, movespeed * move, (movespeed > 7) ? 0.05 : 0.25);
    
    if (move != 0)
        movespeed = 7;
    else
    {
        movespeed = 0;
        hsp = 0;
    }
    
    if (sprite_index == sprites.groundpoundstart && animation_end())
        sprite_index = sprites.groundpound;
	
    move = pky_right + pky_left;
    image_speed = 0.35;
	if (vsp >= 0)
	{
	    state = scr_player_groundpound;
	    create_particleStatic(spr_cloudeffect, x, y, 1, 1);
		buffers.crazyothereffect = 0;
        
		if character == chars.bacon_twist
		{
			vsp = 10
			freefallsmash = -4;
		}
	    else if (character == chars.milton)
	    {
	        vsp = 12;
	        freefallsmash = 10;
	    }
	}
	else
	{
		if character == chars.bacon_twist
			vsp -= 0.2
		freefallsmash = -7;
	}
    
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur == 0)
    {
        buffers.afterimageBlur = 4;
        create_blur_effect(sprite_index, image_index, x, y, xscale);
    }
}