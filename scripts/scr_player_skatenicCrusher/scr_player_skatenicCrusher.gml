function scr_player_skatenicCrusher()
{
    image_speed = 0.35
	var move = pky_right + pky_left
    hsp = approach(hsp, movespeed * move, 1.5)
    if (move != 0)
    {
        if movespeed < 9
            movespeed = 9
    }
    else
        movespeed = 0
    if vsp > 5 && vsp < 20
        vsp += 1.5
	if vsp > 12
        sprite_index = spr_skatenic_crusher
    else
    {
        sprite_index = spr_player1_umbrellaStart
        if animation_end()
            image_index = 8
    }
	
	if slapBuffer > 0
	{
		slapBuffer = false
		state = scr_player_mach2
		movespeed = 13
		scale = 1.7
		image_speed = 0.5
		image_index = 0
		sprite_index = spr_skatenic_wallclimbcancel
		vsp = -7
		jumpstop = true
		flash = true
		if sign(move) != 0
			xscale = sign(move)
		else if sign(hsp) != 0
			xscale = sign(hsp)
	}
 
    buffers.afterimageBlur--
    if (buffers.afterimageBlur <= 0)
    {
        create_blur_effect(sprite_index, image_index, x, y, xscale);
        buffers.afterimageBlur = 4;
    }
    
    if (grounded && vsp > 0 && !place_meeting(x, y + 1, obj_destructibles) && !place_meeting(x, y + 1, obj_metalblock))
    {
		if (scr_slope(x, y + 1) && sprite_index != spr_player_piledriver)
        {
            var slope = instance_place(x, y + 1, obj_slope);
            xscale = -sign(slope.image_xscale);
            movespeed = 12;
            state = scr_player_tumble;
            sprite_index = sprites.rolling;
            create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        }
		else
		{
	        sprite_index = sprites.groundpoundland
	        image_index = 0
	        vsp = 0
	        hsp = 0
	        state = scr_player_freefallland
	        movespeed = abs(movespeed)
			shake_camera(10,15)
	        plrsnds_play(sfx.slam, x, y)
		}
    }
}
